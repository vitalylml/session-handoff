# Installs the session handoff skills for Claude Code (user level) and creates the global sessions folder.
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File install.ps1 [-Uninstall]
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'
$skills = @('start-session', 'save-session', 'resume-session', 'list-sessions')
$source = Join-Path $PSScriptRoot 'skills'
$target = Join-Path $HOME '.claude\skills'
$sessionsHome = if ($env:SESSIONS_HOME) { $env:SESSIONS_HOME } else { Join-Path $HOME '.sessions' }

if ($Uninstall) {
    foreach ($s in $skills) {
        $path = Join-Path $target $s
        if (Test-Path $path) { Remove-Item -Recurse -Force $path; Write-Output "Removed $path" }
    }
    Write-Output "Sessions in $sessionsHome were kept."
    return
}

New-Item -ItemType Directory -Force $target | Out-Null
foreach ($s in $skills) {
    $dest = Join-Path $target $s
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse (Join-Path $source $s) $dest
    Write-Output "Installed $dest"
}

New-Item -ItemType Directory -Force $sessionsHome | Out-Null
Write-Output "Global sessions folder: $sessionsHome"
Write-Output 'Start a new Claude Code session to use /start-session, /save-session, /resume-session and /list-sessions.'
