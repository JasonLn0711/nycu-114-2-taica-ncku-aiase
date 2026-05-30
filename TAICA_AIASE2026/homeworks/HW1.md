# 📝 作業1：Markdown 創作與渲染實作

> **課程作業｜Markdown to Rich Output**
> 繳交方式：上傳至 GitHub Classroom 
> 因為選課相關資料尚未聯結，請所有有修課的同學，先確認你們是否有提供自己相關的姓名、學號、學校、github id、email等資訊，可以到[這裡](https://docs.google.com/forms/d/1x0sxz8-SWJk2uH3WXBDiSvfn13hTNDwZq_pkUp6JRPM/edit)填寫
---

> 因應各校加退退時間不一，有部分上週才加入的同學反應來不及HW1的繳交，我們開放HW1延後到本週五晚上23:59 (3/13 23:59)。這是最後deadline。

## Deadline: 2026/3/10 23:59
> 📌 **不允許遲交，天有不測風雲，請提前繳交**

---

## 作業目標

> Decouple Content and Rendering - 學習使用 Markdown 語法撰寫結構豐富的文件，並透過開源工具將其渲染（rendering）為專業的 PDF、網頁或圖片格式，最終提交至 GitHub Classroom。

---

## 📁 必繳檔案結構

```
AIASE2026-HW1/
├── content.md          ← 主要 Markdown 內容（必要）
├── README.md           ← 說明渲染流程與執行方式（必要）
├── requirements.txt    ← Python 套件清單（若有使用，建議提供）
└── output/             ← 渲染後的成果（至少一個）
    ├── output.pdf
    ├── output.html
    └── output.png / slides.html ...（視工具而定）
```

> ⚠️ **content.md與README.md為必要檔案，缺少任一者以0分計算。**

> ⚠️ **output目錄至少要提供一個成果檔案可以直接呈現，缺少以0分計算。**

---

## ✍️ content.md 的內容要求

`content.md` 是本作業的核心，內容主題**自由選擇**，但必須能呈現你的**個人創意**。以下為建議主題（擇一或自行發揮）：

| 建議主題 | 說明 |
|---|---|
| **個人履歷 (CV)** | 學歷、技能、經歷、專案等 |
| **工作 / 學習流程** | SOP、流程圖說明、系統架構 |
| **會議記錄** | 含議程、討論摘要、行動事項 |
| **提案計畫書** | 專案背景、目標、時程、預算 |
| **技術規格書** | 可轉換為程式碼的 API spec、資料模型定義 |
| **其他創意內容** | 個人介紹、作品集、教學文件等 |

### Markdown 標籤使用要求

`content.md` 中**應盡量使用多種 Markdown 標籤**，以展現內容豐富性，包含但不限於：

- `#` `##` `###` 等**多層標題**
- **粗體**、*斜體*、~~刪除線~~、`行內程式碼`
- 有序與無序**清單**（含巢狀清單）
- **表格**
- **程式碼區塊**（含語言標示，如 ` ```python ` ）
- **引用區塊** `>`
- **水平線** `---`
- **超連結**與**圖片** `![alt](url)`
- **任務清單** `- [ ]` / `- [x]`
- 數學公式（若工具支援，如 `$E=mc^2$`）
- Mermaid 或 PlantUML 流程圖（若工具支援）

---

## 🛠️ 渲染工具（擇一或多個）

你需要選擇**至少一種**開源工具，將 `content.md` 渲染為 PDF、HTML 或圖片。以下為建議工具：

| 工具 | 適合用途 | 輸出格式 |
|---|---|---|
| [Pandoc](https://pandoc.org/) | 通用文件轉換 | PDF、HTML、DOCX 等 |
| [Quarto](https://quarto.org/) | 學術 / 資料科學文件 | PDF、HTML、Slides |
| [Marp](https://marp.app/) | Markdown 投影片 | PDF、HTML、PPTX |
| [markdown-it](https://github.com/markdown-it/markdown-it) | 輕量 HTML 渲染 | HTML |
| [mdpdf](https://github.com/BlueHatbRit/mdpdf) | 快速 Markdown 轉 PDF | PDF |
| [md-to-pdf](https://github.com/simonhaenisch/md-to-pdf) | Node.js 轉 PDF | PDF |
| [WeasyPrint](https://weasyprint.org/) | HTML+CSS 轉 PDF | PDF |
| 其他開源工具 | 自行選擇，需說明 | PDF / HTML / Image |

> 鼓勵同學探索更多 **markdown-to-cv**、**markdown-to-resume** 等專門工具，或搭配 CSS 樣式自訂美化效果。

---

## 📖 README.md 撰寫要求

`README.md` 必須讓**他人（或 AI）能在乾淨的 sandbox 環境中完整重現你的渲染結果**。請包含以下各節：

### 1. 專案簡介
- 說明 `content.md` 的主題與內容摘要
- 說明選用的渲染工具及理由

### 2. 環境需求
- 作業系統（建議支援 Linux / macOS）
- 所需語言 Runtime（Python 版本、Node.js 版本等）
- 系統層套件安裝指令（如 `apt-get install pandoc`）

### 3. 安裝步驟

提供**完整、可逐步執行**的指令，例如：

```bash
# 安裝 Python 套件
pip install -r requirements.txt

# 或安裝系統工具
sudo apt-get install -y pandoc texlive-xetex
```

### 4. 執行渲染

提供**可直接複製執行**的指令，輸出結果應儲存於 `output/` 資料夾，例如：

```bash
pandoc content.md -o output/output.pdf --pdf-engine=xelatex
```

### 5. 預期輸出

- 說明最終輸出檔案名稱與格式
- 可附上截圖或簡短說明輸出樣貌

### 6. 參考資料
- 列出使用的工具官方文件連結

---

## 📦 requirements.txt（建議提供）

若使用 Python 套件，請提供 `requirements.txt`，格式如下：

```
markdown==3.6
weasyprint==62.3
Pygments==2.17.2
```

安裝方式：

```bash
pip install -r requirements.txt
```

---

## 🎯 評分說明

| 評分面向 | 說明 |
|---|---|
| **Markdown 豐富程度** | 標籤種類多樣、內容結構清晰、排版美觀 |
| **工具完整度與複雜度** | 工具選用的適切性、渲染流程的完整性 |
| **文件撰寫詳細程度** | README 的可重現性、指令正確性、說明清晰度 |

- AI自動評分範圍：**60 – 95 分**
- AI評分準則事前不公開，請全面思考以上評分面向。AI評分相關程式碼，會在期末公布
- AI評分將進行排序，也就是一定有人是60分，有人是95分，整體接近Nornal Distribution with $\mu$＝78~80
- 人工抽查：確認是否可正確執行；**無法執行者以 0 分計算**
- 抽查加分：執行正確且呈現**具專業感與美感**者，由老師額外加**1-5分**

> 💡 **提示**：評分重視「可重現性」——請確保你的 README 指令在他人的乾淨環境中可無誤執行。建議自行在新環境中測試一遍再繳交。

---

## 🤖 GitHub Actions 自動檢查（CI）

本作業已設置 **GitHub Actions** 作為 CI，會在你每次 `push` 時自動執行基本檢查，確認你的繳交內容符合最低要求。

### 檢查項目

CI 會自動驗證以下基本條件：

- ✅ `content.md` 檔案是否存在
- ✅ `README.md` 檔案是否存在
- ✅ `output/` 目錄是否存在且包含至少一個輸出檔案

> ⚠️ **CI 檢查未通過 = 基本條件不符，將直接影響成績。** 請務必在繳交前確認 GitHub Actions 顯示綠色 ✅ 通過。

### 如何查看 CI 結果

1. Push 你的程式碼到 GitHub Classroom repo
2. 前往你的repo頁面，點選 **Actions** 頁籤
3. 查看最新的 workflow run 是否顯示 ✅ 通過
4. 若顯示 ❌ 失敗，點入查看錯誤訊息，修正後重新 push

> 💡 **提醒**：CI 僅檢查基本檔案結構，不代表內容品質。通過 CI 是最低門檻，最終評分仍依據內容豐富度、工具完整度與文件品質。

---

## 📅 繳交方式

1. 點擊以下連結接受 GitHub Classroom 邀請：👉 **[接受作業邀請](https://classroom.github.com/a/tniubn-f)**
2. Clone personal repo至local
3. 完成 `content.md`、`README.md`、`output/` 等檔案
4. `git add`、`git commit`、`git push` 至repo
5. 確認 **GitHub Actions CI 檢查通過**（綠色 ✅）

```bash
git add .
git commit -m "Submit assignment: markdown rendering"
git push origin main
```

---

## ❓ 常見問題

**Q：output 資料夾的渲染結果需要 commit 嗎？**
A：是的，請將最終輸出（PDF / HTML / 圖片）一併 push，以利 AI 直接檢視成果。

**Q：可以使用多個工具嗎？**
A：可以，甚至鼓勵組合使用（例如先用 Marp 產生投影片、再用 Pandoc 產生 PDF）。工具越豐富且有效整合，評分越有利。

**Q：content.md 一定要是原創內容嗎？**
A：是，請撰寫自己的原創內容。使用 AI 輔助撰寫須標明，但核心創意須來自個人。

**Q：圖片資源可以放在 repo 中嗎？**
A：可以，建議放在 `assets/` 資料夾，並在 `content.md` 中以相對路徑引用。

---

*如有任何問題，請於Discord課程討論區發問。祝大家作業順利！* 🚀