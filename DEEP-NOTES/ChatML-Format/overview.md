---
title: 'ChatML Overview'
source: 'https://huggingface.co/learn/agents-course/unit1/messages-and-special-tokens'
description: 'What ChatML is, why chat templates exist, and how a message list becomes a single model prompt.'
tags: ['chatml', 'chat-template', 'prompt', 'llm']
---

# ChatML Overview

## Overview

ChatML is a template format that structures a conversation with clear role indicators, namely system, user, and assistant. When you chat with a system like ChatGPT or HuggingChat, the message list you see in the interface is only a UI abstraction, and before anything reaches the model all the messages are concatenated and formatted into a single prompt, because the model does not remember the conversation and reads it in full every time.

This is the job of a chat template, which acts as the bridge between conversational messages and the specific formatting rules of the model you chose, so that every model receives a correctly formatted prompt despite using its own special tokens.

### Quick Takeaways

- A conversation is really one concatenated prompt, not separate memories
- ChatML gives a conversation clear roles that the model can parse
- Different models share the ChatML message shape but use different special tokens

## Definition

- **ChatML** is a standard way to represent a chat as a list of messages, where each message has a role and content.
- **A chat template** is the code that turns that message list into the final prompt string for a specific model.
- **A prompt** is the single stand-alone string of tokens that is actually fed into the model.

## The Analogy

ChatML is like a shared script format for a play, where every message is a line labeled with who speaks it, namely the director as system, the visitor as user, and the actor as assistant. The script is the same idea across theaters, but each theater has its own stage cues and curtain signals, which are the special tokens, and the chat template is the stagehand who takes the shared script and rewrites it with the cues that this particular theater understands.

## When You See It

- Formatting a conversation before sending it to a model
- Switching between models and needing the right delimiters for each one
- Building an agent where the system message also carries tool instructions

## Examples

**A ChatML message list:**

```python
conversation = [
    {"role": "user", "content": "I need help with my order"},
    {"role": "assistant", "content": "I'd be happy to help. Could you provide your order number?"},
    {"role": "user", "content": "It's ORDER-123"},
]
```

**The same list rendered by the SmolLM2 template:**

```text
<|im_start|>system
You are a helpful AI assistant named SmolLM, trained by Hugging Face<|im_end|>
<|im_start|>user
I need help with my order<|im_end|>
<|im_start|>assistant
I'd be happy to help. Could you provide your order number?<|im_end|>
<|im_start|>user
It's ORDER-123<|im_end|>
<|im_start|>assistant
```

## Important Points

- The model reads the whole conversation on every turn, since it holds no memory
- The message list is model-agnostic, but the rendered prompt is model-specific
- Chat templates keep multi-turn context coherent by preserving history
- ChatML is the standard shape used by most modern chat APIs

## Summary

- ChatML is the shared message shape, and the chat template renders it per model.
- A conversation is always flattened into one prompt before the model sees it.
- _The message list is what you write, and the prompt is what the model actually reads._
