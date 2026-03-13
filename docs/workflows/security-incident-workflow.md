# Security Incident Workflow

## Purpose
This workflow links infrastructure operations, vulnerability management, and security response into one repeatable process.

## Workflow

~~~text
Alert
  ↓
Validate Alert
  ↓
Identify Affected System(s)
  ↓
Determine Severity and Scope
  ↓
Contain
  ↓
Investigate Root Cause
  ↓
Remediate
  ↓
Recover Service
  ↓
Validate Security and Stability
  ↓
Document Lessons Learned
~~~

## Use Cases
- Malicious process or suspicious service behavior
- Unexpected account activity
- Post-change security degradation
- Critical vulnerability on exposed systems
- Evidence of unauthorized configuration drift

## Key Questions
1. Is the alert real?
2. Which hosts, services, or identities are affected?
3. Does containment risk breaking mission-critical operations?
4. What is the fastest safe remediation path?
5. What evidence must be retained for audit and reporting?

## Engineering Notes
- Preserve logs before major changes when possible
- Coordinate with system owners before disruptive containment
- Validate both security posture and service restoration before closure
