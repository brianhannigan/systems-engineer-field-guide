# Lab 06 - Terraform Workflow

## Objective
Practice the Terraform workflow from validation through cleanup.

## Prerequisites
- Terraform installed
- Azure credentials or a local safe Terraform example
- non-production test context only

## Tasks
1. Review the code
2. Run format and validation
3. Run a plan
4. Review the plan carefully
5. Apply if safe
6. Validate resources or outputs
7. Destroy if this is a temporary lab

## Suggested Commands
```bash
terraform fmt
terraform validate
terraform init
terraform plan
terraform apply
terraform destroy
```

## Validation
- Plan output is understood before apply
- Resources or outputs match expectation
- Cleanup is completed if lab is temporary
