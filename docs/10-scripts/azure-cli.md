# Azure CLI

## Purpose
Capture useful Azure CLI commands for inventory, validation, and troubleshooting.

## Common Use Cases
- list VMs
- inspect resource groups
- review NSGs
- review role assignments
- check monitoring-related resources

## Example Commands
```bash
az account show
az group list -o table
az vm list -o table
az network nsg list -o table
az role assignment list --all -o table
```

## Usage Rules
- confirm subscription context first
- prefer read-only commands when investigating
- capture outputs for evidence when useful
- avoid destructive commands without validation

## Validation
- command output matches expected environment
- subscription and scope are correct
