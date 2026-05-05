---
bc-version: [all]
domain: ui
keywords: [showcaption, editable, accessibility, screen-reader, label]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Keep captions on editable fields

## Description

`ShowCaption = false` on an editable page field removes the visible and accessible label that identifies the input. `InstructionalText` is not a replacement: it behaves like placeholder text, disappears after entry, and is not reliably announced as the field label. The default `ShowCaption = true` is the safe form-field pattern.

## Best Practice

Leave captions visible on editable fields. `ShowCaption = false` is acceptable for non-editable content fields, for fields inside a valid data-table grid pattern, and for the first visible field in a parent group with a visible non-empty caption; in that last pattern, the group caption becomes the accessible label.

See sample: `keep-captions-on-editable-fields.good.al`.

## Anti Pattern

Hiding the caption on an editable field because the page layout looks cleaner, or because `InstructionalText` appears to describe the input. Screen reader users lose the field label, and sighted users lose the persistent visual cue.

See sample: `keep-captions-on-editable-fields.bad.al`.
