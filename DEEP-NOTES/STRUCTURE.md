# Deep Notes Structure

> Reference: [kyong0612 learning-notes](https://github.com/kyong0612/learning-notes/tree/main/articles) (example: [Claude Code CLAUDE.md](https://github.com/kyong0612/learning-notes/blob/main/articles/Claude%20Code%20%E3%81%AE%20CLAUDE.md%E3%81%AF%E8%A8%AD%E5%AE%9A%E3%81%97%E3%81%9F%E6%96%B9%E3%81%8C%E3%81%84%E3%81%84/note.md))

- One file = one topic or one source
- Frontmatter + structured body; body starts with H1 = note title

---

## 1. Frontmatter (YAML)

```yaml
---
title: 'Note title (representative)'
source: 'Reference URL'
description: 'One or two sentences: what it covers and the main takeaway.'
tags: ['tag1', 'tag2']
---
```

- **title**: Title used in the note (usually same as or a summary of the source).
- **source**: One clickable URL.
- **description**: Short summary for quick scan.
- **tags**: For filtering and navigation. Inline array or multi-line list (as in Time-Complexity) both valid.

---

## 2. Body Structure

**First line of body:** `# Note Title` (H1, same or close to `title` in frontmatter). Kyong always uses this; we follow.

Two patterns:

### Pattern A: Article / Talk Summary (Kyong Style)

Follow the source flow. Not rigid Definition/Analogy/Examples.

- **## はじめに** (or **## Overview** / intro): context, why this topic, what changed for the author.
- **## [Topic 1]**, **## [Topic 2]**, …: sections follow the article/talk structure. Use **###** for subsections.
- Lists, code blocks (```), **bold** for important terms.
- **## まとめ** (or **## Summary**): summary; end with **結論:** or one takeaway sentence (italic allowed).

Real flow example: [note Claude Code CLAUDE.md](https://github.com/kyong0612/learning-notes/blob/main/articles/Claude%20Code%20%E3%81%AE%20CLAUDE.md%E3%81%AF%E8%A8%AD%E5%AE%9A%E3%81%97%E3%81%9F%E6%96%B9%E3%81%8C%E3%81%84%E3%81%84/note.md) — はじめに → CLAUDE.mdとは → ワークフロー → TDD → ツール → … → まとめ + 結論.

### Pattern B: Concept Note

One concept per file; fixed sections. Optional extra sections (e.g. a deeper dive) are allowed.

- **## Overview**: one or two paragraphs, what this note is about and the main point.
- **## Definition** (if needed): formal definition or term boundaries.
- **## The Analogy**: real-world analogy.
- **## When You See It**: when this pattern appears (code, algorithm, context).
- **## Examples**: concrete examples; label **Good:** / **Bad:** (or **Better:** / **Good to know:** as needed).
- **## Important Points**: key points (bullets).
- **## Summary**: summary (bullets) + one closing italic sentence (NeaByte style).

---

## 3. Writing Style

| Aspect          | Rule                                                      |
| --------------- | --------------------------------------------------------- |
| **Density**     | Short sentences, one idea per sentence. Avoid filler.     |
| **Punctuation** | Use periods, commas, colons. Avoid excessive em dash (—). |
| **Examples**    | **Good:** / **Bad:** (text only, no emoji).               |
| **Closing**     | One italic sentence; direct and humble.                   |

---

## 4. File Naming

- Actual file: **lowercase**, kebab-case. Examples: `o-1-constant.md`, `o-n-squared-quadratic.md`.
- In README/index: link to the actual file name (lowercase). Current practice: use lowercase in the table.

---

## 5. Checklist (per note)

**General:**

1. Frontmatter: title, source, description, tags.
2. Body starts with **# Note Title** (H1).
3. Save with lowercase kebab-case file name.

**Pattern A (Article Summary):** intro → sections follow source → まとめ + 結論.

**Pattern B (Concept):** Overview → Definition → The Analogy → When You See It → Examples → Important Points → Summary + italic sentence.

---

## 6. Minimal Template (Pattern B: Concept)

```markdown
---
title: 'Note Title'
source: 'https://...'
description: 'One sentence: what it covers and the main point.'
tags: ['tag1', 'tag2']
---

# Note Title

## Overview

[One or two paragraphs: what this note is about, main point.]

## Definition

[Formal definition or term boundaries.]

## The Analogy

[Real-world analogy.]

## When You See It

[When this pattern appears.]

## Examples

**Good:** [example]

**Bad:** [counter-example]

## Important Points

- Point 1
- Point 2

## Summary

- Short summary.
- _Closing italic sentence._
```

---

_Clear metadata, body starts with H1, structured content (summary follows source / concept uses Overview→Summary), closing that can be read standalone. Pattern A = kyong (article); Pattern B = Time-Complexity (concept)._
