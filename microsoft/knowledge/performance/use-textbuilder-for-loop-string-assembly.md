---
bc-version: [all]
domain: performance
keywords: [textbuilder, string-concatenation, loop, text, allocation]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Use TextBuilder for loop-based string assembly

## Description

Repeated `Text := Text + ...` concatenation inside a loop reallocates and copies the growing string on every iteration. In AL, `TextBuilder` is the platform type for constructing larger text payloads incrementally. `StrSubstNo` remains appropriate for formatting one message; TextBuilder is for many appends, especially inside loops.

## Best Practice

Use `TextBuilder.Append` or `AppendLine` when assembling CSV rows, log payloads, JSON-ish diagnostic text, or other multi-line strings from repeated loop iterations. Convert to Text once, after the loop, with `ToText()`.

See sample: `use-textbuilder-for-loop-string-assembly.good.al`.

## Anti Pattern

Appending to the same Text variable on every iteration of a large loop. Each append copies the accumulated prefix again, so the cost grows with both row count and final string length.

See sample: `use-textbuilder-for-loop-string-assembly.bad.al`.
