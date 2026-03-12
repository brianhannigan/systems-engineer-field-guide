param(
    [string]$ResourceGroupName = "",
    [string]$Name = ""
)

if (-not (Get-Module -ListAvailable -Name Az.Compute)) {
    Write-Error "Az.Compute module is not installed."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($ResourceGroupName) -or [string]::IsNullOrWhiteSpace($Name)) {
    Write-Host "Usage: .\vm-status.ps1 -ResourceGroupName <rg> -Name <vm>" -ForegroundColor Yellow
    exit 1
}

Get-AzVM -ResourceGroupName $ResourceGroupName -Name $Name -Status |
    Select-Object Name, ResourceGroupName, Location,
        @{Name="PowerState";Expression={$_.Statuses | Where-Object {$_.Code -like "PowerState/*"} | Select-Object -ExpandProperty DisplayStatus}},
        @{Name="ProvisioningState";Expression={$_.Statuses | Where-Object {$_.Code -like "ProvisioningState/*"} | Select-Object -ExpandProperty DisplayStatus}}
