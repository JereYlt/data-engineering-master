# app/main.py
from fastapi import FastAPI
# FastAPI: el framework principal para crear APIs en Python
from app.middleware import logging_middleware
# Importar el middleware que creamos
from app.config import settings
# Importar la configuracion
# Crear la aplicacion FastAPI
app = FastAPI(
 title=settings.app_name,
 # title: aparece en la documentacion automatica de la API
 description="Primer proyecto del Roadmap Master — con logging y rate limiting",
 version="1.0.0",
)
# Registrar el middleware
app.middleware("http")(logging_middleware)
# "http": aplicar a todos los requests HTTP
# Cada request pasara por logging_middleware antes de llegar al endpoint
@app.get("/health")
# @app.get: decorador que registra este endpoint para requests GET
# "/health": la URL del endpoint
async def health_check():
 """
 Endpoint de salud del servicio.
 Los sistemas de monitoreo lo llaman periodicamente para saber si la API esta viva.
 Debe responder en menos de 100ms siempre.
 """
 return {
 "status": "ok",
 "service": settings.app_name,
 "environment": settings.environment,
 }
 # FastAPI convierte automaticamente el dict a JSON
@app.get("/suma")
async def sumar(a: float, b: float):
 """
 Suma dos numeros.
 FastAPI lee los parametros automaticamente de la URL:
 GET /suma?a=3&b=4 → a=3.0, b=4.0
 El tipado (float) hace que FastAPI valide que sean numeros.
 Si mandas letras, FastAPI devuelve un error 422 automaticamente.
 """
 resultado = a + b
 return {
 "resultado": resultado,
 "operacion": f"{a} + {b} = {resultado}",
 # f"": f-string — permite insertar variables dentro del string
 }
