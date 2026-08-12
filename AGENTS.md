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

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

Rules:
- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- Dirty graphify-out/ files are expected after hooks or incremental updates; dirty graph files are not a reason to skip graphify. Only skip graphify if the task is about stale or incorrect graph output, or the user explicitly says not to use it.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).

## MemPalace Memory

This repository is linked to a MemPalace memory palace (`fastapi_azure_deploy`).

When starting or answering context/history questions:
- Use `mempalace wake-up` or `mempalace search "<query>"` (or the `mempalace_search` MCP tool) to recall project context, history, architectural decisions, and mined knowledge.
