---
title: 'O(n) Linear Time'
source: 'https://en.wikipedia.org/wiki/Time_complexity'
description: "What linear time means: work grows in proportion to input size. One pass over the data, and when it's acceptable (or unavoidable)."
tags:
  - 'time complexity'
  - 'Big O'
  - 'linear'
  - 'algorithms'
---

# O(n) Linear Time

## Overview

This note covers **O(n) linear time**: the complexity class where the number of operations is proportional to the input size _n_. Double the input, roughly double the work. A single pass over _n_ items is the typical pattern. Linear time is often the baseline for "we have to look at every element at least once," and it's usually acceptable for most problem sizes if you can't do better. **Goal:** recognize "one pass" as the fair baseline when the problem requires touching every element; avoid accidentally doing O(n²) with nested loops.

## Definition

**O(n)** means the running time is bounded above by a linear function of _n_: there exists a constant _c_ such that the number of steps is at most _c_·_n_ for large _n_. So we say "linear in _n_."

- One loop over _n_ elements, doing a constant amount of work per element, is O(n).
- Two separate loops over _n_ (not nested) are still O(n) + O(n) = O(n).

## The Analogy

**Reading a book from page 1 to the last.** The number of pages is _n_. If you read every page once, the work is proportional to the number of pages. Twice as many pages, twice as much reading. No shortcuts, no skipping. One pass through the whole thing. That's linear.

## When You See It

Linear time shows up whenever you:

- **Touch each element a constant number of times**: one (or a few) passes over an array, list, or stream.
- **Compute a single aggregate**: sum, max, min, count, or "find one that matches" (worst case: check all).
- **Copy or transform the whole input**: map, filter (that produces a new collection), or a single loop that builds a result.

Nested loops over the same _n_ (e.g. for each i, for each j in the same array up to n) are usually not linear. They're often O(n²). Linear is "one dimension" of iteration.

## Examples

**Good: single loop, constant work per element**

```typescript
/**
 * Sum all array elements.
 * @description One pass over n elements, linear time.
 * @param arr - Array of numbers to sum
 * @returns Total sum of elements
 */
function sum(arr: number[]): number {
  let total = 0
  for (const x of arr) {
    total += x
  }
  return total
}
```

**Good: find index (worst case)**

```typescript
/**
 * Find index of target value.
 * @description Worst case touches all n elements.
 * @param arr - Array to search
 * @param target - Value to find
 * @returns Index of target or -1
 */
function indexOf<T>(arr: T[], target: T): number {
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] === target) {
      return i
    }
  }
  return -1
}
```

**Bad:** two nested loops over the same array (typically O(n²))

```typescript
/**
 * Check for duplicates using nested loops.
 * @description Nested loops yield n×(n−1)/2 comparisons.
 * @param arr - Array to check for duplicates
 * @returns True if duplicate exists
 */
function hasDuplicateQuadratic(arr: number[]): boolean {
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

## Important Points

- **O(n)** = "one pass (or a fixed number of passes) over _n_ elements." Double _n_, roughly double the work.
- Many problems _require_ at least linear time because you must look at every input element (e.g. find max, sum, or "is there a duplicate?" in general).
- Linear is usually fine for in-memory data at scale. The real question is whether you can avoid it (e.g. with indexing or binary search) or whether you're accidentally doing more (e.g. O(n²) with nested loops).
- When you can't do better than "see every element once," O(n) is the baseline to aim for.

## Summary

- **O(n)**: work proportional to input size, typical pattern is one (or a few) passes over _n_ items.
- **Analogy**: reading a book from start to end. Every page once, so work scales with page count.
- **Use it for**: aggregates (sum, max), single-pass transforms, or any problem where you must look at each element at least once.

_Linear time is often the honest minimum when the problem demands looking at every element. The trap is doing more than one pass when you don't need to._
