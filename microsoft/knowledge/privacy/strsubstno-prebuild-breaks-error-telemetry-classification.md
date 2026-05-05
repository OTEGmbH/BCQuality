---
bc-version: [all]
domain: privacy
keywords: [strsubstno, error, telemetry, dataclassification, pii]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Pre-building Error text with StrSubstNo defeats platform PII stripping

## Description

Error messages are captured by platform telemetry. When Error receives a format template and substitution arguments directly (`Error('... %1 ...', Value)`), the platform can classify and strip sensitive values before telemetry is written. This is true whether the arguments are record fields, local variables, function results, or other expressions. When the caller pre-builds the message with StrSubstNo and then passes the resulting Text to Error, the platform sees a plain string with no argument context and logs the whole thing verbatim — any PII already baked in is exported to telemetry.

## Best Practice

Pass the template and substitution arguments directly to Error. Declare the template as a Label with a Comment describing each placeholder. Do not flag direct Error substitution merely because an argument may contain a customer name, email address, or phone number; the platform intercepts those arguments before telemetry.

See sample: `strsubstno-prebuild-breaks-error-telemetry-classification.good.al`.

## Anti Pattern

Assigning the output of StrSubstNo to a Text variable and passing that variable to Error. Every substituted value is now part of an opaque string; the platform cannot classify it and logs everything.

See sample: `strsubstno-prebuild-breaks-error-telemetry-classification.bad.al`.
