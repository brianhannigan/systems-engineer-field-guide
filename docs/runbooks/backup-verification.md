# Backup Verification Runbook

## Goal

Validate that backups are completing successfully and can support restore operations.

## Checklist

- confirm latest successful backup timestamp
- confirm backup includes critical system and data paths
- confirm retention policy is correct
- confirm restore testing has been performed
- confirm offsite or secondary location exists if required

## Linux Checks

    grep -i backup /var/log/messages

## Windows Checks

    Get-WinEvent -LogName Application | Where-Object {$_.Message -match "backup"} | Select-Object -First 20

## Validation Outcome

Document:
- backup date/time
- restore point or recovery identifier
- exceptions
- next test date
