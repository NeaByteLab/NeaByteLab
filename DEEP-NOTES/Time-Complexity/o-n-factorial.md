---
title: 'O(n!) Factorial Time'
source: 'https://en.wikipedia.org/wiki/Time_complexity'
description: "What factorial time means: work proportional to n!. All permutations, and why it's the worst scaling among common complexity classes."
tags:
  - 'time complexity'
  - 'Big O'
  - 'factorial'
  - 'permutations'
  - 'algorithms'
---

# O(n!) Factorial Time

## Overview

This note covers **O(n!) factorial time**: the complexity class where the number of operations is proportional to _n_! = n×(n−1)×(n−2)×…×1. It shows up when you need to consider **every ordering** (permutation) of _n_ elements, e.g. "try every route through n cities" or "generate all permutations." Unlike O(2ⁿ): 2ⁿ = all subsets (in/out); n! = all orderings (every arrangement). Factorial grows even faster than exponential; for n=20, n! is already enormous. **Goal:** recognize "all orderings" vs "all subsets"; use only for very small _n_ or when the problem really requires trying every ordering (e.g. TSP brute-force).

## Definition

**O(n!)** means the running time is bounded by a constant times _n_!. So the number of steps grows with the factorial of the input size.

- n! = n × (n−1) × (n−2) × … × 1. So 5! = 120, 10! ≈ 3.6 million, 15! ≈ 1.3×10¹², 20! ≈ 2.4×10¹⁸.
- Factorial grows faster than any fixed exponential (e.g. 2ⁿ): for large n, n! ≫ 2ⁿ. So O(n!) is "worse" than O(2ⁿ) in the sense of scaling.

## The Analogy

**Seating n people in a row in every possible order.** For the first seat you have n choices, for the next n−1, then n−2, and so on. So the number of orderings is n×(n−1)×(n−2)×…×1 = n!. If you do something for each ordering (e.g. evaluate a cost), that's n! operations. No shortcut if you must try every order. That's factorial.

## When You See It

Factorial time typically appears when:

- **Generating all permutations**: e.g. list every ordering of n elements. There are n! permutations, so any algorithm that explicitly builds or processes each one is O(n!) (or at least proportional to n!).
- **Brute-force Traveling Salesman (TSP)**: try every order of visiting n cities and pick the shortest tour. That's n! tours (or (n−1)!/2 if you treat reverse order as the same). So naive TSP is O(n!).
- **Some constraint / scheduling problems**: when the only approach you have is "try every ordering and see which satisfies the constraints."
- **Backtracking that prunes very little**: if the search space is "all permutations" and you can't cut it down much, you're in factorial territory.

You do **not** get O(n!) from subset enumeration (that's O(2ⁿ)) or from a fixed number of nested loops (that's a polynomial). The key is "all orderings" or "all arrangements" of n distinct things.

## Examples

**Good example: generate all permutations (n!)**

```typescript
// NOTE: Builds every ordering of n elements → n! permutations → O(n!).
// TSP brute-force uses this idea.
function permutations<T>(arr: T[]): T[][] {
  const result: T[][] = []
  function go(rest: T[], path: T[]) {
    if (rest.length === 0) {
      result.push([...path])
      return
    }
    for (let i = 0; i < rest.length; i++) {
      const next = rest.slice(0, i).concat(rest.slice(i + 1))
      go(next, path.concat(rest[i]))
    }
  }
  go(arr, [])
  return result
}
```

**Good example: naive TSP.** Try every ordering of n cities: (n−1)!/2 tours if symmetric. Same “all orderings” idea as above.

**Bad (not factorial):** all subsets are 2ⁿ (each element in or out), not n! orderings.

```typescript
// NOTE: Subsets = each element in or out → 2ⁿ, not n! orderings.
// Factorial = every permutation.
function powerSet<T>(arr: T[]): T[][] {
  const result: T[][] = []
  function go(i: number, path: T[]) {
    if (i === arr.length) {
      result.push([...path])
      return
    }
    go(i + 1, path)
    go(i + 1, path.concat(arr[i]))
  }
  go(0, [])
  return result
}
```

## Important Points

- **O(n!)** = work proportional to n!. Even for n=15, n! is already in the trillions. So factorial is "only for tiny n" or for problems where there is no known polynomial-time algorithm and you need exact answers.
- **Orderings, not subsets:** n! = "every possible order of n items" (permutations). 2ⁿ = "every subset" (in/out per item). If the problem is "try every arrangement," think n!; if "try every combination of including/excluding," think 2ⁿ.
- **When it's acceptable:** very small n (e.g. n ≤ 10–12), or when the problem is known to be hard (e.g. NP-hard) and you're building an exact solver for small instances. Otherwise, look for heuristics, approximation, or a formulation that avoids enumerating all orderings.
- In practice, if you realize you're in O(n!) territory, cap n or find a different approach. Your future self will thank you.

## Summary

- **O(n!)**: work proportional to n!; typical when you need to consider every permutation or every ordering of n elements.
- **Analogy:** seating n people in a row in every possible order. That's n×(n−1)×…×1 = n! arrangements.
- **Watch for:** all-permutations generation, brute-force TSP, any "try every ordering" algorithm; use only for very small n or when no better option exists.

_Factorial time is "try every ordering." It scales worse than exponential. Fine for tiny n, and a signal to rethink the problem for anything larger._
