---
title: 'API Fundamentals'
source: 'https://restfulapi.net/'
description: 'Core REST API principles, constraints, and practical boundaries.'
tags: ['rest-api', 'http', 'architecture']
---

# API Fundamentals

## Overview

REST API is not just JSON over HTTP. It is a design style for exposing resources through clear
interfaces. Good REST design makes contracts predictable, easier to evolve, and easier to debug.

The main goal is consistency. Teams move faster when naming, behavior, and response shape are
stable across endpoints.

### Quick Takeaways

- Design resource-first, not action-first
- Keep contracts stable across endpoints
- Use HTTP semantics as interface guarantees

## Definition

REST is an architectural style where:

- resources are identified by URIs
- operations use standard HTTP methods
- communication is stateless
- responses are cache-aware when possible

## The Analogy

Think of REST API like a well-organized library:

- URI is the shelf location
- method is the action (read, add, update, remove)
- status code is the librarian response
- payload is the actual book content

If every shelf uses different rules, nobody finds anything.

## When You See It

You are usually in REST territory when:

- your backend exposes CRUD-like resources
- multiple clients need the same contract
- you need long-term maintainability and observability

## Examples

**Good:**

- `GET /v1/prompts`
- `POST /v1/prompts`
- `PATCH /v1/prompts/{id}`

**Bad:**

- `POST /getPromptsList`
- `POST /deletePromptById`
- `POST /editPrompt`

**Good snippet (uniform contract):**

```http
GET /v1/prompts
POST /v1/prompts
PATCH /v1/prompts/{id}
DELETE /v1/prompts/{id}
```

**Bad snippet (action endpoints):**

```http
POST /v1/getPromptsList
POST /v1/removePromptById
POST /v1/updatePromptById
```

## Important Points

- Resource-first design beats action-first URL naming
- Stateless requests simplify scaling and retries
- Uniform conventions reduce client complexity
- REST is a style, not a strict spec

## Summary

- REST API is about predictable contracts, not trends.
- Stable structure now prevents expensive rewrites later.
- _Consistency is the real speed multiplier in API systems._
