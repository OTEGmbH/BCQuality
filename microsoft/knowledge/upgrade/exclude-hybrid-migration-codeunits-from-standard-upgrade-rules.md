---
bc-version: [all]
domain: upgrade
keywords: [hybrid, migration, upgrade-tag, false-positive, datamigration]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Exclude Hybrid migration codeunits from standard upgrade rules

## Description

Hybrid migration codeunits such as `HybridBC14`, `HybridSL`, `HybridGP`, and `HybridBaseDeployment` are one-time migration paths with established migration-specific patterns. They are not ordinary `Subtype = Upgrade` steps, and forcing standard upgrade-tag, trigger-shape, or missing-upgrade-code rules onto them creates false positives.

## Best Practice

When a change is clearly in a Hybrid migration codeunit or migration namespace, review it against migration-specific data handling and destination classification rules. Do not flag it merely because it lacks ordinary upgrade tags or because its control flow differs from standard upgrade codeunits.

## Anti Pattern

Reporting "missing upgrade tag" or "missing standard upgrade code" on a `HybridSL`, `HybridGP`, `HybridBC`, or `HybridBaseDeployment` codeunit solely because it does not look like a normal upgrade step. The name and migration context are the signal that different rules apply.
