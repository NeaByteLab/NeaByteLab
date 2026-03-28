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
// Coffee interface - defines contract for all coffee types
interface Coffee {
  getDescription(): string
  getCost(): number
}

// Concrete component - basic coffee without any extras
class SimpleCoffee implements Coffee {
  getDescription(): string {
    return 'Simple coffee'
  }

  getCost(): number {
    return 2.0
  }
}

// Base decorator - implements Coffee interface and wraps another Coffee
abstract class CoffeeDecorator implements Coffee {
  constructor(protected coffee: Coffee) {}

  // Delegate to wrapped coffee by default
  getDescription(): string {
    return this.coffee.getDescription()
  }

  // Delegate to wrapped coffee by default
  getCost(): number {
    return this.coffee.getCost()
  }
}

// Concrete decorators - add specific coffee extras

class MilkDecorator extends CoffeeDecorator {
  getDescription(): string {
    return `${this.coffee.getDescription()}, milk`
  }

  getCost(): number {
    return this.coffee.getCost() + 0.5
  }
}

class SugarDecorator extends CoffeeDecorator {
  getDescription(): string {
    return `${this.coffee.getDescription()}, sugar`
  }

  getCost(): number {
    return this.coffee.getCost() + 0.25
  }
}

class WhippedCreamDecorator extends CoffeeDecorator {
  getDescription(): string {
    return `${this.coffee.getDescription()}, whipped cream`
  }

  getCost(): number {
    return this.coffee.getCost() + 0.75
  }
}

class VanillaDecorator extends CoffeeDecorator {
  getDescription(): string {
    return `${this.coffee.getDescription()}, vanilla`
  }

  getCost(): number {
    return this.coffee.getCost() + 0.4
  }
}

// Usage - flexible combinations of decorators
let coffee: Coffee = new SimpleCoffee()
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)
// Simple coffee: $2.00

coffee = new MilkDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)
// Simple coffee, milk: $2.50

coffee = new SugarDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)
// Simple coffee, milk, sugar: $2.75

coffee = new WhippedCreamDecorator(coffee)
console.log(`${coffee.getDescription()}: $${coffee.getCost().toFixed(2)}`)
// Simple coffee, milk, sugar, whipped cream: $3.50

// Different combinations of decorators
const espressoWithVanilla = new VanillaDecorator(new SimpleCoffee())
const deluxeCoffee = new WhippedCreamDecorator(
  new MilkDecorator(new SugarDecorator(new VanillaDecorator(new SimpleCoffee())))
)
```

**Good: Web request decorators**

```typescript
// RequestHandler interface - defines contract for request processing
interface RequestHandler {
  handle(request: any): any
}

// BaseRequestHandler - basic request processing
class BaseRequestHandler implements RequestHandler {
  handle(request: any): any {
    console.log('Processing base request')
    return { status: 'success', data: request }
  }
}

// BaseRequestDecorator - wraps other handlers
abstract class RequestDecorator implements RequestHandler {
  constructor(protected handler: RequestHandler) {}

  handle(request: any): any {
    return this.handler.handle(request)
  }
}

// Concrete decorators - add middleware functionality
class AuthenticationDecorator extends RequestDecorator {
  constructor(
    handler: RequestHandler,
    private apiKey: string
  ) {
    super(handler)
  }

  handle(request: any): any {
    console.log('Checking authentication...')
    if (!request.headers || request.headers['api-key'] !== this.apiKey) {
      return { status: 'error', message: 'Unauthorized' }
    }
    console.log('Authentication successful')
    return super.handle(request)
  }
}

// LoggingDecorator - logs request and response with timestamps
class LoggingDecorator extends RequestDecorator {
  constructor(handler: RequestHandler) {
    super(handler)
  }

  handle(request: any): any {
    const timestamp = new Date().toISOString()
    console.log(`[${timestamp}] Incoming request:`, JSON.stringify(request))

    const response = super.handle(request)

    console.log(`[${timestamp}] Response:`, JSON.stringify(response))
    return response
  }
}

// CacheDecorator - caches responses to avoid repeated processing
class CacheDecorator extends RequestDecorator {
  private cache = new Map<string, any>()

  constructor(handler: RequestHandler) {
    super(handler)
  }

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

// ValidationDecorator - validates request data before processing
class ValidationDecorator extends RequestDecorator {
  constructor(
    handler: RequestHandler,
    private schema: any
  ) {
    super(handler)
  }

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

// Usage - flexible middleware chain with decorators
let handler: RequestHandler = new BaseRequestHandler()

// Add decorators in any order to build middleware chain
handler = new AuthenticationDecorator(handler, 'secret-api-key')
handler = new LoggingDecorator(handler)
handler = new ValidationDecorator(handler, { userId: 'string' })
handler = new CacheDecorator(handler)

// Test the decorated handler
const request = {
  headers: { 'api-key': 'secret-api-key' },
  body: { userId: '123', action: 'getData' }
}

const response = handler.handle(request)
console.log('Final response:', response)
```

**Good: Text processing decorators**

```typescript
// TextProcessor interface - defines contract for text processing
interface TextProcessor {
  process(text: string): string
}

// BasicTextProcessor - simplest text processor (returns text unchanged)
class BasicTextProcessor implements TextProcessor {
  process(text: string): string {
    return text
  }
}

// TextDecorator - base decorator for text processing
abstract class TextDecorator implements TextProcessor {
  constructor(protected processor: TextProcessor) {}

  process(text: string): string {
    return this.processor.process(text)
  }
}

// Concrete decorators - add specific text transformations

class UpperCaseDecorator extends TextDecorator {
  process(text: string): string {
    return super.process(text).toUpperCase()
  }
}

class TrimDecorator extends TextDecorator {
  process(text: string): string {
    return super.process(text).trim()
  }
}

class RemoveSpacesDecorator extends TextDecorator {
  process(text: string): string {
    return super.process(text).replace(/\s+/g, '')
  }
}

class AddPrefixDecorator extends TextDecorator {
  constructor(
    processor: TextProcessor,
    private prefix: string
  ) {
    super(processor)
  }

  process(text: string): string {
    return this.prefix + super.process(text)
  }
}

class AddSuffixDecorator extends TextDecorator {
  constructor(
    processor: TextProcessor,
    private suffix: string
  ) {
    super(processor)
  }

  process(text: string): string {
    return super.process(text) + this.suffix
  }
}

// Usage - flexible text processing pipeline
let processor: TextProcessor = new BasicTextProcessor()

// Build processing chain with decorators
processor = new TrimDecorator(processor)
processor = new UpperCaseDecorator(processor)
processor = new AddPrefixDecorator(processor, '>>> ')
processor = new AddSuffixDecorator(processor, ' <<<')

// Test the decorated processor
const input = '   hello world   '
const output = processor.process(input)
console.log(`"${input}" -> "${output}"`)
// "   hello world   " -> ">>> HELLO WORLD <<<"

// Different pipeline for different needs
const compactProcessor = new RemoveSpacesDecorator(
  new UpperCaseDecorator(new TrimDecorator(new BasicTextProcessor()))
)

const compactOutput = compactProcessor.process('  hello world  ')
console.log(`Compact: "${compactOutput}"`)
// Compact: "HELLOWORLD"
```

**Bad: Decorator that changes the interface**

```typescript
// Wrong: Decorator should implement the same interface
class BadDecorator implements Coffee {
  constructor(private coffee: Coffee) {}

  getDescription(): string {
    return this.coffee.getDescription()
  }

  // Wrong: Adding new method not in interface
  getTemperature(): number {
    return 85
  }

  // Wrong: Changing method signature
  getCost(withTax?: boolean): number {
    const baseCost = this.coffee.getCost()
    if (withTax) {
      return baseCost * 1.1
    }
    return baseCost
  }
}

// Better: Keep interface consistent
```

**Bad: Decorator with too many responsibilities**

```typescript
// Wrong: One decorator doing multiple unrelated things
class MegaDecorator extends CoffeeDecorator {
  getDescription(): string {
    let desc = this.coffee.getDescription()

    // Too many responsibilities
    desc += ', milk, sugar, vanilla, caramel, whipped cream, cinnamon'
    return desc
  }

  getCost(): number {
    let cost = this.coffee.getCost()

    // Calculating many different things
    cost += 0.5 // milk
    cost += 0.25 // sugar
    cost += 0.4 // vanilla
    cost += 0.6 // caramel
    cost += 0.75 // whipped cream
    cost += 0.15 // cinnamon

    return cost
  }

  // Wrong: Adding unrelated behavior
  brew(): void {
    console.log('Brewing coffee...')
  }

  serve(): void {
    console.log('Serving coffee...')
  }
}

// Better: Use focused decorators and combine them
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
class CoffeeShop {
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

const latte = CoffeeShop.createCoffee('latte')
const mocha = CoffeeShop.createCoffee('mocha')
```

### Decorator with State

```typescript
class CountingDecorator extends CoffeeDecorator {
  private count = 0

  getDescription(): string {
    this.count++
    console.log(`Description requested ${this.count} times`)
    return this.coffee.getDescription()
  }

  getCost(): number {
    return this.coffee.getCost()
  }

  getCount(): number {
    return this.count
  }
}

// Test the counting decorator
const counter = new CountingDecorator(new SimpleCoffee())
counter.getDescription()
counter.getDescription()
console.log(`Total requests: ${counter.getCount()}`)
```

### Decorator vs Inheritance

```typescript
// Inheritance approach - rigid and inflexible
class MilkSugarCoffee extends SimpleCoffee {
  getDescription(): string {
    return `${super.getDescription()}, milk, sugar`
  }

  getCost(): number {
    return super.getCost() + 0.5 + 0.25
  }
}

// Can't easily add milk without sugar, or sugar without milk
// Need new class for every combination

// Decorator approach - flexible and composable
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
