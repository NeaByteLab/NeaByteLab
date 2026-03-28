# Decision Tree

_Because "it depends" needs a structure_

## Table of Contents

- [Overview](#overview)
- [What Is a Decision Tree in Design?](#what-is-a-decision-tree-in-design)
- [When to Use a Decision Tree](#when-to-use-a-decision-tree)
- [Root Question First](#root-question-first)
- [Criteria Over Gut Feel](#criteria-over-gut-feel)
- [Leaves Should Be Actions](#leaves-should-be-actions)
- [Keep Depth Reasonable](#keep-depth-reasonable)
- [Document the Why](#document-the-why)
- [When the Tree Lies](#when-the-tree-lies)
- [Reuse vs Rebuild](#reuse-vs-rebuild)
- [Simple Beats Complete](#simple-beats-complete)

---

## Overview

Architecture and design decisions often get the answer "it depends." Depends on team, scale, deadline, risk. A decision tree helps turn that "it depends" into clear branches: one root question, written criteria, and leaves that are concrete decisions or actions you can follow.

This isn't about decision trees in machine learning. It's about mapping technical and design choices so you (and your team) don't drown in options without structure.

### Quick Takeaways

1. **One root question first**, then branch from there
2. **Written criteria**, so branches stay consistent, not just feeling-based
3. **Leaf = action or decision**, not "maybe" or "we'll see"
4. **Depth of 3–4 levels**, deeper is hard to maintain
5. **Write the "why"**, one sentence per branch so context doesn't get lost
6. **Trees go stale**, requirements change, treat them as living docs
7. **Check what already exists**, ADR or existing tree before creating a new one
8. **Simple > complete**, something that gets used beats something perfect that nobody opens

---

## What Is a Decision Tree in Design?

Here, a decision tree is a branching decision structure. One question or condition at the top, its answers lead to the next branches, until you reach a single concrete decision or action.

- **Root**, the top-level question or condition (level 0)
- **Branch**, each answer or criterion forms a branch
- **Leaf**, end of a branch: a decision or action you can actually take

Short example: "Need per-service scale within 12 months?" → Yes → consider microservices / modular monolith. No → start with a simple monolith. It doesn't have to be formal, what matters is that the flow is readable and reusable.

---

## When to Use a Decision Tree

Good fit when:

- Options are many and confusing
- Criteria are relatively clear (team size, scale, compliance, deadline)
- Cost of wrong choice is high (time, money, technical debt)

Less fit when:

- Criteria are still vague or change a lot
- The decision heavily depends on context you can't spell out
- One or two questions are enough, no need to map a full tree

---

## Root Question First

Start with **one root question** whose answers drive all branches below. Don't spawn many branches without a focus.

**❌ No clear root:**

Jump straight to: "REST or GraphQL? SQL or NoSQL? Monolith or microservices?" - everything floats, no logical order.

**✅ Root question first:**

"Do we need to scale per-service independently within the next 12 months?"

- If **yes** → branch into microservices vs modular monolith, then further criteria
- If **no** → branch into a simple monolith, then implementation details

That one question gives the rest of the tree context. Without it, the tree is just a pile of unconnected options.

---

## Criteria Over Gut Feel

Write down criteria (and weights if needed) so branches don't rely on feeling alone. Later, others or future-you can see why A was chosen over B.

**❌ Gut feel only:**

"Let's just use X." - Six months later nobody remembers why.

**✅ Written criteria:**

- Team &lt; 5, tight deadline → monolith first
- Need independent per-service deploy, team is used to it → consider microservices
- Compliance needs strict audit trail → choose a stack that supports logging/immutability

It doesn't have to be fancy. A short "if A then B" list already helps. What matters is using it consistently on every branch.

---

## Leaves Should Be Actions

Every leaf (end of a branch) should be **one clear decision or action**, not "maybe" or "we'll see."

**❌ Vague leaves:**

- "Maybe try microservices"
- "Depends on the team"

**✅ Clear leaves:**

- "Use modular monolith, separate domains by folder, deploy as one unit"
- "Use GraphQL for public API, REST for internal"

If the end is still "it depends," add one more level: write the question or criterion that splits that "depends" until you get a decision you can act on.

---

## Keep Depth Reasonable

Three to four levels is usually enough. Deeper makes the tree hard to maintain and rarely read.

- Level 0: root question
- Level 1–2: main criteria
- Level 3–4: decision or action

If the tree goes beyond 4 levels, consider splitting into several trees (one per major topic) or simplifying criteria. The goal stays: it gets used, not just complete.

---

## Document the Why

On each branch (or at least at each leaf), write **one sentence for "why"**: why this branch, or why this decision.

Examples:

- "Choose monolith because team is small and MVP in 3 months, refactor to microservices only if we see real bottleneck evidence."
- "GraphQL for public because mobile clients need query flexibility, REST for internal because it's simpler and tooling already exists."

This helps when context changes: you can reassess whether that "why" still holds or the tree needs an update.

---

## When the Tree Lies

A decision tree assumes a tidy world. Reality: requirements change, new context appears, edge cases show up. A tree that was right before can go stale.

Treat the tree as a **living document**. Review it when something big changes (team, scope, constraints). If criteria or answers no longer fit, update or simplify. Don't let the tree become "set in stone" that nobody dares to change.

---

## Reuse vs Rebuild

Before creating a new decision tree, check:

- Is there already an ADR (Architecture Decision Record) that answers the same question?
- Is there an existing tree or runbook you can reuse or update?

If yes, update or extend what you have. Avoid duplicating "decision logic" so the team isn't left guessing which source is right.

---

## Simple Beats Complete

A tree that is simple and **actually used** is better than one that is complete but never opened.

Priorities:

1. Understandable in a few minutes
2. Reflects real decisions the team has made
3. Updated when context changes

Add detail only when it's really needed. KISS still applies: don't make it complex before there's a real need.
