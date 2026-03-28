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
// Animal interface - defines contract for all animal types
interface Animal {
  makeSound(): void
  move(): void
}

// Concrete Dog implementation
class Dog implements Animal {
  makeSound(): void {
    console.log('Woof! Woof!')
  }

  move(): void {
    console.log('Dog is running')
  }
}

// Concrete Cat implementation
class Cat implements Animal {
  makeSound(): void {
    console.log('Meow!')
  }

  move(): void {
    console.log('Cat is sneaking')
  }
}

// Concrete Bird implementation
class Bird implements Animal {
  makeSound(): void {
    console.log('Tweet!')
  }

  move(): void {
    console.log('Bird is flying')
  }
}

// AnimalFactory - creates animals based on type parameter
class AnimalFactory {
  // Factory method - creates appropriate animal instance
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

// Usage - create different animals using factory
const dog = AnimalFactory.createAnimal('dog')
const cat = AnimalFactory.createAnimal('cat')
const bird = AnimalFactory.createAnimal('bird')

dog.makeSound() // Woof! Woof!
cat.makeSound() // Meow!
bird.makeSound() // Tweet!
```

**Good: Abstract factory for UI components**

```typescript
// Abstract product interfaces - define contracts for UI components
interface Button {
  render(): void
  onClick(callback: () => void): void
}

interface Input {
  render(): void
  getValue(): string
  setValue(value: string): void
}

// Concrete products for Material theme
class MaterialButton implements Button {
  constructor(private text: string) {}

  render(): void {
    console.log(`[Material] Rendering button: ${this.text}`)
  }

  onClick(callback: () => void): void {
    console.log('[Material] Button click handler attached')
  }
}

class MaterialInput implements Input {
  constructor(private placeholder: string) {}

  render(): void {
    console.log(`[Material] Rendering input: ${this.placeholder}`)
  }

  getValue(): string {
    return 'material input value'
  }

  setValue(value: string): void {
    console.log(`[Material] Input value set to: ${value}`)
  }
}

// Concrete products for Bootstrap theme
class BootstrapButton implements Button {
  constructor(private text: string) {}

  render(): void {
    console.log(`[Bootstrap] Rendering button: ${this.text}`)
  }

  onClick(callback: () => void): void {
    console.log('[Bootstrap] Button click handler attached')
  }
}

class BootstrapInput implements Input {
  constructor(private placeholder: string) {}

  render(): void {
    console.log(`[Bootstrap] Rendering input: ${this.placeholder}`)
  }

  getValue(): string {
    return 'bootstrap input value'
  }

  setValue(value: string): void {
    console.log(`[Bootstrap] Input value set to: ${value}`)
  }
}

// Abstract factory - defines interface for creating component families
abstract class UIComponentFactory {
  abstract createButton(text: string): Button
  abstract createInput(placeholder: string): Input
}

// Concrete factory for Material theme
class MaterialFactory extends UIComponentFactory {
  createButton(text: string): Button {
    return new MaterialButton(text)
  }

  createInput(placeholder: string): Input {
    return new MaterialInput(placeholder)
  }
}

// Concrete factory for Bootstrap theme
class BootstrapFactory extends UIComponentFactory {
  createButton(text: string): Button {
    return new BootstrapButton(text)
  }

  createInput(placeholder: string): Input {
    return new BootstrapInput(placeholder)
  }
}

// Usage - app that uses factory to create UI components
class UIApp {
  constructor(private factory: UIComponentFactory) {}

  renderForm(): void {
    const button = this.factory.createButton('Submit')
    const input = this.factory.createInput('Enter name')

    input.render()
    button.render()
  }
}

// Switch themes easily by changing factory
const materialApp = new UIApp(new MaterialFactory())
const bootstrapApp = new UIApp(new BootstrapFactory())

materialApp.renderForm()
bootstrapApp.renderForm()
```

**Good: Database connection factory**

```typescript
// Database interface - defines contract for database operations
interface Database {
  connect(): Promise<void>
  query(sql: string): Promise<any[]>
  disconnect(): Promise<void>
}

// MySQL database implementation
class MySQL implements Database {
  constructor(private config: { host: string; port: number }) {}

  async connect(): Promise<void> {
    console.log(`Connecting to MySQL at ${this.config.host}:${this.config.port}`)
  }

  async query(sql: string): Promise<any[]> {
    console.log(`MySQL executing: ${sql}`)
    return [{ id: 1, name: 'MySQL Result' }]
  }

  async disconnect(): Promise<void> {
    console.log('Disconnecting from MySQL')
  }
}

// PostgreSQL database implementation
class PostgreSQL implements Database {
  constructor(private config: { host: string; port: number }) {}

  async connect(): Promise<void> {
    console.log(`Connecting to PostgreSQL at ${this.config.host}:${this.config.port}`)
  }

  async query(sql: string): Promise<any[]> {
    console.log(`PostgreSQL executing: ${sql}`)
    return [{ id: 1, name: 'PostgreSQL Result' }]
  }

  async disconnect(): Promise<void> {
    console.log('Disconnecting from PostgreSQL')
  }
}

// DatabaseFactory - creates database instances based on type
class DatabaseFactory {
  // Factory method - creates appropriate database connection
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

// Usage - create database connections using factory
const mysql = DatabaseFactory.createDatabase('mysql', { host: 'localhost', port: 3306 })
const postgresql = DatabaseFactory.createDatabase('postgresql', { host: 'localhost', port: 5432 })

mysql.connect()
postgresql.connect()
```

**Bad: Factory that just hides constructors**

```typescript
// Wrong: Factory adds no value over direct construction
class SimpleUser {
  constructor(
    public name: string,
    public email: string
  ) {}
}

class UserFactory {
  // Factory method that just calls constructor - no added value
  static createUser(name: string, email: string): SimpleUser {
    return new SimpleUser(name, email)
  }
}

// No benefit over: new SimpleUser(name, email)
```

**Bad: Factory with complex conditional logic**

```typescript
// Wrong: Too many conditions make factory hard to maintain
class ComplexVehicleFactory {
  static createVehicle(type: string, options: any): any {
    if (type === 'car') {
      if (options.electric) {
        if (options.luxury) {
          return new LuxuryElectricCar()
        } else {
          return new BasicElectricCar()
        }
      } else {
        if (options.luxury) {
          return new LuxuryGasCar()
        } else {
          return new BasicGasCar()
        }
      }
    } else if (type === 'truck') {
      // ... more nested conditions
    }
    // This becomes unmanageable
  }
}

// Better: Use separate factories or builder pattern
```

## Important Points

- **Encapsulates object creation** logic in one place
- **Promotes loose coupling** between client code and concrete classes
- **Supports open/closed principle** - easy to add new types
- **Can hide complex initialization** logic
- **Enables dependency injection** and testing
- **May increase complexity** for simple cases

### Factory Method vs Simple Factory

```typescript
// Simple Factory (static method) - centralized creation
class SimpleAnimalFactory {
  static createAnimal(type: string): Animal {
    // Creation logic
  }
}

// Factory Method (instance method, inheritable) - polymorphic creation
abstract class AnimalCreator {
  abstract factoryMethod(): Animal

  public createAndUse(): void {
    const animal = this.factoryMethod()
    animal.makeSound()
  }
}

// DogCreator - concrete factory for dogs
class DogCreator extends AnimalCreator {
  factoryMethod(): Animal {
    return new Dog()
  }
}
```

### Factory with Configuration

```typescript
// VehicleConfig interface - defines vehicle configuration options
interface VehicleConfig {
  type: 'car' | 'truck' | 'motorcycle'
  engine: 'gas' | 'electric' | 'hybrid'
  color: string
  features: string[]
}

// ConfigurableVehicleFactory - creates vehicles with configuration
class ConfigurableVehicleFactory {
  private static configurations = new Map<string, Partial<VehicleConfig>>()

  // Register reusable configuration templates
  static registerConfiguration(name: string, config: Partial<VehicleConfig>): void {
    this.configurations.set(name, config)
  }

  // Create vehicle with full configuration
  static createVehicle(config: VehicleConfig): Vehicle {
    // Apply registered configurations
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

// Register common configurations for reuse
ConfigurableVehicleFactory.registerConfiguration('eco-friendly', {
  engine: 'electric',
  features: ['regenerative-braking', 'eco-mode']
})
```

### Factory for Testing

```typescript
// Production factory - uses real database
class UserService {
  constructor(private databaseFactory: DatabaseFactory) {}

  async getUser(id: string): Promise<User> {
    const db = this.databaseFactory.createDatabase('production')
    const data = await db.query(`SELECT * FROM users WHERE id = ${id}`)
    return new User(data[0])
  }
}

// Test factory - uses mock database for testing
class MockDatabaseFactory extends DatabaseFactory {
  createDatabase(type: string): Database {
    return new MockDatabase([{ id: '1', name: 'Test User', email: 'test@example.com' }])
  }
}

// Easy testing with dependency injection
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
