---
title: 'O(2ⁿ) Exponential Time'
source: 'https://en.wikipedia.org/wiki/Time_complexity'
description: "What exponential time means: work doubles (or grows by a fixed factor) as n increases by 1. Subset enumeration and why it's impractical at scale."
tags:
  - 'time complexity'
  - 'Big O'
  - 'exponential'
  - 'algorithms'
---

# O(2ⁿ) Exponential Time

## Overview

This note covers **O(2ⁿ) exponential time**: the complexity class where the number of operations grows exponentially with _n_, for example doubling each time _n_ increases by 1. Typical pattern: exploring **all subsets** of _n_ elements (each item: in or out → 2ⁿ outcomes). Unlike O(n!): 2ⁿ = all subsets; n! = all orderings. Exponential algorithms become impractical very quickly; even for moderate _n_ (e.g. 30–50), 2ⁿ is huge. **Goal:** avoid enumerating all subsets or binary combinations unless _n_ is very small; recognize the "two choices per step, n steps" pattern and consider pruning, memoization, or DP.

## Definition

**O(2ⁿ)** means the running time is bounded by a constant times 2ⁿ (or more generally, cⁿ for some constant c > 1). So each time you add one to _n_, the worst-case work multiplies by a fixed factor (for example 2).

- 2^10 ≈ 1,000, 2^20 ≈ 1 million, 2^30 ≈ 1 billion. So "exponential" is not something you want for large _n_.
- Big O allows any exponential base (2ⁿ, 3ⁿ, and so on), we write 2ⁿ as the standard example for "exponential in n."

## The Analogy

**A decision tree that doubles at each step.** At each of _n_ steps you have two choices (for example yes or no, include or exclude). So you have 2×2×…×2 = 2ⁿ possible paths. Exploring all of them means 2ⁿ leaves. The tree "fans out" very fast. That's exponential growth. No way to avoid the explosion unless you prune or don't enumerate everything.

## When You See It

Exponential time typically appears when:

- **Enumerating all subsets**: for example "try every subset of items" (2ⁿ subsets). Each element is either in or out, so 2 choices per element, so 2ⁿ.
- **Recursion with two (or more) branches per call**: for example Fibonacci done naively (each call branches into two), or recursive backtracking that tries two options at each step without memoization or pruning.
- **Some exact algorithms for NP-hard problems**: for example brute-force SAT (try all 2ⁿ truth assignments), or subset-sum by trying all subsets. Often the best _exact_ algorithm we have is exponential, we then rely on heuristics, approximation, or small _n_.
- **Backtracking / exhaustive search**: when the search space is "all combinations of n binary choices."

You do **not** get O(2ⁿ) from a single loop (O(n)) or from nested loops with a fixed depth (for example O(n²), O(n³)). The key is "number of steps or choices grows with n, and we're doing work proportional to the number of outcomes."

## Examples

**Good example: subset enumeration (2ⁿ subsets)**

```typescript
// NOTE: Each element: include or exclude → 2 choices per element.
// → 2ⁿ leaves in recursion tree.
function powerSet<T>(arr: T[]): T[][] {
  const result: T[][] = []
  function go(i: number, path: T[]) {
    if (i === arr.length) {
      result.push([...path])
      return
    }
    go(i + 1, path) // exclude
    go(i + 1, path.concat(arr[i])) // include
  }
  go(0, [])
  return result
}
```

**Good example: naive recursive Fibonacci (exponential calls)**

```typescript
// NOTE: Two branches per call, depth n → call tree has ~2ⁿ nodes → O(2ⁿ).
// Use DP or memo for O(n).
function fib(n: number): number {
  if (n <= 1) {
    return n
  }
  return fib(n - 1) + fib(n - 2)
}
```

**Bad (not exponential):** one loop over n is O(n), not 2ⁿ.

```typescript
// NOTE: Single pass over n elements → O(n).
// Exponential needs "2 choices per step, n steps."
function sumArray(arr: number[]): number {
  let sum = 0
  for (const x of arr) {
    sum += x
  }
  return sum
}
```

## Important Points

- **O(2ⁿ)** means work grows exponentially with n. Adding one to _n_ can double (or worse) the work. For n in the 40s or 50s, 2ⁿ is already astronomically large.
- **Subsets, not orderings:** 2ⁿ = "each element in or out" (2 choices per element). For "every ordering" (permutations) you get O(n!), which grows faster.
- **Classic pattern:** "two choices per step, n steps" → 2ⁿ outcomes. Subset enumeration is the standard example.
- **When it's acceptable:** very small _n_ (e.g. n ≤ 20–25), or when the problem is provably hard and you need an exact answer and have no better algorithm. Otherwise, look for pruning, memoization, or a different formulation (e.g. dynamic programming, approximation).
- Exponential is the "brute force over all combinations" complexity. Your future self will thank you if you cap input size or find a smarter approach.

## Summary

- **O(2ⁿ)**: work proportional to 2ⁿ (or cⁿ), typical pattern is exploring all subsets or all n-step binary choices.
- **Analogy:** a decision tree that doubles at each step. That's 2ⁿ leaves.
- **Watch for:** subset enumeration, naive recursion with two branches per level, brute-force exact algorithms. Use only for small n or when no better option exists.

_Exponential time means every time n goes up by 1, the cost multiplies. That's why we avoid it when we can._
