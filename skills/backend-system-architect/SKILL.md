---
name: backend-system-architect
description: >-
  Guidelines, patterns, and code implementations for building robust backend systems, APIs, microservices,
  database persistence layers, and server logic using FastAPI (Python), Node.js (Express/Hono/Nest), SQLite, and PostgreSQL.
---

# Backend System Architect

This skill equips the agent to architect, scaffold, and implement production-ready backends, RESTful and WebSocket APIs, data models, authentication, and database migrations.

---

## 1. Core Frameworks & Recommendations

- **Python (FastAPI + Pydantic v2 + Uvicorn)**:
  - Best for: Data APIs, AI/LLM application backends, fast prototyping, high throughput async services.
  - Quick Scaffold:
    ```bash
    python "C:/Users/User/.gemini/config/scripts/dev-toolkit/scaffold.py" fastapi-backend ./backend --name "MyAppAPI"
    ```
  - Running server with auto-reload:
    ```bash
    uvicorn main:app --reload --port 8000
    ```
- **Node.js / TypeScript (Express / Hono)**:
  - Best for: Lightweight microservices, JavaScript ecosystem integration, instant execution via `tsx`.
  - Direct execution:
    ```bash
    tsx server.ts
    ```

---

## 2. API Design & Security Best Practices

1. **CORS & Middleware**:
   - Always configure CORS explicitly. In development, allow frontend ports (`http://localhost:3000`, `http://localhost:5173`).
2. **Environment Configuration**:
   - Never hardcode secrets or DB connection strings. Always load from `.env` using `python-dotenv` or `process.env`.
3. **Structured Response & Error Handling**:
   - Use standard HTTP status codes: `200 OK`, `201 Created`, `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `404 Not Found`, `500 Server Error`.
   - In FastAPI, raise `HTTPException(status_code=..., detail=...)`.
4. **Data Persistence**:
   - Default to SQLite for zero-configuration, self-contained local storage: `sqlite:///./app.db`.
   - Use `sqlite-utils` for instant CLI inspection: `sqlite-utils tables app.db --schema`.
   - **PostgreSQL / Redis with Docker**:
     - Pre-configured docker-compose templates are ready in `C:/Users/User/.gemini/config/scripts/dev-toolkit/`:
       - `docker-compose -f "C:/Users/User/.gemini/config/scripts/dev-toolkit/docker-compose-postgres.yml" up -d` (PostgreSQL 16 + pgAdmin 4)
       - `docker-compose -f "C:/Users/User/.gemini/config/scripts/dev-toolkit/docker-compose-redis.yml" up -d` (Redis 7 + Redis Commander)

---

## 3. Testing & Verification

- Write unit tests using `pytest` for Python or Vitest/Jest for Node.
- Test endpoints directly using `httpx` or `curl`.
- Validate OpenAPI documentation generated at `/docs`.
