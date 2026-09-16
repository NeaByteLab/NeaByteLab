---
title: 'Special Tokens'
source: 'https://huggingface.co/learn/agents-course/unit1/messages-and-special-tokens'
description: 'The delimiter tokens that mark turn boundaries and end of sequence, and why they differ across models.'
tags: ['chatml', 'special-tokens', 'eos', 'delimiters']
---

# Special Tokens

## Overview

Special tokens are what models use to delimit where each user and assistant turn starts and ends, and just as every model has its own end of sequence token, each one also uses different formatting rules and delimiters for the messages in a conversation. ChatML gives the messages a shared shape, but the exact tokens that wrap those messages belong to the specific model.

This is why the same conversation looks different once rendered, since SmolLM2 wraps turns one way and Llama 3.2 wraps them another way, even though the underlying message list is identical.

### Quick Takeaways

- Special tokens mark the start and end of each turn
- The end of sequence token signals where a turn stops
- Different models use different delimiter tokens for the same message shape

## Definition

- **A special token** is a reserved marker that the model recognizes as structure rather than content.
- **The end of sequence token**, often called the EOS token, marks where a turn or generation ends.
- **A turn delimiter** wraps a single message, marking its role and its boundaries.

## The Analogy

Special tokens are like punctuation marks that only the model can read, since they are not part of what anyone says, they simply tell the model where one speaker stops and the next begins. Two languages can express the same sentence with different punctuation rules, and in the same way two models express the same conversation with different delimiter tokens.

## When You See It

- Reading a rendered prompt and spotting where each turn begins and ends
- Comparing how two models wrap the same conversation
- Making sure a generation stops cleanly at the right token

## Examples

**SmolLM2 style, using im_start and im_end:**

```text
<|im_start|>user
I need help with my order<|im_end|>
<|im_start|>assistant
```

**Llama 3.2 style, using header ids and eot_id:**

```text
<|begin_of_text|><|start_header_id|>system<|end_header_id|>

Cutting Knowledge Date: December 2023
Today Date: 10 Feb 2025

<|eot_id|><|start_header_id|>user<|end_header_id|>

I need help with my order<|eot_id|><|start_header_id|>assistant<|end_header_id|>
```

## Important Points

- Special tokens are structure, not conversation content
- The end of sequence token differs from model to model
- The same message list maps to different tokens depending on the model
- Llama 3.2 can also inject meta info such as dates into the system turn

## Common Mistakes

- Treating special tokens as normal text and typing them by hand
- Assuming one model delimiters will work for another model
- Forgetting the end of sequence token, which can make generation run on

## Summary

- Special tokens delimit turns and signal the end of a sequence.
- ChatML shares the message shape, but each model owns its delimiter tokens.
- _The words are the same, but the punctuation the model reads is model-specific._
