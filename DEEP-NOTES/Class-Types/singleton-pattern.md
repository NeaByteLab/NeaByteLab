---
title: 'Singleton Pattern'
source: 'https://refactoring.guru/design-patterns/singleton/typescript/example'
description: 'Singleton pattern ensures a class has only one instance while providing global access point to that instance.'
tags: ['typescript', 'singleton', 'design-pattern', 'global-state']
---

# Singleton Pattern

## Overview

The Singleton pattern ensures that a class has exactly one instance while providing a global access point to that instance. This is useful when you need exactly one object to coordinate actions across the system, such as database connections, logging, or configuration management.

## Definition

A **singleton** is a class that restricts its instantiation to a single object. The pattern implements a private constructor and a static method that returns the single instance, creating it only if it doesn't already exist.

## The Analogy

Think of a singleton like a **town hall**:

- There's only one town hall in the city
- Every citizen can access it when needed
- It maintains shared resources and services
- Everyone sees the same information and uses the same facilities
- You don't build multiple town halls for each citizen

## When You See It

Use singleton when:

- You need exactly one instance of a class
- The single instance should be accessible from a global point
- You want to control access to shared resources
- Multiple objects need to coordinate through a central object

Common scenarios:

- Database connection pools
- Logging services
- Configuration managers
- Cache managers
- Thread pools
- Hardware interfaces (printer spooler, graphics card)

## Examples

**Good: Database connection singleton**

```typescript
// DatabaseConnection singleton - ensures only one database connection exists
class DatabaseConnection {
  private static instance: DatabaseConnection
  private connection: any

  // Private constructor prevents direct instantiation
  private constructor() {
    this.connection = this.connect()
    console.log('Database connection established')
  }

  // Global access point to the single instance
  public static get getInstance(): DatabaseConnection {
    if (!DatabaseConnection.instance) {
      DatabaseConnection.instance = new DatabaseConnection()
    }
    return DatabaseConnection.instance
  }

  // Establish database connection
  private connect(): any {
    // Database connection logic
    return { connected: true, database: 'myapp_db' }
  }

  // Execute SQL query using the shared connection
  public query(sql: string): any[] {
    return this.connection.execute(sql)
  }

  // Close the shared database connection
  public close(): void {
    this.connection.close()
  }
}

// Usage throughout the application
const db1 = DatabaseConnection.getInstance
const db2 = DatabaseConnection.getInstance

console.log(db1 === db2) // true - same instance
```

**Good: Logger singleton**

```typescript
// Logger singleton - centralized logging for the entire application
class Logger {
  private static instance: Logger
  private logs: string[] = []

  // Private constructor prevents direct instantiation
  private constructor() {}

  // Global access point to the single logger instance
  public static get getInstance(): Logger {
    if (!Logger.instance) {
      Logger.instance = new Logger()
    }
    return Logger.instance
  }

  // Add timestamped log message
  public log(message: string): void {
    const timestamp = new Date().toISOString()
    this.logs.push(`[${timestamp}] ${message}`)
    console.log(`[${timestamp}] ${message}`)
  }

  // Get copy of all logs (prevents external modification)
  public getLogs(): string[] {
    return [...this.logs]
  }

  // Clear all logs
  public clearLogs(): void {
    this.logs = []
  }
}

// Usage - get logger instance and log messages
const logger = Logger.getInstance
logger.log('Application started')
logger.log('User logged in')
```

**Good: Configuration manager singleton**

```typescript
// ConfigManager singleton - manages application configuration globally
class ConfigManager {
  private static instance: ConfigManager
  private settings: Map<string, string | number | boolean> = new Map()

  // Private constructor loads default settings
  private constructor() {
    this.loadDefaultSettings()
  }

  // Global access point to the single config instance
  public static get getInstance(): ConfigManager {
    if (!ConfigManager.instance) {
      ConfigManager.instance = new ConfigManager()
    }
    return ConfigManager.instance
  }

  // Load default configuration values
  private loadDefaultSettings(): void {
    this.settings.set('api_timeout', 5000)
    this.settings.set('max_retries', 3)
    this.settings.set('debug_mode', false)
  }

  // Get configuration value by key
  public get<T>(key: string): T | undefined {
    return this.settings.get(key) as T
  }

  // Set configuration value
  public set(key: string, value: string | number | boolean): void {
    this.settings.set(key, value)
  }

  // Check if configuration key exists
  public has(key: string): boolean {
    return this.settings.has(key)
  }
}
```

**Bad: Singleton for objects that should have multiple instances**

```typescript
// Wrong: User should not be a singleton
class User {
  private static instance: User

  private constructor(
    public name: string,
    public email: string
  ) {}

  static get Instance(): User {
    if (!User.instance) {
      User.instance = new User('Default User', 'default@example.com')
    }
    return User.instance
  }
}

// Problem: Can only have one user in the entire system
// Should use regular class instead
```

**Bad: Singleton with hidden dependencies**

```typescript
// Wrong: Singleton creates hidden dependencies
class GlobalCache {
  private static instance: GlobalCache
  private cache: Map<string, any> = new Map()

  private constructor() {}

  static get getInstance(): GlobalCache {
    if (!GlobalCache.instance) {
      GlobalCache.instance = new GlobalCache()
    }
    return GlobalCache.instance
  }

  // Problem: Hard to test because of global state
  // Problem: Hidden dependency in other classes
}
```

## Important Points

- **Private constructor** prevents direct instantiation with `new`
- **Static method** provides global access point
- **Lazy initialization** creates instance only when first needed
- **Thread safety** matters in multi-threaded environments
- **Global state** can make testing difficult
- **Hidden dependencies** reduce code clarity

### Singleton Implementation Patterns

```typescript
// Pattern 1: Basic singleton with lazy initialization
class Singleton1 {
  private static instance: Singleton1

  private constructor() {}

  public static get getInstance(): Singleton1 {
    if (!Singleton1.instance) {
      Singleton1.instance = new Singleton1()
    }
    return Singleton1.instance
  }
}

// Pattern 2: Eager initialization (instance created at class load)
class Singleton2 {
  private static readonly instance: Singleton2 = new Singleton2()

  private constructor() {}

  public static get getInstance(): Singleton2 {
    return Singleton2.instance
  }
}

// Pattern 3: Generic singleton base class for reuse
abstract class Singleton<T> {
  private static instances: Map<any, any> = new Map()

  protected static getInstance<T extends Singleton<any>>(this: new () => T): T {
    if (!Singleton.instances.has(this)) {
      Singleton.instances.set(this, new this())
    }
    return Singleton.instances.get(this)
  }
}

// Database class using generic singleton base class
class Database extends Singleton<Database> {
  private constructor() {
    super()
  }

  public static get getInstance(): Database {
    return super.getInstance()
  }
}
```

### Singleton vs Static Class

```typescript
// Static class - no state, just utilities
class MathUtils {
  static PI = 3.14159
  static calculateArea(radius: number): number {
    return MathUtils.PI * radius * radius
  }
}

// Singleton - can have state and implement interfaces
class CacheManager {
  private static instance: CacheManager
  private cache: Map<string, any> = new Map()

  private constructor() {}

  static get getInstance(): CacheManager {
    if (!CacheManager.instance) {
      CacheManager.instance = new CacheManager()
    }
    return CacheManager.instance
  }

  // Instance methods - can access state
  public get(key: string): any {
    return this.cache.get(key)
  }

  public set(key: string, value: any): void {
    this.cache.set(key, value)
  }
}
```

### Testing Considerations

```typescript
// Problem: Singleton makes testing difficult
class UserService {
  getUser(id: string): User {
    // Hidden dependency on Database singleton
    const db = DatabaseConnection.getInstance
    return db.query(`SELECT * FROM users WHERE id = ${id}`)
  }
}

// Solution: Dependency injection for testability
class UserService {
  constructor(private database: DatabaseConnection) {}

  getUser(id: string): User {
    return this.database.query(`SELECT * FROM users WHERE id = ${id}`)
  }
}

// Now we can inject mock database for testing
```

## Summary

- Singleton ensures exactly one instance of a class exists
- Provides global access point to that instance
- Useful for shared resources like database connections and logging
- Can make testing difficult due to global state
- Consider dependency injection as an alternative
- Use when you truly need one instance, not for convenience

_The singleton pattern solves the problem of controlling access to shared resources, but use it carefully to avoid creating hidden dependencies and making your code hard to test._
