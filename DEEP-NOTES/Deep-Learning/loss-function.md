---
title: 'Loss Function'
source: 'https://en.wikipedia.org/wiki/Loss_function'
description: 'A loss function measures how far a model prediction sits from the true value.'
tags: ['deep-learning', 'loss-function', 'cost-function', 'objective']
---

# Loss Function

## Overview

A loss function takes a prediction and a ground truth and returns a single number that says how wrong the prediction is. Zero means perfect and larger means worse. The entire training process exists to make this number smaller.

The loss function is the only feedback the model receives. If the loss is poorly chosen the model will optimize for the wrong thing, so the choice of loss shapes everything downstream.

### Quick Takeaways

- Loss is computed per sample, cost is the average loss over a batch or dataset
- MSE works for regression, cross-entropy works for classification
- The loss must be differentiable so gradients can flow back through the network

## Definition

- **Loss** is the error on a single training example, computed as `L(y_hat, y)` where `y_hat` is the prediction and `y` is the target.
- **Cost** is the mean of the loss over all examples in a batch, often written as `J = (1/N) * sum(L_i)`.
- **Objective function** is the broader term that includes the cost plus any regularization terms the optimizer actually minimizes.
- **Mean Squared Error (MSE)** is `(1/N) * sum((y_hat - y)^2)` and penalizes large errors more than small ones because of the square.
- **Cross-entropy** is `-sum(y * log(y_hat))` and measures how well a predicted probability distribution matches the true distribution.

## The Analogy

A loss function is like a coach watching a basketball player shoot free throws. Each shot either goes in or misses, and the coach measures the distance from the rim. The coach does not care about form or effort, only the gap between the ball and the basket. The player adjusts based on that gap. If the coach measured the wrong thing, say the height of the jump, the player would optimize for jumping high instead of scoring.

## When You See It

- Choosing between regression and classification loss at the start of a project
- Debugging a model that trains but produces useless predictions because the loss was wrong
- Adding class weights to cross-entropy when the dataset is imbalanced

## Examples

**Good, matching loss to task:**

```python
# Regression task: predict house prices
loss_fn = nn.MSELoss()

# Classification task: predict cat vs dog
loss_fn = nn.CrossEntropyLoss()
```

The loss aligns with what the model must predict. MSE for continuous values and cross-entropy for class probabilities.

**Bad:** using MSE for a classification problem. The model will try to minimize squared distance between class indices, which has no meaningful geometric interpretation for categories.

## Important Points

- MSE is sensitive to outliers because the square amplifies large errors
- Cross-entropy requires the target to be a valid probability distribution
- Binary cross-entropy is a special case for two-class problems, use `BCEWithLogitsLoss` for numerical stability
- Custom loss functions are common in practice, such as focal loss for extreme class imbalance
- The loss landscape determines how easy or hard the optimization problem is
- A loss that decreases during training but validation loss rises signals overfitting, not a bad loss function

## Summary

- Loss measures error per sample, cost averages it, and the objective adds regularization.
- MSE works for continuous targets and cross-entropy works for probability targets.
- The wrong loss means the model optimizes for the wrong goal.
- Custom losses exist for edge cases like imbalanced data or ranking tasks.
- _The coach only sees the gap between the ball and the basket, so the gap had better measure what actually matters._
