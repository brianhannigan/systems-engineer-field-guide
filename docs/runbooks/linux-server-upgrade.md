# Linux Server Upgrade Runbook

## Pre-Upgrade Validation

### Identify platform version

    cat /etc/os-release
    uname -r

### Check uptime and current health

    uptime
    systemctl --failed
    journalctl -p 3 -xb

### Verify disk capacity

    df -h
    du -sh /var /usr /home

### Verify backup state

- confirm latest backup completed successfully
- confirm restore path is documented
- confirm rollback point exists if required

### Confirm maintenance window

- approved change ticket
- business owner approval
- support contacts notified

## Apply Updates

### Refresh metadata and apply patches

    sudo dnf check-update
    sudo dnf update -y

### Reboot if required

    sudo reboot

## Post-Upgrade Validation

### Confirm system returns successfully

    uptime
    systemctl --failed
    journalctl -p 3 -xb

### Validate critical services

    systemctl status sshd
    systemctl status firewalld

### Document outcome

- package changes applied
- reboot status
- service validation results
- issues or deviations
