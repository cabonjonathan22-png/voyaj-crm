<#
.SYNOPSIS
  Construit l'installeur Windows du client : dist\VoyajCRM-Setup-<version>.exe

.DESCRIPTION
  1. Compile le client Flutter en mode release.
  2. Ajoute le runtime Visual C++ à côté de l'exécutable (les PC neufs ne
     l'ont pas toujours) et, si -ServerUrl est fourni, le fichier voyaj.json
     qui préconfigure l'adresse du serveur (les utilisateurs arrivent
     directement sur l'écran de connexion).
  3. Compile l'installeur avec Inno Setup.

  Prérequis : Flutter, Visual Studio (C++), Inno Setup 6
  (winget install JRSoftware.InnoSetup --scope user).

.EXAMPLE
  .\build-client-installer.ps1 -ServerUrl "https://crm.voyaj.fr"
#>
[CmdletBinding()]
param(
  [string]$ServerUrl,
  [switch]$SkipBuild
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$ClientDir = Join-Path $RepoRoot 'apps\client'
$DistDir = Join-Path $RepoRoot 'dist'
$Staging = Join-Path $DistDir 'client'

function Write-Step([string]$Message) { Write-Host "==> $Message" -ForegroundColor Cyan }

# Version lue dans le pubspec (x.y.z, sans le numéro de build).
$Version = (Select-String -Path (Join-Path $ClientDir 'pubspec.yaml') -Pattern '^version:\s*([0-9.]+)').Matches[0].Groups[1].Value

if (-not $SkipBuild) {
  Write-Step "Compilation du client $Version (release)"
  Push-Location $ClientDir
  try {
    & flutter build windows --release
    if ($LASTEXITCODE -ne 0) { throw 'La compilation Flutter a échoué.' }
  } finally { Pop-Location }
}

Write-Step 'Préparation des fichiers'
if (Test-Path $Staging) { Remove-Item -Recurse -Force $Staging }
New-Item -ItemType Directory -Force (Join-Path $Staging 'app') | Out-Null
Copy-Item -Recurse (Join-Path $ClientDir 'build\windows\x64\runner\Release\*') (Join-Path $Staging 'app')
Copy-Item (Join-Path $ClientDir 'windows\runner\resources\app_icon.ico') $Staging

# Runtime Visual C++ (déploiement local à l'application, autorisé par Microsoft).
$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$vsPath = & $vswhere -latest -products * -property installationPath
$crt = Get-ChildItem (Join-Path $vsPath 'VC\Redist\MSVC') -Directory |
  Sort-Object Name -Descending |
  ForEach-Object { Get-ChildItem (Join-Path $_.FullName 'x64') -Directory -Filter 'Microsoft.VC*.CRT' -ErrorAction SilentlyContinue } |
  Select-Object -First 1
if (-not $crt) { throw 'Runtime Visual C++ introuvable : installez la charge « Développement Desktop en C++ ».' }
Copy-Item (Join-Path $crt.FullName '*.dll') (Join-Path $Staging 'app')

if ($ServerUrl) {
  $json = @{ server_url = $ServerUrl } | ConvertTo-Json -Compress
  [IO.File]::WriteAllText((Join-Path $Staging 'app\voyaj.json'), $json, (New-Object Text.UTF8Encoding $false))
  Write-Host "   Serveur préconfiguré : $ServerUrl"
}

Write-Step "Compilation de l'installeur"
$iscc = @(
  "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
  "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
  "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $iscc) { throw 'Inno Setup 6 introuvable (winget install JRSoftware.InnoSetup --scope user).' }

& $iscc /Q "/DAppVersion=$Version" "/DSourceDir=$Staging\app" "/DOutputDir=$DistDir" (Join-Path $PSScriptRoot 'client-installer.iss')
if ($LASTEXITCODE -ne 0) { throw "La compilation de l'installeur a échoué." }

$setup = Join-Path $DistDir "VoyajCRM-Setup-$Version.exe"
$size = [Math]::Round((Get-Item $setup).Length / 1MB, 1)
Write-Host "Installeur prêt : $setup ($size Mo)" -ForegroundColor Green
