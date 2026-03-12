# High CPU Investigation

## Initial Triage

### Linux

    uptime
    top
    ps aux --sort=-%cpu | head
    journalctl -p 3 -xb

### Windows

    Get-Process | Sort-Object CPU -Descending | Select-Object -First 15
    Get-Counter '\Processor(_Total)\% Processor Time'

## Investigation Questions

- is the CPU spike sustained or transient?
- is a single process responsible?
- was there a recent deployment, patch, or config change?
- is the system under legitimate workload demand?

## Common Causes

- runaway process
- memory leak
- failed service restart loop
- scan or backup overload
- unexpected user/application demand

## Response Options

- restart offending service if approved
- scale resources if cloud-hosted and justified
- roll back recent change
- isolate workload for deeper investigation
