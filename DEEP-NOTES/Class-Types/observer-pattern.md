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
/**
 * Weather observer interface.
 * @description Contract for weather updates.
 */
interface WeatherObserver {
  /**
   * Update with weather data.
   * @description Receives weather update notification.
   * @param temperature - Current temperature value
   * @param humidity - Current humidity percentage
   */
  update(temperature: number, humidity: number): void
}

/**
 * Weather station subject.
 * @description Manages data and notifies observers.
 */
class WeatherStation {
  /** List of registered observers */
  private observers: WeatherObserver[] = []
  /** Current temperature value */
  private temperature: number = 0
  /** Current humidity percentage */
  private humidity: number = 0

  /**
   * Subscribe observer for updates.
   * @description Registers observer for notifications.
   * @param observer - Observer to register
   */
  public subscribe(observer: WeatherObserver): void {
    this.observers.push(observer)
    console.log(`Observer subscribed. Total observers: ${this.observers.length}`)
  }

  /**
   * Unsubscribe observer from updates.
   * @description Removes observer from list.
   * @param observer - Observer to remove
   */
  public unsubscribe(observer: WeatherObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
      console.log(`Observer unsubscribed. Total observers: ${this.observers.length}`)
    }
  }

  /**
   * Update measurements and notify.
   * @description Sets measurements and notifies.
   * @param temperature - New temperature value
   * @param humidity - New humidity percentage
   */
  public setMeasurements(temperature: number, humidity: number): void {
    this.temperature = temperature
    this.humidity = humidity
    this.notifyObservers()
  }

  /** Notify all observers of changes */
  private notifyObservers(): void {
    console.log('Notifying observers of weather changes...')
    this.observers.forEach(observer => {
      observer.update(this.temperature, this.humidity)
    })
  }
}

/**
 * Displays temperature information.
 * @description Shows temperature on display.
 */
class TemperatureDisplay implements WeatherObserver {
  /**
   * Update and display temperature.
   * @description Displays current temperature.
   * @param temperature - Current temperature value
   * @param humidity - Current humidity percentage
   */
  update(temperature: number, humidity: number): void {
    console.log(`Temperature Display: Current temperature is ${temperature}°C`)
  }
}

/**
 * Displays humidity information.
 * @description Shows humidity on display.
 */
class HumidityDisplay implements WeatherObserver {
  /**
   * Update and display humidity.
   * @description Displays current humidity.
   * @param temperature - Current temperature value
   * @param humidity - Current humidity percentage
   */
  update(temperature: number, humidity: number): void {
    console.log(`Humidity Display: Current humidity is ${humidity}%`)
  }
}

/**
 * Logs weather data with timestamps.
 * @description Logs weather with timestamps.
 */
class WeatherLogger implements WeatherObserver {
  /**
   * Log weather with timestamp.
   * @description Logs weather data with time.
   * @param temperature - Current temperature value
   * @param humidity - Current humidity percentage
   */
  update(temperature: number, humidity: number): void {
    const timestamp = new Date().toISOString()
    console.log(`Weather Logger [${timestamp}]: ${temperature}°C, ${humidity}%`)
  }
}

/**
 * Usage - subscribe observers and trigger weather updates.
 * @description Demonstrates observer subscription pattern.
 */
const weatherStation = new WeatherStation()
const tempDisplay = new TemperatureDisplay()
const humidityDisplay = new HumidityDisplay()
const logger = new WeatherLogger()

/**
 * Subscribe observers to receive weather updates.
 * @description Registers observers with subject.
 */
weatherStation.subscribe(tempDisplay)
weatherStation.subscribe(humidityDisplay)
weatherStation.subscribe(logger)

/**
 * Trigger weather changes and notify observers.
 * @description Updates subject state and notifies.
 */
weatherStation.setMeasurements(25, 60)
weatherStation.setMeasurements(27, 65)

/**
 * Unsubscribe one observer and continue.
 * @description Removes observer from notifications.
 */
weatherStation.unsubscribe(humidityDisplay)
weatherStation.setMeasurements(23, 58)
```

**Good: Stock price monitoring**

```typescript
/**
 * Stock observer interface.
 * @description Contract for stock price updates.
 */
interface StockObserver {
  /**
   * Update with stock data.
   * @description Receives stock price update.
   * @param symbol - Stock ticker symbol
   * @param price - Current stock price
   * @param change - Price change amount
   */
  update(symbol: string, price: number, change: number): void
}

/**
 * Stock data interface.
 * @description Stock information structure.
 */
interface Stock {
  /** Stock ticker symbol */
  symbol: string
  /** Current stock price */
  price: number
}

/**
 * Stock market subject.
 * @description Manages stocks and notifies observers.
 */
class StockMarket {
  /** List of stock observers */
  private observers: StockObserver[] = []
  /** Map of stock data by symbol */
  private stocks: Map<string, Stock> = new Map()

  /**
   * Add observer for updates.
   * @description Registers observer for notifications.
   * @param observer - Observer to register
   */
  public addObserver(observer: StockObserver): void {
    this.observers.push(observer)
  }

  /**
   * Remove observer from updates.
   * @description Removes observer from list.
   * @param observer - Observer to remove
   */
  public removeObserver(observer: StockObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  /**
   * Add stock and notify observers.
   * @description Adds stock and notifies observers.
   * @param stock - Stock data to add
   */
  public addStock(stock: Stock): void {
    const oldPrice = this.stocks.get(stock.symbol)?.price || stock.price
    this.stocks.set(stock.symbol, stock)

    if (oldPrice !== stock.price) {
      this.notifyObservers(stock.symbol, stock.price, stock.price - oldPrice)
    }
  }

  /**
   * Update stock price and notify.
   * @description Updates price and notifies observers.
   * @param symbol - Stock ticker symbol
   * @param newPrice - New stock price
   */
  public updatePrice(symbol: string, newPrice: number): void {
    const stock = this.stocks.get(symbol)
    if (stock) {
      const oldPrice = stock.price
      stock.price = newPrice
      this.notifyObservers(symbol, newPrice, newPrice - oldPrice)
    }
  }

  /**
   * Notify observers of price change.
   * @description Sends price update to observers.
   * @param symbol - Stock ticker symbol
   * @param price - Current stock price
   * @param change - Price change amount
   */
  private notifyObservers(symbol: string, price: number, change: number): void {
    this.observers.forEach(observer => {
      observer.update(symbol, price, change)
    })
  }
}

/**
 * Trader reacting to price changes.
 * @description Reacts to stock price changes.
 */
class Trader implements StockObserver {
  /**
   * Initialize with trader name.
   * @description Creates trader with name.
   * @param name - Trader identifier name
   */
  constructor(private name: string) {}

  /**
   * React to stock price change.
   * @description Reacts to price changes.
   * @param symbol - Stock ticker symbol
   * @param price - Current stock price
   * @param change - Price change amount
   */
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

/**
 * Sends alerts for big movements.
 * @description Sends alerts on big movements.
 */
class NewsAlert implements StockObserver {
  /**
   * Alert on significant movement.
   * @description Alerts when price moves significantly.
   * @param symbol - Stock ticker symbol
   * @param price - Current stock price
   * @param change - Price change amount
   */
  update(symbol: string, price: number, change: number): void {
    if (Math.abs(change) > 5) {
      console.log(`BREAKING: ${symbol} significant movement! Price: $${price} (Change: $${change})`)
    }
  }
}

/**
 * Tracks portfolio value changes.
 * @description Tracks portfolio value changes.
 */
class PortfolioTracker implements StockObserver {
  /** Stock holdings map */
  private holdings: Map<string, number> = new Map()

  /**
   * Add stock to portfolio.
   * @description Adds shares to holdings.
   * @param symbol - Stock ticker symbol
   * @param shares - Number of shares
   */
  addHolding(symbol: string, shares: number): void {
    this.holdings.set(symbol, shares)
  }

  /**
   * Update portfolio with price change.
   * @description Updates portfolio value display.
   * @param symbol - Stock ticker symbol
   * @param price - Current stock price
   * @param change - Price change amount
   */
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

/**
 * Usage - create stock market and observers.
 * @description Demonstrates stock market observer pattern.
 */
const market = new StockMarket()
const alice = new Trader('Alice')
const bob = new Trader('Bob')
const newsAlert = new NewsAlert()
const portfolio = new PortfolioTracker()

/**
 * Subscribe observers to stock market updates.
 * @description Registers multiple observers.
 */
market.addObserver(alice)
market.addObserver(bob)
market.addObserver(newsAlert)
market.addObserver(portfolio)

/**
 * Add portfolio holding.
 * @description Sets up portfolio tracking.
 */
portfolio.addHolding('GOOGL', 50)
market.addStock({ symbol: 'AAPL', price: 150 })
market.updatePrice('AAPL', 155)
market.updatePrice('GOOGL', 2800)
```

**Good: Event-driven user interface**

```typescript
/**
 * UI event interface.
 * @description Structure for UI events.
 */
interface UIEvent {
  /** Event type identifier */
  type: string
  /** Optional event data */
  data?: any
}

/**
 * UI observer interface.
 * @description Contract for event handlers.
 */
interface UIObserver {
  /**
   * Handle UI event.
   * @description Processes UI event from component.
   * @param event - UI event to handle
   */
  onEvent(event: UIEvent): void
}

/**
 * Base UI component.
 * @description Manages observers and emits events.
 */
class UIComponent {
  /** List of UI observers */
  private observers: UIObserver[] = []

  /**
   * Add observer for events.
   * @description Adds observer for events.
   * @param observer - Observer to register
   */
  public addObserver(observer: UIObserver): void {
    this.observers.push(observer)
  }

  /**
   * Remove observer from events.
   * @description Removes observer from events.
   * @param observer - Observer to remove
   */
  public removeObserver(observer: UIObserver): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  /**
   * Emit event to observers.
   * @description Emits event to observers.
   * @param event - UI event to emit
   */
  protected emit(event: UIEvent): void {
    this.observers.forEach(observer => {
      observer.onEvent(event)
    })
  }
}

/**
 * Button UI component.
 * @description Emits click and change events.
 */
class Button extends UIComponent {
  /** Button display text */
  private text: string

  /**
   * Initialize with button text.
   * @description Creates button with text.
   * @param text - Button label text
   */
  constructor(text: string) {
    super()
    this.text = text
  }

  /**
   * Simulate button click.
   * @description Simulates button click event.
   */
  public click(): void {
    console.log(`Button "${this.text}" clicked`)
    this.emit({ type: 'click', data: { button: this.text } })
  }

  /**
   * Change button text.
   * @description Changes button text.
   * @param text - New button text
   */
  public setText(text: string): void {
    const oldText = this.text
    this.text = text
    this.emit({ type: 'textChanged', data: { oldText, newText: text } })
  }
}

/**
 * Input UI component.
 * @description Emits value and focus events.
 */
class Input extends UIComponent {
  /** Current input value */
  private value: string = ''

  /**
   * Set input value.
   * @description Sets input value.
   * @param value - New input value
   */
  public setValue(value: string): void {
    const oldValue = this.value
    this.value = value
    this.emit({ type: 'valueChanged', data: { oldValue, newValue: value } })
  }

  /**
   * Get current input value.
   * @description Returns current input value.
   * @returns Current input value
   */
  public getValue(): string {
    return this.value
  }

  /**
   * Simulate input focus.
   * @description Simulates input focus.
   */
  public focus(): void {
    console.log('Input field focused')
    this.emit({ type: 'focus' })
  }

  /**
   * Simulate input blur.
   * @description Simulates input blur.
   */
  public blur(): void {
    console.log('Input field blurred')
    this.emit({ type: 'blur' })
  }
}

/**
 * Validates form fields.
 * @description Shows validation errors.
 */
class FormValidator implements UIObserver {
  /** Validation error messages */
  private errors: string[] = []

  /**
   * Handle UI event.
   * @description Processes UI event from component.
   * @param event - UI event to handle
   */
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

  /**
   * Validate field data.
   * @description Validates input field changes.
   * @param data - Field old and new values
   */
  private validateField(data: { oldValue: string; newValue: string }): void {
    this.errors = []
    if (data.newValue.length < 3) {
      this.errors.push('Field must be at least 3 characters')
    }
  }

  /** Display validation errors */
  private showValidationErrors(): void {
    if (this.errors.length > 0) {
      console.log('Validation errors:', this.errors.join(', '))
    }
  }
}

/**
 * Tracks UI events.
 * @description Analytics tracking observer.
 */
class AnalyticsTracker implements UIObserver {
  /**
   * Track UI event.
   * @description Processes and logs UI event.
   * @param event - UI event to track
   */
  onEvent(event: UIEvent): void {
    console.log(`Analytics: Event "${event.type}" tracked`, event.data || '')
  }
}

/**
 * Usage - create UI components and observers.
 * @description Demonstrates UI event observer pattern.
 */
const button = new Button('Submit')
const input = new Input()
const validator = new FormValidator()
const analytics = new AnalyticsTracker()

/**
 * Subscribe observers to components.
 * @description Registers event observers.
 */
button.addObserver(analytics)
input.addObserver(validator)
input.addObserver(analytics)

/**
 * Trigger UI events.
 * @description Simulates user interactions.
 */
button.click()
input.setValue('ab')
input.blur()
input.setValue('valid input')
input.blur()
```

**Bad: Observer with too much responsibility**

```typescript
/**
 * Bad observer with too much responsibility.
 * @description Should be split into separate observers.
 */
class BadObserver implements WeatherObserver {
  /**
   * Update doing too many things
   * @param temperature - Current temperature value
   * @param humidity - Current humidity percentage
   */
  update(temperature: number, humidity: number): void {
    console.log(`Temperature: ${temperature}`)
    console.log(`Humidity: ${humidity}`)
    if (temperature > 30) {
      console.log('Turn on AC')
    }
    this.saveToDatabase(temperature, humidity)
    this.sendToAPI(temperature, humidity)
    this.updateDisplay(temperature, humidity)
  }

  /**
   * Save weather data to database.
   * @description Persists temperature and humidity records.
   * @param temp - Temperature value in celsius
   * @param humidity - Humidity percentage value
   */
  private saveToDatabase(temp: number, humidity: number): void {}

  /**
   * Send data to external API.
   * @description Transmits weather metrics to service.
   * @param temp - Temperature value in celsius
   * @param humidity - Humidity percentage value
   */
  private sendToAPI(temp: number, humidity: number): void {}

  /**
   * Update display with new data.
   * @description Refreshes UI with current metrics.
   * @param temp - Temperature value in celsius
   * @param humidity - Humidity percentage value
   */
  private updateDisplay(temp: number, humidity: number): void {}
}

/**
 * Better: Split into focused observers.
 * @description Separates concerns into multiple observers.
 */
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
/**
 * Generic observer interface.
 * @description Works with any data type.
 * @template T - Data type for updates
 */
interface Observer<T> {
  /**
   * Update with generic data.
   * @description Receives update notification from subject.
   * @param data - Update data payload
   */
  update(data: T): void
}

/**
 * Generic subject interface.
 * @description Contract for observables.
 * @template T - Data type for notifications
 */
interface Subject<T> {
  /**
   * Subscribe observer.
   * @description Registers observer for notifications.
   * @param observer - Observer to register
   */
  subscribe(observer: Observer<T>): void
  /**
   * Unsubscribe observer.
   * @description Removes observer from notifications.
   * @param observer - Observer to remove
   */
  unsubscribe(observer: Observer<T>): void
  /**
   * Notify all observers.
   * @description Sends data to all observers.
   * @param data - Data to send observers
   */
  notify(data: T): void
}

/**
 * Generic event emitter.
 * @description Implements subject pattern.
 * @template T - Event data type
 */
class EventEmitter<T> implements Subject<T> {
  /** List of observers */
  private observers: Observer<T>[] = []

  /**
   * Subscribe observer.
   * @description Registers observer for notifications.
   * @param observer - Observer to register
   */
  subscribe(observer: Observer<T>): void {
    this.observers.push(observer)
  }

  /**
   * Unsubscribe observer.
   * @description Removes observer from notifications.
   * @param observer - Observer to remove
   */
  unsubscribe(observer: Observer<T>): void {
    const index = this.observers.indexOf(observer)
    if (index !== -1) {
      this.observers.splice(index, 1)
    }
  }

  /**
   * Notify all observers.
   * @description Sends data to all observers.
   * @param data - Data to send observers
   */
  notify(data: T): void {
    this.observers.forEach(observer => {
      observer.update(data)
    })
  }

  /**
   * Get observer count.
   * @description Returns number of observers.
   * @returns Number of observers
   */
  getObserverCount(): number {
    return this.observers.length
  }
}

/**
 * Usage with typed events.
 * @description Demonstrates typed event union.
 */
type UserEvent =
  | { type: 'login'; userId: string }
  | { type: 'logout'; userId: string }
  | { type: 'update'; userId: string; changes: any }

/**
 * Typed event emitter.
 * @description Emits user events.
 */
class UserEventEmitter extends EventEmitter<UserEvent> {}

/**
 * Tracks user events.
 * @description Analytics observer for users.
 */
class UserAnalytics implements Observer<UserEvent> {
  /**
   * Track user event
   * @param event - User event to track
   */
  update(event: UserEvent): void {
    console.log(`Analytics: User ${event.type}`, event)
  }
}
```

### Observer with Weak References

```typescript
/**
 * Weak reference event emitter.
 * @description Prevents memory leaks.
 * @template T - Event data type
 */
class WeakEventEmitter<T> implements Subject<T> {
  /** Weak references to observers */
  private observers: Set<WeakRef<Observer<T>>> = new Set()
  /** Registry for cleanup */
  private finalizationRegistry: FinalizationRegistry<Observer<T>>

  /**
   * Initialize with auto-cleanup
   * @description Cleanup when observers are garbage collected
   */
  constructor() {
    this.finalizationRegistry = new FinalizationRegistry(weakRef => {
      this.observers.delete(weakRef)
    })
  }

  /**
   * Subscribe with weak reference.
   * @description Registers observer with weak reference.
   * @param observer - Observer to register
   */
  subscribe(observer: Observer<T>): void {
    const weakRef = new WeakRef(observer)
    this.observers.add(weakRef)
    this.finalizationRegistry.register(observer, weakRef)
  }

  /**
   * Unsubscribe observer.
   * @description Removes observer from registry.
   * @param observer - Observer to remove
   */
  unsubscribe(observer: Observer<T>): void {
    for (const weakRef of this.observers) {
      const obs = weakRef.deref()
      if (obs === observer) {
        this.observers.delete(weakRef)
        this.finalizationRegistry.unregister(observer)
        break
      }
    }
  }

  /**
   * Notify remaining observers.
   * @description Sends data to active observers.
   * @param data - Data to send observers
   */
  notify(data: T): void {
    for (const weakRef of this.observers) {
      if (!weakRef.deref()) {
        this.observers.delete(weakRef)
      }
    }
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
/**
 * Observer pattern class.
 * @description Class-based approach.
 */
class WeatherStation {
  /** List of observers */
  private observers: WeatherObserver[] = []

  /**
   * Subscribe observer.
   * @description Registers observer for notifications.
   * @param observer - Observer to register
   */
  subscribe(observer: WeatherObserver): void {
    this.observers.push(observer)
  }

  /**
   * Notify all observers.
   * @description Sends weather data to observers.
   * @param data - Weather data to send
   */
  notify(data: WeatherData): void {
    this.observers.forEach(obs => obs.update(data))
  }
}

/**
 * Event emitter approach.
 * @description Method-based event handling.
 */
class WeatherEvents {
  /** Event listeners map */
  private listeners: Map<string, Function[]> = new Map()

  /**
   * Register event listener.
   * @description Adds callback for event type.
   * @param event - Event name to listen
   * @param callback - Function to execute
   */
  on(event: string, callback: Function): void {
    if (!this.listeners.has(event)) {
      this.listeners.set(event, [])
    }
    this.listeners.get(event)!.push(callback)
  }

  /**
   * Trigger event to listeners.
   * @description Emits event to all listeners.
   * @param event - Event name to trigger
   * @param data - Data to send listeners
   */
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
