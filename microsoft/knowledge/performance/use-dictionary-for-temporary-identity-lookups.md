---
bc-version: [all]
domain: performance
keywords: [dictionary, temporary-table, lookup, identity, o1]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Use Dictionary for temporary identity lookups

## Description

A temporary record is useful when code needs record semantics: filters, keys, FlowFields, or table-shaped buffers. When the only operation is "have I seen this key?" or "what value belongs to this key?", a `Dictionary` is the simpler and faster structure. Dictionary lookup is O(1) by key, while a temporary table still pays record and key-management overhead.

## Best Practice

Use `Dictionary` for in-memory lookup sets and maps whose keys fit in memory and whose access pattern is by identity. Keep temporary tables for data that needs table APIs, multiple keys, filter expressions, or later processing as records.

See sample: `use-dictionary-for-temporary-identity-lookups.good.al`.

## Anti Pattern

Creating a temporary table solely to call `Get` or `FindFirst` by a single key in a loop. The code looks familiar to AL developers, but it is heavier than the lookup problem requires.

See sample: `use-dictionary-for-temporary-identity-lookups.bad.al`.
