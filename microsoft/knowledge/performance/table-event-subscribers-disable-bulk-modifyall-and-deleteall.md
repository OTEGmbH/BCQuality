---
bc-version: [all]
domain: performance
keywords: [event, subscriber, modifyall, deleteall, bulk, row-by-row]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Table event subscribers force ModifyAll and DeleteAll to run row-by-row

## Description

`ModifyAll` and `DeleteAll` normally compile to a single set-based SQL UPDATE or DELETE. That optimization is conditional: the server falls back to row-by-row execution when it must invoke AL per affected row. Common causes are global table delete triggers, table modify/delete event subscribers, and Media or MediaSet fields added to the table or a table extension.

The slowdown is invisible in the caller's source: the call site still reads as a bulk operation. It only shows up under load, and adding an apparently cheap subscriber (even an empty one, or one that guards on a condition and returns) is enough to trigger the fallback for every caller of ModifyAll/DeleteAll on that table across the system. Central tables — Item Ledger Entry, G/L Entry, Sales Line — are the worst places to attach such subscribers because every extension's bulk operation pays the cost.

## Best Practice

Before subscribing to a table's modify or delete events, consider whether the logic can live elsewhere — on the triggering action, on a specific OnValidate, or on a business-event publisher. If the subscriber, global trigger, or Media/MediaSet field is unavoidable, document that the table may no longer support set-based ModifyAll/DeleteAll. When a table has not regressed, prefer a small number of ModifyAll/DeleteAll calls; they are still commonly 10-50x faster than a manual loop.

## Anti Pattern

An empty or nearly-empty `OnAfterModifyEvent` subscriber on `Sales Line` added as a placeholder for future integration. Every `ModifyAll` on `Sales Line` — in the base app, in every extension, in every tenant — can now run one SQL UPDATE per row. The same regression can come from a global delete trigger or from adding a Media field to the table.
