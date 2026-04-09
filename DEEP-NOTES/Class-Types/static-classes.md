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
/**
 * Mathematical utility functions.
 * @description Collection of math operations and constants.
 */
class MathUtils {
  /** PI constant for circle calculations */
  static readonly PI = 3.14159
  /** Euler number constant */
  static readonly E = 2.71828

  /**
   * Calculate circle area from radius.
   * @description Calculates circle area.
   * @param radius - Circle radius length
   * @returns Area of the circle
   */
  static calculateCircleArea(radius: number): number {
    return MathUtils.PI * radius * radius
  }

  /**
   * Calculate factorial recursively.
   * @description Calculates factorial recursively.
   * @param n - Number to calculate factorial
   * @returns Factorial of n
   */
  static factorial(n: number): number {
    if (n <= 1) {
      return 1
    }
    return n * MathUtils.factorial(n - 1)
  }

  /**
   * Clamp value between min and max.
   * @description Clamps value between range.
   * @param value - Number to clamp
   * @param min - Minimum allowed value
   * @param max - Maximum allowed value
   * @returns Clamped value within range
   */
  static clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max)
  }
}
```

**Good: String manipulation utilities**

```typescript
/**
 * String manipulation utilities.
 * @description Collection of helper functions for string operations.
 */
class StringUtils {
  /**
   * Capitalize first letter of string.
   * @description Capitalizes first letter.
   * @param text - Input string to capitalize
   * @returns Capitalized string
   */
  static capitalize(text: string): string {
    return text.charAt(0).toUpperCase() + text.slice(1)
  }

  /**
   * Reverse string character order.
   * @description Reverses string order.
   * @param text - Input string to reverse
   * @returns Reversed string
   */
  static reverse(text: string): string {
    return text.split('').reverse().join('')
  }

  /**
   * Truncate string with ellipsis.
   * @description Truncates string with ellipsis.
   * @param text - Input string to truncate
   * @param maxLength - Maximum string length allowed
   * @returns Truncated string with ellipsis
   */
  static truncate(text: string, maxLength: number): string {
    if (text.length > maxLength) {
      return text.slice(0, maxLength) + '...'
    }
    return text
  }

  /**
   * Check if string is palindrome.
   * @description Checks if palindrome.
   * @param text - Input string to check
   * @returns True if palindrome
   */
  static isPalindrome(text: string): boolean {
    const clean = text.toLowerCase().replace(/[^a-z0-9]/g, '')
    return clean === clean.split('').reverse().join('')
  }
}
```

**Good: API endpoints configuration**

```typescript
/**
 * Centralized API endpoint configuration.
 * @description Defines API URLs and URL building utilities.
 */
class ApiEndpoints {
  /** Base API server URL */
  static readonly BASE_URL = 'https://api.example.com'
  /** Users API endpoint URL */
  static readonly USERS = `${ApiEndpoints.BASE_URL}/users`
  /** Products API endpoint URL */
  static readonly PRODUCTS = `${ApiEndpoints.BASE_URL}/products`
  /** Orders API endpoint URL */
  static readonly ORDERS = `${ApiEndpoints.BASE_URL}/orders`

  /**
   * Build URL with query parameters.
   * @description Builds URL with query.
   * @param endpoint - Base endpoint URL
   * @param params - Query parameters object
   * @returns URL with query string
   */
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
/**
 * Static counter with global state.
 * @description Warning: Static classes should not maintain mutable state.
 */
class Counter {
  /** Current counter value */
  static count = 0

  /** Increment counter value */
  static increment(): void {
    Counter.count++
  }

  /** Reset counter to zero */
  static reset(): void {
    Counter.count = 0
  }
}

/**
 * Better: Use regular class or singleton for stateful behavior.
 * @description Recommendation for stateful behavior patterns.
```

**Bad: Static class that needs instance data**

```typescript
/**
 * Static user profile updater.
 * @description Warning: Static methods cannot access instance data.
 */
class UserProfile {
  /**
   * Update profile for given name.
   * @param name - User name to update
   */
  static updateProfile(name: string): void {
    console.log(`Updating profile for ${name}`)
  }
}

/**
 * Better: Use regular class for user-specific behavior.
 * @description Recommendation for user-specific operations.
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
/**
 * Application configuration constants.
 * @description Static configuration values and cache management.
 */
class Config {
  /** Debug mode enabled flag */
  static readonly DEBUG = process.env.NODE_ENV === 'development'
  /** API version string */
  static readonly API_VERSION = 'v1'
  /** Maximum retry attempts */
  static readonly MAX_RETRIES = 3
  /** Private static cache storage */
  private static _cache: Map<string, any> = new Map()

  /** Public getter for cache map */
  static get cache(): Map<string, any> {
    return Config._cache
  }

  /** Clear all cached entries */
  static clearCache(): void {
    Config._cache.clear()
  }
}
```

### Static Factory Methods

```typescript
/**
 * User with static factory methods.
 * @description Creates users via factory methods and validation.
 */
class User {
  constructor(
    /** User display name */
    public name: string,
    /** User email address */
    public email: string
  ) {}

  /**
   * Create guest user instance.
   * @returns New guest user with defaults
   */
  static createGuest(): User {
    return new User('Guest User', 'guest@example.com')
  }

  /**
   * Create user from JSON object.
   * @param json - Object with name and email
   * @returns New user from JSON data
   */
  static fromJson(json: { name: string; email: string }): User {
    return new User(json.name, json.email)
  }

  /**
   * Validate email format.
   * @param email - Email string to validate
   * @returns True if email format is valid
   */
  static validateEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
  }
}

/**
 * Usage - create users using factory methods.
 * @description Demonstrates factory method usage pattern.
 */
const guest = User.createGuest()
const user = User.fromJson({ name: 'Alice', email: 'alice@example.com' })
```

### Static vs Instance Decision Tree

```typescript
/**
 * Decision tree for choosing class type.
 * @description Guide for selecting appropriate class pattern.
 * @returns Never returns - documentation only
 */
function classTypeDecisionTree(): never {
  /**
   * 1. Multiple instances with different data? → Regular class
   * 2. Shared state across application? → Singleton
   * 3. Stateless utility functions? → Static class
   * 4. Contract with partial implementation? → Abstract class
   */
  throw new Error('Documentation function')
}
```

## Summary

- Static classes contain only static members and cannot be instantiated
- Perfect for utility functions, constants, and stateless operations
- Access members using the class name, not an instance
- Cannot access instance data or use the `this` keyword
- Use when functionality doesn't depend on object state
- Common for math operations, string manipulation, and configuration

_Static classes provide organized namespaces for stateless functionality, keeping related utilities together without the overhead of object instantiation._
