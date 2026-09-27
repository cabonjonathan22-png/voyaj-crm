#Requires -RunAsAdministrator
<#
.SYNOPSIS
  Installe le serveur Voyaj CRM comme service Windows (démarrage automatique).

.DESCRIPTION
  1. Compile le serveur (dart compile exe) si -BinaryPath n'est pas fourni.
  2. Copie le binaire dans -InstallDir et télécharge WinSW (empreinte vérifiée).
  3. Crée la configuration dans -DataDir\config\.env (clé maître générée,
     droits restreints à SYSTEM et Administrateurs) si elle n'existe pas.
  4. Applique les migrations puis installe et démarre le service.

  Relancer le script met à jour le binaire sans toucher à la configuration.

.EXAMPLE
  .\install-server.ps1 -DatabaseUrl "postgres://voyaj:motdepasse@localhost:5432/voyaj"
#>
[CmdletBinding()]
param(
  [string]$DatabaseUrl,
  [string]$InstallDir = "$env:ProgramFiles\Voyaj Server",
  [string]$DataDir = "$env:ProgramData\Voyaj",
  [string]$ServiceName = 'VoyajServer',
  [string]$BindAddress = '127.0.0.1',
  [int]$Port = 8080,
  [string]$BinaryPath
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$WinSwUrl = 'https://github.com/winsw/winsw/releases/download/v2.12.0/WinSW-x64.exe'
$WinSwSha256 = '05B82D46AD331CC16BDC00DE5C6332C1EF818DF8CEEFCD49C726553209B3A0DA'

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$ConfigDir = Join-Path $DataDir 'config'
$LogDir = Join-Path $DataDir 'logs'
$EnvFile = Join-Path $ConfigDir '.env'
$Exe = Join-Path $InstallDir 'voyaj_server.exe'
$Wrapper = Join-Path $InstallDir "$ServiceName.exe"

function Write-Step([string]$Message) { Write-Host "==> $Message" -ForegroundColor Cyan }

# ── 1. Binaire ──────────────────────────────────────────────────────────
if (-not $BinaryPath) {
  Write-Step 'Compilation du serveur'
  $BinaryPath = Join-Path $env:TEMP 'voyaj_server.exe'
  Push-Location $RepoRoot
  try {
    & dart compile exe apps/server/bin/voyaj_server.dart -o $BinaryPath
    if ($LASTEXITCODE -ne 0) { throw 'La compilation a échoué.' }
  } finally { Pop-Location }
}

$existing = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($existing -and $existing.Status -ne 'Stopped') {
  Write-Step 'Arrêt du service existant'
  Stop-Service -Name $ServiceName -Force
  $existing.WaitForStatus('Stopped', [TimeSpan]::FromSeconds(30))
}

New-Item -ItemType Directory -Force -Path $InstallDir, $ConfigDir, $LogDir | Out-Null
Copy-Item -Force $BinaryPath $Exe

# ── 2. WinSW ────────────────────────────────────────────────────────────
if (-not (Test-Path $Wrapper) -or (Get-FileHash $Wrapper -Algorithm SHA256).Hash -ne $WinSwSha256) {
  Write-Step 'Téléchargement de WinSW'
  Invoke-WebRequest -UseBasicParsing $WinSwUrl -OutFile $Wrapper
  $hash = (Get-FileHash $Wrapper -Algorithm SHA256).Hash
  if ($hash -ne $WinSwSha256) {
    Remove-Item $Wrapper
    throw "Empreinte WinSW inattendue ($hash) : téléchargement refusé."
  }
}

# ── 3. Configuration ────────────────────────────────────────────────────
if (-not (Test-Path $EnvFile)) {
  if (-not $DatabaseUrl) {
    throw 'Première installation : précisez -DatabaseUrl "postgres://utilisateur:motdepasse@hote:5432/base".'
  }
  Write-Step "Création de la configuration ($EnvFile)"
  $masterKey = (& $Exe gen-key).Trim()
  $content = @(
    '# Configuration du service Voyaj CRM (générée par install-server.ps1).',
    '# Sauvegardez VOYAJ_MASTER_KEY en lieu sûr : sans elle, les secrets chiffrés sont perdus.',
    "VOYAJ_HOST=$BindAddress",
    "VOYAJ_PORT=$Port",
    "DATABASE_URL=$DatabaseUrl",
    "VOYAJ_MASTER_KEY=$masterKey",
    'VOYAJ_LOG_LEVEL=INFO'
  ) -join "`n"
  [IO.File]::WriteAllText($EnvFile, "$content`n", (New-Object Text.UTF8Encoding $false))

  # Lecture réservée à SYSTEM et aux administrateurs.
  $acl = New-Object Security.AccessControl.FileSecurity
  $acl.SetAccessRuleProtection($true, $false)
  foreach ($sid in 'S-1-5-18', 'S-1-5-32-544') {
    $identity = New-Object Security.Principal.SecurityIdentifier $sid
    $rule = New-Object Security.AccessControl.FileSystemAccessRule($identity, 'FullControl', 'Allow')
    $acl.AddAccessRule($rule)
  }
  Set-Acl -Path $EnvFile -AclObject $acl
}

# ── 4. Service ──────────────────────────────────────────────────────────
$xml = @"
<service>
  <id>$ServiceName</id>
  <name>Voyaj CRM - Serveur</name>
  <description>Serveur Voyaj CRM (API REST et synchronisation).</description>
  <executable>%BASE%\voyaj_server.exe</executable>
  <arguments>--env-file "$EnvFile" serve</arguments>
  <workingdirectory>$DataDir</workingdirectory>
  <startmode>Automatic</startmode>
  <delayedAutoStart>true</delayedAutoStart>
  <stoptimeout>15 sec</stoptimeout>
  <onfailure action="restart" delay="10 sec"/>
  <onfailure action="restart" delay="30 sec"/>
  <onfailure action="restart" delay="60 sec"/>
  <resetfailure>1 hour</resetfailure>
  <logpath>$LogDir</logpath>
  <log mode="roll-by-size">
    <sizeThreshold>10240</sizeThreshold>
    <keepFiles>10</keepFiles>
  </log>
</service>
"@
[IO.File]::WriteAllText((Join-Path $InstallDir "$ServiceName.xml"), $xml, (New-Object Text.UTF8Encoding $false))

Write-Step 'Migrations de la base'
& $Exe --env-file $EnvFile migrate
if ($LASTEXITCODE -ne 0) { throw 'Les migrations ont échoué : vérifiez DATABASE_URL.' }

if (-not $existing) {
  Write-Step 'Installation du service'
  & $Wrapper install
  if ($LASTEXITCODE -ne 0) { throw "L'installation du service a échoué." }
}

Write-Step 'Démarrage du service'
Start-Service -Name $ServiceName

$health = "http://${BindAddress}:$Port/health"
for ($i = 0; $i -lt 30; $i++) {
  try {
    $status = Invoke-RestMethod $health -TimeoutSec 2
    Write-Host "Serveur opérationnel (version $($status.version)) : http://${BindAddress}:$Port" -ForegroundColor Green
    Write-Host "Créez un administrateur si besoin :"
    Write-Host "  & '$Exe' --env-file '$EnvFile' create-admin --email vous@exemple.fr --name 'Vous'"
    exit 0
  } catch { Start-Sleep -Seconds 1 }
}
throw "Le service ne répond pas : consultez les journaux dans $LogDir."
