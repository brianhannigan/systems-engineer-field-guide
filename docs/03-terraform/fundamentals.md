# Terraform Fundamentals

## Purpose
This document explains Terraform from an infrastructure operator's perspective: how to read it, review it safely, predict impact, and avoid common mistakes.

## Why Terraform Matters
Terraform turns infrastructure changes into reviewable code. For systems administration and platform work, that means:

- changes can be planned before execution
- intent is visible in code
- review is more disciplined
- environments can be more consistent
- drift becomes easier to identify

## Core Concepts

### Provider
The provider connects Terraform to a platform such as Azure.

Example:
```hcl
provider "azurerm" {
  features {}
}
```

### Resource
A resource is an infrastructure object Terraform manages.

Example:
```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-sysadmin-lab"
  location = "East US"
}
```

### Variable
Variables are inputs used to make code reusable and environment-aware.

Example:
```hcl
variable "location" {
  type    = string
  default = "East US"
}
```

### Output
Outputs expose useful values after deployment.

Example:
```hcl
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
```

### Module
A module is a reusable collection of Terraform code.

Common use cases:
- standard VM pattern
- standard NSG pattern
- resource group + tagging pattern
- subnet pattern

### State
Terraform state is Terraform's memory of what it manages. It is operationally sensitive and should be handled carefully.

## Basic Workflow
```bash
terraform fmt
terraform validate
terraform init
terraform plan
terraform apply
terraform destroy
```

## Operator Review Workflow
Before applying any change:

1. Read the code
2. Identify what resources are affected
3. Confirm the target subscription or environment
4. Confirm variables and tfvars inputs
5. Run `terraform fmt`
6. Run `terraform validate`
7. Run `terraform plan`
8. Read the plan carefully
9. Only apply after the plan matches expectation

## What to Look for in a Plan
When reading `terraform plan`, verify:

- what is being created
- what is being changed in place
- what is being destroyed
- whether names, regions, and sizes are correct
- whether networking changes are broader than expected
- whether identity or access changes are included
- whether tags or standard settings are drifting

## Safe Admin Mindset
Do not treat Terraform like a magic deploy button.

Use this mindset:

- code first
- plan before apply
- understand before execute
- prefer small changes
- watch for drift
- protect state
- validate after apply

## Common Admin Mistakes
- applying without reading the plan
- working in the wrong subscription or environment
- using stale local code
- changing cloud resources manually, then forgetting drift exists
- treating state casually
- assuming “no syntax error” means “safe change”

## Small Azure Example
```hcl
terraform {
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-sysadmin-lab"
  location = "East US"
}
```

## Validation Before Apply
```bash
terraform fmt
terraform validate
terraform init
terraform plan
```

## Validation After Apply
After a successful apply, verify in both Terraform and Azure:

```bash
terraform state list
terraform output
```

Then validate in Azure:
- resource exists in expected resource group
- region is correct
- naming is correct
- tags are correct
- no unexpected side effects occurred

## Reading Terraform Like an Admin
When you open Terraform code, answer these questions:

- What provider is being used?
- What subscription or environment is this targeting?
- What resources are defined here?
- What variables control behavior?
- Are modules hiding important complexity?
- Where is state stored?
- What would happen if this ran today?

## Review Checklist
- provider and environment understood
- variables reviewed
- plan reviewed carefully
- create/change/destroy actions understood
- state location understood
- validation plan exists after apply

## Example Admin Notes to Capture in This Repo
As you gain experience, update this document with:
- actual plan patterns from your environment
- safe review habits your team uses
- known module conventions
- common drift situations
- mistakes that caused rework

## Quick Reference
```bash
terraform fmt
terraform validate
terraform init
terraform plan
terraform apply
terraform state list
terraform output
```
