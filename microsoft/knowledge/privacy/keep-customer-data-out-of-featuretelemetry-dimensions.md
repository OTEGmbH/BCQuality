---
bc-version: [all]
domain: privacy
keywords: [featuretelemetry, customdimensions, telemetry, pii, customercontent]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Keep customer data out of FeatureTelemetry custom dimensions

## Description

`Codeunit "Feature Telemetry"` writes telemetry through methods such as `LogUsage`, `LogUptake`, and `LogError`. The `CustomDimensions` dictionary passed to those methods is exported to the telemetry pipeline, so it has the same privacy boundary as `Session.LogMessage` dimensions. Customer names, email addresses, employee numbers, user IDs, security IDs, notes, and `GetLastErrorText()` do not become safe merely because they are structured dimensions.

## Best Practice

Log feature state, event names, counts, enum values, and non-personal technical identifiers. Omit customer and employee identifiers from `CustomDimensions`; if diagnostics need correlation, use a non-personal event ID or aggregate count instead.

See sample: `keep-customer-data-out-of-featuretelemetry-dimensions.good.al`.

## Anti Pattern

Adding employee numbers, user names, customer emails, free-text descriptions, or raw `GetLastErrorText()` to the `CustomDimensions` dictionary before calling `FeatureTelemetry.LogUsage`, `LogUptake`, or `LogError`.

See sample: `keep-customer-data-out-of-featuretelemetry-dimensions.bad.al`.
