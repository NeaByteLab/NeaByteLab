---
title: 'O(log n) Logarithmic Time'
source: 'https://en.wikipedia.org/wiki/Binary_search_algorithm'
description: 'What logarithmic time means, why binary search is O(log n), and when this scaling shows up. Halving the problem each step.'
tags:
  - 'time complexity'
  - 'Big O'
  - 'logarithmic'
  - 'binary search'
  - 'algorithms'
---

# O(log n) Logarithmic Time

## Overview

This note covers **O(log n) logarithmic time**: the complexity class where each step cuts the problem size by a constant factor (often half). The number of steps grows very slowly as _n_ increases, doubling _n_ adds roughly one more step (for example n = 1,000,000, about 20 steps). Binary search is the canonical example, it's why "look up in a sorted list" can be so much cheaper than scanning. **Goal:** when data is sorted or tree-shaped, search without reading every element.

## Definition

**O(log n)** means the number of operations grows proportionally to the logarithm of the input size. Usually we mean log₂(n) in algorithm analysis (base 2), but Big O ignores the base: log₂(n), log₁₀(n), and ln(n) differ only by a constant factor.

- Each step typically reduces the "active" size by a constant factor (for example half).
- So: "How many times can you divide _n_ by 2 until you get down to 1?" Answer: about log₂(n).

## The Analogy

**Looking up a word in a dictionary.** You don't read every page. You open to the middle, see if your word is before or after, then throw away half the book and repeat. Each step halves the remaining pages. So the number of "looks" is roughly the number of times you can split the book in half. That's logarithmic in the number of pages.

## When You See It

Logarithmic time usually appears when:

- **Search space is halved (or reduced by a fixed factor) each step**: binary search on a sorted array, binary search on the answer (e.g. in optimization).
- **Balanced tree operations**: lookup/insert/delete in a balanced BST (e.g. AVL, red-black) are O(log n) because height is O(log n).
- **Some divide-and-conquer steps**: where the recurrence only touches one subproblem of size n/2 (e.g. binary search in a merge sort-style recursion isn't the whole algorithm, but the "find split" idea is logarithmic).

You do **not** get O(log n) by "doing one thing per element" or by scanning. That's at least O(n).

## Why Binary Search Is O(log n)

Binary search on a sorted array of size _n_:

1. Compare the target to the middle element.
2. If it matches, done. Otherwise, you know which half to keep.
3. Repeat on that half (size n/2, then n/4, …).

After _k_ steps, the remaining size is at most n/2^k. When n/2^k ≤ 1, you're done. So k ≈ log₂(n). So at most about log₂(n) comparisons, hence O(log n).

Example: for n = 1,000,000, log₂(n) ≈ 20. So about 20 comparisons instead of up to a million.

## Examples

**Good: binary search (sorted array)**

```typescript
// NOTE: Each step halves the range; at most ~log₂(n) iterations.
// → O(log n).
function binarySearch(arr: number[], target: number): number {
  let left = 0
  let right = arr.length - 1
  while (left <= right) {
    const mid = Math.floor((left + right) / 2)
    if (arr[mid] === target) {
      return mid
    }
    if (arr[mid] < target) {
      left = mid + 1
    } else {
      right = mid - 1
    }
  }
  return -1
}
```

**Good: balanced BST lookup.** Same idea: each step goes left or right, so you follow one path of length O(log n).

```typescript
// NOTE: One path from root to leaf; tree height O(log n) when balanced.
// → O(log n).
function bstLookup(node: BSTNode | null, key: number): BSTNode | null {
  if (node === null || node.key === key) {
    return node
  }
  if (key < node.key) {
    return bstLookup(node.left, key)
  }
  return bstLookup(node.right, key)
}
```

**Bad:** linear search on a sorted array (O(n)). Same input as binary search, but we scan one by one instead of halving.

```typescript
// NOTE: Scans every element until found - O(n).
// Use binary search when sorted.
function linearSearchSorted(arr: number[], target: number): number {
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] === target) {
      return i
    }
  }
  return -1
}
```

## Important Points

- **O(log n)** grows very slowly. Doubling _n_ adds about one step (for log base 2).
- **Binary search** is the standard example: sorted data, compare to middle, discard half.
- **Prerequisite**: usually you need structure (sorted, or a balanced tree). Random access + "discard half" is the pattern.
- Use O(log n) when you can avoid scanning the whole input (lookups in sorted or tree-shaped data).

## Summary

- **O(log n)**: steps proportional to log(n), each step often halves the problem.
- **Analogy**: dictionary lookup. Repeatedly open to the middle and throw away half the pages.
- **Classic use**: binary search on sorted array, lookup in balanced BST, requires ordered or tree structure.

_You're not doing one thing per element. You're cutting the problem in half each time. That's why it scales so well._
