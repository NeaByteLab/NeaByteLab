---
title: 'Message Format'
source: 'https://developers.openai.com/cookbook/articles/openai-harmony'
description: 'The special tokens that build a Harmony message and the difference between the three stop tokens.'
tags: ['harmony', 'special-tokens', 'message-format', 'stop-token']
---

# Message Format

## Overview

A Harmony conversation is a sequence of messages, and each message follows one fixed shape made of an opening token, a header, a separator, the content, and a closing token, where special tokens mark every boundary so the model can parse the structure without ambiguity.

The subtle part is the stop tokens, since there are three ways a message can end, and they mean different things for your inference loop.

### Quick Takeaways

- One message shape, start, header, message, content, end
- Special tokens live in the o200k_harmony encoding
- Three stop tokens, end, return, and call

## Definition

**Special tokens and their token ids:**

- **start** with id 200006 begins a message and is followed by the header, which starts with the role.
- **end** with id 200007 ends a fully formed message.
- **message** with id 200008 marks the transition from header to content.
- **channel** with id 200005 marks the channel section of the header.
- **constrain** with id 200003 marks the data type in a tool call.
- **return** with id 200002 is a stop token that means the model finished the final answer.
- **call** with id 200012 is a stop token that means the model wants to call a tool.

**Message shape:**

```text
<|start|>{header}<|message|>{content}<|end|>
```

The header holds the meta info and starts with the role. It can also carry a channel, a recipient written as to equals name, and a content type.

## The Analogy

Think of a shipping label, where the start token is where the label begins, the header is the address block, and the message token is the line that separates the address from the parcel contents, while the end token seals the box. The return and call tokens are two different delivery-complete stamps, where one says the reply is done and the other says a tool pickup is needed.

## When You See It

- Writing a renderer that emits tokens for the model
- Writing a parser that reconstructs messages from generated tokens
- Deciding when to stop inference

## Examples

**Minimal chat input** where the assistant header is left open and the model continues from there:

```text
<|start|>user<|message|>What is 2 + 2?<|end|>
<|start|>assistant
```

**Model output** that ends with the return token:

```text
<|channel|>analysis<|message|>Simple arithmetic. Provide answer.<|end|>
<|start|>assistant<|channel|>final<|message|>2 + 2 = 4.<|return|>
```

## Important Points

- The end token closes a fully formed message
- The call and return tokens are decode-time stop tokens, so stop inference on either one
- The recipient may appear in the role or the channel part of the header
- When storing an assistant reply to history, replace a trailing return token with an end token

## Common Mistakes

- Passing the stop token back into the model during parsing
- Persisting history with the return token instead of normalizing to the end token
- Forgetting that one completion can contain several messages

## Summary

- Every message is start, header, message, content, and close.
- Three stop tokens carry three different meanings, so handle each one.
- _Normalize the return token to the end token before you store a turn, or the next prompt is malformed._
