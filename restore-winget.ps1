$ErrorActionPreference = "Stop"

$BaseUrl = "https://raw.githubusercontent.com/serosme/winget-setup/main"
$TempFile = Join-Path $env:TEMP "winget-backup.json"

$Backups = @(
    "winget-base.json",
    "winget-dev.json"
)

try {
    Write-Host "Available Winget backups:`n"

    for ($i = 0; $i -lt $Backups.Count; $i++) {
        Write-Host "[$($i + 1)] $($Backups[$i])"
    }

    $choice = Read-Host "`nSelect a backup to import"

    if (-not ($choice -as [int]) -or
        $choice -lt 1 -or
        $choice -gt $Backups.Count) {
        throw "Invalid selection."
    }

    $SelectedBackup = $Backups[$choice - 1]
    $BackupUrl = "$BaseUrl/$SelectedBackup"

    Write-Host "`nDownloading Winget backup..."
    Invoke-WebRequest $BackupUrl -OutFile $TempFile

    Write-Host "Importing Winget backup..."
    winget import -i $TempFile

    Write-Host "Cleaning up..."
    Remove-Item $TempFile -Force

    Write-Host "Winget restore completed successfully."
}
catch {
    Write-Error "Restore failed: $_"
    if (Test-Path $TempFile) {
        Remove-Item $TempFile -Force
    }
    exit 1
}
