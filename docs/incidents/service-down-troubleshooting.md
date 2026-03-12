# Service Down Troubleshooting

## First Checks

- determine whether the outage is local or broad
- check monitoring alert details
- identify last known good time

## Linux

    systemctl status <service-name>
    journalctl -u <service-name> -n 100
    ss -tulpn

## Windows

    Get-Service -Name <service-name>
    Get-WinEvent -LogName System -MaxEvents 100
    netstat -ano

## Decision Tree

1. service not running -> attempt controlled restart
2. port not listening -> inspect config and dependencies
3. dependency failure -> restore dependency first
4. recurring failure -> collect logs and escalate
