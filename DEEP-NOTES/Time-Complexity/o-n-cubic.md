---
title: 'O(n³) Cubic Time'
source: 'https://en.wikipedia.org/wiki/Time_complexity'
description: 'What cubic time means: work grows with the cube of input size. Three nested loops and when O(n³) shows up, and why to avoid it at scale.'
tags:
  - 'time complexity'
  - 'Big O'
  - 'cubic'
  - 'algorithms'
---

# O(n³) Cubic Time

## Overview

This note covers **O(n³) cubic time**: the complexity class where the number of operations is proportional to *n*³. Triple the input size, and the work goes up by about 27 times (e.g. n = 100 → 1 million iterations; n = 1,000 → 1 billion). The typical pattern is three nested loops over input of size _n_. Naive matrix multiplication and some "all triples" algorithms land here. **Goal:** recognize three nested loops and when to look for another algorithm (e.g. Strassen for matrices) or cap _n_; for large _n_, O(n³) is rarely sustainable.

## Definition

**O(n³)** means the running time is bounded by a constant times *n*³. So the number of steps grows with the cube of the input size.

- Three nested loops, each iterating over _n_ (or something of order _n_), give O(n³): for each i, for each j, for each k, do constant work → n×n×n = n³.
- Doubling _n_ multiplies the work by about 8; tripling _n_ multiplies it by 27.

## The Analogy

**Checking every combination of three lists.** Suppose you have three lists of length _n_ (e.g. people, times, rooms). You consider every triple: person A × time slot B × room C. That's n×n×n = n³ combinations. No shortcut. You're explicitly iterating over all triples. That's cubic.

## When You See It

Cubic time usually appears when:

- **Naive matrix multiplication**: two n×n matrices multiplied with the straightforward formula. For each row i, for each column j, for each k from 0 to n−1, add A[i][k]\*B[k][j]. Three loops over n, so O(n³). (Faster algorithms like Strassen exist but are a different topic.)
- **All triples**: any algorithm that explicitly considers every combination of three indices or three sets of size n.
- **Some dynamic programming or graph algorithms**: e.g. Floyd–Warshall for all-pairs shortest paths is O(n³) in the number of vertices. Here "n" is the vertex count and you're doing three nested loops over vertices.
- **Naive polynomial multiplication**: multiplying two polynomials of degree n by expanding every pair of terms can be O(n²) or O(n³) depending on how you count.

If you have three nested loops all ranging over _n_, you're in O(n³) territory unless the inner loops are bounded by a constant.

## Examples

**Good example: naive matrix multiply (two n×n matrices)**

```typescript
// NOTE: Three nested loops over n → n³ multiplications/adds → O(n³).
// Strassen does better.
function matrixMultiply(A: number[][], B: number[][]): number[][] {
  const n = A.length
  const C: number[][] = Array(n)
    .fill(0)
    .map(() => Array(n).fill(0))
  for (let i = 0; i < n; i++) {
    for (let j = 0; j < n; j++) {
      for (let k = 0; k < n; k++) {
        C[i][j] += A[i][k] * B[k][j]
      }
    }
  }
  return C
}
```

**Good example: Floyd–Warshall (all-pairs shortest paths).** Three nested loops over vertices, O(n³).

```typescript
// NOTE: k, i, j each 0..n−1 → O(n³).
// Standard for all-pairs shortest paths on dense graphs.
function floydWarshall(dist: number[][]): void {
  const n = dist.length
  for (let k = 0; k < n; k++) {
    for (let i = 0; i < n; i++) {
      for (let j = 0; j < n; j++) {
        dist[i][j] = Math.min(dist[i][j], dist[i][k] + dist[k][j])
      }
    }
  }
}
```

**Bad (not cubic):** two nested loops over n → O(n²), not O(n³).

```typescript
// NOTE: Only two loops over n → O(n²).
// Cubic needs three nested loops.
function pairsOnly(A: number[][], B: number[][]): number {
  const n = A.length
  let total = 0
  for (let i = 0; i < n; i++) {
    for (let j = 0; j < n; j++) {
      total += A[i][j] * B[i][j]
    }
  }
  return total
}
```

## Important Points

- **O(n³)** = work proportional to n³. Small increases in _n_ cause big jumps in runtime. At n=100, that's 1,000,000 iterations; at n=1000, it's 1,000,000,000.
- **Classic cause:** three nested loops over the same (or proportional) dimension. Question whether you need all triples or if there's a better structure (e.g. Strassen for matrix multiply, or a different algorithm for the problem).
- **When it's acceptable:** small _n_ (e.g. n in the tens or low hundreds), or when the problem genuinely requires examining all triples and no better algorithm is known or worth the complexity.
- In practice, if you hit O(n³) and _n_ can grow, look for a smarter algorithm or a different formulation.

## Summary

- **O(n³)**: work proportional to n³; typical pattern is three nested loops over n (or three dimensions of size n).
- **Analogy**: iterating over every combination of three lists of length n. That's n×n×n triples.
- **Classic use:** naive matrix multiplication, Floyd–Warshall; often a sign to look for a better algorithm when n is large.

_Cubic time is the "three nested loops" complexity. It's acceptable for small n; for large n, it's usually worth rethinking the approach._
