# FastAPI Azure Deploy

A production-ready FastAPI application containerized and designed for deployment to Azure Container Registry (ACR).

## Project Structure

```
.
├── .github/workflows/    # CI/CD pipeline (build & push to ACR)
├── app/
│   ├── core/
│   │   └── config.py     # Pydantic settings (env-based config)
│   ├── schemas.py        # Pydantic models / response schemas
│   └── main.py           # FastAPI application entrypoint
├── tests/
│   └── test_main.py      # Pytest test suite
├── Dockerfile            # Container image definition
├── requirements.txt      # Python dependencies
└── .env.example          # Environment variables template
```

## Local Development

```bash
# Create virtual environment
python -m venv .venv
source .venv/bin/activate   # Linux/Mac
.venv\Scripts\activate      # Windows

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env

# Run the server
uvicorn app.main:app --reload --port 8000
```

### Run Tests

```bash
pytest -v
```

## Docker

```bash
# Build
docker build -t fastapi-backend .

# Run
docker run -p 8000:8000 fastapi-backend
```

## CI/CD

On every push to `main`, the GitHub Action in `.github/workflows/build-and-push-acr.yml`:
1. Checks out the code
2. Authenticates to Azure Container Registry
3. Builds and pushes the Docker image tagged with the commit SHA and `latest`

## Configuration

| Variable      | Default       | Description          |
|---------------|---------------|----------------------|
| `ENVIRONMENT` | `development` | Runtime environment  |
| `DEBUG`       | `false`       | Enable debug logging |
