# Antigravity Agent Engineering & Vibe Coding Guidelines

This document defines the core engineering standards, architecture rules, and "Vibe Coding" principles that Antigravity follows when creating, modifying, and maintaining codebases in this workspace.

---

## 1. Tooling & Execution Speed
- **JavaScript / TypeScript**: Prioritize `pnpm` and `bun` over traditional `npm`.
- **Python**: Always use `uv` (`uv pip install --system`, `uv run`) for instantaneous resolution and execution.
- **Direct Scripting**: Execute TypeScript scripts directly via `bun` or `tsx` without separate build steps.

---

## 2. Visual Excellence & "Vibe Coding" Standards
- **Component Registries**:
  - Base Primitives: **Shadcn UI** (`pnpm dlx shadcn@latest add ...`).
  - Animated Hero & Bento Layouts: **Magic UI** (via `frontend-craft-magicui` MCP).
  - High-Impact Motion: **Aceternity UI** & **Framer Motion** (auroras, glows, 3D tilt cards, spotlights).
- **Responsive & Accessible**:
  - Mobile-first breakpoints (`sm`, `md`, `lg`, `xl`).
  - High-contrast accessibility and dark mode support via Tailwind tokens.

---

## 3. Data Integrity & Mock Data Boundary
- **Never Hardcode Mock Data in Production Logic**:
  - UI components and API endpoints must consume real data models from the database or API contracts.
  - Realistic test data (generated via `seed-data` / `seed_data.py` with Faker) must remain strictly isolated in test seed scripts or development fixtures.
  - Production deployments must always start with a clean, unpolluted database schema.

---

## 4. Architecture & Code Cleanliness
- **Layer Separation**:
  - `Routes / Controllers`: Request validation, HTTP responses, status codes.
  - `Services / Domain`: Core business workflows and calculation rules.
  - `Repositories / Adapters`: Database access (SQLAlchemy, SQLite, Supabase) and external APIs.
- **Security & Hygiene**:
  - Never commit credentials. Always maintain `.env.example` alongside `.env`.
  - Use parameterized queries or ORMs; never concatenate user input into raw SQL.
- **Linter & Formatter Verification**:
  - For Python: Run `ruff check .` and `ruff format .`.
  - For TypeScript: Run `biome check --write .`.

---

## 5. Git & Commit Protocol
- Use **Conventional Commits**:
  - `feat:` for new capabilities.
  - `fix:` for bug fixes.
  - `refactor:` for architectural improvements.
  - `docs:` for documentation updates.
  - `chore:` for dependency and build tool adjustments.
