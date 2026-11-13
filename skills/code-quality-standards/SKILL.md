---
name: code-quality-standards
description: >-
  Consolidated community standards and best practices from GitHub: Clean Architecture,
  Conventional Commits, TypeScript/Python strict typing, OWASP security hygiene, and error-handling patterns.
---

# Code Quality & Architecture Standards

This skill defines the engineering quality guidelines derived from GitHub community standards, Clean Architecture principles, and battle-tested production practices.

---

## 1. Clean Architecture & Layering

Always structure code in clear, decoupled layers:

1. **Presentation / API Layer**:
   - HTTP routes, request parsing, response formatting, status codes.
   - No business logic or database queries here.
2. **Business / Service Layer**:
   - Core domain rules, calculations, orchestrations, transaction workflows.
   - Independent of framework specifics.
3. **Data Access / Repository Layer**:
   - Queries, ORM models, file I/O, cache adapters.
   - Provides clean abstractions (`UserRepository`, `ItemStore`).

---

## 2. Conventional Commits Standard

Format all git commit messages according to the Conventional Commits specification:

- `feat: <description>`: New feature or capability.
- `fix: <description>`: Bug fix.
- `refactor: <description>`: Code change that neither fixes a bug nor adds a feature.
- `docs: <description>`: Documentation changes only.
- `style: <description>`: Formatting, missing semi-colons, whitespace (no code change).
- `test: <description>`: Adding or correcting tests.
- `chore: <description>`: Maintenance tasks, dependency updates, build tooling.

---

## 3. Strict Typing & Code Standards

### TypeScript
- Always enable strict mode.
- **NEVER** use `any` unless absolutely unavoidable; prefer `unknown` with type narrowing.
- Use Discriminated Unions for state management (e.g., `type State = { status: 'loading' } | { status: 'success', data: Data }`).
- Handle all Promises with `async/await` and explicit `try/catch` or boundary wrappers.

### Python
- Type annotations on all public functions: `def fetch_user(user_id: int) -> Optional[User]:`.
- Use Pydantic v2 `BaseModel` for request/response contracts and data schemas.
- Format and lint with `ruff check .` and `ruff format .`.

---

## 4. Security & OWASP Top 10 Hygiene

1. **Injection Prevention**:
   - Never concatenate or interpolate user input into raw SQL queries. Always use parameterized queries or ORM bindings (SQLAlchemy, SQLModel).
2. **Secrets & Credentials**:
   - Never hardcode API keys, passwords, or tokens.
   - Always load from `.env` and verify `.gitignore` excludes `.env`, `*.pem`, `*.key`.
3. **Input Sanitization & Validation**:
   - Validate payloads at the boundary using schema validators before processing.
4. **CORS & Headers**:
   - In production, restrict `allow_origins` to known domain origins instead of `*`.
