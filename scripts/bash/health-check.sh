#!/usr/bin/env bash
set -euo pipefail

echo "=== Hostname ==="
hostname

echo "=== Uptime ==="
uptime

echo "=== Disk Usage ==="
df -h

echo "=== Memory ==="
free -h || true

echo "=== Failed Services ==="
systemctl --failed || true
