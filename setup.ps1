<#
.SYNOPSIS
    Antigravity AI & Vibe Coding Environment Setup Script (Modular & Interactive)
.DESCRIPTION
    Installs and configures modern developer runtimes, tools and skills.
.PARAMETER Profile
    Full (default), FrontendOnly, BackendOnly, Minimal, or Interactive
.PARAMETER Interactive
    Prompts the user to choose which specific modules to install.
.EXAMPLE
    .\setup.ps1 -Profile Full
    .\setup.ps1 -Profile FrontendOnly
    .\setup.ps1 -Interactive
#>
param(
    [ValidateSet("Full", "FrontendOnly", "BackendOnly", "Minimal")]
    [string]$Profile = "Full",

    [switch]$Interactive
)

$ErrorActionPreference = "Continue"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY DEV & VIBE CODING ENVIRONMENT SETUP" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$installGitConfig = $true
$installFrontend  = $true
$installBackend   = $true
$installUnixTools = $true
$installToolkit   = $true
$installProfile   = $true

if ($Interactive) {
    Write-Host "`n[Modo Interativo Selecionado - Escolha o que instalar]:" -ForegroundColor Magenta
    
    $ans = Read-Host "1. Configurar Git e caminhos longos no Windows? (S/N) [S]"
    $installGitConfig = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "2. Instalar ecossistema Web/Frontend (Node, pnpm, bun, biome, web-app-architect)? (S/N) [S]"
    $installFrontend = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "3. Instalar ecossistema Backend/Python (uv, ruff, fastapi, sqlite-utils, backend-system-architect)? (S/N) [S]"
    $installBackend = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "4. Instalar ferramentas Modern Unix (ripgrep, jq, bat, fd, tldr, lazygit, httpie)? (S/N) [S]"
    $installUnixTools = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "5. Instalar scripts de Scaffolding, Seed Data e Docker templates? (S/N) [S]"
    $installToolkit = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "6. Configurar perfil e atalhos rápidos do PowerShell 7? (S/N) [S]"
    $installProfile = ($ans -ne 'N' -and $ans -ne 'n')
} elseif ($Profile -eq "FrontendOnly") {
    $installBackend   = $false
    $installUnixTools = $false
} elseif ($Profile -eq "BackendOnly") {
    $installFrontend  = $false
} elseif ($Profile -eq "Minimal") {
    $installUnixTools = $false
    $installProfile   = $false
}

# 1. Windows Long Paths & Git Configuration
if ($installGitConfig) {
    Write-Host "`n[*] Configurando Git e caminhos longos..." -ForegroundColor Yellow
    git config --global core.autocrlf input
    git config --global core.longpaths true
    try {
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1 -ErrorAction SilentlyContinue
    } catch {}
}

# 2. Node & Modern Package Managers
if ($installFrontend) {
    Write-Host "`n[*] Instalando ferramentas Web & Node (pnpm, yarn, tsx, serve, bun, supabase, biome)..." -ForegroundColor Yellow
    npm install -g pnpm yarn tsx serve supabase @biomejs/biome localtunnel
    npm install -g --allow-scripts=bun bun

    # Copy web skills
    $skillsDest = "$HOME\.gemini\config\skills"
    New-Item -ItemType Directory -Force -Path $skillsDest | Out-Null
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\web-app-architect" $skillsDest -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\code-quality-standards" $skillsDest -ErrorAction SilentlyContinue
}

# 3. Python & Astral Rust Tooling
if ($installBackend) {
    Write-Host "`n[*] Instalando ferramentas Python & Astral (uv, ruff, fastapi, faker, sqlite-utils, httpie)..." -ForegroundColor Yellow
    pip install uv
    uv pip install --system ruff httpie faker sqlite-utils mkdocs-material fastapi "uvicorn[standard]" pydantic typer rich python-dotenv sqlalchemy pytest

    # Copy backend skills
    $skillsDest = "$HOME\.gemini\config\skills"
    New-Item -ItemType Directory -Force -Path $skillsDest | Out-Null
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\backend-system-architect" $skillsDest -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\automation-tool-builder" $skillsDest -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\desktop-mobile-apps" $skillsDest -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force "$PSScriptRoot\skills\code-quality-standards" $skillsDest -ErrorAction SilentlyContinue
}

# 4. Modern Unix Binaries
if ($installUnixTools) {
    Write-Host "`n[*] Instalando binários Modern Unix (ripgrep, jq, bat, fd, lazygit, tldr)..." -ForegroundColor Yellow
    npm install -g tldr
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
    print('Notice on downloading binaries:', e)
"@
}

# 5. Copy Dev-Toolkit Scripts
if ($installToolkit) {
    Write-Host "`n[*] Instalando scripts em ~/.gemini/config/scripts/dev-toolkit..." -ForegroundColor Yellow
    $globalToolkit = "$HOME\.gemini\config\scripts\dev-toolkit"
    New-Item -ItemType Directory -Force -Path $globalToolkit | Out-Null
    Copy-Item -Recurse -Force "$PSScriptRoot\scripts\dev-toolkit\*" $globalToolkit
}

# 6. Setup PowerShell 7 Profile
if ($installProfile) {
    Write-Host "`n[*] Configurando perfil do PowerShell 7..." -ForegroundColor Yellow
    $ps7Dir = "$HOME\Documents\PowerShell"
    New-Item -ItemType Directory -Force -Path $ps7Dir | Out-Null
    Copy-Item -Force "$PSScriptRoot\scripts\dev-toolkit\Microsoft.PowerShell_profile.ps1" "$ps7Dir\Microsoft.PowerShell_profile.ps1" -ErrorAction SilentlyContinue
}

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "  INSTALACAO CONCLUIDA COM SUCESSO!" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
