# Terraform Deployment

## Goal

Use infrastructure as code to deploy predictable and reviewable Azure resources.

## Workflow

1. initialize provider plugins
2. validate syntax
3. review plan
4. apply approved changes
5. capture outputs
6. document deployed resources

## Commands

    terraform init
    terraform fmt -recursive
    terraform validate
    terraform plan -out=tfplan
    terraform apply tfplan

## Guardrails

- never apply unreviewed production changes
- commit code before apply
- store state securely
- document variable inputs and outputs
