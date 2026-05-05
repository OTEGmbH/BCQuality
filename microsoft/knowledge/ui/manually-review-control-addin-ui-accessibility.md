---
bc-version: [all]
domain: ui
keywords: [control-addin, javascript, accessibility, wcag, keyboard, aria]
technologies: [al, javascript]
countries: [w1]
application-area: [all]
---

# Manually review UI-rendering control add-in changes for accessibility

## Description

JavaScript control add-ins bypass much of the Business Central client's built-in accessibility support. Once the add-in renders its own HTML, JavaScript, or CSS, the extension owns WCAG 2.1 AA concerns such as accessible names, semantic HTML, keyboard navigation, color contrast, focus management, and 200% zoom/reflow. Automated review cannot exhaustively verify those behaviours.

## Best Practice

When a control add-in change touches DOM creation, templates, CSS, interaction handlers, ARIA attributes, dynamic visibility, or focus flow, include a manual accessibility review finding even if no specific defect is obvious. Do not require manual accessibility review for pure data processing or API changes that do not render UI.

## Anti Pattern

Treating a control add-in diff as clean because no AL page properties changed. A new `div`-based button without an accessible name, a keyboard trap, or a color-only status indicator lives in JavaScript and still affects Business Central users.
