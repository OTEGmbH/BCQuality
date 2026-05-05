---
bc-version: [all]
domain: ui
keywords: [grid, fixed, showcaption, accessibility, table-semantics]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Use the grid data-table pattern consistently

## Description

Business Central `grid` and `fixed` layouts render either as data tables or layout tables based on a structural heuristic. A data table requires all direct children to be groups, every group child to be a field, and all fields to have `ShowCaption = false`. If the structure fails that heuristic, the client renders a layout table; hidden captions on editable fields then remove the only accessible labels.

## Best Practice

Use one pattern consistently. For a data-table grid, make every direct child a group and every field `ShowCaption = false`. For a layout grid, keep captions visible on editable or tabular fields and hide captions only on standalone non-editable content where the missing label is not a form-field problem.

See sample: `use-grid-data-table-pattern-consistently.good.al`.

## Anti Pattern

Mixing the patterns: one loose field, nested group, or visible field caption prevents data-table rendering, while other editable fields still hide captions. The result looks like a table visually but has layout-table semantics and missing labels for assistive technology.

See sample: `use-grid-data-table-pattern-consistently.bad.al`.
