[CmdletBinding()]
param(
    [string] $Environment = 'Development',
    [switch] $Drop
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($env:LITESCREEN_DB_CONNECTION_STRING)) {
    throw 'Set LITESCREEN_DB_CONNECTION_STRING before running database migrations.'
}

$databaseRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$grateArguments = @(
    "--connectionstring=$env:LITESCREEN_DB_CONNECTION_STRING"
    '--databasetype=sqlserver'
    "--sqlfilesdirectory=$databaseRoot"
    "--environment=$Environment"
    '--noninteractive'
)
if ($Drop) {
    $grateArguments += '--drop'
}

& grate @grateArguments
exit $LASTEXITCODE
