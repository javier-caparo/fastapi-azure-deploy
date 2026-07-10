from fastapi import FastAPI
from pydantic import BaseModel

# Initialize the FastAPI app
app = FastAPI(
    title="FastAPI Azure App",
    description="A basic production-ready FastAPI application.",
    version="1.0.0"
)

class ItemResponse(BaseModel):
    message: str
    status: str

@app.get("/", response_model=ItemResponse)
async def root():
    """
    Root endpoint.
    """
    return {"message": "Welcome to the FastAPI application!", "status": "success"}

@app.get("/health", tags=["Monitoring"])
async def health_check():
    """
    Health check endpoint for container orchestration probes.
    """
    return {"status": "healthy"}
