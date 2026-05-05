---
bc-version: [all]
domain: privacy
keywords: [tobeclassified, dataclassification, release, gdpr, placeholder]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Resolve ToBeClassified before release

## Description

`DataClassification = ToBeClassified` is a development marker, not a releasable privacy state. It tells reviewers and tooling that the field still needs classification work. Shipping it prevents data-subject, retention, and telemetry tooling from making a correct decision about the field.

## Best Practice

Replace every `ToBeClassified` value with the narrowest accurate classification before the PR ships to customers. If the field inherits a correct table-level DataClassification, remove the placeholder rather than leaving a field-level `ToBeClassified` override.

## Anti Pattern

Treating ToBeClassified as a safe default because the field is new or because the final classification is uncertain. Uncertainty should bias toward a stronger classification, not toward an unresolved placeholder.
