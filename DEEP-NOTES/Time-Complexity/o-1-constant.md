---
title: 'O(1) Constant Time'
source: 'https://en.wikipedia.org/wiki/Big_O_notation'
description: "What constant time means, when it happens, and why it's the best scaling you can ask for. No growth with input size."
tags:
  - 'time complexity'
  - 'Big O'
  - 'constant time'
  - 'algorithms'
---

# O(1) Constant Time

## Overview

This note covers **O(1) constant time**: the complexity class where the number of operations does not depend on the size of the input. Runtime is effectively the same whether you have 10 items or 10 million. It's the best scaling behavior in Big O terms, and the one you want for hot paths when you can get it. **Goal:** recognize operations that are safe to call repeatedly without worrying about data size growing.

## Definition

**O(1)** means the algorithm's running time is bounded by a constant, independent of the input size _n_. Formally: there exists some constant _c_ such that for large enough _n_, the number of steps is at most _c_. So we say "constant time."

- The actual time might be 1 nanosecond or 10 milliseconds. Big O doesn't care about the constant.
- What matters: doubling or tripling the input does **not** change the number of steps.

## The Analogy

**Checking the time on a wall clock.** Whether it's 1:00 or 12:59, you look at the clock once. Same action, same cost. The "input" (current time) doesn't change how many times you look. That's O(1). (It's not about "very fast," but about "the number of steps does not grow when the data grows.")

## When You See It

Typical O(1) operations:

- **Array index access**: `arr[i]` when the index is known (e.g. random access in a contiguous array).
- **Hash table lookup**: `map.get(key)` on average, assuming a good hash and load factor.
- **Reading a fixed field**: e.g. `object.id`, `list.length` (when length is stored).
- **Pushing/popping the back of a dynamic array**: amortized O(1) for many implementations (e.g. `push`/`pop` on a list that doubles when full).

Not O(1): scanning the whole array to find something (that's at least O(n)), or doing a binary search (O(log n)).

## Examples

**Good: constant-time access by index**

```typescript
/**
 * Get first array element.
 * @description Single index access regardless of array size.
 * @param arr - Source array to access
 * @returns First element or undefined
 */
function getFirst<T>(arr: T[]): T | undefined {
  return arr[0]
}
```

**Good: hash lookup (average case)**

```typescript
/** User lookup by ID. */
const userById = new Map<string, User>()
const user = userById.get(id)
```

**Bad:** getting first element by scanning (O(n), not O(1))

```typescript
/**
 * Find element by scanning array.
 * @description Scans up to n elements - linear time.
 * @param arr - Source array to search
 * @param predicate - Matching function
 * @returns First matching element or undefined
 */
function getFirstByScan<T>(arr: T[], predicate: (x: T) => boolean): T | undefined {
  return arr.find(predicate)
}
```

## Important Points

- **O(1) = no growth with _n_.** Same cost for 10 or 10,000,000 elements (within the constant).
- Prefer O(1) for operations on the critical path: lookups, peeking at a known position, updating a single record by key.
- Hash tables and arrays (by index) are your main tools for O(1) access, use them when the problem allows.
- "Constant" doesn't mean "instant." It means the cost doesn't scale with input size.

## Summary

- **O(1)**: runtime bounded by a constant, independent of input size.
- **Analogy**: checking a wall clock. One look, same effort any time.
- **Use it for**: index access, hash lookups, reading a fixed field, aim for it on hot paths when possible.

_Constant time doesn't mean fast in absolute terms. It means your cost doesn't grow when the data does._
