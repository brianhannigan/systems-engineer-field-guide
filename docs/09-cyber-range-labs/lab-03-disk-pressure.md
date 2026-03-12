# Lab 03 - Disk Pressure

## Objective
Practice detecting and resolving disk usage problems.

## Prerequisites
- Linux VM
- safe location for test files

## Tasks
1. Record current disk usage
2. Create test files to consume space
3. Re-check filesystem usage
4. Identify largest consumers
5. Clean up safely
6. Validate recovery

## Suggested Commands
```bash
df -h
du -sh /*
find /var/log -type f -size +100M
find / -xdev -type f -size +500M 2>/dev/null
```

## Safety Notes
- Do not fill critical filesystems completely
- Use a controlled test directory if possible

## Validation
- You can identify the source of disk growth
- Disk usage returns to normal after cleanup
