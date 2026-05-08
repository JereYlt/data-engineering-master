# app/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "Microservicio Observable"
    environment: str = "development"
    rate_limit_per_minute: int = 10

    class Config:
        env_file = ".env"

settings = Settings()