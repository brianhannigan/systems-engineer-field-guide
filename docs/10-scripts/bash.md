# Bash

## Purpose
Capture Bash patterns useful for Linux administration and health checks.

## Common Use Cases
- disk usage checks
- failed service checks
- uptime and host context
- package status review
- quick evidence capture

## Example Health Check
```bash
#!/usr/bin/env bash
set -euo pipefail

echo "=== Hostname ==="
hostname

echo "=== Uptime ==="
uptime

echo "=== Disk Usage ==="
df -h

echo "=== Failed Services ==="
systemctl --failed || true
```

## Script Design Rules
- fail clearly
- avoid silent destructive actions
- log useful output
- make validation obvious
- keep scripts readable

## Validation
- script runs cleanly
- output is understandable
- failures are visible
