# Windows STIG Hardening

## Focus Areas

- password and account lockout policy
- local administrator control
- remote access restrictions
- audit policy
- Windows Defender and firewall state
- service and protocol hardening

## Example Validation

    secedit /export /cfg C:\temp\secpol.cfg
    Get-NetFirewallProfile
    AuditPol /get /category:*

## Documentation Expectations

- baseline used
- exceptions approved
- validation date
- remediation items remaining
