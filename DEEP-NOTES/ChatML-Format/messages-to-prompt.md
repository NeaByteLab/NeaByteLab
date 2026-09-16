---
title: 'Messages to Prompt'
source: 'https://huggingface.co/learn/agents-course/unit1/messages-and-special-tokens'
description: 'Using the tokenizer apply_chat_template function to render a ChatML message list into the final model input.'
tags: ['chatml', 'apply-chat-template', 'tokenizer', 'transformers']
---

# Messages to Prompt

## Overview

The easiest and safest way to turn a conversation into a correctly formatted prompt is to use the chat template that ships with the model tokenizer, where in transformers you load the tokenizer and call apply_chat_template on your message list, and it returns a prompt string that is ready to send to the model. This same function runs in the backend of chat APIs whenever you interact with messages in the ChatML format, so by letting the tokenizer own the formatting you avoid hand-writing delimiters and you always match the exact format the chosen model expects.

### Quick Takeaways

- Use apply_chat_template rather than building the prompt by hand
- The tokenizer already knows the correct template for its model
- The same function powers the backend of ChatML chat APIs

## Definition

- **apply_chat_template** is the tokenizer method that renders a ChatML message list into the model prompt.
- **add_generation_prompt** is an option that appends the opening assistant turn so the model knows to continue.
- **The rendered prompt** is the final string, ready to be tokenized and passed to the model.

## The Analogy

Using apply_chat_template is like handing your rough script to the theater own stage manager instead of formatting the cues yourself, since the stage manager already knows this theater signals by heart, so the script comes back with every cue in the right place, ready for the actor to perform without you guessing at the details.

## When You See It

- Preparing a conversation as input for a specific instruct model
- Building an API layer that accepts messages and returns a model prompt
- Ensuring the assistant is prompted to generate the next turn

## Examples

**A conversation to render:**

```python
messages = [
    {"role": "system", "content": "You are an AI assistant with access to various tools."},
    {"role": "user", "content": "Hi !"},
    {"role": "assistant", "content": "Hi human, what can help you with ?"},
]
```

**Loading the tokenizer and rendering the prompt:**

```python
from transformers import AutoTokenizer

tokenizer = AutoTokenizer.from_pretrained("HuggingFaceTB/SmolLM2-1.7B-Instruct")
rendered_prompt = tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
```

## Important Points

- The tokenizer chat template is the source of truth for formatting
- Setting add_generation_prompt to true cues the model to write the next turn
- Setting tokenize to false returns a readable string rather than token ids
- The rendered prompt is ready to use directly as model input

## Common Mistakes

- Manually concatenating messages instead of calling apply_chat_template
- Forgetting add_generation_prompt, so the model is not cued to respond
- Loading a tokenizer that does not match the target model

## Summary

- Call apply_chat_template on the tokenizer to render messages into a prompt.
- The tokenizer knows the correct template, so you only structure the messages.
- _Hand the messages to the tokenizer, and it returns the exact prompt the model expects._
