# STIG Troubleshooting

## Purpose
This document provides a repeatable workflow for diagnosing systems that break after hardening changes, policy tightening, or baseline enforcement.

## Why This Matters
STIG implementation often improves security while introducing operational friction. Services may stop working not because the system is “bad,” but because a dependency, permission, access path, or policy assumption changed.

A strong administrator should be able to answer:

- what changed
- what broke
- why it broke
- how to restore function safely
- how to preserve compliance or document exceptions

## Core Troubleshooting Workflow

1. Identify exactly what changed
2. Identify exactly what broke
3. Confirm whether the issue is service, access, or application behavior
4. Review logs and denials
5. Compare before/after settings if possible
6. Validate permissions, authentication, SELinux, and firewall behavior
7. Apply the smallest safe corrective action
8. Re-test functionality
9. Capture evidence and determine whether an exception is required

## First Commands to Run
```bash
systemctl status <service>
journalctl -xe
journalctl -u <service> -n 100 --no-pager
getenforce
ausearch -m avc -ts recent
firewall-cmd --list-all
ss -tulpn
ls -l /path/to/file
id <service-account>
```

## What to Ask First
- What hardening change was applied?
- Was the system working before the change?
- Did the issue affect remote access, application behavior, or both?
- Did the service fail to start or start incorrectly?
- Did logging, file access, or network reachability change?
- Did authentication or account policy change?

## Most Common Break Categories

### 1. SSH / Remote Access Breakage
Typical causes:
- `sshd_config` settings changed
- root login disabled unexpectedly
- old auth method no longer allowed
- firewall port rule removed or changed
- crypto restrictions affect older clients

Useful commands:
```bash
systemctl status sshd
journalctl -u sshd -n 100 --no-pager
sshd -t
ss -tulpn | grep :22
firewall-cmd --list-all
```

### 2. Permission or Ownership Breakage
Typical causes:
- service account lost access to config, temp, PID, or log path
- tighter file mode broke app startup
- inherited path permissions prevent execution or reads

Useful commands:
```bash
ls -l /path/to/file
namei -l /path/to/file
id <service-account>
sudo -u <service-account> test -r /path/to/file && echo readable
```

### 3. SELinux Denials
Typical causes:
- app moved to nonstandard path
- web service needs content context restored
- daemon attempts action outside allowed type behavior

Useful commands:
```bash
getenforce
sestatus
ausearch -m avc -ts recent
restorecon -Rv /path/to/content
```

### 4. Firewall / Network Restriction
Typical causes:
- required port no longer allowed
- zone assignment changed
- service binds correctly but path is blocked

Useful commands:
```bash
firewall-cmd --list-all
firewall-cmd --list-ports
ss -tulpn
curl -I http://localhost
```

### 5. Service Account / Auth Policy Breakage
Typical causes:
- account restrictions changed
- password rules affect service startup
- PAM or login policy blocks automation or access

Useful checks:
- service unit account
- PAM changes
- authentication logs
- lockout or shell restrictions

## Example Scenario: SSH Breaks After Hardening

### Symptom
Users cannot connect after a hardening update.

### Workflow
```bash
systemctl status sshd
journalctl -u sshd -n 100 --no-pager
sshd -t
ss -tulpn | grep :22
firewall-cmd --list-all
```

### Likely Causes
- invalid SSH configuration
- stricter auth settings
- firewall rule changed
- user access assumptions invalidated

### Safe Response
- confirm exact config error
- restore a working access method
- document which control caused impact
- retest with intended auth path

## Example Scenario: Web Service Starts but Site Is Broken

### Symptom
Service is active, but the application does not function correctly.

### Workflow
```bash
systemctl status nginx
journalctl -u nginx -n 100 --no-pager
ls -l /var/www/html
getenforce
ausearch -m avc -ts recent
curl -I http://localhost
```

### Likely Causes
- content path permission problem
- SELinux context issue
- log or temp path write restriction
- app dependency denied access

## Example Scenario: App Fails After Permission Tightening

### Symptom
A service fails on restart after a security baseline is applied.

### Workflow
```bash
systemctl status <service>
journalctl -u <service> -n 100 --no-pager
ls -l /path/to/app/config
id <service-account>
namei -l /path/to/app/config
```

### Likely Causes
- app user cannot read config
- app user cannot write runtime directory
- inherited parent directory permission changed

## Safe Fix Pattern
Use the smallest safe corrective action that restores required function.

Good pattern:
1. prove root cause
2. fix only the required setting
3. re-test
4. document the change
5. determine whether this is compliant, compensating, or exception-worthy

## Evidence to Capture
For every hardening-related fix, capture:

- what rule or change was involved
- what symptom occurred
- what commands proved the issue
- what corrective action was taken
- what validation proved recovery
- whether an exception or compensating control is needed

## Exception Thinking
Sometimes a control cannot be applied cleanly to a mission-critical workload. When that happens, document:

- business impact
- technical reason
- security risk introduced
- compensating controls
- approval path if required

## Validation Checklist
- service starts correctly
- access works as intended
- expected ports are reachable
- logs are clean after the fix
- compliance impact is understood
- evidence is documented

## Quick Runbook Summary
```bash
systemctl status <service>
journalctl -u <service> -n 100 --no-pager
journalctl -xe
getenforce
ausearch -m avc -ts recent
firewall-cmd --list-all
ss -tulpn
ls -l /path/to/file
```
