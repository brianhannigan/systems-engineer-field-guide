Write-Host "=== Computer Info ==="
Get-ComputerInfo | Select-Object CsName, WindowsProductName, OsVersion

Write-Host "`n=== Running Services ==="
Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object -First 20

Write-Host "`n=== Disk Usage ==="
Get-PSDrive -PSProvider FileSystem
