# Lab 02 - Service Failure

## Objective
Simulate and troubleshoot a failed service using a repeatable workflow.

## Prerequisites
- Linux VM
- a service you can safely stop/start or misconfigure in lab

## Tasks
1. Identify the target service
2. Stop or break the service safely
3. Review service status
4. Review logs
5. Fix the issue
6. Restart and validate

## Suggested Commands
```bash
systemctl status <service>
journalctl -u <service> -n 100 --no-pager
journalctl -xe
ss -tulpn
```

## Failure Ideas
- bad config syntax
- wrong file permissions
- service disabled
- port conflict

## Validation
- Service starts successfully
- Logs are clean after fix
- Expected port or app behavior is restored
