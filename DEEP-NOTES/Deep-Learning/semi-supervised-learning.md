---
title: 'Semi-Supervised Learning'
source: 'https://en.wikipedia.org/wiki/Semi-supervised_learning'
description: 'Combining a small amount of labeled data with a large pool of unlabeled data to improve learning.'
tags: ['deep-learning', 'semi-supervised-learning', 'pseudo-labels', 'consistency-regularization']
---

# Semi-Supervised Learning

## Overview

Semi-supervised learning uses a small set of labeled examples together with a much larger pool of unlabeled data. The labeled data provides a direct supervision signal, and the unlabeled data provides structural information about the input distribution. By combining both, the model often reaches accuracy that neither source could achieve alone. This is practical because labels are expensive and raw data is cheap.

Two dominant strategies make this work. Pseudo-labeling uses the model's own confident predictions on unlabeled data as if they were true labels, then retrains on the expanded dataset. Consistency regularization forces the model to produce the same prediction for an input regardless of how it is perturbed, which smooths the decision boundary using unlabeled examples. Modern methods like FixMatch combine both ideas in a single framework.

### Quick Takeaways

- A few labeled examples and many unlabeled examples train together
- Pseudo-labeling treats confident model predictions as ground truth for unlabeled data
- Consistency regularization smooths the decision boundary using perturbations

## Definition

- **Pseudo-labeling** assigns the model's own high-confidence prediction as the label for an unlabeled example, then includes that example in the labeled training set.
- **Consistency regularization** penalizes the model when its predictions change under small perturbations of the input, such as random augmentations or noise.
- **FixMatch** combines pseudo-labeling with consistency regularization by generating a pseudo-label from a weakly augmented input and training the model to match it on a strongly augmented version of the same input.
- **Confidence threshold** is the minimum prediction confidence required before an unlabeled example's pseudo-label is trusted and used for training.
- **Manifold assumption** states that data lies on a lower-dimensional manifold and the decision boundary should not cut through dense regions of data.

## The Analogy

A language teacher gives ten students graded essays with feedback. Then the teacher hands out a hundred ungraded essays and says, "Read these too." The students cannot check their understanding against answers for the ungraded ones, but they notice spelling patterns, sentence structures, and common phrasing that sharpen their sense of what good writing looks like. The graded essays teach the rules. The ungraded essays reinforce the patterns. Semi-supervised learning is that classroom.

## When You See It

- Medical imaging where only a few scans have expert annotations but thousands more are available unlabeled
- Natural language tasks where labeled data requires domain experts but raw text is abundant
- Any domain where annotation cost is high but data collection cost is low
- Production systems that start with limited labeled data and grow their training set over time
- Agricultural imaging where a few crop disease samples are labeled but most field photos are not
- Autonomous driving where labeled driving scenarios are limited but dashcam footage is plentiful

## Examples

**Good:** Training a skin lesion classifier with 200 labeled dermatologist-annotated images and 50,000 unlabeled clinic photos. Pseudo-labeling on high-confidence predictions from the unlabeled pool pushes accuracy well above the labeled-only baseline.

**Bad:** Using pseudo-labels with a low confidence threshold on noisy data. The model generates incorrect labels, trains on them as truth, and spirals into worse performance. This is called confirmation bias.

**Good:** Applying FixMatch to a text classification task where you have 50 labeled reviews and 10,000 unlabeled ones. The model learns robust features by matching predictions across weak and strong augmentations.

**Bad:** Applying semi-supervised learning when the labeled set is already large enough to train a strong classifier. The extra complexity of pseudo-labeling adds noise without meaningful accuracy gains.

## Important Points

- Semi-supervised learning is most effective when labeled data is scarce relative to unlabeled data
- Pseudo-labeling can introduce confirmation bias if the initial model is too weak or the threshold is too low
- Consistency regularization depends on choosing good perturbations that preserve the label
- The unlabeled data must come from the same distribution as the labeled data, or the model learns wrong patterns
- Modern methods like FixMatch achieve near-supervised accuracy with as few as four labeled examples per class
- Teacher-student frameworks are a common architecture where a slowly updated teacher generates targets for the student
- Data augmentation quality directly impacts the effectiveness of consistency regularization
- Semi-supervised learning adds training complexity, so use it only when the labeled set is genuinely too small

## Summary

- Semi-supervised learning stretches a small labeled set by leveraging structure in abundant unlabeled data.
- Pseudo-labeling expands the training set using the model's own confident predictions.
- Consistency regularization smooths decisions by demanding stable predictions under perturbation.
- It works best when labels are scarce, data is plentiful, and both come from the same distribution.
- Start with a strong supervised baseline on the labeled set before adding the semi-supervised component.
- _The few graded essays set the standard, and the ungraded pile teaches the rhythm._
