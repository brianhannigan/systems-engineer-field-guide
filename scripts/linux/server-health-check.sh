#!/usr/bin/env bash
set -euo pipefail

echo "Server Health Check"
echo "==================="
echo

echo "[Uptime]"
uptime
echo

echo "[Disk Usage]"
df -h
echo

echo "[Memory Usage]"
free -m || true
echo

echo "[Failed Services]"
systemctl --failed || true
echo

echo "[Recent Critical Logs]"
journalctl -p 3 -xb -n 50 || true
