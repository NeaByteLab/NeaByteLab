---
title: 'Harmony Overview'
source: 'https://developers.openai.com/cookbook/articles/openai-harmony'
description: 'What the Harmony response format is, why gpt-oss needs it, and how it extends ChatML.'
tags: ['harmony', 'gpt-oss', 'prompt-format', 'chatml']
---

# Harmony Overview

## Overview

Harmony is the response format that the gpt-oss open models were trained on, and it defines how a conversation is structured, how reasoning output is separated from the final answer, and how function calls are shaped. It mimics the OpenAI Responses API, so the mental model carries over directly.

If you consume gpt-oss through an API or a provider like Ollama, the inference layer handles Harmony for you, so you only touch it directly when you build your own inference stack, and even then the model will not behave correctly if you feed it plain text without Harmony.

### Quick Takeaways

- Harmony is mandatory for gpt-oss, not optional formatting
- It is an evolution of ChatML, not a brand new idea
- Its two headline additions are channels and a formal tool-calling protocol

## Definition

- **Harmony** is a token-based conversation format that uses special tokens to mark message boundaries, roles, channels, and tool metadata.
- **Encoding** means the special tokens live in the o200k_harmony tiktoken encoding.
- **Renderer** means the official openai_harmony library on PyPI and crates.io renders messages and parses model output, including a StreamableParser for token streaming.

## The Analogy

ChatML is a plain envelope that wraps each message with a role and nothing more, while Harmony is a courier form. The same outer envelope is still there, but the form now adds fields for which channel the message belongs to, who the message is addressed to, and what data type it carries, so if you know ChatML you already know the envelope, and Harmony simply adds the labeled fields on top.

## When You See It

- Building custom inference or serving gpt-oss on your own runtime
- Debugging why a local gpt-oss deployment returns garbage, which usually means Harmony is missing
- Parsing raw model tokens to separate chain-of-thought from the final answer

## Examples

**Good:** feed the model a full Harmony prompt that ends with an open assistant header, then stop at the return or call token.

**Bad:** send a raw string with no tokens and expect a coherent reply.

**ChatML vs Harmony, side by side:**

```text
ChatML:   <|im_start|>{role}\n{content}<|im_end|>
Harmony:  <|start|>{header}<|message|>{content}<|end|>
```

## Important Points

- gpt-oss requires Harmony to work correctly
- Prefer the official renderer over hand-rolling the format
- The format separates user-facing output from internal reasoning by design
- The design intentionally tracks the Responses API shape

## Summary

- Harmony is ChatML plus channels, a developer role, and a tool-calling protocol.
- Use the official renderer unless you have a strong reason not to.
- _The envelope is old, and the labeled fields are what make it Harmony._
