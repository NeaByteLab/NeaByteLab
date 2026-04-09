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
/**
 * Singleton database connection manager.
 * @description Ensures single database connection instance exists.
 */
class DatabaseConnection {
  /** Singleton instance storage */
  private static instance: DatabaseConnection
  /** Database connection object */
  private connection: any

  /**
   * Private constructor prevents direct instantiation.
   * @description Establishes database connection on first access.
   */
  private constructor() {
    this.connection = this.connect()
  }

  /**
   * Global access to singleton instance.
   * @description Creates instance on first call, returns existing.
   * @returns Single database connection instance
   */
  public static get getInstance(): DatabaseConnection {
    if (!DatabaseConnection.instance) {
      DatabaseConnection.instance = new DatabaseConnection()
    }
    return DatabaseConnection.instance
  }

  /**
   * Establish database connection.
   * @description Internal connection setup logic.
   * @returns Connection object
   */
  private connect(): any {
    return { connected: true, database: 'myapp_db' }
  }

  /**
   * Execute SQL query.
   * @description Executes SQL query string.
   * @param sql - SQL query string to execute
   * @returns Array of query results
   */
  public query(sql: string): any[] {
    return this.connection.execute(sql)
  }

  /**
   * Close database connection.
   * @description Releases connection resources.
   */
  public close(): void {
    this.connection.close()
  }
}

/**
 * Usage throughout the application.
 * @description Demonstrates both references point to same instance.
 */
const db1 = DatabaseConnection.getInstance
const db2 = DatabaseConnection.getInstance
console.log(db1 === db2)
```

**Good: Logger singleton**

```typescript
/**
 * Singleton logger for application.
 * @description Centralized logging with timestamp support.
 */
class Logger {
  /** Singleton instance storage */
  private static instance: Logger
  /** Internal log message array */
  private logs: string[] = []

  /** Private constructor */
  private constructor() {}

  /**
   * Global access to singleton instance.
   * @description Creates instance on first call, returns existing.
   * @returns Single logger instance
   */
  public static get getInstance(): Logger {
    if (!Logger.instance) {
      Logger.instance = new Logger()
    }
    return Logger.instance
  }

  /**
   * Add timestamped log message.
   * @param message - Log message content
   */
  public log(message: string): void {
    const timestamp = new Date().toISOString()
    this.logs.push(`[${timestamp}] ${message}`)
    console.log(`[${timestamp}] ${message}`)
  }

  /**
   * Get copy of all logs.
   * @description Returns copy of all logs.
   * @returns Array of log entries copy
   */
  public getLogs(): string[] {
    return [...this.logs]
  }

  /**
   * Clear all log entries.
   * @description Empties the internal log array.
   */
  public clearLogs(): void {
    this.logs = []
  }
}

/**
 * Usage - get logger instance and log messages.
 * @description Demonstrates singleton logger usage pattern.
 */
const logger = Logger.getInstance
logger.log('Application started')
logger.log('User logged in')
```

**Good: Configuration manager singleton**

```typescript
/**
 * Singleton configuration manager.
 * @description Manages global application settings.
 */
class ConfigManager {
  /** Singleton instance storage */
  private static instance: ConfigManager
  /** Settings key-value storage */
  private settings: Map<string, string | number | boolean> = new Map()

  /**
   * Private constructor loads defaults.
   * @description Initializes with default config values.
   */
  private constructor() {
    this.loadDefaultSettings()
  }

  /**
   * Global access to singleton instance.
   * @description Creates instance on first call, returns existing.
   * @returns The single config manager instance
   */
  public static get getInstance(): ConfigManager {
    if (!ConfigManager.instance) {
      ConfigManager.instance = new ConfigManager()
    }
    return ConfigManager.instance
  }

  /**
   * Load default configuration values.
   * @description Sets initial timeout, retries, debug.
   */
  private loadDefaultSettings(): void {
    this.settings.set('api_timeout', 5000)
    this.settings.set('max_retries', 3)
    this.settings.set('debug_mode', false)
  }

  /**
   * Get configuration value by key.
   * @description Returns configuration value.
   * @param key - Configuration key to retrieve
   * @returns Configuration value or undefined
   */
  public get<T>(key: string): T | undefined {
    return this.settings.get(key) as T
  }

  /**
   * Set configuration value.
   * @description Sets configuration value.
   * @param key - Configuration key name
   * @param value - Value to store
   */
  public set(key: string, value: string | number | boolean): void {
    this.settings.set(key, value)
  }

  /**
   * Check if configuration key exists.
   * @description Checks if key exists.
   * @param key - Configuration key to check
   * @returns True if key exists in settings
   */
  public has(key: string): boolean {
    return this.settings.has(key)
  }
}
```

**Bad: Singleton for objects that should have multiple instances**

```typescript
/**
 * Incorrect singleton user implementation.
 * @description Warning: User should not be a singleton pattern.
 */
class User {
  /** Singleton instance storage */
  private static instance: User

  /**
   * Private constructor.
   * @param name - User display name
   * @param email - User email address
   */
  private constructor(
    /** User display name */
    public name: string,
    /** User email address */
    public email: string
  ) {}

  /**
   * Global access to singleton instance
   * @returns Single user instance
   */
  static get Instance(): User {
    if (!User.instance) {
      User.instance = new User('Default User', 'default@example.com')
    }
    return User.instance
  }
}

/**
 * Problem: Can only have one user in the entire system.
 * @description Warning: Should use regular class instead.
 */
```

**Bad: Singleton with hidden dependencies**

```typescript
/**
 * Singleton cache with hidden dependencies.
 * @description Warning: Creates testing and dependency issues.
 */
class GlobalCache {
  /** Singleton instance storage */
  private static instance: GlobalCache
  /** Internal cache storage map */
  private cache: Map<string, any> = new Map()

  /** Private constructor */
  private constructor() {}

  /**
   * Global access to singleton instance.
   * @description Returns the single cache instance.
   * @returns The single cache instance
   */
  static get getInstance(): GlobalCache {
    if (!GlobalCache.instance) {
      GlobalCache.instance = new GlobalCache()
    }
    return GlobalCache.instance
  }
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
/**
 * Basic singleton with lazy initialization.
 * @description Creates instance on first access only.
 */
class Singleton1 {
  /** Singleton instance storage */
  private static instance: Singleton1

  /** Private constructor */
  private constructor() {}

  /**
   * Global access to singleton instance.
   * @description Returns the single instance.
   * @returns Single instance
   */
  public static get getInstance(): Singleton1 {
    if (!Singleton1.instance) {
      Singleton1.instance = new Singleton1()
    }
    return Singleton1.instance
  }
}

/**
 * Singleton with eager initialization
 * @description Instance created at class load time
 */
class Singleton2 {
  /** Pre-created singleton instance */
  private static readonly instance: Singleton2 = new Singleton2()

  /** Private constructor */
  private constructor() {}

  /**
   * Global access to singleton instance.
   * @description Returns the single instance.
   * @returns Single instance
   */
  public static get getInstance(): Singleton2 {
    return Singleton2.instance
  }
}

/**
 * Generic singleton base class
 * @description Reusable singleton pattern for any type
 * @template T - Type of singleton subclass
 */
abstract class Singleton<T> {
  /** Map storing all singleton instances */
  private static instances: Map<any, any> = new Map()

  /**
   * Get or create singleton instance.
   * @description Returns existing instance or creates new one.
   * @returns Singleton instance of type T
   */
  protected static getInstance<T extends Singleton<any>>(this: new () => T): T {
    if (!Singleton.instances.has(this)) {
      Singleton.instances.set(this, new this())
    }
    return Singleton.instances.get(this)
  }
}

/**
 * Database using generic singleton base
 * @description Implements singleton pattern via inheritance
 */
class Database extends Singleton<Database> {
  /**
   * Private constructor.
   * @description Prevents direct instantiation.
   */
  private constructor() {
    super()
  }

  /**
   * Global access to singleton instance.
   * @description Returns the single database instance.
   * @returns Single database instance
   */
  public static get getInstance(): Database {
    return super.getInstance()
  }
}
```

### Singleton vs Static Class

```typescript
/**
 * Static math utilities class
 * @description Stateless utilities without instance data
 */
class MathUtils {
  /** PI constant value */
  static PI = 3.14159

  /**
   * Calculate circle area.
   * @param radius - Circle radius length
   * @returns Area of the circle
   */
  static calculateArea(radius: number): number {
    return MathUtils.PI * radius * radius
  }
}

/**
 * Singleton cache manager with state
 * @description Maintains stateful cache with global access
 */
class CacheManager {
  /** Singleton instance storage */
  private static instance: CacheManager
  /** Internal cache storage map */
  private cache: Map<string, any> = new Map()

  /**
   * Private constructor.
   * @description Prevents instantiation from outside.
   */
  private constructor() {}

  /**
   * Global access to singleton instance
   * @description Returns the single cache manager instance
   * @returns The single cache manager instance
   */
  static get getInstance(): CacheManager {
    if (!CacheManager.instance) {
      CacheManager.instance = new CacheManager()
    }
    return CacheManager.instance
  }

  /**
   * Get value from cache.
   * @param key - Cache key to retrieve
   * @returns Cached value or undefined
   */
  public get(key: string): any {
    return this.cache.get(key)
  }

  /**
   * Set value in cache.
   * @param key - Cache key name
   * @param value - Value to store
   */
  public set(key: string, value: any): void {
    this.cache.set(key, value)
  }
}
```

### Testing Considerations

```typescript
/**
 * User service with hidden singleton dependency
 * @description Warning: Hard to test due to singleton usage
 */
class UserService {
  /**
   * Get user by ID using singleton database
   * @description Retrieves user from database
   * @param id - User identifier to query
   * @returns User object from database
   */
  getUser(id: string): User {
    const db = DatabaseConnection.getInstance
    return db.query(`SELECT * FROM users WHERE id = ${id}`)
  }
}

/**
 * User service with dependency injection
 * @description Testable version with injected database
 */
class UserServiceDI {
  /**
   * Initialize with database dependency
   * @param database - Database connection to use
   */
  constructor(private database: DatabaseConnection) {}

  /**
   * Get user by ID from database
   * @description Retrieves user from database
   * @param id - User identifier to query
   * @returns User object from database
   */
  getUser(id: string): User {
    return this.database.query(`SELECT * FROM users WHERE id = ${id}`)
  }
}

/**
 * Injects mock database for testing.
 * @description Demonstrates testable dependency injection pattern.
 */
```

## Summary

- Singleton ensures exactly one instance of a class exists
- Provides global access point to that instance
- Useful for shared resources like database connections and logging
- Can make testing difficult due to global state
- Consider dependency injection as an alternative
- Use when you truly need one instance, not for convenience

_The singleton pattern solves the problem of controlling access to shared resources, but use it carefully to avoid creating hidden dependencies and making your code hard to test._
