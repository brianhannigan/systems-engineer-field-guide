# Service Management

## Purpose
This document is a practical service troubleshooting runbook for Linux administrators working in production-minded environments.

## Why This Matters
Service failures are one of the fastest ways infrastructure issues become user-visible. A strong administrator should be able to move from symptom to root cause methodically instead of restarting blindly.

## Core systemd Commands
```bash
systemctl status <service>
systemctl restart <service>
systemctl stop <service>
systemctl start <service>
systemctl enable <service>
systemctl disable <service>
systemctl is-active <service>
systemctl is-enabled <service>
systemctl list-units --type=service
systemctl --failed
```

## First-Response Workflow
When a service is reported as down or unstable:

1. Confirm the exact service name
2. Check current service status
3. Check recent logs
4. Confirm whether the process is listening on the expected port
5. Check config syntax if supported
6. Check permissions, SELinux, and firewall behavior
7. Restart only after evidence is gathered
8. Validate that recovery is real, not just temporary

## Primary Triage Commands
```bash
systemctl status <service>
journalctl -u <service> -n 100 --no-pager
journalctl -xe
ss -tulpn
ps aux | grep <service>
```

## Common Failure Categories

### 1. Bad Configuration
Typical symptoms:
- service fails immediately after restart
- `systemctl status` shows exit code
- logs show syntax or parsing errors

Examples:
```bash
nginx -t
sshd -t
apachectl configtest
```

### 2. Port Binding Failure
Typical symptoms:
- service appears to start then exits
- logs mention bind failure or address in use
- expected port is already used by another process

Examples:
```bash
ss -tulpn | grep :80
ss -tulpn | grep :443
lsof -i :80
```

### 3. Permission Denied
Typical symptoms:
- service account cannot read config
- app cannot write PID, lock, or log file
- logs show access denied

Examples:
```bash
ls -l /path/to/file
namei -l /path/to/file
```

### 4. SELinux Denial
Typical symptoms:
- service looks correctly configured
- permissions look fine
- logs or audit records show blocked access

Examples:
```bash
getenforce
ausearch -m avc -ts recent
sealert -a /var/log/audit/audit.log
restorecon -Rv /path/to/app
```

### 5. Firewall or Network Dependency Issue
Typical symptoms:
- service is active but unreachable
- app binds only to localhost
- dependency host cannot be reached

Examples:
```bash
firewall-cmd --list-all
ss -tulpn
curl -I http://localhost
curl -I http://127.0.0.1
ping <dependency-host>
```

## Validation Pattern
Never stop at “service is active.”

Validate all of the following where applicable:

- service is active
- process is running
- expected port is listening
- local app response is healthy
- remote access works if expected
- recent logs are clean
- monitoring returns to normal

Examples:
```bash
systemctl is-active <service>
ss -tulpn
curl -I http://localhost
journalctl -u <service> -n 20 --no-pager
```

## Example Scenario: NGINX Fails After Config Change

### Symptom
Website returns error after a configuration update.

### Triage
```bash
systemctl status nginx
journalctl -u nginx -n 50 --no-pager
nginx -t
ss -tulpn | grep :80
```

### Possible Findings
- syntax error in site config
- port conflict on 80
- bad file permissions on cert or key
- SELinux denial for content path

### Recovery
```bash
nginx -t
systemctl restart nginx
curl -I http://localhost
journalctl -u nginx -n 20 --no-pager
```

## Example Scenario: SSH Access Breaks After Hardening

### Symptom
Users can no longer connect over SSH.

### Triage
```bash
systemctl status sshd
journalctl -u sshd -n 100 --no-pager
sshd -t
ss -tulpn | grep :22
firewall-cmd --list-all
getenforce
ausearch -m avc -ts recent
```

### Common Causes
- invalid `sshd_config`
- firewall rule changed
- root login or auth method disabled unexpectedly
- SELinux denial on nonstandard path
- permissions wrong on SSH config or key files

## Operational Rules
- do not restart first and investigate later
- capture evidence before making changes
- validate using both service state and functional behavior
- document recurring patterns in the repo
- build reusable troubleshooting checklists

## Minimum Evidence to Capture
- service status output
- relevant log lines
- config test result if applicable
- port listening output
- command used to fix the issue
- proof of successful validation

## Quick Runbook Summary
```bash
systemctl status <service>
journalctl -u <service> -n 100 --no-pager
ss -tulpn
# config test if supported
systemctl restart <service>
curl -I http://localhost
```
