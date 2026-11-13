<#
.SYNOPSIS
    Antigravity AI & Vibe Coding Toolkit - Update Script
.DESCRIPTION
    Pulls the latest skills, scripts, templates and rules from the GitHub repository,
    updates installed CLI tools, and refreshes local machine configurations.
#>

$ErrorActionPreference = "Continue"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  UPDATING ANTIGRAVITY DEV & VIBE CODING TOOLKIT" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Pull Latest Changes from GitHub
Write-Host "[1/4] Pulling latest updates from GitHub..." -ForegroundColor Yellow
git pull origin main

# 2. Update Core Global Tools
Write-Host "[2/4] Updating CLI Tools and Formatters..." -ForegroundColor Yellow
npm update -g pnpm bun tldr localtunnel supabase @biomejs/biome
uv pip install --system --upgrade uv ruff httpie faker sqlite-utils mkdocs-material

# 3. Synchronize Skills to Local Agent System
Write-Host "[3/4] Synchronizing Skills to ~/.gemini/config/skills/..." -ForegroundColor Yellow
$skillsSrc = "$PSScriptRoot\skills"
$skillsDest = "$HOME\.gemini\config\skills"
New-Item -ItemType Directory -Force -Path $skillsDest | Out-Null

Get-ChildItem -Directory $skillsSrc | ForEach-Object {
    $target = Join-Path $skillsDest $_.Name
    Copy-Item -Recurse -Force $_.FullName $target
    Write-Host "  Updated skill: $($_.Name)" -ForegroundColor Green
}

# 4. Synchronize Dev-Toolkit and PowerShell Profile
Write-Host "[4/4] Updating Dev-Toolkit and PowerShell 7 Profile..." -ForegroundColor Yellow
$toolkitDest = "$HOME\.gemini\config\scripts\dev-toolkit"
New-Item -ItemType Directory -Force -Path $toolkitDest | Out-Null
Copy-Item -Recurse -Force "$PSScriptRoot\scripts\dev-toolkit\*" $toolkitDest

$profileSrc = "$PSScriptRoot\scripts\dev-toolkit\Microsoft.PowerShell_profile.ps1"
$profileDest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if (Test-Path $profileSrc) {
    Copy-Item -Force $profileSrc $profileDest
    Write-Host "  PowerShell 7 Profile refreshed." -ForegroundColor Green
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Host "  SUCCESS! Your environment is completely up-to-date." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
