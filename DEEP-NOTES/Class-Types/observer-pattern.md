---
title: 'Observer Pattern'
source: 'https://refactoring.guru/design-patterns/observer/typescript/example'
description: 'Observer pattern defines subscription mechanism to notify multiple objects about events in another object.'
tags: ['typescript', 'observer-pattern', 'behavioral-pattern', 'events', 'publish-subscribe']
---

# Observer Pattern

## Overview

The Observer pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically. It's like a subscription service where objects can subscribe to receive updates when something interesting happens.

## Definition

An **observer pattern** consists of a subject (observable) that maintains a list of observers (subscribers) and notifies them of state changes. Observers register themselves with the subject and receive updates when the subject's state changes.

## The Analogy

Think of the observer pattern like a **magazine subscription**:

- The magazine publisher (subject) publishes issues
- Subscribers (observers) sign up to receive issues
- When a new issue is published, all subscribers automatically receive it
- Subscribers can unsubscribe at any time
- The publisher doesn't need to know who specifically receives each issue

## When You See It

Use observer pattern when:

- A change in one object requires changing others
- You don't know how many objects need to be changed
- An object should notify other objects without making assumptions about who they are
- You want loose coupling between objects that interact

Common scenarios:

- Event handling in UI frameworks
- Model-View-Controller (MVC) architectures
- Real-time data feeds and dashboards
- Notification systems (email, push, SMS)
- Stock price monitoring systems
- Chat applications and messaging

## Examples

**Good: Simple weather station**

```typescript
// Observer interface - defines contract for weather updates
interface WeatherObserver {
  update(temperature: number, humidity: number): void
}

// Subject (Observable) - manages weather data and notifies observers
class WeatherStation {
  private observers: WeatherObserver[] = []
  private temperature: number = 0
  private humidity: number = 0

  // Subscribe observer to receive weather updates
  public subscribe(observer: WeatherObserver): void {
    this.observers.push(observer)
    console.log(`Observer subscribed. Total observers: ${this.observers.length}`)
  }

  // Remove observer from weather updates
  public unsubscribe(observer: WeatherObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
      console.log(`Observer unsubscribed. Total observers: ${this.observers.length}`)
    }
  }

  // Update weather data and notify all observers
  public setMeasurements(temperature: number, humidity: number): void {
    this.temperature = temperature
    this.humidity = humidity
    this.notifyObservers()
  }

  // Notify all subscribed observers of weather changes
  private notifyObservers(): void {
    console.log('Notifying observers of weather changes...')
    this.observers.forEach(observer => {
      observer.update(this.temperature, this.humidity)
    })
  }
}

// Concrete observers - display specific weather information
class TemperatureDisplay implements WeatherObserver {
  update(temperature: number, humidity: number): void {
    console.log(`Temperature Display: Current temperature is ${temperature}°C`)
  }
}

class HumidityDisplay implements WeatherObserver {
  update(temperature: number, humidity: number): void {
    console.log(`Humidity Display: Current humidity is ${humidity}%`)
  }
}

class WeatherLogger implements WeatherObserver {
  update(temperature: number, humidity: number): void {
    const timestamp = new Date().toISOString()
    console.log(`Weather Logger [${timestamp}]: ${temperature}°C, ${humidity}%`)
  }
}

// Usage - subscribe observers and trigger weather updates
const weatherStation = new WeatherStation()

const tempDisplay = new TemperatureDisplay()
const humidityDisplay = new HumidityDisplay()
const logger = new WeatherLogger()

// Subscribe observers to receive weather updates
weatherStation.subscribe(tempDisplay)
weatherStation.subscribe(humidityDisplay)
weatherStation.subscribe(logger)

// Trigger weather changes and notify observers
weatherStation.setMeasurements(25, 60)
weatherStation.setMeasurements(27, 65)

// Unsubscribe one observer and continue
weatherStation.unsubscribe(humidityDisplay)
weatherStation.setMeasurements(23, 58)
```

**Good: Stock price monitoring**

```typescript
// Stock observer interface - defines contract for stock price updates
interface StockObserver {
  update(symbol: string, price: number, change: number): void
}

// Stock data interface
interface Stock {
  symbol: string
  price: number
}

// Stock market subject - manages stock data and notifies observers
class StockMarket {
  private observers: StockObserver[] = []
  private stocks: Map<string, Stock> = new Map()

  // Add observer to receive stock updates
  public addObserver(observer: StockObserver): void {
    this.observers.push(observer)
  }

  // Remove observer from stock updates
  public removeObserver(observer: StockObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  // Add new stock and notify observers if price changed
  public addStock(stock: Stock): void {
    const oldPrice = this.stocks.get(stock.symbol)?.price || stock.price
    this.stocks.set(stock.symbol, stock)

    if (oldPrice !== stock.price) {
      this.notifyObservers(stock.symbol, stock.price, stock.price - oldPrice)
    }
  }

  // Update existing stock price and notify observers
  public updatePrice(symbol: string, newPrice: number): void {
    const stock = this.stocks.get(symbol)
    if (stock) {
      const oldPrice = stock.price
      stock.price = newPrice
      this.notifyObservers(symbol, newPrice, newPrice - oldPrice)
    }
  }

  // Notify all observers of stock price changes
  private notifyObservers(symbol: string, price: number, change: number): void {
    this.observers.forEach(observer => {
      observer.update(symbol, price, change)
    })
  }
}

// Trader observer - reacts to stock price changes
class Trader implements StockObserver {
  constructor(private name: string) {}

  update(symbol: string, price: number, change: number): void {
    if (change > 0) {
      console.log(`${this.name}: ${symbol} went UP by $${change.toFixed(2)} to $${price}`)
    } else if (change < 0) {
      console.log(
        `${this.name}: ${symbol} went DOWN by $${Math.abs(change).toFixed(2)} to $${price}`
      )
    }
  }
}

// NewsAlert observer - sends alerts for significant stock movements
class NewsAlert implements StockObserver {
  update(symbol: string, price: number, change: number): void {
    if (Math.abs(change) > 5) {
      console.log(`BREAKING: ${symbol} significant movement! Price: $${price} (Change: $${change})`)
    }
  }
}

// PortfolioTracker observer - tracks portfolio value changes
class PortfolioTracker implements StockObserver {
  private holdings: Map<string, number> = new Map()

  // Add stock holding to portfolio
  addHolding(symbol: string, shares: number): void {
    this.holdings.set(symbol, shares)
  }

  update(symbol: string, price: number, change: number): void {
    const shares = this.holdings.get(symbol)
    if (shares) {
      const value = shares * price
      const changeValue = shares * change
      console.log(
        `Portfolio: ${symbol} - ${shares} shares worth $${value.toFixed(2)} (Change: $${changeValue.toFixed(2)})`
      )
    }
  }
}

// Usage - create stock market and observers
const market = new StockMarket()

const alice = new Trader('Alice')
const bob = new Trader('Bob')
const newsAlert = new NewsAlert()
const portfolio = new PortfolioTracker()

// Subscribe observers to stock market updates
market.addObserver(alice)
market.addObserver(bob)
market.addObserver(newsAlert)
market.addObserver(portfolio)

// Add portfolio holding
portfolio.addHolding('GOOGL', 50)

market.addStock({ symbol: 'AAPL', price: 150 })
market.updatePrice('AAPL', 155)
market.updatePrice('GOOGL', 2800)
```

**Good: Event-driven user interface**

```typescript
// UI event interface - defines structure for UI events
interface UIEvent {
  type: string
  data?: any
}

// UI observer interface - defines contract for event handlers
interface UIObserver {
  onEvent(event: UIEvent): void
}

// Base UI component - manages observers and emits events
class UIComponent {
  private observers: UIObserver[] = []

  // Add observer to receive UI events
  public addObserver(observer: UIObserver): void {
    this.observers.push(observer)
  }

  // Remove observer from UI events
  public removeObserver(observer: UIObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  // Emit event to all observers
  protected emit(event: UIEvent): void {
    this.observers.forEach(observer => {
      observer.onEvent(event)
    })
  }
}

// Button component - emits click and text change events
class Button extends UIComponent {
  private text: string

  constructor(text: string) {
    super()
    this.text = text
  }

  // Simulate button click and emit click event
  public click(): void {
    console.log(`Button "${this.text}" clicked`)
    this.emit({ type: 'click', data: { button: this.text } })
  }

  // Change button text and emit text change event
  public setText(text: string): void {
    const oldText = this.text
    this.text = text
    this.emit({ type: 'textChanged', data: { oldText, newText: text } })
  }
}

// Input component - emits value change and focus events
class Input extends UIComponent {
  private value: string = ''

  // Set input value and emit value change event
  public setValue(value: string): void {
    const oldValue = this.value
    this.value = value
    this.emit({ type: 'valueChanged', data: { oldValue, newValue: value } })
  }

  // Get current input value
  public getValue(): string {
    return this.value
  }

  // Simulate input focus and emit focus event
  public focus(): void {
    console.log('Input field focused')
    this.emit({ type: 'focus' })
  }

  // Simulate input blur and emit blur event
  public blur(): void {
    console.log('Input field blurred')
    this.emit({ type: 'blur' })
  }
}

// FormValidator observer - validates form fields and shows errors
class FormValidator implements UIObserver {
  private errors: string[] = []

  onEvent(event: UIEvent): void {
    switch (event.type) {
      case 'valueChanged':
        this.validateField(event.data)
        break
      case 'blur':
        this.showValidationErrors()
        break
    }
  }

  // Validate field data and store errors
  private validateField(data: { oldValue: string; newValue: string }): void {
    this.errors = []
    if (data.newValue.length < 3) {
      this.errors.push('Field must be at least 3 characters')
    }
  }

  // Display validation errors if any exist
  private showValidationErrors(): void {
    if (this.errors.length > 0) {
      console.log('Validation errors:', this.errors.join(', '))
    }
  }
}

// AnalyticsTracker observer - tracks UI events for analytics
class AnalyticsTracker implements UIObserver {
  onEvent(event: UIEvent): void {
    console.log(`Analytics: Event "${event.type}" tracked`, event.data || '')
  }
}

// Usage - create UI components and observers
const button = new Button('Submit')
const input = new Input()
const validator = new FormValidator()
const analytics = new AnalyticsTracker()

// Subscribe observers to components
button.addObserver(analytics)
input.addObserver(validator)
input.addObserver(analytics)

// Trigger UI events
button.click()
input.setValue('ab')
input.blur()
input.setValue('valid input')
input.blur()
```

**Bad: Observer with too much responsibility**

```typescript
// Wrong: Observer doing too much in update method
class BadObserver implements WeatherObserver {
  update(temperature: number, humidity: number): void {
    // Too many responsibilities in one observer
    console.log(`Temperature: ${temperature}`)
    console.log(`Humidity: ${humidity}`)

    // Business logic
    if (temperature > 30) {
      console.log('Turn on AC')
    }

    // Data persistence
    this.saveToDatabase(temperature, humidity)

    // Network calls
    this.sendToAPI(temperature, humidity)

    // UI updates
    this.updateDisplay(temperature, humidity)
  }

  private saveToDatabase(temp: number, humidity: number): void {
    // Database logic
  }

  private sendToAPI(temp: number, humidity: number): void {
    // API logic
  }

  private updateDisplay(temp: number, humidity: number): void {
    // UI logic
  }
}

// Better: Split into focused observers
```

## Important Points

- **Loose coupling** between subject and observers
- **Dynamic relationships** - observers can subscribe/unsubscribe at runtime
- **Broadcast communication** - one-to-many notification
- **Potential performance issues** with many observers
- **Memory leaks** if observers don't unsubscribe
- **Complex event chains** can be hard to debug

### Generic Observer Implementation

```typescript
// Generic Observer interface - works with any data type
interface Observer<T> {
  update(data: T): void
}

// Generic Subject interface - defines contract for observable objects
interface Subject<T> {
  subscribe(observer: Observer<T>): void
  unsubscribe(observer: Observer<T>): void
  notify(data: T): void
}

// EventEmitter - generic implementation of Subject pattern
class EventEmitter<T> implements Subject<T> {
  private observers: Observer<T>[] = []

  // Add observer to receive notifications
  subscribe(observer: Observer<T>): void {
    this.observers.push(observer)
  }

  // Remove observer from notifications
  unsubscribe(observer: Observer<T>): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  // Notify all observers with data
  notify(data: T): void {
    this.observers.forEach(observer => {
      observer.update(data)
    })
  }

  // Get current number of observers
  getObserverCount(): number {
    return this.observers.length
  }
}

// Usage with typed events
type UserEvent =
  | { type: 'login'; userId: string }
  | { type: 'logout'; userId: string }
  | { type: 'update'; userId: string; changes: any }

// UserEventEmitter - typed event emitter for user events
class UserEventEmitter extends EventEmitter<UserEvent> {}

// UserAnalytics - observer that tracks user events
class UserAnalytics implements Observer<UserEvent> {
  update(event: UserEvent): void {
    console.log(`Analytics: User ${event.type}`, event)
  }
}
```

### Observer with Weak References

```typescript
// WeakEventEmitter - prevents memory leaks with weak references
class WeakEventEmitter<T> implements Subject<T> {
  private observers: Set<WeakRef<Observer<T>>> = new Set()
  private finalizationRegistry: FinalizationRegistry<Observer<T>>

  constructor() {
    // Auto-cleanup when observers are garbage collected
    this.finalizationRegistry = new FinalizationRegistry(weakRef => {
      this.observers.delete(weakRef)
    })
  }

  subscribe(observer: Observer<T>): void {
    const weakRef = new WeakRef(observer)
    this.observers.add(weakRef)
    this.finalizationRegistry.register(observer, weakRef)
  }

  unsubscribe(observer: Observer<T>): void {
    // Find and remove the weak reference
    for (const weakRef of this.observers) {
      const obs = weakRef.deref()
      if (obs === observer) {
        this.observers.delete(weakRef)
        this.finalizationRegistry.unregister(observer)
        break
      }
    }
  }

  notify(data: T): void {
    // Clean up garbage collected observers
    for (const weakRef of this.observers) {
      if (!weakRef.deref()) {
        this.observers.delete(weakRef)
      }
    }

    // Notify remaining observers
    this.observers.forEach(weakRef => {
      const observer = weakRef.deref()
      if (observer) {
        observer.update(data)
      }
    })
  }
}
```

### Observer vs Event Emitters

```typescript
// Observer pattern - class-based approach
class WeatherStation {
  private observers: WeatherObserver[] = []

  subscribe(observer: WeatherObserver): void {
    this.observers.push(observer)
  }

  notify(data: WeatherData): void {
    this.observers.forEach(obs => obs.update(data))
  }
}

// Event emitter approach - method-based event handling
class WeatherEvents {
  private listeners: Map<string, Function[]> = new Map()

  // Register event listener
  on(event: string, callback: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, [])
    }
    this.listeners.get(event)!.push(callback)
  }

  // Trigger event to all listeners
  emit(event: string, data: any): void {
    const callbacks = this.listeners.get(event) || []
    callbacks.forEach(callback => callback(data))
  }
}
```

## Summary

- Observer pattern enables one-to-many dependency between objects
- Subjects notify observers automatically when state changes
- Promotes loose coupling and dynamic relationships
- Common in event systems, MVC patterns, and real-time applications
- Can cause performance and memory management issues
- Essential for building responsive, event-driven applications

_The observer pattern is fundamental for building systems where objects need to react to changes in other objects without tight coupling, making it essential for modern event-driven architectures._
