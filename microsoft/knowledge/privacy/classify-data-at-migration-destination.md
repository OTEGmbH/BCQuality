---
bc-version: [all]
domain: privacy
keywords: [migration, dataclassification, hybrid, destination, pii]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Classify migrated data at the destination field

## Description

Hybrid migration codeunits such as HybridSL, HybridGP, and HybridBC legitimately process sensitive source data: tax IDs, employee identifiers, financial balances, and customer records. The privacy concern is not that the migration code touches the data. The concern is where the data lands: the destination table field must have a DataClassification value that matches the migrated content.

## Best Practice

When reviewing migration code, follow the assignment to the destination field and verify that the destination table declares an appropriate field-level or inherited DataClassification. Treat the migration procedure itself as expected business functionality; flag only missing or understated classification on the persistent destination.

See sample: `classify-data-at-migration-destination.good.al`.

## Anti Pattern

Flagging a migration procedure merely because it copies tax IDs or names from a source system. That creates false positives and misses the real issue: a destination field with no classification, `ToBeClassified`, or `SystemMetadata` for customer or employee data.

See sample: `classify-data-at-migration-destination.bad.al`.
