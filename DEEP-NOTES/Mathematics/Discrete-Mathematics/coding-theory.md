---
title: 'Coding Theory'
source: 'https://en.wikipedia.org/wiki/Coding_theory'
description: 'The study of codes that detect and correct errors so information survives noisy transmission and storage.'
tags: ['mathematics', 'discrete-mathematics', 'error-correction', 'information']
---

# Coding Theory

## Overview

Coding theory studies how to encode information so it survives noise. When data travels over a channel or sits on a disk, some bits flip. The core idea is to add carefully chosen redundancy so the receiver can detect that an error happened and often correct it without asking for a resend. The trick is not just repeating data, but spreading it so that any single valid message is far, in a precise sense, from every other valid message. That distance is what lets errors be caught.

It matters because every reliable digital system depends on it, from deep-space probes to QR codes to memory chips. The central tension is efficiency versus protection. More redundancy corrects more errors but wastes bandwidth and storage. Coding theory finds the sweet spot, using algebra and combinatorics to pack the most protection into the fewest extra bits. Hamming distance and the code rate are the two numbers that govern the whole game.

### Quick Takeaways

- Codes add structured redundancy to detect and correct transmission errors
- Larger Hamming distance between valid words allows correcting more errors
- The trade-off is protection against overhead, measured by the code rate

```mermaid
flowchart LR
  M[Message] --> E[Encoder adds redundancy]
  E --> N[Noisy Channel]
  N --> D[Decoder detects and corrects]
  D --> O[Recovered Message]
```

## Definition

- **Codeword** is an encoded block that includes the original data plus redundancy.
- **Hamming distance** is the number of positions in which two codewords differ.
- **Minimum distance** is the smallest Hamming distance between any two codewords.
- **Code rate** is the ratio of data bits to total transmitted bits.
- **Parity check** is a redundant bit chosen to make a property like even parity hold.
- **Error-correcting code** can recover the original message despite a bounded number of errors.

## The Analogy

Think of spelling names on a phone using "A as in Alpha, B as in Bravo." A single mumbled letter is ambiguous, but a whole distinct word is not. If someone hears "Brabo" they still recover "Bravo" because no other code word is that close. Coding theory does the same for bits. It picks code words far enough apart that a few flipped bits still point clearly back to the intended one.

## When You See It

- Deep-space and satellite communication
- QR codes and barcodes that scan despite smudges
- RAM and storage error correction like ECC memory
- Cell phone and Wi-Fi data links
- CD, DVD, and Blu-ray scratch tolerance
- Network protocols with checksums and CRCs

## Examples

**Good:** Using a Hamming code to correct any single-bit error in a block. The minimum distance of three lets the decoder pinpoint and flip the wrong bit automatically.

**Bad:** Adding a single parity bit and expecting to fix errors. One parity bit only detects an odd number of flips, it cannot locate or correct them.

## Important Points

- A code with minimum distance d detects up to d-1 errors and corrects up to (d-1)/2
- Redundancy is the price of reliability, quantified by the code rate
- Linear codes let encoding and decoding use fast matrix algebra
- Hamming codes correct single-bit errors with minimal overhead
- Reed-Solomon codes correct bursts and power CDs, QR codes, and storage
- Shannon's theorem sets the ultimate limit on reliable rate over a channel
- Detection is cheaper than correction, so many systems just request a resend
- Good codes balance distance, rate, and decoding speed

## Summary

- Coding theory adds structured redundancy so data survives noise.
- Hamming distance between code words determines error-handling power.
- Minimum distance d corrects up to (d-1)/2 errors per block.
- The core trade-off is protection versus overhead, set by the code rate.
- Shannon's theorem bounds how efficient any reliable code can be.
- _Keep the valid words far apart, and a few flipped bits still point home._
