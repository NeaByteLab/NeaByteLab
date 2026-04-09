---
title: 'Factory Pattern'
source: 'https://refactoring.guru/design-patterns/factory-method/typescript/example'
description: 'Factory pattern provides interface for creating objects in superclass while allowing subclasses to alter creation types.'
tags: ['typescript', 'factory-pattern', 'creational-pattern', 'object-creation']
---

# Factory Pattern

## Overview

The Factory pattern defines an interface for creating objects but lets subclasses decide which class to instantiate. It lets a class defer instantiation to subclasses, promoting loose coupling by eliminating the need to bind application-specific classes into your code.

## Definition

A **factory** is a class or method responsible for creating objects without specifying the exact class of the object that will be created. The Factory pattern encapsulates object creation logic, making it easier to manage and modify.

## The Analogy

Think of a factory like a **pizza restaurant**:

- The restaurant has a standard pizza-making process (factory interface)
- Different pizza types (cheese, pepperoni, veggie) are made differently
- You order "pizza" without specifying exactly how it's made
- The kitchen (factory) knows how to create each pizza type
- You can add new pizza types without changing the ordering system

## When You See It

Use factory pattern when:

- You can't anticipate the class of objects that need to be created
- You want to provide users with a way to create objects without exposing creation logic
- You want to consolidate object creation code in one place
- You need to switch between different product families
- You want to test code with mock objects

Common scenarios:

- Database connection factories (MySQL, PostgreSQL, MongoDB)
- UI component factories (buttons, inputs, panels for different themes)
- Payment processor factories (Stripe, PayPal, Square)
- Logger factories (console, file, cloud logging)
- Vehicle factories (cars, trucks, motorcycles)

## Examples

**Good: Simple factory method**

```typescript
/**
 * Animal interface for all types.
 * @description Defines sound and movement contracts.
 */
interface Animal {
  /** Make animal-specific sound */
  makeSound(): void
  /** Execute movement behavior */
  move(): void
}

/**
 * Dog implementation.
 * @description Concrete dog with bark and run.
 */
class Dog implements Animal {
  /** Output dog barking sound */
  makeSound(): void {
    console.log('Woof! Woof!')
  }

  /** Output dog running movement */
  move(): void {
    console.log('Dog is running')
  }
}

/**
 * Cat implementation.
 * @description Concrete cat with meow and sneak.
 */
class Cat implements Animal {
  /** Output cat meowing sound */
  makeSound(): void {
    console.log('Meow!')
  }

  /** Output cat sneaking movement */
  move(): void {
    console.log('Cat is sneaking')
  }
}

/**
 * Bird implementation.
 * @description Concrete bird with tweet and fly.
 */
class Bird implements Animal {
  /** Output bird tweeting sound */
  makeSound(): void {
    console.log('Tweet!')
  }

  /** Output bird flying movement */
  move(): void {
    console.log('Bird is flying')
  }
}

/**
 * Factory for creating animals.
 * @description Creates animals based on type parameter.
 */
class AnimalFactory {
  /**
   * Create animal instance.
   * @description Creates animal by type parameter.
   * @param type - Animal type to create
   * @returns New animal instance
   * @throws Error for unknown animal type
   */
  static createAnimal(type: 'dog' | 'cat' | 'bird'): Animal {
    switch (type) {
      case 'dog':
        return new Dog()
      case 'cat':
        return new Cat()
      case 'bird':
        return new Bird()
      default:
        throw new Error(`Unknown animal type: ${type}`)
    }
  }
}

/**
 * Usage demonstration.
 * @description Creates different animals using factory.
 */
const dog = AnimalFactory.createAnimal('dog')
const cat = AnimalFactory.createAnimal('cat')
const bird = AnimalFactory.createAnimal('bird')
dog.makeSound()
cat.makeSound()
bird.makeSound()
```

**Good: Abstract factory for UI components**

```typescript
/**
 * Button component interface.
 * @description Contract for rendering and clicks.
 */
interface Button {
  /** Render button to display */
  render(): void
  /**
   * Attach click event handler.
   * @description Attaches click event listener.
   * @param callback - Function to execute
   */
  onClick(callback: () => void): void
}

/**
 * Input component interface.
 * @description Contract for rendering and value access.
 */
interface Input {
  /** Render input to display */
  render(): void
  /**
   * Get current input value.
   * @description Returns current input value.
   * @returns Current input value
   */
  getValue(): string
  /**
   * Set input value.
   * @description Sets input value to new value.
   * @param value - New value to set
   */
  setValue(value: string): void
}

/**
 * Material button component.
 * @description Material theme implementation.
 */
class MaterialButton implements Button {
  /**
   * Initialize with button text
   * @description Creates button with label
   * @param text - Button label text
   */
  constructor(private text: string) {}

  /** Render material button */
  render(): void {
    console.log(`[Material] Rendering button: ${this.text}`)
  }

  /**
   * Attach click handler.
   * @description Attaches click event listener.
   * @param callback - Function to execute
   */
  onClick(callback: () => void): void {
    console.log('[Material] Button click handler attached')
  }
}

/**
 * Material input component.
 * @description Material theme implementation.
 */
class MaterialInput implements Input {
  /**
   * Initialize with placeholder
   * @description Creates input with placeholder
   * @param placeholder - Input placeholder text
   */
  constructor(private placeholder: string) {}

  /** Render material input */
  render(): void {
    console.log(`[Material] Rendering input: ${this.placeholder}`)
  }

  /**
   * Get current input value.
   * @description Returns current input value.
   * @returns Current input value
   */
  getValue(): string {
    return 'material input value'
  }

  /**
   * Set input value.
   * @description Sets input value to new value.
   * @param value - New value to display
   */
  setValue(value: string): void {
    console.log(`[Material] Input value set to: ${value}`)
  }
}

/**
 * Bootstrap button component.
 * @description Bootstrap theme implementation.
 */
class BootstrapButton implements Button {
  /**
   * Initialize with button text
   * @description Creates button with label
   * @param text - Button label text
   */
  constructor(private text: string) {}

  /** Render bootstrap button */
  render(): void {
    console.log(`[Bootstrap] Rendering button: ${this.text}`)
  }

  /**
   * Attach click handler.
   * @description Attaches click event listener.
   * @param callback - Function to execute
   */
  onClick(callback: () => void): void {
    console.log('[Bootstrap] Button click handler attached')
  }
}

/**
 * Bootstrap input component.
 * @description Bootstrap theme implementation.
 */
class BootstrapInput implements Input {
  /**
   * Initialize with placeholder
   * @description Creates input with placeholder
   * @param placeholder - Input placeholder text
   */
  constructor(private placeholder: string) {}

  /** Render bootstrap input */
  render(): void {
    console.log(`[Bootstrap] Rendering input: ${this.placeholder}`)
  }

  /**
   * Get current input value.
   * @description Returns current input value.
   * @returns Current input value
   */
  getValue(): string {
    return 'bootstrap input value'
  }

  /**
   * Set input value.
   * @description Sets input value to new value.
   * @param value - New value to display
   */
  setValue(value: string): void {
    console.log(`[Bootstrap] Input value set to: ${value}`)
  }
}

/**
 * Abstract factory for UI components.
 * @description Interface for creating themed families.
 */
abstract class UIComponentFactory {
  /**
   * Create button component.
   * @description Creates new button instance.
   * @param text - Button label text
   * @returns New button instance
   */
  abstract createButton(text: string): Button
  /**
   * Create input component.
   * @description Creates new input instance.
   * @param placeholder - Input placeholder text
   * @returns New input instance
   */
  abstract createInput(placeholder: string): Input
}

/**
 * Material theme factory.
 * @description Creates Material design components.
 */
class MaterialFactory extends UIComponentFactory {
  /**
   * Create material button
   * @description Instantiates material button
   * @param text - Button label text
   * @returns New material button
   */
  createButton(text: string): Button {
    return new MaterialButton(text)
  }

  /**
   * Create material input
   * @description Instantiates material input
   * @param placeholder - Input placeholder text
   * @returns New material input
   */
  createInput(placeholder: string): Input {
    return new MaterialInput(placeholder)
  }
}

/**
 * Bootstrap theme factory.
 * @description Creates Bootstrap UI components.
 */
class BootstrapFactory extends UIComponentFactory {
  /**
   * Create bootstrap button
   * @description Instantiates bootstrap button
   * @param text - Button label text
   * @returns New bootstrap button
   */
  createButton(text: string): Button {
    return new BootstrapButton(text)
  }

  /**
   * Create bootstrap input
   * @description Instantiates bootstrap input
   * @param placeholder - Input placeholder text
   * @returns New bootstrap input
   */
  createInput(placeholder: string): Input {
    return new BootstrapInput(placeholder)
  }
}

/**
 * Application using UI factory.
 * @description Renders forms with injected factory.
 */
class UIApp {
  /**
   * Initialize with factory
   * @description Creates app with component factory
   * @param factory - Factory for creating components
   */
  constructor(private factory: UIComponentFactory) {}

  /** Render form with components */
  renderForm(): void {
    const button = this.factory.createButton('Submit')
    const input = this.factory.createInput('Enter name')
    input.render()
    button.render()
  }
}

/**
 * Theme switching demonstration
 * @description Demonstrates abstract factory pattern
 */
const materialApp = new UIApp(new MaterialFactory())
const bootstrapApp = new UIApp(new BootstrapFactory())
materialApp.renderForm()
bootstrapApp.renderForm()
```

```typescript
/**
 * Database interface.
 * @description Contract for database operations.
 */
interface Database {
  /** Connect to database */
  connect(): Promise<void>
  /**
   * Execute SQL query
   * @description Executes SQL and returns results
   * @param sql - SQL query string
   * @returns Query result rows
   */
  query(sql: string): Promise<any[]>
  /** Disconnect from database */
  disconnect(): Promise<void>
}

/**
 * MySQL database implementation.
 * @description MySQL database connection handler.
 */
class MySQL implements Database {
  /**
   * Initialize with connection config
   * @description Creates MySQL with config
   * @param config - Database connection config
   */
  constructor(private config: { host: string; port: number }) {}

  /** Connect to MySQL database */
  async connect(): Promise<void> {
    console.log(`Connecting to MySQL at ${this.config.host}:${this.config.port}`)
  }

  /**
   * Execute MySQL query
   * @description Executes SQL on MySQL
   * @param sql - SQL query string
   * @returns Query result rows
   */
  async query(sql: string): Promise<any[]> {
    console.log(`MySQL executing: ${sql}`)
    return [{ id: 1, name: 'MySQL Result' }]
  }

  /** Disconnect from MySQL */
  async disconnect(): Promise<void> {
    console.log('Disconnecting from MySQL')
  }
}

/**
 * PostgreSQL database implementation.
 * @description PostgreSQL database connection handler.
 */
class PostgreSQL implements Database {
  /**
   * Initialize with connection config
   * @description Creates PostgreSQL with config
   * @param config - Database connection config
   */
  constructor(private config: { host: string; port: number }) {}

  /** Connect to PostgreSQL database */
  async connect(): Promise<void> {
    console.log(`Connecting to PostgreSQL at ${this.config.host}:${this.config.port}`)
  }

  /**
   * Execute PostgreSQL query
   * @description Executes SQL on PostgreSQL
   * @param sql - SQL query string
   * @returns Query result rows
   */
  async query(sql: string): Promise<any[]> {
    console.log(`PostgreSQL executing: ${sql}`)
    return [{ id: 1, name: 'PostgreSQL Result' }]
  }

  /** Disconnect from PostgreSQL */
  async disconnect(): Promise<void> {
    console.log('Disconnecting from PostgreSQL')
  }
}

/**
 * Database factory.
 * @description Creates database instances by type.
 */
class DatabaseFactory {
  /**
   * Create database connection
   * @description Creates database by type
   * @param type - Database type to create
   * @param config - Database connection config
   * @returns New database instance
   * @throws Error for unsupported type
   */
  static createDatabase(
    type: 'mysql' | 'postgresql',
    config: { host: string; port: number }
  ): Database {
    switch (type) {
      case 'mysql':
        return new MySQL(config)
      case 'postgresql':
        return new PostgreSQL(config)
      default:
        throw new Error(`Unsupported database type: ${type}`)
    }
  }
}

/**
 * Usage demonstration
 * @description Demonstrates database factory pattern
 */
const mysql = DatabaseFactory.createDatabase('mysql', { host: 'localhost', port: 3306 })
const postgresql = DatabaseFactory.createDatabase('postgresql', { host: 'localhost', port: 5432 })
mysql.connect()
postgresql.connect()
```

**Good: Configurable vehicle factory**

```typescript
/**
 * Vehicle configuration interface.
 * @description Vehicle configuration options.
 */
interface VehicleConfig {
  /** Vehicle type category */
  type: 'car' | 'truck' | 'motorcycle'
  /** Engine type option */
  engine: 'gas' | 'electric' | 'hybrid'
  /** Vehicle color choice */
  color: string
  /** Feature list array */
  features: string[]
}

/**
 * Configurable vehicle factory.
 * @description Creates vehicles with configuration.
 */
class ConfigurableVehicleFactory {
  /** Stored configuration templates */
  private static configurations = new Map<string, Partial<VehicleConfig>>()

  /**
   * Register configuration template
   * @description Stores template for later use
   * @param name - Template name
   * @param config - Configuration template
   */
  static registerConfiguration(name: string, config: Partial<VehicleConfig>): void {
    this.configurations.set(name, config)
  }

  /**
   * Create vehicle with configuration
   * @description Creates vehicle from configuration
   * @param config - Full vehicle configuration
   * @returns New vehicle instance
   * @throws Error for unknown vehicle type
   */
  static createVehicle(config: VehicleConfig): Vehicle {
    const baseConfig = { type: 'car', engine: 'gas', color: 'black', features: [] }
    const finalConfig = { ...baseConfig, ...config }
    switch (finalConfig.type) {
      case 'car':
        return new Car(finalConfig)
      case 'truck':
        return new Truck(finalConfig)
      case 'motorcycle':
        return new Motorcycle(finalConfig)
      default:
        throw new Error(`Unknown vehicle type: ${finalConfig.type}`)
    }
  }
}
```

**Good: Testing with factory injection**

```typescript
/**
 * User service with database.
 * @description Production service using real database.
 */
class UserService {
  /**
   * Initialize with factory
   * @param databaseFactory - Factory for database connections
   */
  constructor(private databaseFactory: DatabaseFactory) {}

  /**
   * Get user by ID
   * @description Fetches user from database
   * @param id - User ID to fetch
   * @returns User instance
   */
  async getUser(id: string): Promise<User> {
    const db = this.databaseFactory.createDatabase('production')
    const data = await db.query(`SELECT * FROM users WHERE id = ${id}`)
    return new User(data[0])
  }
}

/**
 * Mock database factory.
 * @description Factory for testing with mock data.
 */
class MockDatabaseFactory extends DatabaseFactory {
  /**
   * Create mock database
   * @description Creates mock database instance
   * @param type - Database type parameter
   * @returns Mock database instance
   */
  createDatabase(type: string): Database {
    return new MockDatabase([{ id: '1', name: 'Test User', email: 'test@example.com' }])
  }
}

/**
 * Testing with dependency injection
 * @description Demonstrates testable factory pattern
 */
const testService = new UserService(new MockDatabaseFactory())
const user = await testService.getUser('1')
```

## Summary

- Factory pattern encapsulates object creation logic
- Promotes loose coupling between client code and concrete classes
- Supports open/closed principle - easy to add new types without modifying existing code
- Useful when you can't anticipate object classes or need complex initialization
- Can be overkill for simple object creation
- Excellent for testing and dependency injection scenarios

_The factory pattern is a fundamental creational pattern that provides flexibility and maintainability in object creation, especially when dealing with complex or variable object instantiation requirements._
