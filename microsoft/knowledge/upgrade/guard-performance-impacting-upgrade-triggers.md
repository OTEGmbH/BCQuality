---
bc-version: [all]
domain: upgrade
keywords: [onvalidateupgrade, trigger, upgrade-tag, performance, justification]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Guard performance-impacting upgrade triggers

## Description

Upgrade validation triggers such as `OnValidateUpgradePerCompany` can run during upgrade for every tenant and company. Expensive validation, full-table scans, or repair logic in those triggers becomes part of the upgrade's critical path. The trigger is acceptable only when the work is necessary and when re-execution is prevented.

## Best Practice

Add written justification for the trigger's work and guard it with an upgrade tag just like a data-migration step. Check `HasUpgradeTag` before the expensive work and call `SetUpgradeTag` only after the work succeeds, so retries do not re-run completed validation.

See sample: `guard-performance-impacting-upgrade-triggers.good.al`.

## Anti Pattern

Putting `ValidateAllCustomers()`, table scans, or external-style setup validation directly in `OnValidateUpgradePerCompany` without a skip tag. The work runs on every upgrade attempt, including retries after unrelated failures.

See sample: `guard-performance-impacting-upgrade-triggers.bad.al`.
