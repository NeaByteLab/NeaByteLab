---
title: 'Decorator Pattern'
source: 'https://refactoring.guru/design-patterns/decorator/typescript/example'
description: 'Decorator pattern attaches new behaviors to objects by placing them inside special wrapper objects.'
tags: ['typescript', 'decorator-pattern', 'structural-pattern', 'wrappers', 'composition']
---

# Decorator Pattern

## Overview

The Decorator pattern lets you attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors. Using decorators, you can wrap objects multiple times and combine behaviors without modifying the original object's code.

## Definition

A **decorator** is an object that adds new functionality to another object dynamically, without altering its structure. The decorator implements the same interface as the object it decorates and delegates calls to the wrapped object while adding its own behavior before or after the delegation.

## The Analogy

Think of the decorator pattern like **clothing accessories**:

- You have a basic outfit (the original object)
- You can add a scarf (decorator) without changing the outfit
- You can add sunglasses (another decorator) over the scarf
- You can add a hat (another decorator) over everything
- Each accessory adds functionality (warmth, sun protection) without changing the core outfit
- You can mix and match accessories in any combination

## When You See It

Use decorator pattern when:

- You need to add responsibilities to individual objects dynamically
- You want to add responsibilities without affecting other objects
- Extending behavior by subclassing is impractical
- You want to combine multiple behaviors flexibly

Common scenarios:

- Coffee shop orders (espresso + milk + whipped cream)
- Text processing (compression + encryption + formatting)
- UI components (scroll bars + borders + tooltips)
- Web requests (authentication + logging + caching)
- Stream processing (buffering + compression + encryption)

## Examples

**Good: Coffee shop decorator pattern**

```typescript
/**
 * Coffee component interface.
 * @description Contract for coffee description and pricing.
 */
interface Coffee {
  /** Get coffee description */
  getDescription(): string
  /** Get coffee cost in dollars */
  getCost(): number
}

/**
 * Basic coffee without extras.
 * @description Concrete coffee with base price.
 */
class SimpleCoffee implements Coffee {
  /** Get simple coffee description */
  getDescription(): string {
    return 'Simple coffee'
  }

  /** Get simple coffee cost */
  getCost(): number {
    return 2.0
  }
}

/**
 * Base decorator for coffee components.
 * @description Wraps coffee and delegates calls by default.
 */
abstract class CoffeeDecorator implements Coffee {
  /**
   * Initialize with coffee to wrap.
   * @description Stores wrapped coffee component.
   * @param coffee - Coffee component to decorate
   */
  constructor(protected coffee: Coffee) {}

  /** Get wrapped coffee description */
  getDescription(): string {
    return this.coffee.getDescription()
  }

  /** Get wrapped coffee cost */
  getCost(): number {
    return this.coffee.getCost()
  }
}

/**
 * Adds milk to coffee.
 * @description Decorator adding milk to coffee.
 */
class MilkDecorator extends CoffeeDecorator {
  /** Get description with milk */
  getDescription(): string {
    return `${this.coffee.getDescription()}, milk`
  }

  /** Get cost with milk added */
  getCost(): number {
    return this.coffee.getCost() + 0.5
  }
}

/**
 * Adds sugar to coffee.
 * @description Decorator adding sugar to coffee.
 */
class SugarDecorator extends CoffeeDecorator {
  /** Get description with sugar */
  getDescription(): string {
    return `${this.coffee.getDescription()}, sugar`
  }

  /** Get cost with sugar added */
  getCost(): number {
    return this.coffee.getCost() + 0.25
  }
}

/**
 * Adds whipped cream to coffee.
 * @description Decorator adding whipped cream.
 */
class WhippedCreamDecorator extends CoffeeDecorator {
  /** Get description with whipped cream */
  getDescription(): string {
    return `${this.coffee.getDescription()}, whipped cream`
  }

  /** Get cost with whipped cream */
  getCost(): number {
    return this.coffee.getCost() + 0.75
  }
}

/**
 * Adds vanilla flavor to coffee.
 * @description Decorator adding vanilla flavor.
 */
class VanillaDecorator extends CoffeeDecorator {
  /** Get description with vanilla */
  getDescription(): string {
    return `${this.coffee.getDescription()}, vanilla`
  }

  /** Get cost with vanilla added */
  getCost(): number {
    return this.coffee.getCost() + 0.4
  }
}

/**
 * Usage - flexible combinations of decorators.
 * @description Demonstrates decorator composition pattern.
 */
let coffee: Coffee = new SimpleCoffee()
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)

coffee = new MilkDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)

coffee = new SugarDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)

coffee = new WhippedCreamDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)

/**
 * Different combinations of decorators.
 * @description Shows flexible decorator stacking.
 */
const espressoWithVanilla = new VanillaDecorator(new SimpleCoffee())
const deluxeCoffee = new WhippedCreamDecorator(
  new MilkDecorator(new SugarDecorator(new VanillaDecorator(new SimpleCoffee())))
)
```

**Good: Web request decorators**

```typescript
/**
 * Request handler interface.
 * @description Contract for HTTP request processing.
 */
interface RequestHandler {
  /**
   * Handle incoming request.
   * @description Processes request and returns response.
   * @param request - Request object to process
   * @returns Response object
   */
  handle(request: any): any
}

/**
 * Basic request handler.
 * @description Simple request processing implementation.
 */
class BaseRequestHandler implements RequestHandler {
  /**
   * Handle request with base processing.
   * @description Processes request with base logic.
   * @param request - Request object to process
   * @returns Success response with data
   */
  handle(request: any): any {
    console.log('Processing base request')
    return { status: 'success', data: request }
  }
}

/**
 * Base decorator for request handlers.
 * @description Wraps handler and delegates by default.
 */
abstract class RequestDecorator implements RequestHandler {
  /**
   * Initialize with handler to wrap.
   * @description Wraps handler for decoration.
   * @param handler - Request handler to decorate
   */
  constructor(protected handler: RequestHandler) {}

  /**
   * Delegate to wrapped handler.
   * @description Delegates to wrapped handler.
   * @param request - Request object to process
   * @returns Response from wrapped handler
   */
  handle(request: any): any {
    return this.handler.handle(request)
  }
}

/**
 * Authenticates requests before processing.
 * @description Decorator validating API authentication.
 */
class AuthenticationDecorator extends RequestDecorator {
  /**
   * Initialize with handler and API key.
   * @description Wraps handler with authentication.
   * @param handler - Handler to wrap
   * @param apiKey - Valid API key for authentication
   */
  constructor(
    handler: RequestHandler,
    private apiKey: string
  ) {
    super(handler)
  }

  /**
   * Authenticate request then delegate.
   * @description Validates API key and delegates.
   * @param request - Request with headers to validate
   * @returns Response or unauthorized error
   */
  handle(request: any): any {
    console.log('Checking authentication...')
    if (!request.headers || request.headers['api-key'] !== this.apiKey) {
      return { status: 'error', message: 'Unauthorized' }
    }
    console.log('Authentication successful')
    return super.handle(request)
  }
}

/**
 * Logs requests and responses with timestamps.
 * @description Decorator logging request and response.
 */
class LoggingDecorator extends RequestDecorator {
  /**
   * Initialize with handler to wrap.
   * @description Wraps handler with logging.
   * @param handler - Handler to decorate with logging
   */
  constructor(handler: RequestHandler) {
    super(handler)
  }

  /**
   * Log request and response.
   * @description Logs request and response data.
   * @param request - Request object to log and process
   * @returns Response from wrapped handler
   */
  handle(request: any): any {
    const timestamp = new Date().toISOString()
    console.log(`[${timestamp}] Incoming request:`, JSON.stringify(request))
    const response = super.handle(request)
    console.log(`[${timestamp}] Response:`, JSON.stringify(response))
    return response
  }
}

/**
 * Caches responses to avoid repeated processing.
 * @description Decorator caching response data.
 */
class CacheDecorator extends RequestDecorator {
  /** Cache storage for responses */
  private cache = new Map<string, any>()

  /**
   * Initialize with handler to wrap.
   * @description Wraps handler for logging.
   * @param handler - Request handler to decorate
   */
  constructor(handler: RequestHandler) {
    super(handler)
  }

  /**
   * Handle request with caching.
   * @description Returns cached response or processes.
   * @param request - Request data to process
   * @returns Cached or fresh response
   */
  handle(request: any): any {
    const cacheKey = JSON.stringify(request)

    if (this.cache.has(cacheKey)) {
      console.log('Cache hit!')
      return this.cache.get(cacheKey)
    }

    console.log('Cache miss, processing request...')
    const response = super.handle(request)
    this.cache.set(cacheKey, response)
    return response
  }
}

/**
 * Validates request data before processing.
 * @description Decorator validating request data.
 */
class ValidationDecorator extends RequestDecorator {
  /**
   * Initialize with handler and schema.
   * @description Wraps handler with validation.
   * @param handler - Request handler to decorate
   * @param schema - Validation schema object
   */
  constructor(
    handler: RequestHandler,
    private schema: any
  ) {
    super(handler)
  }

  /**
   * Handle request with validation.
   * @description Validates request body and delegates.
   * @param request - Request data to process
   * @returns Validated response or error
   */
  handle(request: any): any {
    console.log('Validating request...')
    if (!request.body || typeof request.body !== 'object') {
      return { status: 'error', message: 'Invalid request body' }
    }
    if (!request.body.userId) {
      return { status: 'error', message: 'Missing userId' }
    }
    console.log('Validation passed')
    return super.handle(request)
  }
}

/**
 * Usage - flexible middleware chain with decorators.
 * @description Demonstrates request handler decoration.
 */
let handler: RequestHandler = new BaseRequestHandler()

/**
 * Adds decorators to build middleware chain.
 * @description Shows flexible middleware composition.
 */
handler = new AuthenticationDecorator(handler, 'secret-api-key')
handler = new LoggingDecorator(handler)
handler = new ValidationDecorator(handler, { userId: 'string' })
handler = new CacheDecorator(handler)

/**
 * Test the decorated handler.
 * @description Executes decorated request handling.
 */
const request = {
  headers: { 'api-key': 'secret-api-key' },
  body: { userId: '123', action: 'getData' }
}
const response = handler.handle(request)
console.log('Final response:', response)
```

**Good: Text processing decorators**

```typescript
/**
 * Text processor interface.
 * @description Contract for text transformations.
 */
interface TextProcessor {
  /**
   * Process text and return result.
   * @description Transforms input text to output.
   * @param text - Input text to process
   * @returns Processed text output
   */
  process(text: string): string
}

/**
 * Basic text processor.
 * @description Returns text unchanged.
 */
class BasicTextProcessor implements TextProcessor {
  /**
   * Process text without changes.
   * @description Returns text unchanged.
   * @param text - Input text to process
   * @returns Same text unchanged
   */
  process(text: string): string {
    return text
  }
}

/**
 * Base decorator for text processing.
 * @description Delegates to wrapped processor.
 */
abstract class TextDecorator implements TextProcessor {
  /**
   * Initialize with processor to wrap.
   * @description Wraps processor for decoration.
   * @param processor - Text processor to decorate
   */
  constructor(protected processor: TextProcessor) {}

  /**
   * Process text by delegation.
   * @description Delegates to wrapped processor.
   * @param text - Input text to process
   * @returns Processed text output
   */
  process(text: string): string {
    return this.processor.process(text)
  }
}

/**
 * Converts text to uppercase.
 * @description Decorator converting text to uppercase.
 */
class UpperCaseDecorator extends TextDecorator {
  /**
   * Process text to uppercase.
   * @description Converts text to uppercase.
   * @param text - Input text to process
   * @returns Uppercase text result
   */
  process(text: string): string {
    return super.process(text).toUpperCase()
  }
}

/**
 * Trims whitespace from text.
 * @description Decorator trimming whitespace from text.
 */
class TrimDecorator extends TextDecorator {
  /**
   * Process text with trim.
   * @description Removes leading and trailing spaces.
   * @param text - Input text to process
   * @returns Trimmed text result
   */
  process(text: string): string {
    return super.process(text).trim()
  }
}

/**
 * Removes all spaces from text.
 * @description Decorator removing all spaces.
 */
class RemoveSpacesDecorator extends TextDecorator {
  /**
   * Process text without spaces.
   * @description Removes all whitespace from text.
   * @param text - Input text to process
   * @returns Text with no spaces
   */
  process(text: string): string {
    return super.process(text).replace(/\s+/g, '')
  }
}

/**
 * Adds prefix to text.
 * @description Decorator adding prefix to text.
 */
class AddPrefixDecorator extends TextDecorator {
  /**
   * Initialize with processor and prefix.
   * @description Wraps processor with prefix.
   * @param processor - Text processor to decorate
   * @param prefix - Prefix string to add
   */
  constructor(
    processor: TextProcessor,
    private prefix: string
  ) {
    super(processor)
  }

  /**
   * Process text with prefix.
   * @description Prepends prefix to text.
   * @param text - Input text to process
   * @returns Text with prefix added
   */
  process(text: string): string {
    return this.prefix + super.process(text)
  }
}

/**
 * Adds suffix to text.
 * @description Decorator adding suffix to text.
 */
class AddSuffixDecorator extends TextDecorator {
  /**
   * Initialize with processor and suffix.
   * @description Wraps processor with suffix.
   * @param processor - Text processor to decorate
   * @param suffix - Suffix string to add
   */
  constructor(
    processor: TextProcessor,
    private suffix: string
  ) {
    super(processor)
  }

  /**
   * Process text with suffix.
   * @description Appends suffix to text.
   * @param text - Input text to process
   * @returns Text with suffix added
   */
  process(text: string): string {
    return super.process(text) + this.suffix
  }
}

/**
 * Usage - flexible text processing pipeline.
 * @description Demonstrates text processor decoration.
 */
let processor: TextProcessor = new BasicTextProcessor()

/**
 * Build processing chain with decorators.
 * @description Shows decorator pipeline composition.
 */
processor = new TrimDecorator(processor)
processor = new UpperCaseDecorator(processor)
processor = new AddPrefixDecorator(processor, '>>> ')
processor = new AddSuffixDecorator(processor, ' <<<')

/**
 * Test the decorated processor.
 * @description Executes text transformation pipeline.
 */
const input = '   hello world   '
const output = processor.process(input)
console.log(`"${input}" -> "${output}"`)

/**
 * Different pipeline for different needs.
 * @description Alternative text processing chain.
 */
const compactProcessor = new RemoveSpacesDecorator(
  new UpperCaseDecorator(new TrimDecorator(new BasicTextProcessor()))
)
const compactOutput = compactProcessor.process('  hello world  ')
console.log(`Compact: "${compactOutput}"`)
```

**Bad: Decorator that changes the interface**

```typescript
/**
 * Bad decorator breaking interface rules.
 * @description Warning: Decorators must maintain interface contract.
 */
class BadDecorator implements Coffee {
  /**
   * Initialize with coffee to wrap.
   * @description Wraps coffee for decoration.
   * @param coffee - Coffee instance to decorate
   */
  constructor(private coffee: Coffee) {}

  /** Get description from wrapped coffee */
  getDescription(): string {
    return this.coffee.getDescription()
  }

  /** Wrong new method not in interface */
  getTemperature(): number {
    return 85
  }

  /**
   * Wrong changed method signature.
   * @description Changes method signature wrongly.
   * @param withTax - Whether to include tax
   * @returns Cost with optional tax
   */
  getCost(withTax?: boolean): number {
    const baseCost = this.coffee.getCost()
    if (withTax) {
      return baseCost * 1.1
    }
    return baseCost
  }
}

/**
 * Better: Keep interface consistent.
 * @description Maintains interface contract properly.
 */
```

**Bad: Decorator with too many responsibilities**

```typescript
/**
 * Bad: Decorator with too many responsibilities.
 * @description Warning: Should use focused decorators instead.
 */
class MegaDecorator extends CoffeeDecorator {
  /** Gets description with many additions */
  getDescription(): string {
    let desc = this.coffee.getDescription()
    desc += ', milk, sugar, vanilla, caramel, whipped cream, cinnamon'
    return desc
  }

  /** Gets cost with many additions */
  getCost(): number {
    let cost = this.coffee.getCost()
    cost += 0.5
    cost += 0.25
    cost += 0.4
    cost += 0.6
    cost += 0.75
    cost += 0.15
    return cost
  }

  /** Brew the coffee */
  brew(): void {
    console.log('Brewing coffee...')
  }

  /** Serve the coffee */
  serve(): void {
    console.log('Serving coffee...')
  }
}

/**
 * Better: Use focused decorators and combine them.
 * @description Composes focused single-responsibility decorators.
 */
```

## Important Points

- **Same interface** as decorated object
- **Composition over inheritance** - wrap objects instead of subclassing
- **Flexible combinations** - stack decorators in any order
- **Runtime behavior changes** - add/remove decorators dynamically
- **Single responsibility** - each decorator adds one behavior
- **Transparent to client** - client works with interface, not concrete classes

### Decorator Factory Pattern

```typescript
/**
 * Factory for creating coffee drinks.
 * @description Creates decorated coffee by type.
 */
class CoffeeShop {
  /**
   * Create coffee by type.
   * @description Creates decorated coffee by type.
   * @param type - Coffee type to create
   * @returns New decorated coffee instance
   */
  static createCoffee(type: 'simple' | 'latte' | 'cappuccino' | 'mocha'): Coffee {
    let coffee: Coffee = new SimpleCoffee()
    switch (type) {
      case 'latte':
        coffee = new MilkDecorator(coffee)
        break
      case 'cappuccino':
        coffee = new MilkDecorator(coffee)
        coffee = new WhippedCreamDecorator(coffee)
        break
      case 'mocha':
        coffee = new MilkDecorator(coffee)
        coffee = new SugarDecorator(coffee)
        coffee = new VanillaDecorator(coffee)
        coffee = new WhippedCreamDecorator(coffee)
        break
      default:
        break
    }
    return coffee
  }
}

/**
 * Create latte coffee with milk.
 */
const latte = CoffeeShop.createCoffee('latte')

/**
 * Create mocha coffee with extras.
 */
const mocha = CoffeeShop.createCoffee('mocha')
```

### Decorator with State

```typescript
/**
 * Decorator counting description requests.
 * @description Tracks how many times description is called.
 */
class CountingDecorator extends CoffeeDecorator {
  /** Count of description requests */
  private count = 0

  /** Get description and increment count */
  getDescription(): string {
    this.count++
    console.log(`Description requested ${this.count} times`)
    return this.coffee.getDescription()
  }

  /** Get cost from wrapped coffee */
  getCost(): number {
    return this.coffee.getCost()
  }

  /** Get current request count */
  getCount(): number {
    return this.count
  }
}

/**
 * Test the counting decorator.
 * @description Demonstrates decorator counting functionality.
 */
const counter = new CountingDecorator(new SimpleCoffee())
counter.getDescription()
counter.getDescription()
console.log(`Total requests: ${counter.getCount()}`)
```

### Decorator vs Inheritance

```typescript
/**
 * Inheritance example: rigid approach.
 * @description Demonstrates inflexible inheritance pattern.
 */
class MilkSugarCoffee extends SimpleCoffee {
  /** Get description with milk and sugar */
  getDescription(): string {
    return `${super.getDescription()}, milk, sugar`
  }

  /** Get cost with additions */
  getCost(): number {
    return super.getCost() + 0.5 + 0.25
  }
}

/**
 * Decorator approach - flexible and composable.
 * @description Demonstrates decorator flexibility.
 */
const milkOnly = new MilkDecorator(new SimpleCoffee())
const sugarOnly = new SugarDecorator(new SimpleCoffee())
const milkAndSugar = new SugarDecorator(new MilkDecorator(new SimpleCoffee()))
```

## Summary

- Decorator pattern adds behavior to objects dynamically without subclassing
- Decorators implement the same interface as the objects they decorate
- Multiple decorators can be stacked in any order
- Promotes composition over inheritance
- Each decorator should have a single responsibility
- Essential for flexible, extensible object behavior enhancement

_The decorator pattern provides a flexible alternative to subclassing for extending functionality, allowing you to wrap objects with new behaviors dynamically and combine them in various ways._
