---
bc-version: [all]
domain: upgrade
keywords: [primary-key, field-type, existing-data, schema, breaking-change]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Assess existing data before primary-key or field-type changes

## Description

Primary-key and field-type changes are upgrade concerns because existing rows may no longer map safely to the new schema. The risk depends on whether the table already has tenant data and whether the old values can be converted without loss. New feature tables with no production rows do not have the same migration burden as ledger, document, or base application tables.

## Best Practice

For existing tables with data, require a concrete migration or compatibility assessment before changing keys or field types. For new tables, new feature tables, or Integer-to-BigInteger changes with evidence that existing values fit, avoid flagging a breaking-change finding without data-impact evidence.

## Anti Pattern

Treating every primary-key edit in a new feature table as a blocker while missing a key or type change on an established ledger-like table. Reviewers need to tie the finding to existing tenant data, not just to the syntactic shape of the schema edit.
