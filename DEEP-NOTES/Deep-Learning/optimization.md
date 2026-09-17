---
title: 'Optimization'
source: 'https://en.wikipedia.org/wiki/Mathematical_optimization'
description: 'Optimization algorithms navigate the loss landscape to find parameter values that minimize the cost function.'
tags: ['deep-learning', 'optimization', 'adam', 'sgd', 'momentum']
---

# Optimization

## Overview

Training a neural network means finding the set of weights that minimizes the loss function. The loss landscape is a high-dimensional surface and the optimizer walks downhill on it. Each step uses the gradient to decide direction and the learning rate to decide step size.

No optimizer sees the full landscape. Stochastic methods estimate the gradient from a mini-batch and that noise is both a curse and a blessing, because it slows convergence but helps escape shallow local minima.

### Quick Takeaways

- SGD computes the raw gradient and steps in the opposite direction
- Momentum adds velocity so the optimizer does not stall in flat regions
- Adam combines momentum with per-parameter adaptive learning rates

## Definition

- **Stochastic Gradient Descent (SGD)** updates each parameter by `w = w - lr * grad(w)` using the gradient from a random mini-batch instead of the full dataset.
- **Momentum** accumulates past gradients into a velocity term `v = beta * v + grad(w)` and updates with `w = w - lr * v`, which smooths noisy gradients and accelerates through narrow valleys.
- **RMSProp** divides the learning rate by a running average of recent gradient magnitudes, so parameters with large gradients get smaller effective steps and vice versa.
- **Adam** combines momentum (first moment) and RMSProp (second moment) with bias correction, making it the default choice for most problems.
- **Learning rate schedule** reduces the learning rate over time so the optimizer takes large steps early and fine steps late, common strategies include step decay, cosine annealing, and warmup.

## The Analogy

Imagine rolling a ball down a mountain in fog. SGD is a blind hiker who checks the slope under their feet and takes one step downhill. Momentum gives the hiker mass so they roll through small bumps instead of getting stuck. RMSProp gives the hiker different shoe grip for different terrain, gripping harder on steep slopes and sliding faster on gentle ones. Adam is the hiker with both mass and adaptive grip, which is why most people pick Adam and move on.

## When You See It

- Picking an optimizer at the start of training, usually `Adam(lr=3e-4)` as the first try
- Tuning learning rate when the loss plateaus or explodes
- Switching from Adam to SGD with momentum for final fine-tuning in vision tasks

## Examples

**Good, setting up Adam with a cosine schedule:**

```python
optimizer = torch.optim.Adam(model.parameters(), lr=3e-4, weight_decay=1e-5)
scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=100)

for epoch in range(100):
    train_one_epoch(model, optimizer)
    scheduler.step()
```

The learning rate starts at `3e-4` and smoothly decays to near zero over 100 epochs.

**Bad:** using a fixed high learning rate like `1e-1` with Adam. Adam already adapts per-parameter rates, and a large global rate on top causes the loss to oscillate or diverge.

## Important Points

- A learning rate that is too high causes divergence and too low causes stagnation
- Adam works well out of the box but can generalize worse than SGD with momentum on some vision tasks
- Weight decay in Adam (AdamW) decouples regularization from the adaptive rate and is preferred over L2 in the loss
- Learning rate warmup prevents early large updates when the model weights are still random
- Gradient clipping caps the gradient norm to prevent exploding updates, common in RNNs and transformers
- Convergence means the loss stops decreasing meaningfully, not that it hits zero

## Summary

- SGD follows the gradient, momentum adds inertia, RMSProp adapts per parameter, and Adam does both.
- Start with Adam at `3e-4` and add a cosine or step schedule.
- Weight decay belongs in AdamW, not as L2 in the loss.
- Gradient clipping and warmup handle instability in the early and explosive phases.
- _The ball finds the valley faster when it has both mass and the right shoes._
