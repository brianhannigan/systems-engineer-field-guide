# Terraform

## Purpose
Document the practical Terraform command flow and safe usage habits.

## Core Workflow
```bash
terraform fmt
terraform validate
terraform init
terraform plan
terraform apply
terraform destroy
```

## Admin Rules
- read the code before plan
- read the plan before apply
- understand target subscription or environment
- avoid casual state manipulation
- treat destroy carefully

## Common Notes to Capture
- provider requirements
- variable file usage
- state location
- module dependencies
- output interpretation

## Validation
- plan is understood
- apply matches expectation
- cleanup is deliberate
