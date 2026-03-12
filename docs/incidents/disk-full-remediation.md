# Disk Full Remediation

## Linux

    df -h
    du -xh / | sort -h | tail -n 20
    journalctl --disk-usage

## Windows

    Get-Volume | Sort-Object SizeRemaining
    Get-ChildItem C:\ -Recurse -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object -First 50

## Remediation Steps

- identify growth path
- remove temporary or stale files where approved
- rotate or archive logs
- extend storage if needed
- confirm application recovery after cleanup

## Prevention

- alert on filesystem thresholds
- review retention settings
- validate log rotation
