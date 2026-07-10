import logging

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.schemas import ItemResponse

logging.basicConfig(
    level=logging.DEBUG if settings.debug else logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
)
logger = logging.getLogger(__name__)

app = FastAPI(
    title=settings.app_name,
    description="A basic production-ready FastAPI application.",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.on_event("startup")
async def startup_event():
    logger.info(
        "Starting %s in %s mode", settings.app_name, settings.environment
    )


@app.get("/", response_model=ItemResponse)
async def root():
    return {"message": "Welcome to the FastAPI application!", "status": "success"}


@app.get("/health", tags=["Monitoring"])
async def health_check():
    return {"status": "healthy"}
