# Change Validation Workflow

## Purpose
Use this workflow after upgrades, hardening changes, Terraform applies, patching, and remediation work.

## Workflow

~~~text
Planned Change Complete
        ↓
Validate Service Health
        ↓
Validate Network Paths
        ↓
Validate Logs and Errors
        ↓
Validate Monitoring / Alerts
        ↓
Validate Security / Compliance State
        ↓
Capture Evidence
        ↓
Close Change or Roll Back
~~~

## Validation Checklist
- Service starts successfully
- Required ports are listening
- Users can authenticate
- Monitoring is healthy
- No new critical errors appear in logs
- Security baseline remains acceptable
- Evidence is recorded for the ticket or change record
