[CmdletBinding()]
param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Section {
    param([string]$Message)
    Write-Host ""
    Write-Host "=== $Message ===" -ForegroundColor Cyan
}

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
    else {
        Write-Host "Directory exists: $Path" -ForegroundColor DarkGray
    }
}

function Ensure-File {
    param(
        [string]$Path,
        [string]$Content
    )

    if ((Test-Path -LiteralPath $Path) -and -not $Force) {
        Write-Host "File exists, skipped: $Path" -ForegroundColor DarkGray
        return
    }

    $parent = Split-Path -Parent $Path
    if ($parent) {
        Ensure-Directory -Path $parent
    }

    Set-Content -LiteralPath $Path -Value $Content -Encoding UTF8
    Write-Host "Wrote file: $Path" -ForegroundColor Green
}

function Upsert-ReadmeSection {
    param(
        [string]$ReadmePath,
        [string]$Header,
        [string]$SectionContent
    )

    $content = Get-Content -LiteralPath $ReadmePath -Raw
    $escapedHeader = [regex]::Escape($Header)
    $pattern = "(?ms)^$escapedHeader\s*$.*?(?=^##\s|\z)"

    if ([regex]::IsMatch($content, $pattern)) {
        $updated = [regex]::Replace($content, $pattern, ($SectionContent.Trim() + "`r`n"))
        Set-Content -LiteralPath $ReadmePath -Value $updated -Encoding UTF8
        Write-Host "Updated README section: $Header" -ForegroundColor Green
        return
    }

    $updated = $content.TrimEnd() + "`r`n`r`n" + $SectionContent.Trim() + "`r`n"
    Set-Content -LiteralPath $ReadmePath -Value $updated -Encoding UTF8
    Write-Host "Added README section: $Header" -ForegroundColor Green
}

Write-Section "Validating repository path"

if (-not (Test-Path -LiteralPath $RepoRoot)) {
    throw "RepoRoot does not exist: $RepoRoot"
}

$readmePath = Join-Path $RepoRoot "README.md"
if (-not (Test-Path -LiteralPath $readmePath)) {
    throw "README.md not found at: $readmePath"
}

Write-Host "Repository root validated: $RepoRoot" -ForegroundColor Green

Write-Section "Ensuring target folders exist"

$folders = @(
    "docs/workflows",
    "docs/metrics",
    "docs/architecture",
    "diagrams/placeholders"
)

foreach ($folder in $folders) {
    Ensure-Directory -Path (Join-Path $RepoRoot $folder)
}

Write-Section "Creating workflow documents"

$securityWorkflow = @"
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
"@

$validationWorkflow = @"
# Change Validation Workflow

## Purpose
Use this workflow after upgrades, hardening changes, Terraform applies, patching, and remediation work.

## Workflow

~~~text
Planned Change Complete
        ↓
Validate Service Health
        ↓
Validate Network Paths
        ↓
Validate Logs and Errors
        ↓
Validate Monitoring / Alerts
        ↓
Validate Security / Compliance State
        ↓
Capture Evidence
        ↓
Close Change or Roll Back
~~~

## Validation Checklist
- Service starts successfully
- Required ports are listening
- Users can authenticate
- Monitoring is healthy
- No new critical errors appear in logs
- Security baseline remains acceptable
- Evidence is recorded for the ticket or change record
"@

Ensure-File -Path (Join-Path $RepoRoot "docs/workflows/security-incident-workflow.md") -Content $securityWorkflow
Ensure-File -Path (Join-Path $RepoRoot "docs/workflows/change-validation-workflow.md") -Content $validationWorkflow

Write-Section "Creating metrics documents"

$engineeringMetrics = @"
# Engineering Metrics

## Why Metrics Matter
Metrics help a systems engineer prove improvement, identify bottlenecks, and prioritize operational effort.

## Core Metrics

### Mean Time to Resolution (MTTR)
How long it takes to restore service or resolve a validated issue.

### Patch Latency
The time between patch release / approval and production deployment.

### Vulnerability Closure Rate
How quickly validated findings are remediated and closed.

### Change Success Rate
The percentage of infrastructure or application changes that succeed without rollback, outage, or incident.

### Availability / Uptime
How reliably critical systems remain available to users.

### Repeat Incident Rate
How often the same issue returns after an attempted fix.

## How to Use These Metrics
- Track trends over time
- Review during retrospectives
- Use them to justify automation and hardening improvements
- Identify unstable services or weak operational areas
"@

$metricsScorecard = @"
# Operational Metrics Scorecard Template

| Metric | Definition | Target | Current | Notes |
|---|---|---:|---:|---|
| MTTR | Average time to resolve incidents | TBD | TBD | |
| Patch Latency | Time from patch approval to deployment | TBD | TBD | |
| Vulnerability Closure Rate | Time to remediate findings | TBD | TBD | |
| Change Success Rate | % of successful changes | TBD | TBD | |
| Availability | % uptime for critical services | TBD | TBD | |
| Repeat Incident Rate | Recurring issue frequency | TBD | TBD | |

## Review Guidance
Update this scorecard monthly or after major operational reviews.
"@

Ensure-File -Path (Join-Path $RepoRoot "docs/metrics/engineering-metrics.md") -Content $engineeringMetrics
Ensure-File -Path (Join-Path $RepoRoot "docs/metrics/operational-metrics-scorecard-template.md") -Content $metricsScorecard

Write-Section "Creating architecture documents"

$architectureDoc = @"
# Infrastructure Architecture Overview

## Purpose
This document describes the major systems engineering layers represented in this repository.

## Conceptual Architecture

~~~text
                    Azure / Cloud Resources
                             │
         ┌───────────────────┴───────────────────┐
         │                                       │
   Linux Servers                           Windows Servers
         │                                       │
         └────────────── Terraform / Automation ──────────────┘
                             │
                    Hardening & Compliance
                       (STIG / Baselines)
                             │
                    Monitoring / Logging
                             │
                  Vulnerability Remediation
                             │
                 Validation / Operational Evidence
~~~

## Design Intent
- Support repeatable infrastructure deployment
- Keep hardening connected to operational testing
- Treat remediation as a lifecycle, not a one-time task
- Reinforce documentation and evidence collection
"@

$diagramPlaceholder = @"
# Infrastructure Architecture Diagram Placeholder

Create a polished diagram asset for the infrastructure architecture shown in the related markdown doc.

## Suggested Final Assets
- infrastructure-architecture.svg
- infrastructure-architecture.png
- infrastructure-architecture.drawio

## Diagram Content
- Azure / cloud layer
- Linux and Windows server layer
- Terraform / automation layer
- STIG / compliance layer
- Monitoring / logging layer
- Vulnerability remediation / validation layer
"@

$securityDiagramPlaceholder = @"
# Security Incident Workflow Diagram Placeholder

Create a polished diagram asset for the security incident workflow.

## Suggested Final Assets
- security-incident-workflow.svg
- security-incident-workflow.png
- security-incident-workflow.drawio
"@

Ensure-File -Path (Join-Path $RepoRoot "docs/architecture/infrastructure-architecture-overview.md") -Content $architectureDoc
Ensure-File -Path (Join-Path $RepoRoot "diagrams/placeholders/infrastructure-architecture.md") -Content $diagramPlaceholder
Ensure-File -Path (Join-Path $RepoRoot "diagrams/placeholders/security-incident-workflow.md") -Content $securityDiagramPlaceholder

Write-Section "Updating README navigation"

$securitySection = @"
## Security Incident Workflow

This section connects infrastructure operations to security-aware investigation, containment, remediation, and recovery.

- [Security Incident Workflow](docs/workflows/security-incident-workflow.md)
- [Change Validation Workflow](docs/workflows/change-validation-workflow.md)
- [Security Diagram Placeholder](diagrams/placeholders/security-incident-workflow.md)
"@

$metricsSection = @"
## Operational Metrics

These documents help measure engineering performance, remediation efficiency, and service reliability.

- [Engineering Metrics](docs/metrics/engineering-metrics.md)
- [Operational Metrics Scorecard Template](docs/metrics/operational-metrics-scorecard-template.md)
"@

$architectureSection = @"
## Infrastructure Architecture

This section explains the systems engineering stack represented throughout the guide.

- [Infrastructure Architecture Overview](docs/architecture/infrastructure-architecture-overview.md)
- [Architecture Diagram Placeholder](diagrams/placeholders/infrastructure-architecture.md)
"@

Upsert-ReadmeSection -ReadmePath $readmePath -Header "## Security Incident Workflow" -SectionContent $securitySection
Upsert-ReadmeSection -ReadmePath $readmePath -Header "## Operational Metrics" -SectionContent $metricsSection
Upsert-ReadmeSection -ReadmePath $readmePath -Header "## Infrastructure Architecture" -SectionContent $architectureSection

Write-Section "Complete"

Write-Host "Security workflow, metrics, and architecture docs added." -ForegroundColor Green
Write-Host ""
Write-Host "Next commands:" -ForegroundColor Yellow
Write-Host "cd `"$RepoRoot`""
Write-Host "git status"
Write-Host "git add README.md docs diagrams tools"
Write-Host "git commit -m `"docs: add security workflow metrics and architecture guidance`""
Write-Host "git push"