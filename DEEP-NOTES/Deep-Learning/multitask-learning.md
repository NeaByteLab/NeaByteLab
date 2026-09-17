---
title: 'Multitask Learning'
source: 'https://en.wikipedia.org/wiki/Multi-task_learning'
description: 'Training a single model on multiple related tasks so shared knowledge improves each one.'
tags: ['deep-learning', 'multitask-learning', 'shared-representation', 'auxiliary-task']
---

# Multitask Learning

## Overview

Multitask learning trains one model on several tasks at the same time. The model shares some layers across tasks and keeps separate heads for each output. The shared layers learn features that generalize across tasks, which acts as a built-in regularizer. If the tasks are related, the shared representation is richer than what any single task would produce alone.

The payoff depends on task relatedness. When tasks share underlying structure, they push the shared layers toward features that capture that structure. When tasks conflict, the gradients fight each other and performance drops. Balancing task losses is the central practical challenge, because a dominant task can starve the others.

Multitask learning is different from transfer learning. Transfer learning trains on one task first and adapts to another. Multitask learning trains on all tasks simultaneously. The shared representation is shaped by all tasks from the start, not inherited from one and adapted to another.

### Quick Takeaways

- Shared layers act as an implicit regularizer across related tasks
- Hard parameter sharing uses identical layers while soft sharing uses separate but linked layers
- Task balancing prevents one task from dominating the gradient updates

## Definition

- **Hard parameter sharing** means all tasks pass through the exact same hidden layers and branch only at the output heads.
- **Soft parameter sharing** gives each task its own set of layers but adds a regularization term that encourages the parameters to stay close to each other.
- **Auxiliary task** is a secondary objective added to improve the main task, not because its output is needed at inference time.
- **Task balancing** is the practice of weighting or scheduling task losses so no single task dominates the gradient updates during training.
- **Negative transfer** occurs when an unrelated or conflicting task degrades the performance of another task in the shared model.
- **Gradient conflict** happens when two tasks push a shared weight in opposite directions during the same update step.

## The Analogy

A student prepares for three exams at once: math, physics, and chemistry. The algebra skills from math help solve physics equations, and the atomic theory from chemistry helps understand physics at the molecular level. Studying all three together builds a stronger foundation than studying each in isolation. But if the student also tries to prepare for a history exam, the unrelated material competes for study time without reinforcing anything, and all scores drop. The key is that the exams must share underlying concepts. When they do, the shared study time is an investment. When they do not, it is a tax.

## When You See It

- A self-driving perception stack predicts depth, segmentation, and object detection from the same image encoder
- A language model jointly learns part-of-speech tagging and named entity recognition
- A recommendation system predicts click-through rate and watch time from the same user embedding
- An auxiliary reconstruction loss is added to improve a classifier hidden representation
- A speech model jointly predicts transcription and speaker identity from shared audio features

## Examples

**Good:** A single encoder processes images and feeds into three heads for object detection, lane segmentation, and depth estimation. The detection head benefits from depth cues and the depth head benefits from object boundaries. All three tasks improve over their single-task baselines because the shared features capture spatial structure that every head needs.

**Bad:** Jointly training sentiment analysis and machine translation in the same model. The two tasks need very different representations. Sentiment needs local phrase-level features while translation needs long-range sequential alignment. The shared encoder cannot satisfy both and both tasks underperform their single-task counterparts. The gradient conflicts between these tasks make the shared layers worse at both.

## Important Points

- Start with hard parameter sharing because it is simpler and works well when tasks are closely related
- Use uncertainty weighting or gradient normalization to balance task losses automatically
- Add auxiliary tasks that are cheap to label but expose useful structure in the data
- Monitor per-task metrics separately because aggregate loss can hide a collapsing task
- Remove a task from the joint model if it consistently hurts others after tuning the balance
- The number of shared layers versus task-specific layers is a hyperparameter worth searching
- Gradient surgery methods like PCGrad project conflicting gradients to reduce interference between tasks
- When one task has far more data than the others, sampling strategies like temperature-based mixing help equalize task exposure
- At inference time, unused task heads can be discarded, so the serving cost is the same as a single-task model

## Summary

- Shared layers learn richer features when the tasks are related.
- Hard sharing ties layers directly while soft sharing links them loosely.
- Auxiliary tasks can boost the main task without needing their output at inference.
- Task balancing is the make-or-break practical step.
- Gradient conflicts between tasks must be detected and resolved, not ignored.
- _Three exams strengthen each other, but a fourth from a different school just splits the night._
