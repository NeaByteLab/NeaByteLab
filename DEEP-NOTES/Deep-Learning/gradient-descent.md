---
title: 'Gradient Descent'
source: 'https://en.wikipedia.org/wiki/Gradient_descent'
description: 'How gradient descent iteratively adjusts parameters to minimize a loss function by following the steepest downhill direction.'
tags: ['deep-learning', 'gradient-descent', 'optimization', 'learning-rate']
---

# Gradient Descent

## Overview

Gradient descent is the optimization algorithm that trains nearly every neural network. It works by computing the gradient of the loss function with respect to each parameter, then nudging every parameter a small step in the direction that reduces the loss. Repeat this thousands of times and the parameters converge toward values that make the model's predictions accurate.

The gradient is just the vector of partial derivatives. It points uphill, so you move in the opposite direction. The size of each step is controlled by the learning rate, which is the single most important hyperparameter in training. Too large and the parameters overshoot. Too small and training takes forever or gets stuck.

### Quick Takeaways

- The gradient tells you the direction of steepest increase, so you go the opposite way
- The learning rate controls how far you step each iteration
- Variants like SGD and mini-batch trade exactness for speed

## Definition

- **Gradient** is the vector of partial derivatives of the loss function with respect to each parameter, pointing in the direction of steepest ascent.
- **Learning rate (η)** is a scalar that controls the step size of each parameter update.
- **Batch gradient descent** computes the gradient over the entire training set before updating parameters.
- **Stochastic gradient descent (SGD)** computes the gradient on a single randomly chosen sample and updates immediately.
- **Mini-batch gradient descent** computes the gradient on a small random subset of the training set, balancing noise and efficiency.

## The Analogy

Imagine you are blindfolded on a hilly landscape and want to reach the lowest valley. You cannot see, but you can feel the slope under your feet. At each step, you feel which direction goes downhill and take a step that way. The length of your stride is the learning rate. If you take huge strides, you might leap over the valley and land on the other side. If you take tiny steps, you will get there eventually but it will take all day. Gradient descent is this blindfolded walk, and the landscape is the loss surface.

## When You See It

- Every time you call `model.fit()` or `optimizer.step()` in a training loop
- When tuning the learning rate, which is usually the first hyperparameter to adjust
- When a training loss curve plateaus, oscillates, or diverges, all symptoms of learning rate issues
- When comparing optimizers like SGD, Adam, and RMSProp, which are all gradient descent variants

## Examples

**Good:** use mini-batch SGD with a learning rate of 0.01 and a batch size of 64. The gradient estimate is noisy but cheap to compute, and the noise often helps escape shallow local minima.

**Bad:** use full-batch gradient descent on a dataset of 10 million samples. Each single update requires a full pass over all data, making training painfully slow with no benefit from the noise that helps generalization.

**The update rule:**

```
θ = θ - η · ∇L(θ)

where:
  θ = parameter vector
  η = learning rate
  ∇L(θ) = gradient of loss with respect to θ
```

## Important Points

- The loss surface of a deep network is non-convex, so gradient descent finds local minima, not guaranteed global ones
- In practice, most local minima in high-dimensional spaces are nearly as good as the global minimum
- SGD noise acts as implicit regularization, helping the model generalize
- Learning rate schedules (decay, warmup, cosine annealing) often improve convergence
- Momentum accumulates past gradients to accelerate movement through flat regions and dampen oscillations
- Adaptive methods like Adam adjust the learning rate per parameter based on gradient history

## Summary

- Gradient descent updates parameters by moving opposite to the gradient of the loss.
- The learning rate is the most critical hyperparameter to get right.
- SGD and mini-batch variants trade gradient accuracy for computational speed and useful noise.
- The loss surface is non-convex, but local minima in high dimensions are usually good enough.
- _Follow the slope downhill and trust that small steps in the right direction add up._
