---
title: 'O(n log n) Linearithmic Time'
source: 'https://en.wikipedia.org/wiki/Merge_sort'
description: "What O(n log n) means: the 'sorting complexity.' Merge sort and other efficient sorts hit this; why it's n times log n, not worse."
tags:
  - 'time complexity'
  - 'Big O'
  - 'linearithmic'
  - 'merge sort'
  - 'sorting'
  - 'algorithms'
---

# O(n log n) Linearithmic Time

## Overview

This note covers **O(n log n) linearithmic time**: the complexity class that shows up in efficient comparison-based sorting and many divide-and-conquer algorithms. "Linearithmic" = linear × logarithmic: you do about "n times log n" work (for example log n levels, each level touching all n elements). Merge sort is the standard example: split, sort halves recursively, then merge. It's the bar for "good" general-purpose sorting. **Goal:** recognize this as the right complexity for sorting or divide-and-conquer with linear-time merge; if your sort is worse than this, there's usually a better algorithm.

## Definition

**O(n log n)** means the running time is bounded by a constant times _n_·log(_n_). So it sits between linear O(n) and quadratic O(n²). The name "linearithmic" is a blend of linear and logarithmic. You have both an _n_ and a log _n_ factor.

- Common in **divide-and-conquer** algorithms that split into two (or more) subproblems of size n/2 and do O(n) work per level.
- Comparison-based sorting has a lower bound of Ω(n log n) in the general case, so O(n log n) is effectively optimal for that model.

## The Analogy

**Sorting a deck of cards with merge sort.** You don't compare every card with every other (that would be O(n²)). You split the deck in half, sort each half (same process recursively), then merge the two sorted halves by repeatedly picking the smaller top card. The "split and merge" structure gives you log n levels of splitting, and at each level you touch all n cards once. So: n work per level, log n levels → O(n log n). Divide, then merge.

## When You See It

O(n log n) typically appears when:

- **Efficient comparison-based sorting**: merge sort, heapsort, and (in average case) quicksort. Each does O(n log n) in the typical or worst case.
- **Divide-and-conquer with linear merge**: split into subproblems of size n/2, solve them, then combine in O(n). If there are O(log n) levels and O(n) work per level, you get O(n log n).
- **Some efficient data-structure operations**: e.g. building a heap in O(n) is a different story, but many "process all and reorder" algorithms land here.

You do **not** get O(n log n) from a single loop (that's O(n)) or from nested loops over the whole array (that's usually O(n²)).

## Why Merge Sort Is O(n log n)

Merge sort:

1. **Divide**: split the array into two halves (O(1) for the split idea; the real cost is in the recursion).
2. **Conquer**: sort each half recursively. So two subproblems of size n/2.
3. **Merge**: combine two sorted arrays of size n/2 into one sorted array of size n by scanning both once, O(n).

Recurrence: T(n) = 2T(n/2) + O(n). There are about log₂(n) levels (until subproblem size is 1). At each level, the total work for all subproblems is O(n). Each element is in exactly one merge at that level. So total work is O(n) × O(log n) = **O(n log n)**.

Same idea applies to heapsort and to the average case of quicksort (with a proper pivot choice).

## Examples

**Good: merge sort (merge step O(n), log n levels)**

```typescript
// NOTE: merge() does one pass over left+right → O(n).
// mergeSort has ~log n levels → O(n log n).
function merge(left: number[], right: number[]): number[] {
  const out: number[] = []
  let i = 0
  let j = 0
  while (i < left.length && j < right.length) {
    if (left[i] <= right[j]) {
      out.push(left[i++])
    } else {
      out.push(right[j++])
    }
  }
  return out.concat(left.slice(i), right.slice(j))
}

// NOTE: Split in half each time (log n levels).
// Merge at each level is O(n).
function mergeSort(arr: number[]): number[] {
  if (arr.length <= 1) {
    return arr
  }
  const mid = Math.floor(arr.length / 2)
  return merge(mergeSort(arr.slice(0, mid)), mergeSort(arr.slice(mid)))
}
```

**Good: heapsort.** Build heap O(n), then n extract-max operations each O(log n), so O(n log n).

**Bad: bubble sort (O(n²))**

```typescript
// NOTE: Nested loops over n; up to n²/2 swaps in worst case.
// → O(n²).
function bubbleSort(arr: number[]): void {
  for (let i = 0; i < arr.length; i++) {
    for (let j = 0; j < arr.length - 1 - i; j++) {
      if (arr[j] > arr[j + 1]) {
        ;[arr[j], arr[j + 1]] = [arr[j + 1], arr[j]]
      }
    }
  }
}
```

## Important Points

- **O(n log n)** = "n times log n": often from divide-and-conquer with O(n) work per level and O(log n) levels.
- **Sorting**: comparison-based sorts can't do better than Ω(n log n) in the general case, merge sort and heapsort achieve it.
- When you need to sort and _n_ is large, O(n log n) is the target, avoid O(n²) sorts unless _n_ is tiny.
- The "merge" step (combining two sorted pieces in linear time) is what keeps the per-level cost at O(n).

## Summary

- **O(n log n)**: work proportional to n·log(n), typical of efficient sorting and divide-and-conquer with linear combine.
- **Analogy**: merge sort on a deck. Split, sort halves, merge, log n levels, n work per level.
- **Use it for**: general-purpose sorting (merge sort, heapsort, quicksort average), and algorithms with the same recurrence.

_Efficient sorting lives here. If you're doing worse than O(n log n) for a comparison-based sort, there's usually a better algorithm._
