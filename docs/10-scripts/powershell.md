# PowerShell

## Purpose
Capture PowerShell patterns useful for Windows administration and inventory.

## Common Use Cases
- running service checks
- server inventory
- event log review
- patch or version checks
- quick environment reporting

## Example Inventory Script
```powershell
Write-Host "=== Computer Info ==="
Get-ComputerInfo | Select-Object CsName, WindowsProductName, OsVersion

Write-Host "`n=== Running Services ==="
Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object -First 20

Write-Host "`n=== Disk Usage ==="
Get-PSDrive -PSProvider FileSystem
```

## Script Design Rules
- be explicit with output
- avoid hidden assumptions
- prefer readable objects when possible
- capture before/after evidence for changes

## Validation
- output is meaningful
- script is safe to run repeatedly
- no unnecessary side effects
