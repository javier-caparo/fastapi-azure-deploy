from pydantic import BaseModel

class ItemResponse(BaseModel):
    message: str
    status: str
