---
title: 'Payload Validation'
source: 'https://json-schema.org/understanding-json-schema/'
description: 'Request and response validation patterns to protect API contracts and data quality.'
tags: ['rest-api', 'validation', 'api-contract']
---

# Payload Validation

## Overview

Validation protects system boundaries. Without strict validation, bad payloads leak into storage,
business logic, and downstream services.

Validation should happen before business processing starts.

### Quick Takeaways

- Validate payloads at API boundaries
- Use explicit schema-based checks
- Return structured field-level validation errors

## Definition

Payload validation checks:

- shape (required fields, types)
- constraints (length, range, enum)
- semantic consistency (cross-field logic)
- request and response payload contracts

## The Analogy

Airport security screening:

- identity check -> required fields
- bag scan -> type and constraint checks
- additional checks -> semantic rules

Skipping one checkpoint increases risk downstream.

## When You See It

You need strong validation in:

- create and update endpoints
- webhook receivers
- public APIs with untrusted clients
- internal APIs with multiple teams

## Examples

**Good:**

- Reject invalid payload with `422` and field-level errors

**Bad:**

- Accept everything, fail later in DB with generic `500`

**Good snippet (schema first):**

```ts
// Validate request body using schema before processing
const result = createPromptSchema.safeParse(req.body)
if (!result.success) {
  // Return structured validation errors with 422 status
  return res.status(422).json({
    code: 'validation_failed',
    details: result.error.issues
  })
}
```

**Bad snippet (late failure):**

```ts
try {
  // Direct database insert without validation - bad practice
  await db.prompts.insert(req.body)
  return res.status(201).json({ ok: true })
} catch {
  // Generic error hides real validation issues
  return res.status(500).json({ message: 'Something went wrong' })
}
```

## Important Points

- Validate at API boundary, not deep in service chain
- Use explicit schemas, not ad-hoc checks
- Return structured errors for each invalid field
- Validate responses for critical public endpoints

## Status Code Boundary

- Use `400` when request syntax is malformed
- Use `422` when syntax is valid but business payload is invalid
- Use `500` only for unexpected server-side failures

## Summary

- Validation preserves contract quality and operational stability.
- Early rejection is cheaper than late failure.
- _Strict boundaries keep systems flexible, not rigid._
