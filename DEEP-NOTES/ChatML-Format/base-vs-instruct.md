---
title: 'Base vs Instruct Models'
source: 'https://huggingface.co/learn/agents-course/unit1/messages-and-special-tokens'
description: 'The difference between base and instruct models and why chat templates make a base model behave like an instruct one.'
tags: ['chatml', 'base-model', 'instruct-model', 'fine-tuning']
---

# Base vs Instruct Models

## Overview

A base model is trained on raw text to predict the next token, while an instruct model is fine-tuned specifically to follow instructions and hold a conversation, so for example SmolLM2-135M is a base model and SmolLM2-135M-Instruct is its instruction-tuned variant. To make a base model behave like an instruct model, you format the prompt in a consistent way that the model can understand, which is exactly what a chat template provides.

The catch is that a base model can be fine-tuned on different chat templates, so when you use an instruct model you must use the matching template, or the formatting the model learned will not line up.

### Quick Takeaways

- A base model only predicts the next token from raw text
- An instruct model is fine-tuned to follow instructions and chat
- A chat template lets a base model imitate instruct behavior

## Definition

- **A base model** is trained on raw text data with the single goal of predicting the next token.
- **An instruct model** is a base model fine-tuned to follow instructions and engage in conversation.
- **The matching template** is the specific chat format an instruct model was trained on, which must be reused at inference time.

## The Analogy

A base model is like a fluent writer who can continue any text but has never been told to hold a conversation, and an instruct model is that same writer after training as a customer service agent, now used to a fixed script format. If you speak to the agent using the exact script they trained on they respond perfectly, but use a different script and the training no longer fits.

## When You See It

- Choosing between a base and an instruct variant of a model
- Formatting prompts so a base model follows instructions consistently
- Selecting the correct chat template for a given instruct model

## Examples

**Good:** use SmolLM2-135M-Instruct with the exact template it was trained on.

**Bad:** feed an instruct model a prompt formatted with a different model template and expect reliable behavior.

**Good:** apply a consistent ChatML format to a base model so it can imitate instruction following.

## Important Points

- Base models predict text, and instruct models follow instructions
- A chat template is how you coax instruct-like behavior from a base model
- Each instruct model expects the specific template it was fine-tuned on
- Mismatched templates lead to inconsistent or broken behavior

## Common Mistakes

- Using an instruct model with the wrong chat template
- Expecting a base model to follow instructions without any formatting
- Assuming every instruct model shares one universal template

## Summary

- Base models predict tokens, and instruct models follow instructions.
- Chat templates make a base model behave like an instruct model.
- _An instruct model only performs when you speak the script it was trained on._
