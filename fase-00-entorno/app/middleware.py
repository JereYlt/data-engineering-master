# app/middleware.py
import logging
import json
import time
import uuid
from collections import defaultdict

from fastapi import Request
from fastapi.responses import JSONResponse

from app.config import settings


class JsonFormatter(logging.Formatter):
    """
    Formatea los logs como JSON en lugar del formato de texto por defecto.

    Formato por defecto: 2024-01-15 10:30:00 - INFO - mensaje
    Nuestro formato: {"timestamp": "...", "level": "INFO", "message": "...", ...}

    El formato JSON es mejor porque:
    - Se puede buscar y filtrar con herramientas como Grafana/Loki
    - Se puede parsear programaticamente
    - Incluye campos estructurados (request_id, duracion, etc.)
    """

    def format(self, record: logging.LogRecord) -> str:
        log_data = {
            "timestamp": self.formatTime(record, self.datefmt),
            "level": record.levelname,
            # levelname: DEBUG, INFO, WARNING, ERROR, CRITICAL
            "message": record.getMessage(),
            "module": record.module,
            # module: nombre del archivo Python que genero el log
        }

        # Agregar campos extra si existen (como request_id)
        # getattr(objeto, "campo", valor_por_defecto)
        extra_fields = ["request_id", "method", "path", "status", "duration_ms"]

        for field in extra_fields:
            value = getattr(record, field, None)
            if value is not None:
                log_data[field] = value

        return json.dumps(log_data)
        # json.dumps: convierte el diccionario a string JSON


def setup_logging() -> logging.Logger:
    """Configura el sistema de logging de la aplicacion."""

    handler = logging.StreamHandler()
    # StreamHandler: envia los logs a la consola (stdout)

    handler.setFormatter(JsonFormatter())
    # Aplicar nuestro formato JSON al handler

    logger = logging.getLogger("app")
    # getLogger("app"): obtener (o crear) el logger llamado "app"

    logger.addHandler(handler)
    logger.setLevel(logging.INFO)
    # setLevel: solo registrar mensajes de nivel INFO o superior
    # Jerarquia: DEBUG < INFO < WARNING < ERROR < CRITICAL

    return logger


logger = setup_logging()
# Variable global del logger para importar desde otros modulos

# Almacen de rate limiting en memoria
# defaultdict(list): diccionario donde cada valor es una lista vacia por defecto
request_counts: dict = defaultdict(list)


async def logging_middleware(request: Request, call_next):
    """
    Middleware que se ejecuta en CADA request que llega a la API.

    Un middleware es codigo que corre entre que llega el request
    y que se ejecuta el endpoint. Es como un filtro.

    Este middleware hace 3 cosas:
    1. Genera un ID unico para cada request (request_id)
    2. Aplica rate limiting (maximo N requests por minuto por IP)
    3. Registra cada request en los logs con su duracion
    """

    # 1. Generar ID unico para este request
    request_id = str(uuid.uuid4())[:8]
    # uuid4(): genera un UUID aleatorio como "a1b2c3d4-e5f6-..."
    # [:8]: tomamos solo los primeros 8 caracteres para que sea legible

    # 2. Aplicar rate limiting
    client_ip = request.client.host
    # request.client.host: la IP del cliente que hace el request

    now = time.time()
    # time.time(): segundos desde el 1 enero 1970 (Unix timestamp)

    # Limpiar requests antiguos (mas de 60 segundos)
    request_counts[client_ip] = [
        t for t in request_counts[client_ip]
        if now - t < 60
    ]
    # List comprehension: nueva lista con solo los timestamps recientes

    if len(request_counts[client_ip]) >= settings.rate_limit_per_minute:
        logger.warning("rate_limit_exceeded", extra={
            "request_id": request_id,
            "client_ip": client_ip,
        })

        return JSONResponse(
            status_code=429,
            # 429 = Too Many Requests (estandar HTTP)
            content={"error": "rate limit exceeded", "retry_after": "60 seconds"}
        )

    request_counts[client_ip].append(now)
    # Registrar este request

    # 3. Medir duracion y loggear
    start_time = time.time()

    response = await call_next(request)
    # call_next: llama al endpoint real y espera la respuesta
    # await: esperar la respuesta asincrona

    duration_ms = round((time.time() - start_time) * 1000, 2)
    # (tiempo_final - tiempo_inicio) * 1000 = milisegundos

    logger.info("request_completed", extra={
        "request_id": request_id,
        "method": request.method,
        # method: GET, POST, PUT, DELETE, etc.
        "path": str(request.url.path),
        "status": response.status_code,
        # status_code: 200 = OK, 404 = Not Found, 500 = Error, etc.
        "duration_ms": duration_ms,
    })

    # Agregar el request_id al header de respuesta
    response.headers["X-Request-ID"] = request_id
    # Esto permite al cliente correlacionar su request con los logs del servidor

    return response