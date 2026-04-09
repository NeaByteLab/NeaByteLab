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
/**
 * User with independent state per instance.
 * @description User with name, email, age properties.
 */
class User {
  constructor(
    /** User display name */
    public name: string,
    /** User email address */
    public email: string,
    /** User age in years */
    public age: number
  ) {}

  /**
   * Update user profile name.
   * @param newName - New display name for user
   */
  updateProfile(newName: string): void {
    this.name = newName
  }

  /**
   * Get display name with age.
   * @description Returns formatted name with age.
   * @returns Formatted name with age in parentheses
   */
  getDisplayName(): string {
    return `${this.name} (${this.age})`
  }
}

/**
 * Creates independent user instances.
 * @description Demonstrates independent user instance creation.
 */
const user1 = new User('Alice', 'alice@example.com', 28)
const user2 = new User('Bob', 'bob@example.com', 35)

/**
 * Updates only user1 name.
 * @description Shows independent state modification.
 */
user1.updateProfile('Alice Smith')
```

**Good: Product catalog with independent items**

```typescript
/**
 * Product with price and identification.
 * @description Product in catalog with discount support.
 */
class Product {
  constructor(
    /** Product identifier */
    public id: number,
    /** Product display name */
    public name: string,
    /** Current product price */
    public price: number
  ) {}

  /**
   * Apply percentage discount to price.
   * @param percentage - Discount percentage to apply
   */
  applyDiscount(percentage: number): void {
    this.price *= 1 - percentage / 100
  }

  /**
   * Creates copy of product.
   * @description Returns new product with identical properties.
   * @returns New product with identical properties
   */
  clone(): Product {
    return new Product(this.id, this.name, this.price)
  }
}

/**
 * Create independent product instances.
 * @description Demonstrates independent product creation.
 */
const laptop = new Product(1, 'Laptop', 999)
const mouse = new Product(2, 'Mouse', 25)

/**
 * Apply discounts independently.
 * @description Shows independent discount application.
 */
laptop.applyDiscount(10)
mouse.applyDiscount(20)
```

**Bad: Using regular class when only one instance needed**

```typescript
/**
 * Manages configuration settings per instance.
 * @description Key-value settings storage.
 */
class ConfigurationManager {
  /** Internal settings storage */
  private settings: Record<string, string> = {}

  /**
   * Set configuration value by key.
   * @param key - Configuration key name
   * @param value - Value to store
   */
  setSetting(key: string, value: string): void {
    this.settings[key] = value
  }

  /**
   * Get configuration value by key.
   * @param key - Configuration key to retrieve
   * @returns Stored value or undefined
   */
  getSetting(key: string): string {
    return this.settings[key]
  }
}

/**
 * Problem: Multiple instances, different settings.
 * @description Warning: Use singleton pattern instead.
 */
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
/**
 * User with parameter properties.
 * @description Demonstrates TypeScript constructor parameter properties.
 */
class User {
  constructor(
    /** User display name */
    public name: string,
    /** User email address */
    private email: string,
    /** Unique user identifier */
    readonly id: number
  ) {}
}

/**
 * Product with default constructor values.
 * @description Demonstrates default parameter values in constructor.
 */
class Product {
  constructor(
    /** Product display name */
    public name: string,
    /** Product price in dollars */
    public price: number = 0,
    /** Product category name */
    public category: string = 'general'
  ) {}
}
```

### Method Types

```typescript
/**
 * Calculator with various method types.
 * @description Demonstrates instance, arrow, and static methods.
 */
class Calculator {
  /**
   * Add two numbers together.
   * @param a - First operand number
   * @param b - Second operand number
   * @returns Sum of both operands
   */
  add(a: number, b: number): number {
    return a + b
  }

  /**
   * Multiply two numbers together.
   * @param a - First operand number
   * @param b - Second operand number
   * @returns Product of both operands
   */
  multiply = (a: number, b: number): number => {
    return a * b
  }

  /** Mathematical constant PI value */
  static PI = 3.14159

  /**
   * Calculate circle area from radius.
   * @param radius - Circle radius length
   * @returns Area of the circle
   */
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
