# Troubleshooting

## Purpose
Track script and command patterns that support repeatable troubleshooting.

## Common Areas
- failed services
- ports not listening
- disk pressure
- bad config
- network reachability
- post-patch validation

## Example Linux Triage Commands
```bash
systemctl --failed
journalctl -xe
ss -tulpn
df -h
ip addr
ip route
```

## Example Windows Triage Commands
```powershell
Get-Service | Where-Object {$_.Status -ne "Running"}
Get-WinEvent -LogName System -MaxEvents 50
Get-PSDrive -PSProvider FileSystem
ipconfig /all
```

## Documentation Rules
- record what symptom triggered investigation
- record what command proved the issue
- record what fixed it
- record how success was validated

## Validation
- troubleshooting steps are repeatable
- commands are organized by symptom or subsystem
