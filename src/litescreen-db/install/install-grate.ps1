[CmdletBinding()]
param(
    [string] $Version = '2.2.0'
)

$ErrorActionPreference = 'Stop'
$architecture = switch ($env:PROCESSOR_ARCHITECTURE) {
    'AMD64' { 'x64' }
    'ARM64' { 'arm64' }
    default { throw "Unsupported Windows architecture: $env:PROCESSOR_ARCHITECTURE" }
}

$asset = "grate-win-$architecture-self-contained-$Version.zip"
$downloadUri = "https://github.com/grate-devs/grate/releases/download/$Version/$asset"
$installDirectory = Join-Path $env:LOCALAPPDATA 'Programs\Grate'
$temporaryDirectory = Join-Path ([IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString())
$archivePath = Join-Path $temporaryDirectory $asset

try {
    New-Item -ItemType Directory -Path $temporaryDirectory -Force | Out-Null
    Invoke-WebRequest -Uri $downloadUri -OutFile $archivePath
    Expand-Archive -LiteralPath $archivePath -DestinationPath $temporaryDirectory -Force

    $grateExecutable = Get-ChildItem -LiteralPath $temporaryDirectory -Filter 'grate.exe' -File -Recurse |
        Select-Object -First 1
    if (-not $grateExecutable) {
        throw "The release archive did not contain grate.exe: $downloadUri"
    }

    New-Item -ItemType Directory -Path $installDirectory -Force | Out-Null
    Get-ChildItem -LiteralPath $grateExecutable.DirectoryName -Force |
        Copy-Item -Destination $installDirectory -Recurse -Force

    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    $pathEntries = @($userPath -split ';' | Where-Object { $_ })
    if ($installDirectory -notin $pathEntries) {
        $newPath = (@($pathEntries) + $installDirectory) -join ';'
        [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    }

    Write-Host "Installed Grate $Version to $installDirectory. Open a new terminal to use grate from PATH."
}
finally {
    Remove-Item -LiteralPath $temporaryDirectory -Recurse -Force -ErrorAction SilentlyContinue
}
