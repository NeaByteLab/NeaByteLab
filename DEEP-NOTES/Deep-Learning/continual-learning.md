---
title: 'Continual Learning'
source: 'https://en.wikipedia.org/wiki/Continual_learning'
description: 'Training a model on a sequence of tasks without forgetting what it learned from earlier ones.'
tags: ['deep-learning', 'continual-learning', 'catastrophic-forgetting', 'lifelong-learning']
---

# Continual Learning

## Overview

Neural networks forget. When you train a model on task A and then train it on task B, the weights shift to serve B and the performance on A collapses. This is catastrophic forgetting, and it is the central problem of continual learning. The goal is to learn a sequence of tasks over time while retaining knowledge from all previous ones.

Three families of solutions exist. Regularization methods like elastic weight consolidation penalize changes to important weights. Replay methods store or generate examples from old tasks and mix them into current training. Architecture methods grow the network or assign dedicated parameters per task. Each trades off plasticity, which is the ability to learn new tasks, against stability, which is the ability to retain old ones.

Continual learning is closely related to online learning but adds the harder constraint that old tasks may never reappear. In online learning the data stream is often stationary or slowly drifting. In continual learning the tasks are distinct and sequential, and forgetting is the primary failure mode.

### Quick Takeaways

- Catastrophic forgetting destroys old knowledge when new tasks overwrite shared weights
- The stability-plasticity dilemma is the fundamental tension in continual learning
- Solutions fall into three categories: regularization, replay, and architecture methods

## Definition

- **Catastrophic forgetting** is the abrupt loss of previously learned knowledge when a neural network is trained on new data from a different task.
- **Elastic weight consolidation (EWC)** adds a penalty term that discourages large changes to weights that were important for previous tasks, measured by the Fisher information matrix.
- **Replay buffer** is a memory bank of stored examples from earlier tasks that are mixed into the current training batch to preserve old knowledge.
- **Progressive networks** freeze old task columns and add new lateral connections for each new task, preventing any forgetting by design at the cost of growing parameters.
- **Task-incremental learning** assumes the task identity is known at test time, so the model only needs to pick among classes within that task.
- **Class-incremental learning** does not reveal the task identity at test time, so the model must distinguish among all classes seen so far across all tasks.

## The Analogy

A musician learns piano for years, then switches to guitar. If practicing guitar causes the fingers to forget piano entirely, that is catastrophic forgetting. A careful musician sets aside time each week to play old piano pieces, which is the replay buffer. Another approach is to protect the muscle memory for piano by being extra careful not to change those specific movements while learning guitar, which is elastic weight consolidation. A third option is to grow a new set of motor skills for guitar without touching the piano circuitry at all, which is a progressive network.

## When You See It

- A robot deployed in a factory learns new product types over months without retraining from scratch
- A language model is updated with new knowledge without forgetting its original capabilities
- A medical imaging system expands to new pathologies as labeled data arrives sequentially
- A classification system adds new categories over time in a class-incremental setting
- An autonomous vehicle must learn to handle new road types and weather conditions after initial deployment

## Examples

**Good:** A model trained on ten object classes uses EWC when learning ten more. The Fisher information matrix identifies which weights matter most for the first ten classes, and the penalty keeps those weights stable. After learning all twenty classes, accuracy on the first ten drops only a few percent instead of collapsing to near zero.

**Bad:** Fine-tuning a pretrained model on a new task with no forgetting mitigation. After a few epochs on the new task, the model performs well on it but accuracy on the original task drops from 95 percent to 30 percent. The weights that encoded the original knowledge were overwritten without protection. This is the default behavior and happens every time without an explicit countermeasure.

## Important Points

- EWC is simple to implement but scales poorly because it stores a Fisher matrix per task
- Replay buffers are effective but raise storage and privacy concerns for sensitive data
- Generative replay uses a generative model to produce pseudo-examples of old tasks instead of storing real data
- Progressive networks prevent forgetting entirely but grow linearly with the number of tasks
- Class-incremental learning is harder than task-incremental because the model must handle all classes without a task label
- The stability-plasticity tradeoff means no method perfectly balances remembering and learning
- Knowledge distillation from the old model to the new one is another way to preserve past knowledge
- Measuring forgetting requires evaluating on all previous tasks after each new one, not just the latest
- In practice, a small replay buffer combined with EWC often outperforms either method alone

## Summary

- Catastrophic forgetting is the default behavior of neural networks trained sequentially.
- EWC protects important weights by penalizing changes measured through the Fisher information.
- Replay buffers mix old examples into new training to keep memories alive.
- Progressive networks grow new capacity and freeze old capacity for zero forgetting.
- Class-incremental is the harder and more realistic setting because the task identity is unknown at test time.
- _The musician who never revisits old songs will forget them, and the one who never learns new ones will stagnate._
