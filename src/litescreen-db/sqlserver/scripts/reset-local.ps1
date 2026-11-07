[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($env:LITESCREEN_DB_CONNECTION_STRING)) {
    throw 'Set LITESCREEN_DB_CONNECTION_STRING to your local development database before resetting.'
}

$serverMatch = [regex]::Match($env:LITESCREEN_DB_CONNECTION_STRING, '(?i)(?:^|;)\s*(?:Server|Data Source|Address|Addr|Network Address)\s*=\s*([^;]+)')
$databaseMatch = [regex]::Match($env:LITESCREEN_DB_CONNECTION_STRING, '(?i)(?:^|;)\s*(?:Database|Initial Catalog)\s*=\s*([^;]+)')
if (-not $serverMatch.Success -or -not $databaseMatch.Success) {
    throw 'The connection string must include Server (or Data Source) and Database (or Initial Catalog) so the reset target can be confirmed.'
}

$server = $serverMatch.Groups[1].Value.Trim()
$database = $databaseMatch.Groups[1].Value.Trim()
$target = "$server/$database"
Write-Warning "This will DROP database '$database' on '$server', then recreate it and run every pending SQL Server migration. Only use a local development connection string."
$confirmation = Read-Host "Type '$target' to continue"
if ($confirmation -cne $target) {
    throw 'Reset cancelled; the confirmation did not match the target.'
}

& (Join-Path $PSScriptRoot 'migrate.ps1') -Environment Development -Drop
exit $LASTEXITCODE
