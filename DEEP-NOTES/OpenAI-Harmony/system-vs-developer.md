---
title: 'System vs Developer Message'
source: 'https://developers.openai.com/cookbook/articles/openai-harmony'
description: 'Why Harmony splits the prompt into a system meta layer and a developer instruction layer.'
tags: ['harmony', 'system-message', 'developer-message', 'prompt']
---

# System vs Developer Message

## Overview

In most formats the system prompt is one thing, but Harmony splits it in two. The `system` message holds the meta configuration, while the `developer` message holds the actual instructions that other formats would call the system prompt. Confusing the two is a common source of weak results, so knowing which layer owns which setting keeps your prompt clean and the model predictable.

### Quick Takeaways

- The `system` message holds meta config, and the `developer` message holds the real instructions
- Model identity stays fixed in `system`, while persona changes go in `developer`
- Function tools and response formats live in `developer`

## Definition

**The system message defines the following:**

- The identity, which always stays as `You are ChatGPT, a large language model trained by OpenAI.`
- The meta dates, namely the knowledge cutoff and the current date.
- The reasoning effort, set to high, medium, or low.
- The valid channels, namely analysis, commentary, and final.
- The built-in tools such as browser and python, added under a Tools section.
- A note that function calls must go to the commentary channel, added only when functions exist.

**The developer message defines the following:**

- The instructions, which are the real system prompt, placed under an Instructions section.
- The function tools, placed under a Tools section.
- The structured output schema, placed under a Response Formats section.

## The Analogy

The `system` message is like the firmware settings of a machine, holding the clock, the region, and the installed hardware, while the `developer` message is like the job sheet you hand the operator, telling them what to actually do today, so you do not rewrite firmware to change today task, you simply write a new job sheet.

## When You See It

- Setting reasoning effort in system versus writing behavior rules in developer
- Changing the assistant persona, where you keep identity in system and override it in developer
- Registering function tools, which always go in the developer message

## Examples

**Good, a system message with meta only:**

```text
<|start|>system<|message|>You are ChatGPT, a large language model trained by OpenAI.
Knowledge cutoff: 2024-06
Current date: 2025-06-28

Reasoning: high

# Valid channels: analysis, commentary, final. Channel must be included for every message.<|end|>
```

**Good, a developer message with the real instructions:**

```text
<|start|>developer<|message|># Instructions

Use a friendly tone.<|end|>
```

**Bad:** putting the instruction to use a friendly tone inside the system message and leaving the developer message empty.

## Important Points

- Never change the identity line, and override persona through developer instructions instead
- Add the note that calls must go to the commentary channel when functions exist
- Built-in tools go in system, while function tools go in developer
- Response format schemas belong at the end of the developer message

## Common Mistakes

- Treating system as the place for the actual prompt
- Editing the identity line to change behavior
- Mixing built-in tool definitions into the developer message

## Summary

- System is the meta and firmware layer, while developer is the job sheet.
- Identity is fixed, and persona is a developer instruction.
- _If it configures the model it is system, and if it tells the model what to do it is developer._
