"""
GitIgnore Generator
Fetches official, battle-tested .gitignore rules directly from the community repository.
Usage:
    python get_gitignore.py <targets...> [--dest <path>]
Example:
    python get_gitignore.py python
    python get_gitignore.py node,react,vite
    python get_gitignore.py rust,windows
"""

import sys
import urllib.request
import argparse
from pathlib import Path

def fetch_gitignore(targets: list[str], dest_dir: Path):
    joined = ",".join(targets).lower()
    url = f"https://www.toptal.com/developers/gitignore/api/{joined}"
    print(f"[*] Fetching .gitignore for [{joined}] from community registry...")

    req = urllib.request.Request(url, headers={"User-Agent": "Antigravity-AI-DevKit"})
    try:
        with urllib.request.urlopen(req) as resp:
            content = resp.read().decode("utf-8")
            
        out_file = dest_dir / ".gitignore"
        # Always append local security hygiene rules
        security_rules = """
# === Antigravity Local Security Hygiene ===
.env
.env.local
.env.*.local
*.pem
*.key
credentials.json
service-account*.json
.DS_Store
Thumbs.db
"""
        final_content = content.strip() + "\n" + security_rules.strip() + "\n"
        out_file.write_text(final_content, encoding="utf-8")
        print(f"[+] .gitignore successfully created at: {out_file.resolve()}")
    except Exception as e:
        print(f"[-] Failed to fetch .gitignore: {e}")

def main():
    parser = argparse.ArgumentParser(description="Generate official .gitignore for any tech stack")
    parser.add_argument("targets", nargs="+", help="Technologies (e.g. node, python, rust, react, visualstudiocode)")
    parser.add_argument("--dest", default=".", help="Target folder (defaults to current directory)")
    args = parser.parse_args()

    dest_dir = Path(args.dest)
    fetch_gitignore(args.targets, dest_dir)

if __name__ == "__main__":
    main()
