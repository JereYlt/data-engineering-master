# tests/test_main.py
import pytest
from httpx import AsyncClient
# AsyncClient: cliente HTTP para hacer requests de prueba a la API

from app.main import app
# Importar la aplicacion FastAPI para hacer requests en los tests
# Los tests en pytest son funciones que empiezan con "test_"
# pytest las detecta automaticamente

@pytest.mark.asyncio
# asyncio: marca el test como asincrono (necesario con FastAPI)
async def test_health_check_devuelve_ok():
    """
    Verifica que el endpoint /health responde correctamente.
    Nombre descriptivo: test_[que_hace]_[que_resultado_esperamos]
    """
    async with AsyncClient(app=app, base_url="http://test") as client:
        # async with: contexto asincrono que cierra el cliente al terminar
        # base_url="http://test": URL falsa para tests (no necesita servidor real)

        response = await client.get("/health")
        # await: esperar la respuesta del request asincrono

        assert response.status_code == 200
        # assert: si la condicion es False, el test FALLA con un error claro
        # status_code 200 = OK

        data = response.json()
        assert data["status"] == "ok"
        assert "service" in data
        # "service" in data: verifica que la clave "service" existe en el dict


@pytest.mark.asyncio
async def test_suma_dos_numeros_positivos():
    """Verifica que la suma de 3 + 4 da 7."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/suma", params={"a": 3, "b": 4})
        # params: los parametros de la URL (?a=3&b=4)

        assert response.status_code == 200
        data = response.json()
        assert data["resultado"] == 7.0


@pytest.mark.asyncio
async def test_suma_numeros_negativos():
    """Verifica que la suma funciona con numeros negativos."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/suma", params={"a": -5, "b": 3})
        assert response.status_code == 200
        assert response.json()["resultado"] == -2.0


@pytest.mark.asyncio
async def test_suma_sin_parametros_devuelve_error():
    """
    Verifica que FastAPI devuelve 422 si faltan parametros obligatorios.
    422 = Unprocessable Entity (error de validacion)
    """
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/suma")
        # Sin parametros a ni b

        assert response.status_code == 422
        # FastAPI valida automaticamente — nosotros solo verificamos que lo hace


@pytest.mark.asyncio
async def test_suma_con_texto_devuelve_error():
    """Verifica que FastAPI valida que los parametros sean numeros."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/suma", params={"a": "hola", "b": 4})
        assert response.status_code == 422


@pytest.mark.asyncio
async def test_response_tiene_header_request_id():
    """Verifica que cada respuesta incluye el header X-Request-ID."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        response = await client.get("/health")

        assert "x-request-id" in response.headers
        # Los headers se comparan en minusculas

        assert len(response.headers["x-request-id"]) == 8
        # Nuestro request_id tiene 8 caracteres