<#
.SYNOPSIS
    Antigravity AI & Vibe Coding Toolkit - Update & Version Switcher
.DESCRIPTION
    Pulls updates, switches to specific releases, or updates selected modules.
.PARAMETER Version
    Specific tag/version to checkout (e.g. v1.0.0, main)
.PARAMETER Interactive
    Allows choosing what to update.
.EXAMPLE
    .\update.ps1
    .\update.ps1 -Version v1.0.0
    .\update.ps1 -Interactive
#>
param(
    [string]$Version,
    [switch]$Interactive
)

$ErrorActionPreference = "Continue"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  ANTIGRAVITY DEV & VIBE CODING TOOLKIT - UPDATER" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Version Switching or Git Pull
if ($Version) {
    Write-Host "[*] Mudando para a versão $Version..." -ForegroundColor Yellow
    git fetch --tags
    git checkout $Version
} else {
    Write-Host "[*] Sincronizando com a versão mais recente da branch main..." -ForegroundColor Yellow
    git checkout main -ErrorAction SilentlyContinue
    git pull origin main
}

$updateTools   = $true
$updateSkills  = $true
$updateToolkit = $true

if ($Interactive) {
    Write-Host "`n[Modo Interativo - Escolha as atualizações]:" -ForegroundColor Magenta
    $ans = Read-Host "1. Atualizar ferramentas CLI globais (pnpm, uv, ruff, biome, etc.)? (S/N) [S]"
    $updateTools = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "2. Sincronizar skills do Antigravity/Cursor/Claude? (S/N) [S]"
    $updateSkills = ($ans -ne 'N' -and $ans -ne 'n')

    $ans = Read-Host "3. Sincronizar scripts do Dev-Toolkit e perfil PowerShell? (S/N) [S]"
    $updateToolkit = ($ans -ne 'N' -and $ans -ne 'n')
}

# 2. Update Core Global Tools
if ($updateTools) {
    Write-Host "`n[*] Atualizando pacotes CLI e formatadores..." -ForegroundColor Yellow
    npm update -g pnpm bun tldr localtunnel supabase @biomejs/biome
    uv pip install --system --upgrade uv ruff httpie faker sqlite-utils mkdocs-material
}

# 3. Synchronize Skills to Local Agent System
if ($updateSkills) {
    Write-Host "`n[*] Sincronizando Skills em ~/.gemini/config/skills/..." -ForegroundColor Yellow
    $skillsSrc = "$PSScriptRoot\skills"
    $skillsDest = "$HOME\.gemini\config\skills"
    New-Item -ItemType Directory -Force -Path $skillsDest | Out-Null

    Get-ChildItem -Directory $skillsSrc | ForEach-Object {
        $target = Join-Path $skillsDest $_.Name
        Copy-Item -Recurse -Force $_.FullName $target
        Write-Host "  Skill atualizada: $($_.Name)" -ForegroundColor Green
    }
}

# 4. Synchronize Dev-Toolkit and PowerShell Profile
if ($updateToolkit) {
    Write-Host "`n[*] Atualizando Dev-Toolkit e perfil do PowerShell 7..." -ForegroundColor Yellow
    $toolkitDest = "$HOME\.gemini\config\scripts\dev-toolkit"
    New-Item -ItemType Directory -Force -Path $toolkitDest | Out-Null
    Copy-Item -Recurse -Force "$PSScriptRoot\scripts\dev-toolkit\*" $toolkitDest

    $profileSrc = "$PSScriptRoot\scripts\dev-toolkit\Microsoft.PowerShell_profile.ps1"
    $profileDest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    if (Test-Path $profileSrc) {
        Copy-Item -Force $profileSrc $profileDest
        Write-Host "  Perfil do PowerShell 7 atualizado." -ForegroundColor Green
    }
}

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "  ATUALIZACAO CONCLUIDA! O ambiente está pronto." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
