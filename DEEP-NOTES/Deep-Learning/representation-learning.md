---
title: 'Representation Learning'
source: 'https://en.wikipedia.org/wiki/Representation_learning'
description: 'How deep networks learn their own representations of data instead of relying on hand-crafted features.'
tags: ['deep-learning', 'representation-learning', 'feature-extraction', 'embedding']
---

# Representation Learning

## Overview

Representation learning is the family of methods where a model discovers the representations it needs for a task directly from raw data. Instead of a human deciding which features matter, the model learns to transform the input into a form that makes the downstream task easier. A face recognizer does not receive hand-measured distances between eyes and nose. It receives pixels and learns, layer by layer, what matters.

The learned representation is often called an embedding or a latent vector. It lives in a latent space where similar inputs land close together and dissimilar inputs land far apart. The quality of this space determines how well the model performs, which is why representation learning is sometimes called the core problem in deep learning.

### Quick Takeaways

- The model learns what to measure instead of being told
- Learned representations consistently beat hand-crafted features on complex tasks
- The latent space is where the real knowledge lives, not in the final classifier

## Definition

- **Representation** is a transformation of raw data into a vector that captures the properties useful for a given task.
- **Embedding** is a dense, low-dimensional vector that represents a high-dimensional input, such as a word or an image.
- **Latent space** is the continuous vector space in which embeddings live, where geometric distance reflects semantic similarity.
- **Hand-crafted features** are representations designed by a human expert using domain knowledge, such as SIFT descriptors or Mel-frequency cepstral coefficients.

## The Analogy

Hand-crafting features is like a librarian who sorts books by color and height. The system works for a small shelf, but it breaks when you ask a question like "find books about the French Revolution." Representation learning is like letting a well-read assistant organize the library by topic, era, and writing style after reading every book. The assistant builds a map of the collection that answers questions the librarian's color scheme never could.

## When You See It

- Word2Vec, GloVe, and transformer embeddings in NLP
- Autoencoders and variational autoencoders that compress data into latent vectors
- Transfer learning, where a pretrained model's internal representations are reused for a new task
- Self-supervised learning, where the model invents its own training signal to learn representations without labels

## Examples

**Good:** train a language model on a large corpus and use its internal embeddings to measure sentence similarity. The model learns that "dog" and "puppy" should be close in the latent space without anyone telling it so.

**Bad:** represent each word as a one-hot vector (a vector of all zeros with a single one). The representation has no notion of similarity. "Dog" and "puppy" are equally distant from each other as "dog" and "volcano."

**Latent space geometry:**

```
cosine_similarity(embed("king") - embed("man") + embed("woman"), embed("queen")) ≈ 0.9
```

## Important Points

- Representation quality is often more important than classifier complexity
- Deep networks learn hierarchical representations: edges, textures, parts, objects
- Pretraining on a large dataset produces general-purpose representations that transfer well
- A bad representation forces the downstream model to work harder and often fail
- Disentangled representations, where each dimension captures one factor of variation, are especially useful but hard to guarantee

## Summary

- Representation learning lets the model discover what features matter from data.
- Embeddings encode inputs as dense vectors in a latent space.
- Similar inputs cluster together in the latent space, and that structure is what downstream tasks exploit.
- Learned representations outperform hand-crafted ones when data is plentiful.
- _The representation is the bottleneck, and everything downstream depends on it._
