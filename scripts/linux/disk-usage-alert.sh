#!/usr/bin/env bash
set -euo pipefail

THRESHOLD="${1:-85}"

echo "Checking filesystems above ${THRESHOLD}% utilization..."
df -hP | awk -v threshold="$THRESHOLD" 'NR>1 {
    gsub(/%/,"",$5);
    if ($5+0 >= threshold) {
        print "ALERT:", $6, "is at", $5 "% used"
    }
}'
