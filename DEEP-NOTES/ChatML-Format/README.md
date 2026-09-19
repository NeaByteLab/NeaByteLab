# ChatML Format

_The chat markup format that turns a message list into a single prompt._

## Contents

| File                                             | Topic              | One-line                                                      |
| ------------------------------------------------ | ------------------ | ------------------------------------------------------------- |
| [overview.md](./overview.md)                     | Overview           | What ChatML is, why chat templates exist, and what they solve |
| [messages-and-roles.md](./messages-and-roles.md) | Messages and Roles | The system, user, and assistant roles in a conversation       |
| [chat-templates.md](./chat-templates.md)         | Chat Templates     | Jinja2 templates that render messages into a prompt string    |
| [special-tokens.md](./special-tokens.md)         | Special Tokens     | Delimiters that mark turn boundaries and end of sequence      |
| [base-vs-instruct.md](./base-vs-instruct.md)     | Base vs Instruct   | Why instruct models need a template and base models do not    |
| [messages-to-prompt.md](./messages-to-prompt.md) | Messages to Prompt | Using apply_chat_template to render the final model input     |
