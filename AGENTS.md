# AGENTS.md

FastAPI service containerized for Azure Container Registry (ACR) deployment.

## Commands

- Install deps: `pip install -r requirements.txt`
- Run app locally: `uvicorn app.main:app --reload --port 8000`
- Run tests (from repo root, imports `app.main`): `pytest`
- No lint/format/typecheck tooling, no lockfile, no pytest config.

## App

- Entrypoint `app.main:app`; uvicorn binds `0.0.0.0:8000`.
- Settings via `app/core/config.py` (pydantic-settings, env vars / `.env`). Copy `.env.example` to `.env` for local. Keys: `ENVIRONMENT`, `DEBUG`.
- Response models live in `app/schemas.py`, not `main.py`.
- `requirements.txt` intentionally mixes runtime + test deps (`httpx` is there solely for `TestClient`) — do not remove it.

## Docker

- `Dockerfile` copies only `./app`; any new package/module must live under `app/` to reach the image.
- `HEALTHCHECK` hits `/health`; keep that endpoint healthy.

## CI/CD

- `.github/workflows/build-and-push-acr.yml` runs on push to `main` (and manual dispatch). Builds/pushes `fastapi-backend` tagged with commit SHA + `latest` to ACR.
- Requires GitHub Secrets: `ACR_LOGIN_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD`.

## IaC (Azure CLI)

- `iac/infra.sh` creates RG `rg-quick-tests` in `centralus` (if absent) and ACR `acrquicktests` (Basic, admin enabled), then prints the credentials to set as the CI secrets above. Optional args: `$1` RG name, `$2` location.
- `iac/destroy.sh` deletes the ACR. Both require an authenticated `az` login.

## Docs

- `docs/assessment.md` holds the project technical assessment.
