from pydantic_settings import BaseSettings
from pydantic import ConfigDict
from typing import Optional

class Settings(BaseSettings):
    # Campos que realmente usa la API
    app_name: str = "Microservicio Observable"
    environment: str = "development"
    rate_limit_per_minute: int = 10

    # Campos extra que están en .env pero la API no necesita (opcionales)
    # Si no los pones, Pydantic lanzará error por campos extra.
    # Al declararlos como Optional con valor None, se ignoran.
    postgres_user: Optional[str] = None
    postgres_password: Optional[str] = None
    postgres_db: Optional[str] = None
    pgadmin_email: Optional[str] = None
    pgadmin_password: Optional[str] = None

    # Configuración moderna de Pydantic v2 (reemplaza class Config)
    model_config = ConfigDict(
        env_file=".env",           # sigue leyendo el .env
        extra="ignore"             # ignora cualquier campo extra no declarado (doble seguridad)
    )

settings = Settings()