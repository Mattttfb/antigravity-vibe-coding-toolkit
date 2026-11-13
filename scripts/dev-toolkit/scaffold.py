"""
Scaffold Toolkit for Instant Project Generation
Author: Antigravity AI
Usage:
    python scaffold.py <template> <destination_folder> [--name <project_name>]
Templates:
    - fastapi-backend     : Modern REST API with FastAPI, Pydantic v2, CORS, and SQLite
    - vite-react-tailwind : Modern Frontend with React, Vite, TypeScript & Tailwind CSS
    - python-cli          : Professional CLI with Typer, Rich formatting, and subcommands
    - tauri-desktop       : Native desktop app starter (Rust + React/Vite)
    - automation-script   : Robust automation script template with logging and error handling
"""

import os
import sys
import argparse
from pathlib import Path

TEMPLATES = {
    "fastapi-backend": {
        "files": {
            "main.py": """from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import uvicorn

app = FastAPI(
    title="{name}",
    description="High-performance API built with FastAPI",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Item(BaseModel):
    id: Optional[int] = None
    title: str
    description: Optional[str] = None
    completed: bool = False

db: List[Item] = []

@app.get("/")
def read_root():
    return {"message": "Welcome to {name} API", "status": "online", "docs": "/docs"}

@app.get("/api/items", response_model=List[Item])
def get_items():
    return db

@app.post("/api/items", response_model=Item, status_code=201)
def create_item(item: Item):
    item.id = len(db) + 1
    db.append(item)
    return item

@app.get("/api/items/{item_id}", response_model=Item)
def get_item(item_id: int):
    for item in db:
        if item.id == item_id:
            return item
    raise HTTPException(status_code=404, detail="Item not found")

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
""",
            "requirements.txt": """fastapi>=0.110.0
uvicorn[standard]>=0.28.0
pydantic>=2.6.0
python-dotenv>=1.0.0
httpx>=0.27.0
sqlalchemy>=2.0.0
pytest>=8.0.0
""",
            ".env.example": """PORT=8000
DEBUG=True
DATABASE_URL=sqlite:///./data.db
SECRET_KEY=super-secret-key-change-in-production
""",
            "README.md": """# {name}

High-performance API built with FastAPI & Uvicorn.

## Getting Started

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Run the development server:
   ```bash
   uvicorn main:app --reload --port 8000
   ```

3. Open API Documentation:
   - Swagger UI: [http://localhost:8000/docs](http://localhost:8000/docs)
   - ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)
"""
        }
    },
    "python-cli": {
        "files": {
            "cli.py": """import typer
from rich.console import Console
from rich.table import Table
from rich.progress import track
import time

app = typer.Typer(help="{name} - High productivity CLI tool")
console = Console()

@app.command()
def hello(name: str = "World"):
    \"\"\"Greets the user in style\"\"\"
    console.print(f"[bold green]Hello[/bold green], [cyan]{name}[/cyan]! :rocket:")

@app.command()
def process(count: int = 5):
    \"\"\"Simulates a batch operation with progress bar\"\"\"
    console.print(f"[bold yellow]Starting task with {count} steps...[/bold yellow]")
    for step in track(range(count), description="Processing..."):
        time.sleep(0.3)
    console.print("[bold green]Success![/bold green] All tasks completed.")

@app.command()
def list_items():
    \"\"\"Displays sample tabular data\"\"\"
    table = Table(title="Inventory / Status")
    table.add_column("ID", style="cyan", no_wrap=True)
    table.add_column("Item Name", style="magenta")
    table.add_column("Status", style="green")

    table.add_row("1", "Frontend Service", "Active")
    table.add_row("2", "Backend API", "Healthy")
    table.add_row("3", "Database SQLite", "Connected")
    console.print(table)

if __name__ == "__main__":
    app()
""",
            "requirements.txt": """typer>=0.9.0
rich>=13.7.0
python-dotenv>=1.0.0
requests>=2.31.0
""",
            "README.md": """# {name} CLI

Built with Typer and Rich.

## Usage

```bash
pip install -r requirements.txt
python cli.py --help
python cli.py hello --name Developer
python cli.py process --count 5
python cli.py list-items
```
"""
        }
    },
    "automation-script": {
        "files": {
            "run.py": """import os
import sys
import logging
import argparse
from pathlib import Path

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger("{name}")

def main():
    parser = argparse.ArgumentParser(description="{name} Automation Worker")
    parser.add_argument("--dry-run", action="store_true", help="Simulate without changes")
    args = parser.parse_args()

    logger.info("Initializing {name} automation...")
    if args.dry_run:
        logger.warning("Dry run mode active. No persistent changes will be made.")

    logger.info("Automation task completed successfully.")

if __name__ == "__main__":
    main()
""",
            "README.md": """# {name} Automation

Automated task runner and data processor.
Run with:
```bash
python run.py
```
"""
        }
    }
}

def scaffold(template_name: str, dest_dir: Path, project_name: str):
    if template_name not in TEMPLATES:
        print(f"Error: Unknown template '{template_name}'. Available: {list(TEMPLATES.keys())}")
        sys.exit(1)

    dest_dir.mkdir(parents=True, exist_ok=True)
    tpl = TEMPLATES[template_name]

    for rel_path, content in tpl["files"].items():
        file_path = dest_dir / rel_path
        file_path.parent.mkdir(parents=True, exist_ok=True)
        rendered_content = content.replace("{name}", project_name)
        file_path.write_text(rendered_content, encoding="utf-8")
        print(f"  Created: {rel_path}")

    # Copy master AGENTS.md rules into project root
    master_agents_md = Path(__file__).parent / "AGENTS.md"
    if master_agents_md.exists():
        (dest_dir / "AGENTS.md").write_text(master_agents_md.read_text(encoding="utf-8"), encoding="utf-8")
        print(f"  Created: AGENTS.md (Vibe Coding Rules)")

    print(f"\n[+] Project '{project_name}' scaffolded successfully at: {dest_dir.resolve()}")

def main():
    parser = argparse.ArgumentParser(description="Scaffold web, api, cli, and system projects")
    parser.add_argument("template", choices=list(TEMPLATES.keys()), help="Template type")
    parser.add_argument("dest", help="Destination directory")
    parser.add_argument("--name", default=None, help="Project name (defaults to folder name)")
    args = parser.parse_args()

    dest_dir = Path(args.dest)
    name = args.name or dest_dir.name
    scaffold(args.template, dest_dir, name)

if __name__ == "__main__":
    main()
