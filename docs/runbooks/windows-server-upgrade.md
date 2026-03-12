# Windows Server Upgrade Runbook

## Pre-Upgrade Validation

- confirm change approval
- confirm backup or snapshot
- verify free disk space
- record installed roles and running services
- identify reboot impact

## Health Checks

    Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
    Get-Service | Where-Object {$_.Status -ne "Running" -and $_.StartType -eq "Automatic"}
    Get-Volume | Select-Object DriveLetter, SizeRemaining, Size

## Apply Updates

    Install-WindowsUpdate -AcceptAll -AutoReboot

## Post-Upgrade Validation

    Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 10
    Get-Service | Where-Object {$_.Status -ne "Running" -and $_.StartType -eq "Automatic"}
    Get-EventLog -LogName System -Newest 50

## Closeout

- confirm applications responded normally
- confirm monitoring restored
- document issues and remediation steps
