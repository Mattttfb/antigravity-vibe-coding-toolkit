# Claude Code Guidelines & Vibe Coding Protocols

This project and environment are configured for autonomous AI software engineering and rapid "Vibe Coding" with zero friction.

## Environment & Commands
- **JavaScript / TypeScript**: Use `pnpm` (default) or `bun`. Execute scripts directly with `bun run script.ts` or `tsx script.ts`.
- **Python**: Use `uv` exclusively (`uv pip install --system`, `uv run script.py`).
- **Code Quality**:
  - Python: `ruff check .` and `ruff format .`
  - TypeScript: `biome check --write .`
- **Testing**:
  - Python: `pytest`
  - JavaScript/TypeScript: `pnpm test` (Vitest/Jest)

## Architecture Principles
1. **Layer Separation**: Strict boundaries between Routes (presentation), Services (business logic), and Repositories/ORM (database access).
2. **Never Hardcode Mock Data**: Component logic and API endpoints must consume real models. Test data must remain in isolated seed scripts (`scripts/dev-toolkit/seed_data.py`).
3. **Visual Excellence**:
   - Base UI: Shadcn UI (`pnpm dlx shadcn@latest add <component>`)
   - Animated Hero & Bento Layouts: Magic UI (`https://magicui.design/r/<component>`)
   - 3D & High-impact Motion: Aceternity UI + Framer Motion
4. **Git Protocol**: Always format commits with Conventional Commits (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`).
