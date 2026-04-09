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
/**
 * Base class for all animal types.
 * @description Defines common animal behavior.
 */
abstract class Animal {
  constructor(
    /** Animal display name */
    public name: string,
    /** Animal age in years */
    public age: number
  ) {}

  /** Move the animal */
  move(): void {
    console.log(`${this.name} is moving`)
  }

  /**
   * Feed the animal.
   * @description Logs eating action to console.
   * @param food - Type of food to eat
   */
  eat(food: string): void {
    console.log(`${this.name} is eating ${food}`)
  }

  /** Make animal-specific sound */
  abstract makeSound(): void

  /**
   * Sleep for specified hours.
   * @description Abstract method for sleep behavior.
   * @param hours - Hours to sleep
   */
  abstract sleep(hours: number): void

  /** Execute daily routine */
  performDailyRoutine(): void {
    this.makeSound()
    this.eat('food')
    this.move()
    this.sleep(8)
  }
}

/**
 * Concrete dog implementation.
 * @description Implements Animal with dog behavior.
 */
class Dog extends Animal {
  constructor(
    name: string,
    age: number,
    /** Dog breed type */
    public breed: string
  ) {
    super(name, age)
  }

  /** Bark like dog */
  makeSound(): void {
    console.log('Woof! Woof!')
  }

  /**
   * Sleep for specified hours.
   * @description Dog sleeps for given hours.
   * @param hours - Hours to sleep
   */
  sleep(hours: number): void {
    console.log(`${this.name} the ${this.breed} is sleeping for ${hours} hours`)
  }

  /** Wag the tail */
  wagTail(): void {
    console.log(`${this.name} is wagging tail`)
  }
}

/**
 * Concrete cat implementation.
 * @description Implements Animal with cat behavior.
 */
class Cat extends Animal {
  constructor(
    name: string,
    age: number,
    /** Number of remaining lives */
    public lives: number = 9
  ) {
    super(name, age)
  }

  /** Meow like cat */
  makeSound(): void {
    console.log('Meow!')
  }

  /**
   * Sleep while purring.
   * @description Cat sleeps while purring.
   * @param hours - Hours to sleep
   */
  sleep(hours: number): void {
    console.log(`${this.name} is purring and sleeping for ${hours} hours`)
  }

  /** Scratch furniture */
  scratch(): void {
    console.log(`${this.name} is scratching furniture`)
  }
}

/**
 * Create instances of concrete classes.
 * @description Demonstrates concrete class instantiation.
 */
const dog = new Dog('Buddy', 3, 'Golden Retriever')
const cat = new Cat('Whiskers', 2)
dog.performDailyRoutine()
cat.performDailyRoutine()
```

**Good: Abstract controller base class**

```typescript
/**
 * Base class for all controllers.
 * @description Provides template method for HTTP handling.
 */
abstract class Controller {
  /** HTTP request object */
  protected request: any
  /** HTTP response object */
  protected response: any

  /**
   * Initialize with request and response.
   * @param request - Incoming HTTP request
   * @param response - Outgoing HTTP response
   */
  constructor(request: any, response: any) {
    this.request = request
    this.response = response
  }

  /** Handle incoming request */
  public handle(): void {
    if (this.validate()) {
      const result = this.process()
      this.sendResponse(result)
    } else {
      this.sendError('Invalid request')
    }
  }

  /**
   * Validate request data.
   * @description Checks if request body exists.
   */
  protected validate(): boolean {
    return this.request.body !== null
  }

  /**
   * Process the validated request.
   * @description Each controller implements its own logic.
   */
  abstract process(): any

  /** Send success response */
  protected sendResponse(data: any): void {
    this.response.json({ success: true, data })
  }

  /**
   * Send error response.
   * @description Sends JSON error response with status.
   * @param message - Error message to display
   */
  protected sendError(message: string): void {
    this.response.status(400).json({ success: false, error: message })
  }
}

/**
 * Controller for user operations.
 * @description Handles user creation and data processing.
 */
class UserController extends Controller {
  /**
   * Process user creation request.
   * @description Creates user from request body data.
   */
  process(): any {
    const { name, email } = this.request.body
    return { id: 1, name, email, createdAt: new Date() }
  }
}

/**
 * Controller for product operations.
 * @description Handles product creation with price validation.
 */
class ProductController extends Controller {
  /**
   * Validate product request data.
   * @description Checks body exists and price positive.
   */
  protected validate(): boolean {
    return super.validate() && this.request.body.price > 0
  }

  /**
   * Process product creation request.
   * @description Creates product from request body data.
   */
  process(): any {
    const { name, price } = this.request.body
    return { id: 1, name, price, inStock: true }
  }
}
```

**Good: Abstract shape base class**

```typescript
/**
 * Base class for geometric shapes.
 * @description Defines shape contract with area.
 */
abstract class Shape {
  constructor(
    /** Shape color */
    public color: string
  ) {}

  /**
   * Calculate shape area.
   * @description Each shape implements its own area formula.
   */
  abstract getArea(): number

  /**
   * Calculate shape perimeter.
   * @description Each shape implements its own perimeter formula.
   */
  abstract getPerimeter(): number

  /** Get area to perimeter ratio */
  getAreaToPerimeterRatio(): number {
    return this.getArea() / this.getPerimeter()
  }

  /**
   * Get shape description string.
   * @description Returns formatted description with color and area.
   */
  describe(): string {
    return `This ${this.constructor.name} is ${this.color} and has area ${this.getArea()}`
  }
}

/**
 * Circle shape implementation.
 * @description Implements Shape with circle calculations.
 */
class Circle extends Shape {
  constructor(
    color: string,
    /** Circle radius length */
    public radius: number
  ) {
    super(color)
  }

  /**
   * Calculate circle area using PI.
   * @description Calculates area from radius.
   */
  getArea(): number {
    return Math.PI * this.radius * this.radius
  }

  /**
   * Calculate circle perimeter using PI.
   * @description Calculates perimeter from radius.
   */
  getPerimeter(): number {
    return 2 * Math.PI * this.radius
  }
}

/**
 * Rectangle shape implementation.
 * @description Implements Shape with rectangle calculations.
 */
class Rectangle extends Shape {
  constructor(
    color: string,
    /** Rectangle width */
    public width: number,
    /** Rectangle height */
    public height: number
  ) {
    super(color)
  }

  /**
   * Calculate rectangle area.
   * @description Multiplies width by height.
   */
  getArea(): number {
    return this.width * this.height
  }

  /**
   * Calculate rectangle perimeter.
   * @description Sums all sides doubled.
   */
  getPerimeter(): number {
    return 2 * (this.width + this.height)
  }
}

/**
 * Create instances and test abstract class functionality.
 * @description Demonstrates concrete shape instantiation.
 */
const circle = new Circle('red', 5)
const rectangle = new Rectangle('blue', 4, 6)
console.log(circle.describe())
console.log(rectangle.describe())

/**
 * Calculator with only concrete methods.
 * @description Should be regular class, not abstract.
 */
abstract class Calculator {
  /**
   * Add two numbers.
   * @param a - First operand
   * @param b - Second operand
   */
  add(a: number, b: number): number {
    return a + b
  }

  /**
   * Subtract two numbers.
   * @param a - First operand
   * @param b - Second operand
   */
  subtract(a: number, b: number): number {
    return a - b
  }

  /**
   * Multiply two numbers.
   * @param a - First operand
   * @param b - Second operand
   */
  multiply(a: number, b: number): number {
    return a * b
  }
}

/**
 * Drawable with only abstract methods.
 * @description Should be interface, not abstract class.
 */
abstract class Drawable {
  /** Draw the object */
  abstract draw(): void
  /** Get bounding coordinates */
  abstract getBounds(): { x: number; y: number; width: number; height: number }
}

/**
 * Logger interface for logging operations.
 * @description Pure contract with no implementation details.
 */
interface Logger {
  /** Log at info level */
  log(message: string): void
  /** Log at error level */
  error(message: string): void
}

/**
 * Base logger with shared implementation.
 * @description Provides log history and shared log storage.
 */
abstract class BaseLogger {
  /** Internal log storage */
  protected logs: string[] = []
  /** Log at info level */
  abstract log(message: string): void
  /** Log at error level */
  abstract error(message: string): void

  /**
   * Add timestamped log entry.
   * @param message - Log message content
   */
  protected addLog(message: string): void {
    this.logs.push(`${new Date().toISOString()}: ${message}`)
  }

  /**
   * Get copy of log history.
   * @description Returns copy of log entries
   */
  getHistory(): string[] {
    return [...this.logs]
  }
}
```

### Abstract Properties

```typescript
/**
 * Abstract database connection handler.
 * @description Defines database connection contract.
 */
abstract class Database {
  /** Database connection */
  abstract connection: any
  /** Establish connection */
  abstract connect(): Promise<void>
  /** Close connection */
  abstract disconnect(): Promise<void>

  /**
   * Test database connectivity
   * @description Connects and verifies connection is valid.
   */
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

/**
 * MySQL database implementation.
 * @description Implements Database for MySQL connections.
 */
class MySQL extends Database {
  /** MySQL connection instance */
  connection: any = null

  /** Connect to MySQL */
  async connect(): Promise<void> {
    this.connection = { connected: true, type: 'mysql' }
  }

  /** Disconnect from MySQL */
  async disconnect(): Promise<void> {
    this.connection = null
  }
}
```

### Abstract Method Signatures

```typescript
/**
 * Data processor with various method signatures.
 * @description Demonstrates different abstract method patterns.
 */
abstract class Processor {
  /**
   * Process input string.
   * @description Transforms input to output string.
   * @param input - Input string to process
   */
  abstract process(input: string): string

  /**
   * Transform array items using mapper.
   * @description Maps items to strings with function.
   * @param data - Array of items to transform
   * @param mapper - Function to map items to strings
   */
  abstract transform<T>(data: T[], mapper: (item: T) => string): string[]

  /**
   * Validate data with optional strict mode.
   * @description Checks data validity with strict option.
   * @param data - Data to validate
   * @param strict - Enable strict validation
   */
  abstract validate(data: any, strict?: boolean): boolean

  /**
   * Parse input string to object.
   * @description Parses string to object or null.
   * @param input - Input string to parse
   */
  abstract parse(input: string): object | null

  /**
   * Fetch data from URL.
   * @description Fetches data from given URL.
   * @param url - URL to fetch from
   */
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
