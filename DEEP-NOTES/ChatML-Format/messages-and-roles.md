---
title: 'Messages and Roles'
source: 'https://huggingface.co/learn/agents-course/unit1/messages-and-special-tokens'
description: 'The system, user, and assistant roles that make up a ChatML conversation and what each one does.'
tags: ['chatml', 'roles', 'system-message', 'conversation']
---

# Messages and Roles

## Overview

A ChatML conversation is a list of messages, and every message carries a role and its content, where the three core roles are system, user, and assistant. The system role sets behavior, the user role carries human input, and the assistant role carries the model reply, so a real conversation is just these messages alternating between the human and the model, and the template preserves that history so multi-turn exchanges stay coherent.

Getting the roles right matters, because the system message is the one that shapes tone, rules, and, for agents, the available tools and how actions should be formatted.

### Quick Takeaways

- Three core roles, namely system, user, and assistant
- The system message is a persistent instruction that guides every later turn
- User and assistant messages alternate to form the conversation history

## Definition

- **The system message**, also called the system prompt, defines how the model should behave and acts as a persistent instruction across the whole session.
- **The user message** carries the human input for a single turn.
- **The assistant message** carries the model reply for a single turn.
- **A conversation** is the alternating sequence of user and assistant messages, optionally opened by a system message.

## The Analogy

Think of a stage play, where the system message is the director briefing given before the curtain rises, telling the actor how to behave for the entire show. The user messages are the visitor lines, and the assistant messages are the actor lines, so the show is the back and forth between visitor and actor, while the director briefing quietly shapes every line the actor delivers.

## When You See It

- Setting the persona or rules of an assistant through a system message
- Building an agent where the system message also lists tools and action formats
- Preserving prior turns so the model keeps track of what was already said

## Examples

**A system message that sets a polite persona:**

```python
system_message = {
    "role": "system",
    "content": "You are a professional customer service agent. Always be polite, clear, and helpful."
}
```

**A multi-turn conversation with all three roles:**

```python
messages = [
    {"role": "system", "content": "You are a math tutor."},
    {"role": "user", "content": "What is calculus?"},
    {"role": "assistant", "content": "Calculus is a branch of mathematics..."},
    {"role": "user", "content": "Can you give me an example?"},
]
```

## Important Points

- The system message persists and influences every subsequent interaction
- For agents, the system message also carries tool info and action formatting rules
- User and assistant messages must alternate to form a valid history
- Changing only the system message can flip the assistant from polite to rebellious

## Common Mistakes

- Putting behavior rules in a user message instead of the system message
- Dropping earlier turns and losing the conversation context
- Forgetting that the system message applies to the whole session, not one turn

## Summary

- System sets behavior, user carries input, and assistant carries the reply.
- The system message is persistent, while user and assistant turns alternate.
- _The system message is the director briefing that shapes every line the model speaks._
