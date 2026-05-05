---
bc-version: [all]
domain: performance
keywords: [event, subscriber, publisher, extension]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Keep event subscribers lightweight

> Contributions welcome — open a PR to refine or extend this article.

## Description

Event subscribers run synchronously on the publisher's thread. If a subscriber does heavy work — a database query, a web service call, a layout render — every caller of the publisher pays that cost. Subscribers on hot events (OnAfterValidate on common fields, OnBeforeInsert on ledger-entry-like tables) can multiply a small per-call cost into a system-wide regression.

## Best Practice

Keep subscribers small: guard early with inexpensive checks on the publisher record before doing any database work, defer heavy work to a task queue or a background session, and cache results across invocations when the data is stable. In hot events, a cheap `Type`/`Status`/`IsTemporary` exit before a `Get` or `FindFirst` is often the difference between a rare lookup and an N+1 query across every posted line.

See sample: `keep-event-subscribers-lightweight.good.al`.

## Anti Pattern

Calling an external web service, running a report, or iterating a large table from inside an event subscriber on a hot publisher makes every operation on that publisher as slow as the heaviest subscriber.

See sample: `keep-event-subscribers-lightweight.bad.al`.

