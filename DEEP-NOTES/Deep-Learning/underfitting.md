---
title: 'Underfitting'
source: 'https://en.wikipedia.org/wiki/Underfitting'
description: 'Underfitting happens when a model is too simple to capture the patterns in the training data.'
tags: ['deep-learning', 'underfitting', 'model-capacity', 'bias']
---

# Underfitting

## Overview

Underfitting is the failure mode where a model cannot learn the underlying structure of the data. The model performs poorly on training data and test data alike, because it lacks the capacity or the exposure to represent what the data actually contains. This is the opposite of overfitting, where the model memorizes noise.

The core cause is always the same. The model is too constrained to fit even the real signal. This constraint can come from having too few parameters, from regularization that is too aggressive, or from stopping training too early. A model that underfits has high bias and low variance.

### Quick Takeaways

- Underfitting means the model fails on training data, not just test data
- The root cause is insufficient model capacity or insufficient training
- High training loss that does not decrease is the clearest signal

## Definition

- **Underfitting** occurs when a model cannot capture the relationship between inputs and outputs, resulting in high error on both the training set and unseen data.
- **Bias** in this context is the error introduced by approximating a complex problem with a model that is too simple.
- **Model capacity** is the range of functions a model can represent, determined by its architecture and parameter count.
- **Regularization** is any technique that constrains the model to prevent overfitting, but too much of it causes underfitting.

## The Analogy

Imagine you are trying to draw a map of a coastline, but you are only allowed to use straight lines and no curves. No matter how carefully you place each line, you will miss every bay, inlet, and peninsula. The coastline has structure, but your tool cannot represent it. That is underfitting. The fix is not to draw more carefully with the same ruler but to pick up a better pen that can follow curves.

## When You See It

- Training loss stays flat or decreases very slowly across many epochs
- Validation loss is close to training loss and both are high
- The model predicts roughly the same output for all inputs, like always guessing the mean
- A learning curve shows the model has not yet benefited from more data

## Examples

**Good:** a neural network with two hidden layers of 128 units fits a nonlinear regression task and achieves low training error.

```python
model = Sequential([
    Dense(128, activation='relu'),
    Dense(128, activation='relu'),
    Dense(1)
])
```

**Bad:** a single linear layer tries to fit the same nonlinear data and the training loss never drops below a high baseline.

```python
model = Sequential([
    Dense(1)  # linear model, cannot capture curves
])
```

## Important Points

- Underfitting is diagnosed on training data, not test data
- Adding more data does not fix underfitting because the model cannot learn what it already has
- Common remedies are increasing layer count, increasing units per layer, reducing dropout rate, reducing weight decay, and training for more epochs
- A model that underfits a simple task usually has an architecture problem
- Feature engineering can help when the model cannot be made larger, by presenting the data in a form the model can use
- Always check training loss first before looking at validation loss

## Summary

- Underfitting means the model is too simple to learn the signal in the data.
- Fix it by increasing capacity, reducing regularization, or training longer.
- _A ruler cannot draw a coastline, and no amount of patience with the ruler will change that._
