# Antigravity & Gemini Agent Guidelines

This project leverages the Google Antigravity and Gemini CLI agentic architecture.

## Tooling & Fast Execution
- Prioritize `pnpm`, `uv` and `bun` over traditional legacy package managers.
- Always lint and verify code changes using `ruff` (Python) and `biome` (TypeScript).
- Use `sqlite-utils` for database auditing and `localtunnel` / `tunnel.py` for public port exposure.

## Skill Integration
- The repository provides 5 production-ready skills under `skills/`:
  - `web-app-architect`: React, Next.js, Vite, Tailwind CSS, Shadcn UI, Magic UI.
  - `backend-system-architect`: FastAPI, Uvicorn, SQLite, PostgreSQL, CORS, Auth.
  - `desktop-mobile-apps`: Tauri (Rust + React) and Android Compose.
  - `automation-tool-builder`: Typer, Rich, TSX, Bun, automated workers.
  - `code-quality-standards`: Clean Architecture, OWASP security, Conventional Commits.

## Mock Data Boundary
- Production code must never contain hardcoded sample data.
- Use `scripts/dev-toolkit/seed_data.py` to generate realistic Brazilian (`pt_BR`) datasets for testing and visualization.
