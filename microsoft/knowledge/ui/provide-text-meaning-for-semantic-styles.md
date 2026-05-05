---
bc-version: [all]
domain: ui
keywords: [style, styleexpr, favorable, unfavorable, ambiguous, accessibility]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Provide text meaning for semantic styles

## Description

Most Business Central page styles are cosmetic, but `Favorable`, `Unfavorable`, and `Ambiguous` communicate meaning through color. Color-only meaning is not accessible. A user who cannot perceive the style must still be able to determine whether the value is positive, negative, or uncertain from the caption, value, or nearby text.

## Best Practice

Use semantic styles only when the meaning is independently available: a caption such as "Error", a value such as "Failed", a signed number whose sign carries the meaning, or an adjacent status field. Cosmetic styles such as `Strong`, `Attention`, and `Subordinate` do not need this extra check. Cue tiles inside `cuegroup` are exempt because the client supplies accessible semantic labels.

See sample: `provide-text-meaning-for-semantic-styles.good.al`.

## Anti Pattern

Applying `Style = Favorable`, `Unfavorable`, or `Ambiguous` to a value whose text is neutral, such as "42" or "Open", without any caption or adjacent field explaining what the color means.

See sample: `provide-text-meaning-for-semantic-styles.bad.al`.
