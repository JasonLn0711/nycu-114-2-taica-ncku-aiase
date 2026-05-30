Here is a formal **Software Design Document (SDD)** template in English, structured for the real-time stock/crypto monitoring system you described. You can copy and modify this Markdown content for your project.

---

# Software Design Document: Real-Time Market Data Visualizer

**Project Name:** Live-OHLC-Monitor

**Version:** 1.0.0

**Status:** Draft

**Default Assets:** BTC-USD, ETH-USD

---

## 1. Introduction

### 1.1 Purpose

This document outlines the design and architecture of a web-based financial monitoring tool. The system fetches real-time market data and renders dynamic 1-minute OHLC (Open, High, Low, Close) candlestick charts for two concurrent assets.

### 1.2 Scope

The application focuses on frontend-side data processing and visualization, utilizing WebSockets for low-latency updates and JavaScript-based charting libraries for high-performance rendering.

---

## 2. System Architecture

The system follows a **Client-Side Reactive Architecture**. Since the requirement emphasizes real-time "minute-by-minute" updates, the client maintains a persistent connection to a data provider.

### 2.1 Component Diagram

* **WebSocket Handler:** Manages the lifecycle of the connection to the Exchange API (e.g., Binance, Coinbase, or Alpaca).
* **Data Aggregator:** Buffers incoming "ticks" and updates the current minute's candlestick bar.
* **Chart Engine:** Responsible for the visual representation of the OHLC data on a `<canvas>` or `SVG` element.
* **State Manager:** Maintains the current price and historical bar data in the browser's memory.

---

## 3. Data Design

### 3.1 Data Schema (Internal OHLC Object)

Each data point in the time series must conform to the following structure:

| Field | Type | Description |
| --- | --- | --- |
| `time` | Number | Unix timestamp (in seconds). |
| `open` | Float | Price at the start of the 1-minute interval. |
| `high` | Float | Highest price reached during the interval. |
| `low` | Float | Lowest price reached during the interval. |
| `close` | Float | Latest/final price of the interval. |

---

## 4. Interface Design

### 4.1 UI Layout

* **Header:** Displays project title and connection status (Connected/Disconnected).
* **Dual Chart Workspace:** A split-screen layout containing two independent chart containers.
* **Control Panel:** (Optional) Allows users to input different ticker symbols.

### 4.2 Charting Logic

The system uses a **Update-on-Tick** strategy:

1. **Incoming Message:** Receive JSON payload from WebSocket.
2. **Comparison:** If the timestamp belongs to the *current* bar, update `high`, `low`, and `close`.
3. **Creation:** If the timestamp belongs to a *new* minute, finalize the previous bar and start a new one.

---

## 5. Technical Stack

* **Language:** JavaScript (ES6+).
* **Rendering Library:** [Lightweight Charts](https://tradingview.github.io/lightweight-charts/) (Optimized for performance).
* **Data Source:** Binance WebSocket API (Default for BTC/ETH).
* **Styling:** CSS3 Flexbox/Grid for responsive layout.

---

## 6. Implementation Detail (JavaScript Snippet)

```javascript
/**
 * Core Logic: Handling Real-time Ticks
 * @param {Object} tick - Raw data from WebSocket
 */
function handleIncomingTick(tick) {
    const symbol = tick.s; // e.g., "BTCUSDT"
    const kline = tick.k;  // Kline/Candlestick data
    
    const formattedData = {
        time: kline.t / 1000,
        open: parseFloat(kline.o),
        high: parseFloat(kline.h),
        low: parseFloat(kline.l),
        close: parseFloat(kline.c)
    };

    // Update the specific chart series
    chartRegistry[symbol].series.update(formattedData);
}

```

---

## 7. Non-Functional Requirements

* **Performance:** The UI should remain responsive (60 FPS) even with frequent data updates.
* **Scalability:** The architecture should allow adding more charts (e.g., a 2x2 grid) with minimal configuration changes.
* **Resilience:** Implement a `reconnect()` function with exponential backoff if the WebSocket stream is interrupted.
