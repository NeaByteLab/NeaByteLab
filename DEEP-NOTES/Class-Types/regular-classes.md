---
title: 'Regular Classes'
source: 'https://www.typescriptlang.org/docs/handbook/classes.html'
description: 'Regular classes in TypeScript for creating multiple instances with independent state and behavior.'
tags: ['typescript', 'classes', 'regular-classes', 'instances']
---

# Regular Classes

## Overview

Regular classes are the standard way to create objects in TypeScript. They support multiple instances, each with its own state and behavior. When you need independent objects that can exist simultaneously with different data, regular classes are the default choice.

## Definition

A **regular class** is a class that can be instantiated multiple times using the `new` operator. Each instance maintains its own copy of instance properties and can execute methods independently of other instances.

## The Analogy

Think of regular classes like a **car factory blueprint**:

- The blueprint defines what every car will have (wheels, engine, color)
- Each car built from the blueprint is a separate instance
- Each car has its own odometer, fuel level, and current speed
- Cars can drive independently without affecting other cars

## When You See It

Use regular classes when:

- You need multiple objects of the same type
- Each object needs its own independent state
- Objects should not share data by default
- You want to encapsulate related data and behavior

Common scenarios:

- User accounts, products, orders in an e-commerce system
- Game characters, enemies, items
- UI components with their own state
- Database records represented as objects

## Examples

**Good: Multiple independent users**

```typescript
// User class - each instance represents a different user
class User {
  constructor(
    public name: string,
    public email: string,
    public age: number
  ) {}

  // Update user's profile name
  updateProfile(newName: string): void {
    this.name = newName
  }

  // Get user's display name with age
  getDisplayName(): string {
    return `${this.name} (${this.age})`
  }
}

// Create separate user instances with independent data
const user1 = new User('Alice', 'alice@example.com', 28)
const user2 = new User('Bob', 'bob@example.com', 35)

// Update only user1 - user2 remains unchanged
user1.updateProfile('Alice Smith')
// user1.name = 'Alice Smith', user2.name = 'Bob' (unchanged)
```

**Good: Product catalog with independent items**

```typescript
// Product class - each instance represents a different product
class Product {
  constructor(
    public id: number,
    public name: string,
    public price: number
  ) {}

  // Apply discount to this specific product
  applyDiscount(percentage: number): void {
    this.price *= 1 - percentage / 100
  }

  // Create a copy of this product
  clone(): Product {
    return new Product(this.id, this.name, this.price)
  }
}

// Create independent product instances
const laptop = new Product(1, 'Laptop', 999)
const mouse = new Product(2, 'Mouse', 25)

// Apply discounts independently
laptop.applyDiscount(10) // $899.10
mouse.applyDiscount(20) // $20.00
```

**Bad: Using regular class when only one instance needed**

```typescript
// Wrong: This should be a singleton or static class
class ConfigurationManager {
  private settings: Record<string, string> = {}

  setSetting(key: string, value: string): void {
    this.settings[key] = value
  }

  getSetting(key: string): string {
    return this.settings[key]
  }
}

// Problem: Multiple instances could have different settings
const config1 = new ConfigurationManager()
const config2 = new ConfigurationManager()
```

## Important Points

- Each instance has its own copy of instance properties
- Methods are shared between instances (prototype-based)
- Constructor runs for each instance
- Use `this` to access instance properties and methods
- Can implement interfaces and extend other classes
- Support access modifiers: `public`, `private`, `protected`

### Constructor Patterns

```typescript
// Parameter properties (shorthand for property declaration)
class User {
  constructor(
    public name: string, // public property + assignment
    private email: string, // private property + assignment
    readonly id: number // readonly property + assignment
  ) {}
}

// Default values in constructor parameters
class Product {
  constructor(
    public name: string,
    public price: number = 0,
    public category: string = 'general'
  ) {}
}
```

### Method Types

```typescript
class Calculator {
  // Instance method (has access to this)
  add(a: number, b: number): number {
    return a + b
  }

  // Arrow method (this is bound to instance)
  multiply = (a: number, b: number): number => {
    return a * b
  }

  // Static method (no access to this, belongs to class)
  static PI = 3.14159

  static circleArea(radius: number): number {
    return Calculator.PI * radius * radius
  }
}
```

## Summary

- Regular classes create multiple independent instances
- Each instance maintains its own state
- Perfect for representing real-world objects with independent data
- Support inheritance, interfaces, and access modifiers
- Use when you need many objects of the same type with different data

_Regular classes are the foundation of object-oriented programming in TypeScript, providing the flexibility to create as many instances as your application needs._
