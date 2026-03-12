# Azure VM Management

## Core Tasks

- start / stop / restart virtual machines
- review status and health
- validate networking and NSG alignment
- monitor disk and performance metrics
- confirm backup protection status

## Example Azure PowerShell Commands

    Get-AzVM -Status
    Start-AzVM -ResourceGroupName "<rg>" -Name "<vm>"
    Stop-AzVM -ResourceGroupName "<rg>" -Name "<vm>" -Force
    Restart-AzVM -ResourceGroupName "<rg>" -Name "<vm>"
