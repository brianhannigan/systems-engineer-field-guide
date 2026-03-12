# Patch Management Runbook

## Objective

Apply patches in a controlled and validated way across Linux, Windows, and cloud-connected assets.

## Workflow

1. Review vulnerability and patch advisories
2. Identify affected assets
3. Test in lower environment where possible
4. Schedule maintenance window
5. Apply patches
6. Reboot and validate
7. Re-scan or re-check status
8. Document completion

## Minimum Validation

- services started successfully
- no critical errors in system logs
- monitoring is healthy
- disk and memory usage remain normal
- security controls still active

## Rollback Requirements

- snapshot, image, or backup available
- restore owner identified
- rollback decision criteria defined
