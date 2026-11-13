# ==============================================================================
# PowerShell 7 Developer Profile - Antigravity Toolkit
# ==============================================================================

# Ensure essential developer tool directories are always in PATH
$devPaths = @(
    "$HOME\.bun\bin",
    "$HOME\AppData\Roaming\npm",
    "$HOME\AppData\Local\Programs\Python\Python312\Scripts",
    "$HOME\.cargo\bin"
)
foreach ($p in $devPaths) {
    if ((Test-Path $p) -and ($env:Path -notlike "*$p*")) {
        $env:Path = "$p;$env:Path"
    }
}

# ------------------------------------------------------------------------------
# Navigation & Terminal Aliases
# ------------------------------------------------------------------------------
function ll { Get-ChildItem -Path $args }
function la { Get-ChildItem -Force -Path $args }
Set-Alias -Name lg -Value lazygit -ErrorAction SilentlyContinue

# Community Unix Tool Aliases
if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat-color { bat $args }
}

# ------------------------------------------------------------------------------
# Git Productivity Shortcuts
# ------------------------------------------------------------------------------
function gs { git status }
function gp { git push }
function gpl { git pull }
function gl { git log --oneline --graph --decorate -n 15 }
function gd { git diff }

# ------------------------------------------------------------------------------
# Antigravity Scaffolding & Utility Shortcuts
# ------------------------------------------------------------------------------
$toolkitDir = "$HOME\.gemini\config\scripts\dev-toolkit"

function get-gitignore {
    param(
        [Parameter(Mandatory=$true)][string[]]$Tech
    )
    python "$toolkitDir\get_gitignore.py" @Tech
}

function scaffold-api {
    param(
        [Parameter(Mandatory=$true)][string]$Path,
        [string]$Name
    )
    python "$toolkitDir\scaffold.py" fastapi-backend $Path --name $Name
}

function scaffold-cli {
    param(
        [Parameter(Mandatory=$true)][string]$Path,
        [string]$Name
    )
    python "$toolkitDir\scaffold.py" python-cli $Path --name $Name
}

function scaffold-web {
    param(
        [Parameter(Mandatory=$true)][string]$Path
    )
    powershell "$toolkitDir\scaffold.ps1" -Type vite-react -TargetDir $Path
}

function tunnel {
    param(
        [Parameter(Mandatory=$true)][int]$Port,
        [string]$Subdomain
    )
    python "$toolkitDir\tunnel.py" $Port $Subdomain
}

function seed-data {
    param(
        [Parameter(Mandatory=$true)][ValidateSet("users","products","metrics","posts")][string]$Type,
        [int]$Count = 10,
        [string]$Out
    )
    if ($Out) {
        python "$toolkitDir\seed_data.py" $Type $Count --out $Out
    } else {
        python "$toolkitDir\seed_data.py" $Type $Count
    }
}

Write-Host "Antigravity Dev Toolkit loaded! Commands: scaffold-api, scaffold-web, scaffold-cli, seed-data, tunnel, lg, gs, gl" -ForegroundColor Cyan
