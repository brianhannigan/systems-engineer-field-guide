# Lab 05 - STIG Hardening

## Objective
Practice validating security changes and identifying operational breakpoints.

## Prerequisites
- Linux VM
- safe test changes only
- ability to recover access if SSH settings are changed

## Tasks
1. Record baseline access and service behavior
2. Apply a limited hardening change
3. Test access and application behavior
4. Review logs and denials
5. Adjust safely if needed
6. Document the impact

## Suggested Commands
```bash
systemctl status sshd
cat /etc/ssh/sshd_config
sshd -t
getenforce
ausearch -m avc -ts recent
firewall-cmd --list-all
journalctl -xe
```

## Validation
- You can identify what changed
- You can explain why the change affected behavior
- You can restore working access safely
