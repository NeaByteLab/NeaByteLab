---
title: 'Fourier Analysis'
source: 'https://en.wikipedia.org/wiki/Fourier_analysis'
description: 'The decomposition of functions and signals into sums of sines and cosines by frequency.'
tags: ['mathematics', 'analysis', 'fourier-analysis', 'frequency']
---

# Fourier Analysis

## Overview

Fourier analysis is the specific and hugely influential technique of decomposing functions into sines and cosines. Its founding claim is that almost any reasonable periodic function can be written as a sum of pure waves, each with a definite frequency and amplitude. The Fourier series does this for periodic functions, and the Fourier transform extends it to non-periodic ones, mapping a function of time into a function of frequency. This shift of viewpoint is the whole point.

It matters because operations that are hard in the time domain become easy in the frequency domain. Differentiation turns into multiplication, and convolution, the smearing operation behind filtering, becomes simple pointwise multiplication. This is why Fourier analysis underlies audio, image, and signal processing, data compression, and the numerical solution of differential equations. The fast Fourier transform makes the computation efficient enough to run in real time on ordinary hardware.

### Quick Takeaways

- Functions decompose into sines and cosines by frequency
- The Fourier transform maps time to frequency
- Convolution and differentiation become simple in the frequency domain

```mermaid
flowchart LR
  T["Signal in time"] --> FT["Fourier transform"]
  FT --> FRQ["Frequency spectrum"]
  FRQ --> MOD["Filter or process"]
  MOD --> INV["Inverse transform to time"]
```

## Definition

- **Fourier series** expands a periodic function into a sum of sines and cosines.
- **Fourier transform** maps a function of time to a function of frequency.
- **Frequency spectrum** lists the amplitude of each frequency present.
- **Amplitude** is the strength of a given frequency component.
- **Convolution** is a smearing operation that becomes multiplication in frequency.
- **Fast Fourier transform** is an efficient algorithm computing the discrete transform.

## The Analogy

Imagine shining white light through a prism. The prism splits the single beam into a rainbow, showing exactly which colors and how much of each make up the light. Fourier analysis is a prism for signals. It takes a blended signal and splits it into its component frequencies, revealing how much of each pure tone is present. Processing then adjusts individual colors before recombining them into a new beam.

## When You See It

- Processing audio, including equalizers and noise removal
- Compressing images and video with frequency transforms
- Analyzing vibrations and spectra in physics and engineering
- Solving differential equations by transforming to frequency
- Modulating and demodulating signals in communications
- Detecting periodic patterns in time-series data

## Examples

**Good:** Using the fast Fourier transform to find and remove a 60 hertz power-line hum from a recording, then transforming back. The hum is a single spike in frequency, trivial to delete there.

**Bad:** Expecting the Fourier series of a sharp square wave to converge cleanly at its jumps. It overshoots near the edges, the Gibbs phenomenon, so a naive reconstruction has ripples.

## Important Points

- The Fourier transform pairs time and frequency as two views of the same function
- Convolution in time equals multiplication in frequency, the key to fast filtering
- Differentiation becomes multiplication by frequency, simplifying many PDEs
- The Gibbs phenomenon causes overshoot near discontinuities
- The uncertainty principle limits simultaneous sharpness in time and frequency
- The fast Fourier transform computes the discrete transform in near-linear time
- Sampling must satisfy the Nyquist rate to avoid aliasing artifacts

## Summary

- Fourier analysis decomposes functions into sines and cosines.
- Series handle periodic functions, transforms handle general ones.
- The frequency domain turns convolution into multiplication.
- The fast Fourier transform makes it efficient in practice.
- It underpins signal processing, compression, and PDE solving.
- _Fourier analysis is a prism that splits a signal into its pure frequencies._
