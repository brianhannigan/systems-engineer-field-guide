# Infrastructure Architecture Overview

## Purpose
This document describes the major systems engineering layers represented in this repository.

## Conceptual Architecture

~~~text
                    Azure / Cloud Resources
                             │
         ┌───────────────────┴───────────────────┐
         │                                       │
   Linux Servers                           Windows Servers
         │                                       │
         └────────────── Terraform / Automation ──────────────┘
                             │
                    Hardening & Compliance
                       (STIG / Baselines)
                             │
                    Monitoring / Logging
                             │
                  Vulnerability Remediation
                             │
                 Validation / Operational Evidence
~~~

## Design Intent
- Support repeatable infrastructure deployment
- Keep hardening connected to operational testing
- Treat remediation as a lifecycle, not a one-time task
- Reinforce documentation and evidence collection
