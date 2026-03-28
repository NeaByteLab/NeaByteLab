---
title: 'Abstract Classes'
source: 'https://www.typescriptlang.org/docs/handbook/classes.html'
description: 'Abstract classes in TypeScript for defining base classes with contracts and partial implementation.'
tags: ['typescript', 'abstract-classes', 'inheritance', 'contracts']
---

# Abstract Classes

## Overview

Abstract classes are base classes that cannot be instantiated directly. They provide a way to define common behavior and state while requiring derived classes to implement specific methods. Think of them as incomplete blueprints that other classes must complete.

## Definition

An **abstract class** is a class that cannot be instantiated and may contain abstract methods that must be implemented by derived classes. Abstract methods have no implementation in the base class, only method signatures.

## The Analogy

Think of abstract classes like a **vehicle blueprint**:

- The blueprint defines that all vehicles have wheels, engines, and can move
- It specifies that every vehicle must have a start() method
- It doesn't specify exactly how start() works (car vs motorcycle vs truck)
- Each vehicle type must implement its own start() method
- You can't build a "generic vehicle" - only specific types

## When You See It

Use abstract classes when:

- You want to share code among several closely related classes
- You expect classes to have many common methods or properties
- You need to provide partial implementation
- You want to declare non-public members
- You expect to add new methods in the future

Common scenarios:

- Base controllers in web frameworks
- Shape classes in graphics systems
- Animal classes in biology simulations
- Component classes in UI frameworks
- Service classes with common operations

## Examples

**Good: Abstract animal base class**

```typescript
// Abstract Animal class - base class for all animal types
abstract class Animal {
  constructor(
    public name: string,
    public age: number
  ) {}

  // Concrete method - shared movement behavior for all animals
  move(): void {
    console.log(`${this.name} is moving`)
  }

  // Concrete method - shared eating behavior for all animals
  eat(food: string): void {
    console.log(`${this.name} is eating ${food}`)
  }

  // Abstract method - each animal type must implement its own sound
  abstract makeSound(): void

  // Abstract method with parameters - each animal defines its own sleep pattern
  abstract sleep(hours: number): void

  // Concrete method using abstract methods - defines daily routine structure
  performDailyRoutine(): void {
    this.makeSound()
    this.eat('food')
    this.move()
    this.sleep(8)
  }
}

// Dog class - concrete implementation of Animal
class Dog extends Animal {
  constructor(
    name: string,
    age: number,
    public breed: string
  ) {
    super(name, age)
  }

  // Implement abstract method - dog sound
  makeSound(): void {
    console.log('Woof! Woof!')
  }

  // Implement abstract method - dog sleep pattern
  sleep(hours: number): void {
    console.log(`${this.name} the ${this.breed} is sleeping for ${hours} hours`)
  }

  // Dog-specific method - unique to Dog class
  wagTail(): void {
    console.log(`${this.name} is wagging tail`)
  }
}

// Cat class - concrete implementation of Animal
class Cat extends Animal {
  constructor(
    name: string,
    age: number,
    public lives: number = 9
  ) {
    super(name, age)
  }

  // Implement abstract method - cat sound
  makeSound(): void {
    console.log('Meow!')
  }

  // Implement abstract method - cat sleep pattern
  sleep(hours: number): void {
    console.log(`${this.name} is purring and sleeping for ${hours} hours`)
  }

  // Cat-specific method - unique to Cat class
  scratch(): void {
    console.log(`${this.name} is scratching furniture`)
  }
}

// Create instances of concrete classes
const dog = new Dog('Buddy', 3, 'Golden Retriever')
const cat = new Cat('Whiskers', 2)

dog.performDailyRoutine() // Uses concrete and abstract methods
cat.performDailyRoutine()
```

**Good: Abstract controller base class**

```typescript
// Abstract Controller - base class for all controllers
abstract class Controller {
  protected request: any
  protected response: any

  constructor(request: any, response: any) {
    this.request = request
    this.response = response
  }

  // Template method - defines request handling algorithm
  public handle(): void {
    if (this.validate()) {
      const result = this.process()
      this.sendResponse(result)
    } else {
      this.sendError('Invalid request')
    }
  }

  // Concrete method - shared validation logic for all controllers
  protected validate(): boolean {
    return this.request.body !== null
  }

  // Abstract method - each controller implements its own processing logic
  abstract process(): any

  // Concrete method - shared success response logic
  protected sendResponse(data: any): void {
    this.response.json({ success: true, data })
  }

  // Concrete method - shared error response logic
  protected sendError(message: string): void {
    this.response.status(400).json({ success: false, error: message })
  }
}

// UserController - concrete implementation for user operations
class UserController extends Controller {
  // Implement abstract method - process user data
  process(): any {
    const { name, email } = this.request.body
    return { id: 1, name, email, createdAt: new Date() }
  }
}

// ProductController - concrete implementation for product operations
class ProductController extends Controller {
  // Override concrete method - extend validation for products
  protected validate(): boolean {
    // Extend validation logic
    return super.validate() && this.request.body.price > 0
  }

  // Implement abstract method - process product data
  process(): any {
    const { name, price } = this.request.body
    return { id: 1, name, price, inStock: true }
  }
}
```

**Good: Abstract shape base class**

```typescript
// Abstract Shape - base class for all geometric shapes
abstract class Shape {
  constructor(public color: string) {}

  // Abstract methods - each shape must implement these
  abstract getArea(): number
  abstract getPerimeter(): number

  // Concrete method - uses abstract methods to calculate ratio
  getAreaToPerimeterRatio(): number {
    return this.getArea() / this.getPerimeter()
  }

  // Concrete method - shared description behavior
  describe(): string {
    return `This ${this.constructor.name} is ${this.color} and has area ${this.getArea()}`
  }
}

// Circle class - concrete implementation of Shape
class Circle extends Shape {
  constructor(
    color: string,
    public radius: number
  ) {
    super(color)
  }

  // Implement abstract method - calculate circle area
  getArea(): number {
    return Math.PI * this.radius * this.radius
  }

  // Implement abstract method - calculate circle perimeter
  getPerimeter(): number {
    return 2 * Math.PI * this.radius
  }
}

// Rectangle class - concrete implementation of Shape
class Rectangle extends Shape {
  constructor(
    color: string,
    public width: number,
    public height: number
  ) {
    super(color)
  }

  // Implement abstract method - calculate rectangle area
  getArea(): number {
    return this.width * this.height
  }

  // Implement abstract method - calculate rectangle perimeter
  getPerimeter(): number {
    return 2 * (this.width + this.height)
  }
}

// Create instances and test abstract class functionality
const circle = new Circle('red', 5)
const rectangle = new Rectangle('blue', 4, 6)

console.log(circle.describe())
console.log(rectangle.describe())
```

**Bad: Abstract class with all concrete methods**

```typescript
// Wrong: If all methods are concrete, use regular class
abstract class Calculator {
  add(a: number, b: number): number {
    return a + b
  }

  subtract(a: number, b: number): number {
    return a - b
  }

  multiply(a: number, b: number): number {
    return a * b
  }
}

// Should be a regular class, not abstract
```

**Bad: Abstract class that could be an interface**

```typescript
// Wrong: If no implementation, use interface
abstract class Drawable {
  abstract draw(): void
  abstract getBounds(): { x: number; y: number; width: number; height: number }
}

// Better as interface since no shared implementation
interface Drawable {
  draw(): void
  getBounds(): { x: number; y: number; width: number; height: number }
}
```

## Important Points

- **Cannot be instantiated** directly with `new`
- **Can contain both** abstract and concrete methods
- **Abstract methods** must be implemented by derived classes
- **Concrete methods** provide shared implementation
- **Can have properties** (both abstract and concrete)
- **Support inheritance chains** (abstract extending abstract)
- **Constructors** are called when derived classes are instantiated

### Abstract vs Interface Decision

```typescript
// Use interface when:
// - No implementation details
// - Multiple inheritance needed
// - Public API contract only
interface Logger {
  log(message: string): void
  error(message: string): void
}

// Use abstract class when:
// - Shared implementation needed
// - Protected members required
// - Non-public contract needed
abstract class BaseLogger {
  protected logs: string[] = []

  abstract log(message: string): void
  abstract error(message: string): void

  protected addLog(message: string): void {
    this.logs.push(`${new Date().toISOString()}: ${message}`)
  }

  getHistory(): string[] {
    return [...this.logs]
  }
}
```

### Abstract Properties

```typescript
abstract class Database {
  abstract connection: any

  abstract connect(): Promise<void>
  abstract disconnect(): Promise<void>

  // Concrete method using abstract property
  async testConnection(): Promise<boolean> {
    try {
      await this.connect()
      return this.connection !== null
    } catch {
      return false
    } finally {
      await this.disconnect()
    }
  }
}

// MySQL implementation of Database abstract class
class MySQL extends Database {
  connection: any = null

  // Implement abstract method - connect to MySQL database
  async connect(): Promise<void> {
    this.connection = { connected: true, type: 'mysql' }
  }

  // Implement abstract method - disconnect from MySQL database
  async disconnect(): Promise<void> {
    this.connection = null
  }
}
```

### Abstract Method Signatures

```typescript
// Processor abstract class - demonstrates various abstract method signatures
abstract class Processor {
  // Simple abstract method
  abstract process(input: string): string

  // Abstract method with generic type parameter
  abstract transform<T>(data: T[], mapper: (item: T) => string): string[]

  // Abstract method with optional parameters
  abstract validate(data: any, strict?: boolean): boolean

  // Abstract method with union return type
  abstract parse(input: string): object | null

  // Abstract async method
  abstract fetch(url: string): Promise<Response>
}
```

## Summary

- Abstract classes cannot be instantiated directly
- They provide both abstract methods (must implement) and concrete methods (shared implementation)
- Use when you need shared code plus enforced contracts
- Perfect for base classes in frameworks and hierarchies
- Choose over interfaces when you need implementation details
- Support complex inheritance patterns with partial implementation

_Abstract classes strike a balance between interfaces (pure contracts) and regular classes (full implementation), making them ideal for creating extensible frameworks and class hierarchies._
