#Requires -RunAsAdministrator
<#
.SYNOPSIS
  Désinstalle le service Windows du serveur Voyaj CRM.

.DESCRIPTION
  Arrête et supprime le service et les binaires. La configuration et les
  journaux (-DataDir) sont conservés, sauf avec -RemoveData. La base
  PostgreSQL n'est jamais touchée.
#>
[CmdletBinding()]
param(
  [string]$InstallDir = "$env:ProgramFiles\Voyaj Server",
  [string]$DataDir = "$env:ProgramData\Voyaj",
  [string]$ServiceName = 'VoyajServer',
  [switch]$RemoveData
)

$ErrorActionPreference = 'Stop'
$Wrapper = Join-Path $InstallDir "$ServiceName.exe"

$service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
if ($service) {
  if ($service.Status -ne 'Stopped') {
    Stop-Service -Name $ServiceName -Force
    $service.WaitForStatus('Stopped', [TimeSpan]::FromSeconds(30))
  }
  if (Test-Path $Wrapper) { & $Wrapper uninstall } else { & sc.exe delete $ServiceName | Out-Null }
  Write-Host "Service $ServiceName supprimé."
}

if (Test-Path $InstallDir) {
  Remove-Item -Recurse -Force $InstallDir
  Write-Host "Binaires supprimés ($InstallDir)."
}

if ($RemoveData -and (Test-Path $DataDir)) {
  Remove-Item -Recurse -Force $DataDir
  Write-Host "Configuration et journaux supprimés ($DataDir)."
} else {
  Write-Host "Configuration conservée dans $DataDir (clé maître incluse)."
}
