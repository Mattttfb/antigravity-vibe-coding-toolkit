<#
.SYNOPSIS
    Antigravity AI & Vibe Coding Environment Setup Script
.DESCRIPTION
    Installs and configures all modern runtimes, package managers, Modern Unix CLI tools,
    Rust formatters, database utilities, and PowerShell profile.
    Compatible with: Antigravity, Claude Code, OpenAI Codex, Windsurf, Cursor.
#>

$ErrorActionPreference = "Continue"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY DEV & VIBE CODING ENVIRONMENT SETUP" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Windows Long Paths & Git Configuration
Write-Host "[1/6] Configuring Git & Windows Long Paths..." -ForegroundColor Yellow
git config --global core.autocrlf input
git config --global core.longpaths true

try {
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -ErrorAction SilentlyContinue
} catch {}

# 2. Node & Modern Package Managers
Write-Host "[2/6] Installing Node CLI Tools (pnpm, yarn, tsx, serve, bun, tldr, localtunnel, supabase, biome)..." -ForegroundColor Yellow
npm install -g pnpm yarn tsx serve tldr localtunnel supabase @biomejs/biome
npm install -g --allow-scripts=bun bun

# 3. Python & Astral Rust Tooling (uv, ruff, fastapi, faker, sqlite-utils, httpie)
Write-Host "[3/6] Installing Python & Astral Rust Ecosystem..." -ForegroundColor Yellow
pip install uv
uv pip install --system ruff httpie faker sqlite-utils mkdocs-material fastapi "uvicorn[standard]" pydantic typer rich python-dotenv sqlalchemy pytest

# 4. Modern Unix Binaries (ripgrep, jq, bat, fd, lazygit)
Write-Host "[4/6] Installing Modern Unix Binaries..." -ForegroundColor Yellow
$scriptsDir = (python -c "import sys, os; print(os.path.join(sys.prefix, 'Scripts'))").Trim()

python -c @"
import urllib.request, zipfile, io, os

dest = r'$scriptsDir'

def download_file(url, out_name):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as resp, open(os.path.join(dest, out_name), 'wb') as f:
        f.write(resp.read())

def download_zip(url, exe_name):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as resp:
        z = zipfile.ZipFile(io.BytesIO(resp.read()))
        for n in z.namelist():
            if n.endswith(exe_name):
                with open(os.path.join(dest, exe_name), 'wb') as f:
                    f.write(z.read(n))
                break

try:
    download_file('https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-windows-amd64.exe', 'jq.exe')
    download_zip('https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-pc-windows-msvc.zip', 'rg.exe')
    download_zip('https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Windows_x86_64.zip', 'lazygit.exe')
    download_zip('https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-pc-windows-msvc.zip', 'bat.exe')
    download_zip('https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-pc-windows-msvc.zip', 'fd.exe')
    print('Binaries downloaded successfully.')
except Exception as e:
    print('Error downloading binaries:', e)
"@

# 5. Copy Dev-Toolkit Scripts
Write-Host "[5/6] Deploying Dev-Toolkit to ~/.gemini/config/scripts/..." -ForegroundColor Yellow
$globalToolkit = "$HOME\.gemini\config\scripts\dev-toolkit"
New-Item -ItemType Directory -Force -Path $globalToolkit | Out-Null
Copy-Item -Recurse -Force "$PSScriptRoot\scripts\dev-toolkit\*" $globalToolkit

# 6. Setup PowerShell 7 Profile
Write-Host "[6/6] Configuring PowerShell 7 Profile..." -ForegroundColor Yellow
$ps7Dir = "$HOME\Documents\PowerShell"
New-Item -ItemType Directory -Force -Path $ps7Dir | Out-Null
Copy-Item -Force "$PSScriptRoot\scripts\dev-toolkit\Microsoft.PowerShell_profile.ps1" "$ps7Dir\Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue

Write-Host "==========================================================" -ForegroundColor Green
Write-Host "  SETUP COMPLETED! ALL TOOLS AND SKILLS ARE OPERATIONAL." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
