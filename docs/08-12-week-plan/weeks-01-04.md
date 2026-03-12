# Weeks 1-4

## Objective
Survive the first month, learn the environment, and establish operational awareness.

## Week 1 - Environment Discovery
### Goals
- Build a system inventory
- Identify Linux, Windows, Azure, and Terraform touchpoints
- Learn who owns what
- Identify monitoring, patching, and backup systems

### Study Topics
- Linux basics
- Service management
- Existing infrastructure diagrams
- Ticket and change processes

### Hands-On Tasks
- Collect server lists
- Review runbooks and diagrams
- Validate access methods
- Identify critical systems

### Validation
- You can explain the major systems at a high level
- You know where logs, docs, and monitoring live

## Week 2 - Linux Foundations
### Goals
- Build confidence with Linux navigation and troubleshooting
- Understand services, logs, networking, and disk usage

### Study Topics
- `systemctl`
- `journalctl`
- `ss`
- `df`, `du`, `lsblk`
- permissions and sudo

### Hands-On Tasks
- Troubleshoot a failed service in lab
- Practice log review
- Practice network checks
- Practice disk usage triage

### Validation
- You can diagnose a service issue methodically

## Week 3 - STIG and Security Baseline Awareness
### Goals
- Understand why hardening breaks systems
- Learn how to validate security changes safely

### Study Topics
- STIG concepts
- SSH hardening
- SELinux basics
- firewall review
- least privilege

### Hands-On Tasks
- Review hardening docs
- Compare service before/after config changes
- Practice access validation after security changes

### Validation
- You can explain common hardening breakpoints

## Week 4 - Terraform and Azure Introduction
### Goals
- Understand the structure of infrastructure-as-code
- Learn Azure resource basics

### Study Topics
- Terraform init/plan/apply
- providers/resources/variables
- Azure VMs, VNets, NSGs, RBAC

### Hands-On Tasks
- Read existing Terraform code if available
- Run a safe Terraform lab
- Review Azure VM and network inventory

### Validation
- You can explain what a Terraform plan is doing
