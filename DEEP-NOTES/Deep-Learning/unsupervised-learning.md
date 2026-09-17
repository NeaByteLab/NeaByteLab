---
title: 'Unsupervised Learning'
source: 'https://en.wikipedia.org/wiki/Unsupervised_learning'
description: 'Learning patterns and structure from data that has no labels or predefined categories.'
tags: ['deep-learning', 'unsupervised-learning', 'clustering', 'autoencoder']
---

# Unsupervised Learning

## Overview

Unsupervised learning works with raw data that carries no labels. The model looks for structure on its own, grouping similar things together, finding compressed representations, or learning to generate new samples that look like the training data. Nobody tells the model what is right or wrong. It discovers patterns by exploiting statistical regularities in the input distribution.

This paradigm is valuable when labels are expensive or impossible to obtain. Clustering organizes data into natural groups. Dimensionality reduction compresses high-dimensional data into fewer meaningful dimensions. Autoencoders learn compact internal representations by reconstructing their own input. Generative models like GANs and VAEs learn the data distribution well enough to produce new samples from it.

### Quick Takeaways

- No labels exist, so the model finds structure by itself
- Clustering groups similar data points and dimensionality reduction compresses them
- Autoencoders and generative models learn the underlying data distribution

## Definition

- **Clustering** partitions data into groups where members of each group are more similar to each other than to members of other groups, using methods like k-means or DBSCAN.
- **Dimensionality reduction** maps high-dimensional data to a lower-dimensional space while preserving meaningful structure, using methods like PCA or t-SNE.
- **Autoencoder** is a neural network that compresses input into a bottleneck representation and then reconstructs it, forcing the bottleneck to capture essential features.
- **Generative model** learns the probability distribution of the training data and can sample new data points from it, including GANs and VAEs.
- **Latent space** is the compressed internal representation that captures the factors of variation in the data.

## The Analogy

A child dumps a box of mixed buttons onto a table with no instructions. Nobody says which buttons go together. The child starts sorting them by color, then by size, then by shape, discovering natural groupings on their own. Some buttons cluster into obvious piles while others sit between groups. The child might also notice that just three features, such as color and size and shape, describe every button well enough to skip looking at all twenty details. Unsupervised learning is the child sorting buttons without a sorting guide, and the piles are whatever structure the data actually has.

## When You See It

- Customer segmentation where a business groups users by behavior without predefined segments
- Anomaly detection where the model learns what normal looks like and flags anything that deviates
- Compressing images or embeddings into lower dimensions for visualization or storage
- Pre-training representations that downstream supervised tasks can fine-tune
- Topic modeling where documents are grouped by theme without predefined topic labels
- Data exploration where the structure of a new dataset is unknown and needs to be discovered

## Examples

**Good:** Running k-means on customer purchase histories to discover natural spending segments. The algorithm finds clusters that marketing never defined but that reflect real behavior patterns.

**Bad:** Using k-means when you already know the exact categories and have labels for them. Supervised classification would give better accuracy because it uses the label signal directly.

**Good:** Training a variational autoencoder on face images to learn a smooth latent space, then interpolating between faces to generate new ones.

**Bad:** Expecting an autoencoder to produce clean outputs when the training data is tiny. Without enough examples the model cannot learn the data distribution and produces noise.

## Important Points

- Unsupervised learning scales well because it does not need human annotation
- The quality of discovered structure depends heavily on the choice of algorithm and hyperparameters
- Evaluation is harder than supervised learning because there is no ground truth to compare against
- Autoencoders learn features that transfer to other tasks when used as pre-training
- Generative models like GANs can produce photorealistic samples but are notoriously hard to train stably
- Clustering requires choosing the number of clusters in advance for methods like k-means, and a bad choice distorts the result
- Anomaly detection is a natural application because the model learns normal patterns and flags deviations
- The latent space of a well-trained generative model captures meaningful factors of variation like pose and lighting

## Summary

- Unsupervised learning finds structure in data without any labels or supervision signal.
- Clustering groups similar points and dimensionality reduction compresses them into fewer dimensions.
- Autoencoders and generative models learn the data distribution from reconstruction or sampling objectives.
- Evaluation is inherently harder because there is no answer key to check against.
- The structure is real, but discovering it requires the right algorithm and enough data.
- _The buttons sort themselves once you stop telling them where to go._
