#!/usr/bin/env bash
set -euo pipefail

echo "Patch Check"
echo "==========="

if command -v dnf >/dev/null 2>&1; then
    dnf check-update || true
elif command -v yum >/dev/null 2>&1; then
    yum check-update || true
else
    echo "No supported package manager detected."
fi
