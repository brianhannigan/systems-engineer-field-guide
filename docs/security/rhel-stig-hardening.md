# RHEL STIG Hardening

## Objectives

Apply and validate a secure baseline aligned with enterprise and DoD-style expectations.

## High-Level Controls

- disable direct root SSH login
- enforce password policy
- enable audit logging
- disable unused services
- validate firewall configuration
- restrict file permissions on sensitive files

## Example Checks

### SSH hardening

    sudo grep -E "PermitRootLogin|PasswordAuthentication" /etc/ssh/sshd_config

### Audit rules

    sudo auditctl -l

### Sensitive permissions

    ls -l /etc/shadow
    ls -l /etc/ssh/sshd_config

## Notes

Document which controls are applied automatically, manually, or by baseline tooling.
