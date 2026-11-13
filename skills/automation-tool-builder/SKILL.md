---
name: automation-tool-builder
description: >-
  Workflows, patterns, and templates for creating developer tools, command-line interfaces (CLIs), background automations,
  web scrapers, data pipelines, and system scripts using Python (Typer, Rich, httpx), TypeScript (tsx), and PowerShell.
---

# Automation Tool & CLI Builder

This skill guides the rapid design, development, and packaging of CLI tools, automation scripts, and background workers.

---

## 1. Python CLI Tools & Lightning Execution (`uv` + `typer` + `rich`)

- **Lightning Execution with `uv`**:
  - Run one-off scripts with dependencies without manual installs:
    ```bash
    uv run --with httpx --with rich script.py
    ```
  - Fast dependency installation into project:
    ```bash
    uv pip install <package>
    ```

- **Scaffold a new CLI**:
  ```bash
  python "C:/Users/User/.gemini/config/scripts/dev-toolkit/scaffold.py" python-cli ./my-cli --name "SuperTool"
  ```
- **Key Patterns**:
  - Colored text and emoji:
    ```python
    from rich.console import Console
    console = Console()
    console.print("[bold green]Success:[/bold green] Task finished! :white_check_mark:")
    ```
  - Progress bar for batch processes:
    ```python
    from rich.progress import track
    for item in track(items, description="Processing items..."):
        process(item)
    ```
  - Formatted tabular data:
    ```python
    from rich.table import Table
    table = Table(title="Results")
    table.add_column("Key", style="cyan")
    table.add_column("Value", style="magenta")
    table.add_row("Status", "200 OK")
    console.print(table)
    ```

---

## 2. Instant Local Tunnels & Public Exposure

- Expose any local web or backend server to the internet via HTTPS:
  ```bash
  python "C:/Users/User/.gemini/config/scripts/dev-toolkit/tunnel.py" 8000
  ```
- Or directly with `lt`:
  ```bash
  lt --port 8000
  ```

---

## 3. SQLite Database Operations (`sqlite-utils`)

- Inspect tables, schemas, and run queries instantly from the terminal:
  ```bash
  sqlite-utils tables mydb.db --schema
  sqlite-utils query mydb.db "SELECT * FROM users LIMIT 10" --table
  sqlite-utils insert mydb.db users data.json --pk=id
  ```

---

## 4. Instant TypeScript Automation (`tsx`)

Run `.ts` scripts directly with full ESM and modern TypeScript features without a `tsconfig.json` or build step:

```bash
tsx my-script.ts
```

- Example `my-script.ts`:
  ```typescript
  import fs from "fs/promises";
  import path from "path";

  async function run() {
    console.log("Running automation task in TypeScript...");
  }
  run();
  ```

---

## 3. Automation Scripts & Background Workers

- Scaffold with:
  ```bash
  python "C:/Users/User/.gemini/config/scripts/dev-toolkit/scaffold.py" automation-script ./my-automation
  ```
- Use `argparse` or `typer` for dry-run modes (`--dry-run`), verbose logging (`--verbose`), and config file overrides.
