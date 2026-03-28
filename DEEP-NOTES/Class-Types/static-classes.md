---
title: 'Static Classes'
source: 'https://www.typescriptlang.org/docs/handbook/classes.html'
description: 'Static classes in TypeScript for utility functions and stateless operations without instantiation.'
tags: ['typescript', 'static-classes', 'utilities', 'stateless']
---

# Static Classes

## Overview

Static classes contain only static members and cannot be instantiated. They serve as containers for utility functions, constants, and stateless operations. Think of them as organized namespaces for related functionality that doesn't need object state.

## Definition

A **static class** is a class where all members are marked as `static`. These members belong to the class itself rather than to any instance. Since TypeScript doesn't have a true `static class` keyword like C#, we create static classes by making all members static and often making the constructor private.

## The Analogy

Think of static classes like a **public library**:

- The library building exists (the class)
- Anyone can use its resources (static methods)
- You don't check out the entire library (no instances)
- The reference books are shared by everyone (static properties)
- The library doesn't change based on who uses it (stateless)

## When You See It

Use static classes when:

- You need utility functions that don't depend on state
- You want to group related functionality together
- You need constants or configuration values
- You want to create a namespace for related operations
- The operations are mathematical, string manipulation, or data transformations

Common scenarios:

- Math utilities, string helpers, date formatters
- Validation functions, parsers, converters
- Configuration constants, API endpoints
- Factory methods for creating objects

## Examples

**Good: Math utilities**

```typescript
// MathUtils class - collection of mathematical utility functions
class MathUtils {
  // Mathematical constants
  static readonly PI = 3.14159
  static readonly E = 2.71828

  // Calculate area of a circle using PI constant
  static calculateCircleArea(radius: number): number {
    return MathUtils.PI * radius * radius
  }

  // Calculate factorial recursively
  static factorial(n: number): number {
    if (n <= 1) {
      return 1
    }
    return n * MathUtils.factorial(n - 1)
  }

  // Clamp value between min and max bounds
  static clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max)
  }
}

// Usage: MathUtils.calculateCircleArea(5)
// No instantiation needed - call methods directly on class
```

**Good: String manipulation utilities**

```typescript
// StringUtils class - collection of string manipulation utilities
class StringUtils {
  // Capitalize first letter of a string
  static capitalize(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1)
  }

  // Reverse a string character by character
  static reverse(text: string): string {
    return text.split('').reverse().join('')
  }

  // Truncate string to maximum length with ellipsis
  static truncate(text: string, maxLength: number): string {
    if (text.length > maxLength) {
      return text.slice(0, maxLength) + '...'
    }
    return text
  }

  // Check if string is a palindrome
  static isPalindrome(text: string): boolean {
    const clean = text.toLowerCase().replace(/[^a-z0-9]/g, '')
    return clean === clean.split('').reverse().join('')
  }
}
```

**Good: API endpoints configuration**

```typescript
// ApiEndpoints class - centralized API endpoint configuration
class ApiEndpoints {
  // Base API URL
  static readonly BASE_URL = 'https://api.example.com'

  // Specific endpoint URLs
  static readonly USERS = `${ApiEndpoints.BASE_URL}/users`
  static readonly PRODUCTS = `${ApiEndpoints.BASE_URL}/products`
  static readonly ORDERS = `${ApiEndpoints.BASE_URL}/orders`

  // Build URL with query parameters
  static buildUrl(endpoint: string, params: Record<string, string>): string {
    const url = new URL(endpoint)
    Object.entries(params).forEach(([key, value]) => {
      url.searchParams.set(key, value)
    })
    return url.toString()
  }
}
```

**Bad: Static class with mutable state**

```typescript
// Wrong: Static class shouldn't maintain instance-like state
class Counter {
  static count = 0

  static increment(): void {
    Counter.count++ // Global state is dangerous
  }

  static reset(): void {
    Counter.count = 0
  }
}

// Better: Use regular class or singleton for stateful behavior
```

**Bad: Static class that needs instance data**

```typescript
// Wrong: Static methods can't access instance data
class UserProfile {
  static updateProfile(name: string): void {
    // Can't access 'this.name' - no instance exists
    console.log(`Updating profile for ${name}`)
  }
}

// Better: Use regular class for user-specific behavior
```

## Important Points

- Static members belong to the class, not to instances
- Access static members using the class name: `ClassName.member`
- Static methods cannot access `this` or instance members
- Static properties are shared across all references
- Can have static properties, methods, and getters/setters
- Often used with `private constructor()` to prevent instantiation

### Static Property Patterns

```typescript
// Config class - static properties for application configuration
class Config {
  // Immutable configuration constants
  static readonly DEBUG = process.env.NODE_ENV === 'development'
  static readonly API_VERSION = 'v1'
  static readonly MAX_RETRIES = 3

  // Private static cache with public getter
  private static _cache: Map<string, any> = new Map()

  // Public getter for cache (read-only access)
  static get cache(): Map<string, any> {
    return Config._cache
  }

  // Static method to clear cache
  static clearCache(): void {
    Config._cache.clear()
  }
}
```

### Static Factory Methods

```typescript
// User class with static factory methods for object creation
class User {
  constructor(
    public name: string,
    public email: string
  ) {}

  // Factory method for guest users
  static createGuest(): User {
    return new User('Guest User', 'guest@example.com')
  }

  // Factory method to create user from JSON
  static fromJson(json: { name: string; email: string }): User {
    return new User(json.name, json.email)
  }

  // Static utility method for email validation
  static validateEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
  }
}

// Usage - create users using factory methods
const guest = User.createGuest()
const user = User.fromJson({ name: 'Alice', email: 'alice@example.com' })
```

### Static vs Instance Decision Tree

```typescript
// Decision tree for choosing class type:
// 1. Do I need multiple instances with different data? → Regular class
// 2. Do I need shared state across the application? → Singleton
// 3. Do I need stateless utility functions? → Static class
// 4. Do I need a contract with partial implementation? → Abstract class
```

## Summary

- Static classes contain only static members and cannot be instantiated
- Perfect for utility functions, constants, and stateless operations
- Access members using the class name, not an instance
- Cannot access instance data or use the `this` keyword
- Use when functionality doesn't depend on object state
- Common for math operations, string manipulation, and configuration

_Static classes provide organized namespaces for stateless functionality, keeping related utilities together without the overhead of object instantiation._
