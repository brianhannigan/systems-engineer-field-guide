# Lab 04 - Patching

## Objective
Practice a controlled patching workflow with pre-checks and post-validation.

## Prerequisites
- Linux VM
- patch-capable package manager
- reboot allowed if needed

## Tasks
1. Record current package and service baseline
2. Check available updates
3. Apply updates
4. Reboot if required
5. Re-run validation checks
6. Document results

## Suggested Commands
```bash
dnf check-update
dnf update -y
rpm -qa | sort
systemctl --failed
journalctl -p err -b
```

## Validation
- Updates applied successfully
- System came back cleanly
- Services are healthy
- No major new errors were introduced
