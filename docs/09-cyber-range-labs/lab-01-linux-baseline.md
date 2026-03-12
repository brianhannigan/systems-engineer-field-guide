# Lab 01 - Linux Baseline

## Objective
Establish a healthy Linux baseline and verify core admin checks.

## Prerequisites
- Access to a Linux VM
- sudo access
- basic shell familiarity

## Tasks
1. Confirm hostname and uptime
2. Review running services
3. Check disk usage
4. Check IP addressing and routes
5. Review recent logs
6. Confirm firewall state
7. Record findings

## Suggested Commands
```bash
hostnamectl
uptime
systemctl --failed
df -h
lsblk
ip addr
ip route
journalctl -p err -b
firewall-cmd --state
```

## Expected Outcome
You can describe the VM's current health and baseline configuration.

## Validation
- No unexplained failed services
- Disk is healthy
- Network is understood
- No major boot errors are present
