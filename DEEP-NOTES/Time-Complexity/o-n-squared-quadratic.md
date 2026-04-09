---
title: 'O(n²) Quadratic Time'
source: 'https://en.wikipedia.org/wiki/Time_complexity'
description: 'What quadratic time means: work grows with the square of input size. Nested loops over n, and why it hurts at scale.'
tags:
  - 'time complexity'
  - 'Big O'
  - 'quadratic'
  - 'algorithms'
---

# O(n²) Quadratic Time

## Overview

This note covers **O(n²) quadratic time**: the complexity class where the number of operations is proportional to *n*². Double the input, and the work goes up by about four times. The classic pattern is two nested loops over the same (or proportional) input size, e.g. comparing every pair. It's acceptable for small _n_, but it scales poorly. Once _n_ gets into the thousands or more, you feel it. **Goal:** recognize the "every pair" pattern (two nested loops) and when to switch to hash, sort, or one pass so it doesn't blow up on large data.

## Definition

**O(n²)** means the running time is bounded by a constant times *n*². So the number of steps grows with the square of the input size.

- Two nested loops, each iterating over _n_ (or something proportional to _n_), often give O(n²). E.g. for each of n elements, do something for each of n elements, so n×n = n².
- Triple nested loops over _n_ give O(n³); we're sticking to the quadratic case here.

## The Analogy

**Handshakes in a room.** If there are _n_ people and everyone shakes hands with everyone else (once), each person shakes with (n−1) others. So total handshakes = n(n−1)/2 ≈ n²/2. For 10 people that's 45 handshakes; for 100 people it's 4,950. The number of pairs grows with the square of the number of people. That's quadratic.

## When You See It

Quadratic time usually appears when:

- **Every pair of elements**: compare each element with each other (e.g. duplicate check with two loops, or "all pairs" in a list).
- **Simple sorting**: bubble sort, insertion sort (worst case), selection sort. Repeatedly scan or swap in a way that touches O(n²) pairs.
- **Naive matrix operations**: multiplying two n×n matrices with the straightforward triple loop is O(n³); but "visit every cell and for each do something with a row/column" can be O(n²) or more.
- **Some graph algorithms on dense graphs**: when you represent the graph as a matrix or iterate over all pairs of vertices.

If you have two nested loops and both ranges depend on _n_, ask: is this really necessary, or can I use a hash set, sort, or a different structure to avoid comparing every pair?

## Examples

**Bad: naive duplicate check, O(n²)**

```typescript
/**
 * Check for duplicate values.
 * @description All pairs with j > i, n(n−1)/2 comparisons.
 * @param arr - Array to check for duplicates
 * @returns True if duplicate found
 */
function hasDuplicate(arr: number[]): boolean {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] === arr[j]) {
        return true
      }
    }
  }
  return false
}
```

**Good to know: bubble sort (worst case).** Nested loops, up to n² comparisons (see O(n log n) note for snippet).

**Better: one pass with a Set (O(n))**

```typescript
/**
 * Check for duplicates using Set.
 * @description Single pass with O(1) Set operations.
 * @param arr - Array to check for duplicates
 * @returns True if duplicate found
 */
function hasDuplicateLinear(arr: number[]): boolean {
  const seen = new Set<number>()
  for (const x of arr) {
    if (seen.has(x)) {
      return true
    }
    seen.add(x)
  }
  return false
}
```

## Important Points

- **O(n²)** = work proportional to n². Double _n_ → about four times the work. At n=10,000 you're at 100M operations; at n=100,000 you're at 10 billion. It adds up fast.
- **Classic cause:** two nested loops over the same (or proportional) input. Question whether you need all pairs or if there's a smarter way (sorting, hashing, one pass).
- **Sorting:** bubble/insertion/selection sort are O(n²) in worst (or typical) case. For larger _n_, prefer O(n log n) sorts.
- When you see nested loops both depending on _n_, check if the algorithm can be improved before you scale.

## Summary

- **O(n²)**: work proportional to n²; typical pattern is two nested loops over n (or "all pairs").
- **Analogy**: everyone in a room shaking hands with everyone else. Number of handshakes ≈ n²/2.
- **Watch for:** naive pair-wise checks, simple sorts (bubble, insertion, selection); consider hashing, sorting, or better algorithms when _n_ grows.

_Quadratic is fine for small n. For large n, it's the first place to look when things feel slow: nested loops over the same data._
