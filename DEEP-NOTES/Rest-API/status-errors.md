---
title: 'Status Errors'
source: 'https://www.rfc-editor.org/rfc/rfc9110'
description: 'Reliable status code mapping and error payload contracts for production APIs.'
tags: ['rest-api', 'status-code', 'error-handling']
---

# Status Errors

## Overview

Status codes and error payloads are part of the API contract. If they are inconsistent, clients
implement brittle workarounds and reliability drops fast.

Treat errors as first-class response design.

### Quick Takeaways

- Use correct status code family (`2xx`, `4xx`, `5xx`)
- Keep one stable error envelope format
- Separate authentication and authorization failures

## Definition

- Status code describes high-level HTTP outcome
- Error body describes actionable details for client logic

Both must be stable and documented.

### Practical Status Mapping

- `200 OK`: read/update success with response body
- `201 Created`: create success for new resource
- `204 No Content`: success with no response body
- `400 Bad Request`: malformed syntax or invalid query format
- `401 Unauthorized`: authentication missing or invalid
- `403 Forbidden`: authenticated but not allowed
- `404 Not Found`: target resource not found
- `409 Conflict`: state conflict (duplicate key, version conflict)
- `422 Unprocessable Entity`: semantic payload validation failed
- `429 Too Many Requests`: rate limit exceeded
- `500 Internal Server Error`: unhandled server failure

## The Analogy

Status code is traffic light color. Error payload is the road sign explaining why you cannot pass.
One without the other creates confusion.

## When You See It

Critical response mapping areas:

- auth failures
- validation failures
- permission checks
- missing resources
- server faults

## Examples

**Good:**

- `401` for invalid token
- `403` for forbidden role
- `422` for payload validation failure

**Bad:**

- Returning `200` with `{ "error": true }` for failures

**Good snippet (status + envelope):**

```ts
if (!token) {
  return res.status(401).json({
    code: 'auth_missing',
    message: 'Authentication required',
    requestId
  })
}
```

**Bad snippet (ambiguous success):**

```ts
if (!token) {
  return res.status(200).json({
    error: true,
    message: 'Unauthorized'
  })
}
```

## Important Points

- Keep a single error envelope shape across all endpoints
- Separate auth (`401`) vs permission (`403`)
- Use `422` for semantic validation issues
- Include request id for support and tracing

## Error Envelope Example

**Good:**

- Use one consistent response body shape
- Include stable machine-readable `code`
- Include `requestId` for tracing support tickets

```json
{
  "code": "validation_failed",
  "message": "Payload validation failed",
  "details": [{ "field": "email", "issue": "invalid_format" }],
  "requestId": "req_01HR..."
}
```

**Bad:**

- Mixing different shapes per endpoint (`error`, `msg`, `reason`)
- Returning stack traces to clients in production

## Summary

- Consistent status and error contracts simplify client behavior.
- Error design quality directly affects system operability.
- _Predictable failures are a reliability feature, not a bonus._
