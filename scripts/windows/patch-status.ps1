Write-Host "Windows Patch Status" -ForegroundColor Cyan
Write-Host "===================="

Get-HotFix |
    Sort-Object InstalledOn -Descending |
    Select-Object -First 20 Description, HotFixID, InstalledBy, InstalledOn
