---
title: 'Overfitting'
source: 'https://en.wikipedia.org/wiki/Overfitting'
description: 'Overfitting is when a model learns the noise in the training data instead of the underlying pattern.'
tags: ['deep-learning', 'overfitting', 'regularization', 'dropout']
---

# Overfitting

## Overview

Overfitting happens when a model fits the training data too well. It captures noise and random fluctuations as if they were real patterns. The result is excellent training metrics and poor test metrics. The model has memorized rather than learned.

Every sufficiently complex model will overfit if given enough time and not enough data. The question is never whether overfitting can happen but how to detect it early and how to control it. The tools exist and they are well understood.

### Quick Takeaways

- Overfitting shows up as a growing gap between training loss and validation loss
- The main causes are too much capacity, too little data, and training too long
- Remedies include dropout, early stopping, data augmentation, and weight decay

## Definition

- **Overfitting** occurs when a model achieves low training error but high test error because it has learned patterns specific to the training set that do not generalize.
- **Dropout** randomly zeroes a fraction of neuron activations during training, forcing the network to not rely on any single neuron and acting as an ensemble of subnetworks.
- **Early stopping** halts training when validation loss stops decreasing, using the checkpoint with the best validation performance.
- **Data augmentation** applies random transformations like rotation, cropping, or flipping to training inputs, effectively increasing dataset size without collecting new data.
- **Weight decay** adds a penalty proportional to the squared magnitude of weights `lambda * sum(w^2)` to the loss, discouraging large weights that often signal memorization.

## The Analogy

A student who memorizes every answer in the practice booklet word for word will ace the practice test. But give them a real exam with slightly different wording and they fail because they never understood the concepts. Dropout is like randomly covering parts of the booklet during study, forcing the student to build understanding from incomplete information. Early stopping is the teacher taking the booklet away before the student starts memorizing answers verbatim.

## When You See It

- Training accuracy climbs to 99% while validation accuracy plateaus at 75%
- The learning curves diverge after a certain epoch, training loss keeps falling but validation loss rises
- A model performs suspiciously well on training data compared to any held-out set

## Examples

**Good, applying dropout and early stopping together:**

```python
class Classifier(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 256)
        self.dropout = nn.Dropout(p=0.5)
        self.fc2 = nn.Linear(256, 10)

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = self.dropout(x)  # active only during training
        return self.fc2(x)

# Early stopping logic
best_val_loss = float('inf')
patience, wait = 10, 0
for epoch in range(200):
    train(model, train_loader)
    val_loss = evaluate(model, val_loader)
    if val_loss < best_val_loss:
        best_val_loss = val_loss
        wait = 0
        torch.save(model.state_dict(), 'best.pt')
    else:
        wait += 1
        if wait >= patience:
            break  # stop before the model memorizes
```

Dropout regularizes during training and early stopping picks the best checkpoint before memorization sets in.

**Bad:** training for 1000 epochs with no validation monitoring and no regularization. The model will eventually memorize every training example, including the noise, and the weights will be useless on new data.

## Important Points

- Plot training and validation loss curves every time, they are the primary diagnostic tool for overfitting
- Dropout rate of 0.5 is a strong default for fully connected layers, lower values like 0.1 are typical for convolutional and transformer layers
- Data augmentation is free regularization because it increases effective dataset size without collection cost
- Weight decay of `1e-4` to `1e-5` is a common starting range
- More training data is always the best remedy, and if collecting more is impossible then augmentation is the next best thing
- Reducing model size works but risks underfitting, so prefer regularization over shrinking the architecture

## Summary

- Overfitting is memorizing noise, and it shows up as a gap between training and validation performance.
- Detect it early by plotting learning curves every epoch.
- Dropout forces redundancy, early stopping picks the best moment, and weight decay penalizes complexity.
- Data augmentation increases effective dataset size for free.
- _The student who understands the concept will always beat the one who memorized the answer sheet._
