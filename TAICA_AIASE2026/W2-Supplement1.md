# StockCheck CLI — Product Requirements Document (PRD)

**Product Name**: stockcheck.py
**Version**: v0.1 Draft
**Date**: 2026-03-04
**Status**: Draft

---

## 1. 產品願景與目標

### 1.1 問題陳述

投資人持有多檔股票，每天需要逐一開啟網頁查看最新報價，費時且容易遺漏。需要一個輕量的命令列工具，能從一份自訂的股票清單檔案中批次查詢最新價格，一次輸出所有結果。

### 1.2 產品目標

打造一支單檔 Python 腳本 `stockcheck.py`，能夠：

- 讀取使用者自訂的股票清單檔案（每行一個股票代號）
- 逐一查詢 Google Finance 頁面取得最新報價
- 在終端機輸出每檔股票的即時價格

### 1.3 目標使用者

| 使用者類型 | 需求場景 |
|-----------|---------|
| 個人投資者 | 每日快速檢視自選股票的最新價格 |
| 學生 | 學習 Python 網頁爬取、CLI 設計、檔案處理的入門專案 |

---

## 2. 功能需求

### FR-1：股票清單檔案格式

使用者提供一個純文字檔（如 `stocklist.txt`），每行一個股票代號，格式為 `SYMBOL:EXCHANGE`：

```
MSFT:NASDAQ
AAPL:NASDAQ
GOOGL:NASDAQ
2330:TPE
6758:TYO
005930:KRX
```

檔案規則：

- 每行格式為 `SYMBOL:EXCHANGE`，冒號分隔
- 空行與 `#` 開頭的註解行應被忽略
- 編碼為 UTF-8

### FR-2：CLI 介面

```
python stockcheck.py <filename>

位置參數：
  filename        股票清單檔案路徑（如 stocklist.txt）

選用參數：
  -o, --output <FORMAT>   輸出格式：table | csv | json（預設：table）
  -v, --verbose           顯示查詢過程的詳細資訊
  -h, --help              顯示說明
```

### FR-3：價格查詢機制

針對清單中的每一檔股票，程式應：

1. 組合 URL：`https://www.google.com/finance/quote/{SYMBOL}:{EXCHANGE}`
2. 發送 HTTP GET 請求至該 URL
3. 從回傳的 HTML 中解析出當前股價
4. 若查詢失敗（網路錯誤、股票代號不存在、頁面結構變動），記錄錯誤訊息但繼續處理下一檔

### FR-4：輸出格式

**table（預設）：**

```
Stock Price Check - 2026-03-04 15:30:00

SYMBOL        EXCHANGE    PRICE       CURRENCY    STATUS
──────────────────────────────────────────────────────────
MSFT          NASDAQ      420.15      USD         ✓
AAPL          NASDAQ      178.32      USD         ✓
2330          TPE         595.00      TWD         ✓
INVALID       NASDAQ      —           —           ✗ Not Found

Total: 4 stocks checked, 3 succeeded, 1 failed
```

**csv：**

```csv
symbol,exchange,price,currency,status
MSFT,NASDAQ,420.15,USD,ok
AAPL,NASDAQ,178.32,USD,ok
2330,TPE,595.00,TWD,ok
INVALID,NASDAQ,,, not_found
```

**json：**

```json
{
  "timestamp": "2026-03-04T15:30:00",
  "results": [
    {"symbol": "MSFT", "exchange": "NASDAQ", "price": 420.15, "currency": "USD", "status": "ok"},
    {"symbol": "AAPL", "exchange": "NASDAQ", "price": 178.32, "currency": "USD", "status": "ok"}
  ],
  "summary": {"total": 4, "succeeded": 3, "failed": 1}
}
```

---

## 3. 非功能需求

| 項目 | 要求 |
|------|------|
| 單檔腳本 | 整個工具為一支 `stockcheck.py`，不拆分多個檔案 |
| 相依性 | 僅依賴 `requests` 與 `beautifulsoup4`（標準爬蟲工具） |
| 效能 | 每檔查詢間隔 0.5–1 秒（避免被 Google 封鎖） |
| 錯誤韌性 | 單一股票查詢失敗不影響其餘股票，最終彙報成功/失敗數量 |
| Exit Code | 全部成功 = 0；部分失敗 = 1；檔案不存在或格式嚴重錯誤 = 2 |
| Python 版本 | Python 3.10+ |

---

## 4. 使用範例

```bash
# 基本用法
python stockcheck.py stocklist.txt

# CSV 輸出，可接 pipeline
python stockcheck.py stocklist.txt -o csv > prices.csv

# JSON 輸出
python stockcheck.py stocklist.txt -o json

# 詳細模式，觀察每一步查詢
python stockcheck.py stocklist.txt -v
```

---

## 5. 開放問題與風險

| 項目 | 說明 | 緩解策略 |
|------|------|---------|
| Google 頁面結構變動 | HTML class/tag 可能隨時改變 | 解析邏輯集中於單一函式，方便快速修復 |
| 請求被封鎖 | 頻繁查詢可能觸發 Google 的 rate limit | 加入請求間隔延遲與 User-Agent header |
| 幣別解析 | 不同交易所的幣別不同 | 從頁面同時解析幣別欄位 |
| 盤後/休市 | 非交易時段顯示的價格為前一交易日收盤價 | 輸出中不區分即時/收盤，僅顯示頁面上的數值 |

---

## 6. 成功指標

| 指標 | 目標 |
|------|------|
| 支援交易所數 | ≥ 4（NASDAQ、TPE、TYO、KRX） |
| 單檔查詢成功率 | ≥ 95%（在合法股票代號的前提下） |
| 總執行時間 | 10 檔股票 ≤ 15 秒 |
| 錯誤報告清晰度 | 使用者能從輸出中辨識哪些股票查詢失敗及原因 |

---

*本文件為 PRD，定義了「做什麼」與「為什麼」。後續可依 SDD 方法論轉化為可執行的技術規格，拆分為漸進式的 Generation 實作。*