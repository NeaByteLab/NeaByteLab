# Code Organization

_Where everything lives and why_

## Table of Contents

- [Overview](#overview)
- [Folder Structure Strategies](#folder-structure-strategies)
  - [Flat vs Deep Structures](#flat-vs-deep-structures)
  - [Recommended: Feature-Based Organization](#recommended-feature-based-organization)
- [File Naming Strategies](#file-naming-strategies)
- [Naming Conventions](#naming-conventions)
  - [Variables and Functions](#variables-and-functions)
  - [Files and Folders](#files-and-folders)
  - [Component/Class Names](#componentclass-names)
  - [Principle: Say What It Does](#principle-say-what-it-does)
- [A Practical Approach](#a-practical-approach)
  - [Class Names Reflect Their Location](#class-names-reflect-their-location)
- [Is There a Standard Organization?](#is-there-a-standard-organization)

---

## Overview

Code organization is crucial yet tricky.

We can make code powerful, research patterns and algorithms, but what happens after?

- **The Knowledge Loss:** Today's brilliant pattern becomes tomorrow's forgotten memory without clear structure. Proper organization bridges the gap between understanding and recall.

- **The Memory Problem:** You might remember your code structure for about a week. Beyond that, you'll definitely spend considerable time re-learning it if the code isn't organized well.

- **The Team Collaboration Problem:** Imagine working with team members who each have different coding styles. Without proper organization, this becomes exhausting and unproductive.

- **The Productivity Impact:** Well-organized code saves hours. Poorly organized code wastes them. The difference is in the initial investment of structure and documentation.

### Quick Takeaways

Before diving into details, here are the key principles:

1. **Feature-based organization** - Group related code by business feature (users, products, orders)
2. **Consistent naming** - Use the same pattern throughout your project (kebab-case, PascalCase, etc.)
3. **Descriptive names** - Classes, functions, and files should explain what they do
4. **Path + name = context** - Folder location + class name tells the complete story
5. **No universal standard** - Choose what works for your team and stick with it

## Folder Structure Strategies

A well-planned folder structure can make code much easier to maintain.

### Flat vs Deep Structures

**Flat Structure (Few folders):**

```
project/
├── src/
│   ├── users.ts
│   ├── products.ts
│   ├── orders.ts
│   └── utils.ts
```

- ✅ Simple, easy to find files
- ✅ Good for small projects
- ❌ Gets messy with scale
- ❌ All files mixed together

**Deep Structure (Many folders):**

```
project/
├── src/
│   ├── features/
│   │   ├── users/
│   │   │   ├── controllers/
│   │   │   ├── models/
│   │   │   ├── routes/
│   │   │   └── utils/
│   │   ├── products/
│   │   └── orders/
│   ├── core/
│   │   ├── database/
│   │   ├── auth/
│   │   └── middleware/
│   └── shared/
│       ├── types/
│       └── constants/
```

- ✅ Scales well
- ✅ Clear separation of concerns
- ✅ Easy to locate related code
- ❌ Can become too deep
- ❌ More navigation required

### Recommended: Feature-Based Organization

Organize by features/modules first, then by technical layers:

```
project/
├── src/
│   ├── features/
│   │   ├── users/            # User-related everything
│   │   │   ├── index.ts
│   │   │   ├── service.ts
│   │   │   ├── types.ts
│   │   │   └── routes.ts
│   │   ├── products/
│   │   └── orders/
│   ├── core/                 # Shared infrastructure
│   │   ├── database.ts
│   │   ├── auth.ts
│   │   └── config.ts
│   └── shared/               # Common utilities
│       ├── utils/
│       ├── types/
│       └── constants/
```

**Why this helps:**

- Related code stays together
- New developers understand quickly
- Easy to refactor entire features
- Clear ownership per module

## File Naming Strategies

**Consistency is key:**

- ✅ Descriptive names
- ✅ Same pattern across the project
- ✅ Match project conventions

**Common patterns:**

```
kebab-case  ->  user-service.ts
camelCase   ->  userService.ts
PascalCase  ->  UserService.ts
snake_case  ->  user_service.ts
```

**Choose one convention and use it consistently.**

## Naming Conventions

Names should reveal intent and purpose.

### Variables and Functions

**✅ Good:**

```typescript
const userAge = 25
const isAuthenticated = true
const fetchUserData = async () => {}
const calculateTotalPrice = () => {}
```

**❌ Bad:**

```typescript
const age = 25 // What age?
const flag = true // What flag?
const fetchData = () => {} // What data?
const calc = () => {} // What does it calculate?
```

### Files and Folders

**✅ Good:**

```
/src/features/user/UserService.ts
/src/core/database/DatabaseConnection.ts
/src/utils/formatDate.ts
```

**❌ Bad:**

```
/src/f1/s1.ts
/src/core/db.ts
/src/utilities/f.ts
```

### Component/Class Names

**✅ Good:**

```typescript
class UserRepository
class PaymentProcessor
class EmailValidator
```

**❌ Bad:**

```typescript
class UserClass         // Too generic!
class PaymentManager    // Too vague!
class EmailHelper       // Not a class, sounds like a utility
```

### Principle: Say What It Does

**Good names:**

- Answer "What does it do?"
- Answer "What is it?"
- Are self-documenting

**Examples:**

```
✅ getUserById()              → Gets user by id
✅ isEmailValid()             → Checks if email is valid
✅ formatCurrency()           → Formats currency
✅ sendEmailNotification()    → Sends email notification

❌ getUser()                  → Gets user how?
❌ validate()                 → Validates what?
❌ format()                   → Formats what?
❌ notify()                   → Notifies about what?
```

## A Practical Approach

Here's an approach that has proven helpful: applying abstraction in both naming conventions and folder structure. This pattern helps make code easier to understand and navigate.

**The Abstraction Principle:**

- Folder structure reveals context
- Naming indicates specificity
- Path itself tells a story

**Example File Structures:**

```
/src/features/user/Generator.ts
→ Read as: User-specific generator feature

/src/core/database/Connection.ts
→ Read as: Database connection (core infrastructure)

/src/utils/Formatter.ts
→ Read as: General data formatter utility
```

**Benefits of This Approach:**

- Each path conveys meaning
- Context is clear from location
- Easy to understand without opening files
- Self-documenting structure

### Class Names Reflect Their Location

Here's a helpful pattern: combine the folder context with the file purpose in the class name.

Here's how it reads:

```typescript
// File: /src/features/user/Generator.ts
class UserGenerator {
  // Breakdown:
  // - "User" = context from folder (/features/user/)
  // - "Generator" = purpose from file name (Generator.ts)
  // Result: A generator for user-related functionality
}
```

```typescript
// File: /src/core/database/Connection.ts
class DatabaseConnection {
  // Breakdown:
  // - "Database" = context from folder (/core/database/)
  // - "Connection" = purpose from file name (Connection.ts)
  // Result: A connection for database operations
}
```

```typescript
// File: /src/utils/Formatter.ts
class FormatterUtils {
  // Breakdown:
  // - "Formatter" = purpose from file name (Formatter.ts)
  // - "Utils" = indicates utility context from (/utils/)
  // Result: A general formatting utility
}
```

**The Pattern:**

1. **Identify the context**: Look at the folder path (e.g., `/features/user/` → "User")
2. **Identify the purpose**: Look at the file name (e.g., `Generator.ts` → "Generator")
3. **Combine them**: Class name = Context + Purpose
4. **Result**: Self-documenting code that tells a complete story

This approach creates a mental map: location + class name gives you full understanding without opening the file

## Is There a Standard Organization?

**Short answer: No universal standard exists.**

Code organization depends on each developer's style, team preferences, and project needs. What works for a startup might not work for an enterprise, and what's perfect for a solo project might not scale for a team of 50.

**The real standard:**

- Be consistent
- Document your choices
- Choose an approach that works for **your team**
- Refactor when it stops serving you

**Remember:** The best organization is one that your team can understand and maintain. There's no "one size fits all" solution—just principles and patterns you adapt to your situation.
