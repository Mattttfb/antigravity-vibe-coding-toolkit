<#
.SYNOPSIS
    Instant Project Scaffolder for Sites, Apps, APIs and Systems
.DESCRIPTION
    Quickly bootstraps full projects with optimal configuration.
.PARAMETER Type
    vite-react, nextjs, fastapi, python-cli, tauri
.PARAMETER Path
    Target directory
#>
param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("vite-react", "nextjs", "fastapi", "python-cli", "tauri")]
    [string]$Type,

    [Parameter(Mandatory=$true)]
    [string]$TargetDir,

    [string]$Name
)

$targetPath = [System.IO.Path]::GetFullPath($TargetDir)
if (-not $Name) {
    $Name = Split-Path $targetPath -Leaf
}

Write-Host "Creating project '$Name' (Type: $Type) in $targetPath..." -ForegroundColor Cyan

switch ($Type) {
    "vite-react" {
        # Using pnpm or npm to create modern Vite React + TS + Tailwind
        if (Get-Command pnpm -ErrorAction SilentlyContinue) {
            pnpm create vite $TargetDir --template react-ts
        } else {
            npm create vite@latest $TargetDir -- --template react-ts
        }
        Write-Host "Vite project bootstrapped. Navigate to $TargetDir and install Tailwind/lucide-react." -ForegroundColor Green
    }
    "nextjs" {
        npx create-next-app@latest $TargetDir --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-pnpm
        Write-Host "Next.js project bootstrapped." -ForegroundColor Green
    }
    "fastapi" {
        python "$PSScriptRoot\scaffold.py" fastapi-backend $targetPath --name $Name
    }
    "python-cli" {
        python "$PSScriptRoot\scaffold.py" python-cli $targetPath --name $Name
    }
    "tauri" {
        # Cargo + Tauri starter
        pnpm create tauri-app $TargetDir --template react-ts
        Write-Host "Tauri desktop app bootstrapped." -ForegroundColor Green
    }
}
