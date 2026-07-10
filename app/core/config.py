from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    app_name: str = "FastAPI Azure App"
    environment: str = "development"
    debug: bool = False

    class Config:
        env_file = ".env"

# Instantiate settings to be imported elsewhere
settings = Settings()
