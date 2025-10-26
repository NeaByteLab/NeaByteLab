# DRY: Don't Repeat Yourself

_Because copying code is lazy_

## Table of Contents

- [Overview](#overview)
- [What is DRY?](#what-is-dry)
- [The Problem with Duplication](#the-problem-with-duplication)
- [How to Identify Duplication](#how-to-identify-duplication)
- [DRY Strategies](#dry-strategies)
  - [Extract Functions](#extract-functions)
  - [Create Utilities](#create-utilities)
  - [Use Constants](#use-constants)
  - [Leverage Configuration](#leverage-configuration)
- [When NOT to Be DRY](#when-not-to-be-dry)

---

## Overview

DRY stands for "Don't Repeat Yourself" - a principle that encourages reducing repetition in code.

**But here's the thing:** It's not about never duplicating code. It's about recognizing when duplication hurts and when it's actually simpler. The goal is maintainable code, not clever abstractions.

### Quick Takeaways

Before diving into details, here are the key principles:

1. **Extract common logic** - If you write the same logic three times, it's time to extract
2. **Watch for copy-paste** - If you're copying large blocks, consider why
3. **Simplify, don't complicate** - DRY should make code easier, not harder
4. **Know when to duplicate** - Sometimes duplication is better than wrong abstraction
5. **Refactor incrementally** - Don't abstract everything upfront

## What is DRY?

**DRY Principle:** Every piece of knowledge should have a single, unambiguous, authoritative representation within a system.

In simpler terms: Don't write the same thing twice.

**The core idea:**

- Each piece of logic lives in one place
- When you need to change it, you change it once
- Bugs are fixed once, not in multiple places

## The Problem with Duplication

Duplication creates multiple sources of truth. Here's why that's dangerous:

### The Maintenance Nightmare

**❌ With Duplication:**

```typescript
// Feature A
const calculateTax = (price: number) => {
  return price * 1.1 // 10% tax
}

// Feature B
const getTotalPrice = (basePrice: number) => {
  return basePrice * 1.1 // 10% tax (duplicate logic!)
}

// Feature C
const computeFinalAmount = (amount: number) => {
  return amount * 1.1 // 10% tax (duplicate again!)
}
```

**What happens when tax rate changes?**

- You update line 1
- You forget to update line 5
- You definitely forget to update line 9
- → Bug in production, inconsistent results

**✅ With DRY:**

```typescript
// Single source of truth
const TAX_RATE = 1.1

const calculateTax = (price: number) => price * TAX_RATE
const getTotalPrice = (basePrice: number) => basePrice * TAX_RATE
const computeFinalAmount = (amount: number) => amount * TAX_RATE
```

**Tax rate changes?** Update one line, fix everywhere.

### The Testing Burden

**❌ Testing Duplicate Logic:**

```typescript
// You have to test the same logic 3 times
test('Feature A calculates tax correctly', () => {
  /* ... */
})
test('Feature B calculates tax correctly', () => {
  /* ... */
})
test('Feature C calculates tax correctly', () => {
  /* ... */
})
```

**✅ Testing DRY Logic:**

```typescript
// Test once, trust everywhere
test('calculateTax works correctly', () => {
  /* ... */
})
```

## How to Identify Duplication

**Warning signs:**

1. **Copy-paste code** - You find yourself copying blocks
2. **Similar function names** - `validateUser`, `validateProduct`, `validateOrder` (same validation logic?)
3. **Magic numbers everywhere** - `1.1` appears in 10 different files
4. **Same comments repeated** - Explaining the same logic multiple times
5. **Pattern matching** - Code structures look suspiciously similar

**A quick test:** If you were to change this logic, how many places would you need to update?

## DRY Strategies

### Extract Functions

**The Pattern:** When you see similar logic blocks, create a reusable function.

**❌ Before (Duplicated Logic):**

```typescript
// In UserService
const validateEmail = (email: string) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}

// In OrderService
const checkEmailFormat = (email: string) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}

// In SubscriptionService
const isValidEmailAddress = (email: string) => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}
```

**✅ After (DRY):**

```typescript
// In utils/Validator.ts
export const isValidEmail = (email: string): boolean => {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}

// Everywhere else
import { isValidEmail } from '@utils/Validator'
```

### Create Utilities

**The Pattern:** Extract common operations into utility functions.

**❌ Before:**

```typescript
// Converting dates everywhere
const userCreated = new Date(user.createdAt).toLocaleDateString()
const orderDate = new Date(order.createdAt).toLocaleDateString()
const postDate = new Date(post.publishedAt).toLocaleDateString()
```

**✅ After:**

```typescript
// In utils/format.ts
export const formatDate = (date: string | Date): string => {
  return new Date(date).toLocaleDateString()
}

// Usage
const userCreated = formatDate(user.createdAt)
const orderDate = formatDate(order.createdAt)
const postDate = formatDate(post.publishedAt)
```

### Use Constants

**The Pattern:** Extract repeated values into named constants.

**❌ Before (Magic Values):**

```typescript
if (user.age >= 18) {
  /* ... */
}
if (order.discount > 0.1) {
  /* ... */
}
setTimeout(() => {}, 3000) // What's 3000?
const maxItems = 100 // Why 100?
```

**✅ After (Named Constants):**

```typescript
// In constants/index.ts
export const LEGAL_AGE = 18
export const DISCOUNT_THRESHOLD = 0.1
export const NOTIFICATION_DELAY = 3000 // 3 seconds
export const MAX_CART_ITEMS = 100
```

**Why this helps:**

- Self-documenting code
- Easy to change globally
- Clear intent

### Leverage Configuration

**The Pattern:** Move repeated settings to configuration files.

**❌ Before (Hardcoded Everywhere):**

```typescript
// In api/User.ts
const response = await fetch('https://api.example.com/users', {
  headers: { Authorization: 'Bearer token123' }
})

// In api/Product.ts
const response = await fetch('https://api.example.com/products', {
  headers: { Authorization: 'Bearer token123' }
})

// In api/Order.ts
const response = await fetch('https://api.example.com/orders', {
  headers: { Authorization: 'Bearer token123' }
})
```

**✅ After (Centralized Config):**

```typescript
// In config/index.ts
export const API_CONFIG = {
  baseUrl: 'https://api.example.com',
  headers: {
    Authorization: `Bearer ${getAuthToken()}`
  }
}

// In api/User.ts, Product.ts, Order.ts
import { API_CONFIG } from '@/config/api'
const response = await fetch(`${API_CONFIG.baseUrl}/users`, {
  headers: API_CONFIG.headers
})
```

## When NOT to Be DRY

**Important:** DRY isn't always the answer.

### 1. Premature Abstraction

**❌ Too DRY Too Soon:**

```typescript
// You've used this twice, let's share everything!
function processData(input: unknown) {
  // 20 lines of logic trying to handle both cases
  if (isUser(input)) {
    return processUser(input)
  } else if (isProduct(input)) {
    return processProduct(input)
  }
}

function processUser(user: User) {
  /* ... */
}
function processProduct(product: Product) {
  /* ... */
}
```

**Problem:** Forcing two different things into one function. Now they're tangled together.

**✅ Better Approach:**

```typescript
// Just write it twice - they'll probably evolve differently
function processUser(user: User) {
  /* ... */
}
function processProduct(product: Product) {
  /* ... */
}

// Extract common logic ONLY after you see real duplication (3+ times)
```

### 2. Different Contexts, Different Evolution

**❌ Forcing Similar Things Together:**

```typescript
// Both have validation logic, let's merge!
function validate(input: User | Product) {
  if (isUser(input)) {
    return input.email && input.email.includes('@')
  } else {
    return input.sku && input.sku.length > 0
  }
}
```

**Problem:** Different validation rules mixed together. This will get messy as they diverge.

**✅ Better:**

```typescript
// Keep them separate - simpler and clearer
function validateUser(user: User) {
  return user.email && user.email.includes('@')
}

function validateProduct(product: Product) {
  return product.sku && product.sku.length > 0
}

// Extract common patterns ONLY when they actually stay the same
```

### 3. Simplicity Over Abstraction

**❌ Over-Engineering:**

```typescript
// Creating an abstraction for one simple check
class UserPermissionChecker {
  private user: User
  constructor(user: User) {
    this.user = user
  }
  checkRole(role: string): boolean {
    return this.user.roles.includes(role)
  }
}

const checker = new UserPermissionChecker(user)
const isAdmin = checker.checkRole('admin')
```

**✅ Simple enough:**

```typescript
// Just check it - no classes needed
const isAdmin = user.roles.includes('admin')
```

**Remember:** If you need a class to do a simple check, you're probably overthinking it

**The Rule of Three:** Write it once, write it twice, abstract on the third time.

---

## Remember

DRY is a tool, not a religion. The goal is maintainable code. Sometimes that means extracting common logic. Sometimes it means keeping things separate. **The real principle:** Make the code easier to understand and maintain. If DRY helps, use it. If it hurts, don't.

_Don't repeat yourself, but don't abstract yourself into complexity either._
