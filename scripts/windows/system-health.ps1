Write-Host "Windows System Health" -ForegroundColor Cyan
Write-Host "====================="

Write-Host "`n[Computer Info]" -ForegroundColor Yellow
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber

Write-Host "`n[Volumes]" -ForegroundColor Yellow
Get-Volume | Select-Object DriveLetter, FileSystemLabel, SizeRemaining, Size

Write-Host "`n[Automatic Services Not Running]" -ForegroundColor Yellow
Get-Service | Where-Object { $_.StartType -eq "Automatic" -and $_.Status -ne "Running" } |
    Select-Object Name, DisplayName, Status, StartType

Write-Host "`n[Recent System Events]" -ForegroundColor Yellow
Get-WinEvent -LogName System -MaxEvents 25 |
    Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message
