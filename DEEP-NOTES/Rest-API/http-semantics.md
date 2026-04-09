---
title: 'HTTP Semantics'
source: 'https://www.rfc-editor.org/rfc/rfc9110'
description: 'How HTTP methods express intent, safety, and idempotency in REST APIs.'
tags: ['rest-api', 'http-methods', 'semantics']
---

# HTTP Semantics

## Overview

HTTP methods are contracts. If method semantics are wrong, clients cannot trust your API behavior.
Most production API bugs start from semantic mismatch, not syntax errors.

This note focuses on method intent, safety, and idempotency.

### Quick Takeaways

- Method choice defines behavior expectations
- Do not use `GET` for state changes
- Idempotency is critical for retry-safe operations

## Definition

- **Safe methods:** do not change server state (`GET`, `HEAD`)
- **Idempotent methods:** repeated call has same final state (`PUT`, `DELETE`)
- **Non-idempotent methods:** repeated call may create different outcomes (`POST`)

### Method Matrix

- `GET`: safe yes, idempotent yes, common use is read resource
- `POST`: safe no, idempotent no, common use is create action/session/resource
- `PUT`: safe no, idempotent yes, common use is full replace intent
- `PATCH`: safe no, usually non-idempotent, common use is partial update
- `DELETE`: safe no, idempotent yes, common use is remove resource

## The Analogy

Pressing an elevator button:

- `GET`: check current floor display
- `POST`: call elevator for a new trip
- `PUT`: set floor indicator to a specific value
- `DELETE`: clear a scheduled stop

Pressing once or five times should follow method semantics.

## When You See It

Common API design decisions:

- create session or token -> `POST`
- update one field -> `PATCH`
- replace full resource -> `PUT`
- remove resource -> `DELETE`

## Examples

**Good:**

- `DELETE /v1/sessions/{id}` to revoke one session

**Bad:**

- `GET /v1/logout` that mutates session state

**Good snippet (Express style):**

```ts
/**
 * Replace user resource completely.
 * @description Performs full update of user data.
 * @param req - Express request object
 * @param res - Express response object
 */
app.put('/v1/users/:id', async (req, res) => {
  const user = await replaceUser(req.params.id, req.body)
  return res.status(200).json(user)
})

/**
 * Partially update user resource.
 * @description Applies partial modifications to user.
 * @param req - Express request object
 * @param res - Express response object
 */
app.patch('/v1/users/:id', async (req, res) => {
  const user = await updateUserPartial(req.params.id, req.body)
  return res.status(200).json(user)
})
```

**Bad snippet (semantic mismatch):**

```ts
/**
 * Mutate server state incorrectly.
 * @description Demonstrates anti-pattern of state mutation in GET.
 * @param _req - Express request object unused
 * @param res - Express response object
 */
app.get('/v1/logout', async (_req, res) => {
  await revokeSession()
  return res.status(200).json({ ok: true })
})
```

## Important Points

- Use method semantics as interface guarantees
- Do not hide mutations behind `GET`
- Idempotency helps retries under network failure
- `PATCH` is partial update, `PUT` is full replacement intent

## Common Mistakes

- Using `POST` for every endpoint because it feels easier
- Treating `PATCH` as full replace and silently dropping omitted fields
- Returning different behavior for the same method on similar resources

## Summary

- Method choice is behavior design, not naming preference.
- Correct semantics reduce hidden production risk.
- _If clients must guess behavior, semantics are already broken._
