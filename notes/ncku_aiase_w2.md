# TAICA AIASE W2 Note

Attachments: **AIASE W2 正課主線 + W2 補充講義 + HW2 的實作與評分邏輯 + W3 對 Agentic Engineering 的延伸 + 四本書的補底地圖**。這門課的真正核心，不是「叫 AI 幫你生 code」，而是把工程師的價值從「逐行撰寫」往上推到「定義問題、設計架構、約束風險、驗證結果、承擔責任」。W2 反覆強調升維/降維、FDE/PM、Agent Architect、AI Agents、PRD/SDD、Mermaid、滾雪球開發，以及從「誰寫的」轉向「如何驗證」。

## 第 0 章：先講結論——這門課到底在訓練你什麼

這門課表面上在教 AI coding，骨子裡其實在教你三件事。第一，你要能把模糊需求整理成可執行規格；第二，你要能把規格拆成可測試、可迭代、可維護的系統；第三，你要能在 AI 參與開發時守住品質、安全與可追責性。課堂裡把人類工程師重新定位成 **Navigator / Human Guardian / Orchestrator**，不是因為寫 code 不重要，而是因為「只會寫 code」已經不夠了。 

如果用一句最濃縮的話來記：
**AI 讓「打字」便宜了，卻讓「定義問題、設計系統、承擔責任」更貴。** 這也是講義裡「會問好問題比會寫程式更貴」的真正意思。 

---

## 第 1 章：從零開始，你一定要先有的世界觀

#### 1.1 軟體工程不是寫程式而已

很多新手把軟體工程想成：需求來了 → 寫 code → 跑起來 → 結束。這其實只抓到最表面的 20%。真正完整的工程鏈條是：**需求理解 → 邊界定義 → 規格文件 → 架構設計 → 模組切分 → 實作 → 測試 → 除錯 → 部署 → 監控 → 演化**。W2 用非常強烈的語氣在提醒這件事：不要一開始就讓 AI 生出龐大完整程式，因為如果你自己沒有底層知識、沒有規格、沒有驗證策略，那個程式通常只是看起來很像能跑。

這門課還有一個很重要的產業判斷：AI 會把軟體生產推向「超長尾」。少數大平台吃下大量流量，但同時會有海量個人化、小眾化、由領域專家自己做出來的工具。這代表你未來的競爭力，不只來自程式技巧，還來自你能不能結合 domain knowledge，把需求變成真正有價值的系統。 

#### 1.2 這門課為什麼一直強調 CLI

因為 CLI 幾乎是最乾淨的工程訓練場。你在 CLI 專案裡會直接碰到輸入、輸出、參數解析、檔案處理、錯誤碼、日誌、依賴、環境、資料格式、測試與自動化。這些東西不炫，但都是真工程。W3 甚至直接把 CLI 和純聊天式 AI 做出區分：聊天視窗比較像拿答案，CLI/Agentic 工具比較像完成工程。

---

## 第 2 章：最基本但一定要懂的名詞，一次補齊

這一章我不只定義，還直接串成一條你能看懂的「執行鏈」。

#### 2.1 先看一條完整執行鏈

當你在 terminal 輸入：

```bash
python stockcheck.py stocklist.txt -o json
```

背後其實發生了這些事：

1. shell 先讀你的命令。
2. 作業系統建立一個新的 process。
3. Python interpreter 載入 `stockcheck.py` 與它依賴的 library。
4. CLI 參數解析器讀取 `stocklist.txt` 與 `-o json`。
5. 程式開啟檔案，逐行讀入股票代號。
6. 對每個 ticker 組出 Google Finance URL，送出 HTTP GET。
7. 收到 HTML 後，用 parser 擷取價格與幣別。
8. 將資料整理成 table / csv / json。
9. 把結果印到 stdout，或寫進檔案。
10. 如果全部成功，回傳 exit code 0；部分失敗回傳 1；嚴重輸入錯誤回傳 2。  ([Wiley Catalog Images][1])

只是一條 CLI 指令，就已經把你帶進了 OS、process、file I/O、network、parser、data format、error handling、observability 的世界。這就是為什麼我說：**會做一個好 CLI，你就已經摸到半個工程核心。**  ([Wiley Catalog Images][1])

#### 2.2 你一定要會分的基本名詞

**程式（program）** 是靜態的原始碼或可執行檔；**程序（process）** 是執行中的程式，包含記憶體、開啟的檔案、CPU 狀態等；**執行緒（thread）** 則是 process 裡較輕量的執行流。OSC 10th 把這些概念放在很前面：Chapter 3 處理 process，Chapter 4 處理 thread 與 concurrency。([Wiley Catalog Images][1])

**作業系統（OS）** 是資源管理者與抽象提供者。你看到的是「開檔、讀檔、連網、啟動程式」，OS 看到的是 CPU、memory、files、devices、permissions、scheduling。OSC 10th 在 Chapter 1–2 先講 OS 做什麼，再講 services、system calls、debugging，這個順序非常適合新手。([Wiley Catalog Images][1])

**CLI（Command-Line Interface）** 是用文字命令操作程式；**argument** 是你在命令後面附帶的參數；**exit code** 是程式給系統的整數結果，讓 shell、CI、script 判斷成功或失敗。W2 的 `stockcheck.py` 就明確規範了 CLI 參數、輸出格式與 exit code。 

**library / dependency** 是你借用的外部程式能力；**runtime** 是程式執行時期的環境；**environment variable** 是程式啟動時可讀的環境參數。這些東西若不控管好，就會變成資安風險，尤其當 AI agent 有能力執行 shell 或碰網路時更明顯。

**API** 是模組與模組、系統與系統之間的契約；**HTTP GET** 是向伺服器請求資源的一種方法；**HTML parser** 是把網頁文字結構化抽取成資料的邏輯。Attacking Network Protocols 把網路流量擷取、system call tracing、protocol structure、TLS、fuzzing 與 exploit 都接在一起講，會讓你知道「一個 request 並不是憑空消失又突然回來」。([No Starch Press][2])

**JSON / CSV / table** 是不同輸出格式。JSON 給程式吃，CSV 給試算表與 pipeline，table 給人類看。W2 刻意讓同一個工具支援三種輸出，因為這就是工程裡「同一份資料服務不同使用場景」的簡單版。

**SQLite** 是嵌入式資料庫，適合本地歷史資料、快取、簡單查詢；**schema** 是資料表欄位結構；**persistence** 是把資料從記憶體落到可持久保存的儲存層。W2 的 Phase 2 就是把抓到的資料落到 SQLite，這一步非常重要，因為沒有持久化，你就做不了歷史分析與後續最佳化。

**log / debugging / testing / CI** 分別是在說：留下可追查紀錄、理解故障原因、驗證行為正確、把驗證自動化。W2 後面直接把信任焦點從「誰寫的」切到「如何驗證」，這正是工程成熟度的標誌。

**concurrency / race condition / deadlock** 是多執行流程時必碰的概念。Concurrency 是同時處理多件事；race condition 是不同執行流程搶共享資源導致結果不穩；deadlock 是彼此互等，誰都走不了。OSC 10th 把 synchronization、deadlocks、memory 都拉成完整章節，因為這些不是進階花招，而是系統穩定性的基本盤。([Wiley Catalog Images][1])

**least privilege / fail-safe defaults / complete mediation / least astonishment** 是安全設計的四大金句。它們分別是：只給最小必要權限、預設拒絕、每次敏感存取都要檢查、系統行為要符合使用者直覺。Computer Security: Art and Science 把這些放在 Chapter 14 Design Principles，頁碼清楚列在 457–464。([PTG Media][3])

---

## 第 3 章：AI 時代工程師角色怎麼變

W2 與 W3 合在一起看，你會看到一條很清楚的演化線：從早期的 Tab 補全，到同步代理，再到能自己規劃、測試、修正的大型自主 agent。人類角色也跟著變：從單純 writer，變成 co-pilot，再變成 orchestrator。 

課程把這件事拆成「AI 時代軟體開發鐵三角」：
**FDE/PM（Navigator）** 負責問題定義與市場方向；
**Agent Architect（Human Guardian）** 負責架構、資安、品質、邏輯驗證；
**AI Agents（Drivers）** 負責高速實作、測試、除錯與自動化。 

這個模型對面試很有用，因為它會讓你講話不再像「我會用某個工具」，而是像「我知道人在 AI workflow 裡該扮演什麼角色」。真正成熟的回答不是「我會叫 GPT 幫我寫」，而是：

> 我通常先做需求收斂與風險界定，再把規格轉成 SDD、圖與測試；AI 只負責在我定好的邊界內高速實作，最後由我做架構審查、驗證與風險把關。

這句話幾乎就是課堂精神本體。 

---

## 第 4 章：升維與降維——這份課最值錢的觀念

W2 最漂亮的地方，是把軟體開發講成「維度轉換」。

**升維建構**：把一句零碎需求，整理成架構圖、模組關係、資料流與狀態機。
**降維打擊**：把這個藍圖，在資源、效能、安全與維護限制下，收斂成可執行程式。 

這個觀念真的要吃透。因為很多人以為 prompt engineering 只是「換個問法」，其實不是。真正高階的 prompt，是先做升維，把需求整理成 AI 能理解的空間結構；再做降維，把藍圖拆成 phase、module、contract、tests，讓 AI 按順序做。

你可以用一個很簡單的例子理解：

* 低維需求：我想做一個讀書工具。
* 升維後：CLI 還是 Web？單人還是多人？儲存用 JSON、SQLite 還是 PostgreSQL？功能是 CRUD、搜尋、統計還是排程？有無登入？有無提醒？
* 降維後：先做 CLI CRUD + JSON；第二版換 SQLite；第三版加搜尋與統計；第四版加通知。

這就從一句話，走到了工程路線圖。

---

## 第 5 章：PRD、SDD、FR、NFR、Constraints、Risks，一次徹底搞懂

#### 5.1 PRD 是什麼

PRD（Product Requirements Document）回答的是：**做什麼、為什麼做、為誰做、怎樣算做成**。課堂補充講義明確說 PRD 是從使用者視角出發，定義產品目標、範圍與驗收標準。以 `stockcheck.py` 為例，PRD 的問題陳述是：投資人不想一檔一檔打開網頁看盤，希望有一個能批次查詢股票價格的 CLI 工具。

一份好的 PRD 至少要有：問題陳述、目標用戶、核心使用情境、功能需求、非功能需求、成功指標、風險、驗收標準。W2 的 stockcheck 就列了目標用戶、輸入格式、CLI 行為、輸出格式、成功率、執行時間與風險。 

#### 5.2 SDD 是什麼

SDD（Software Design Document）回答的是：**怎麼做、用什麼做、資料怎麼流、出錯怎麼處理、怎麼驗證**。補充講義把它定義成：將 PRD 轉化為技術決策、資料流與模組切分的文件。它不是作文，而是可執行規格。HW2 甚至直接寫明：SDD 不是 PRD，它應該精確到足以讓 AI 或他人直接實作。 

一份好的 SDD 至少要有：系統架構摘要、模組責任、資料流、API / Tool Schema / Contract、儲存設計、錯誤處理、日誌與監控、測試計畫、安全邊界、已知限制、演化策略。W3 又把這套思想往 agent 系統推進：**需求 → System Prompt（Role / Goal / Constraints / Output Format）→ Tool Schema → Eval Cases → 實作/迭代**。這等於說，agent 的 prompt 本身就是一種 SDD。

#### 5.3 FR、NFR、Constraints 到底差在哪

**FR（Functional Requirements）** 是「系統要做什麼」。
`stockcheck.py` 的 FR 例子包括：輸入檔格式必須是 `SYMBOL:EXCHANGE`；CLI 支援 `-o`、`-v`、`-h`；程式需要能對 Google Finance 發請求並解析價格；結果可以輸出 table / csv / json。

**NFR（Non-Functional Requirements）** 是「系統要做到什麼品質」。
例子包括：單檔腳本、只依賴 `requests` 和 `beautifulsoup4`、每檔查詢間隔 0.5–1 秒、單檔失敗不影響整體、明確 exit code、Python 3.10+、10 檔在 15 秒內完成。這些不是「功能」，但決定了系統是不是實際可用。 

**Constraints** 是「不准超線的邊界」。例如：不能用付費 API、只能用指定套件、只能單機本地儲存、只能在某個硬體或作業系統上跑。這些邊界如果不寫，AI 很容易擅自引入不合規的東西。補充講義甚至把高效能系統的 constraint 寫到硬體拓樸、VRAM、threading model、memory safety、FFI 介面。 

**Risks** 是「已知會壞在哪」。`stockcheck.py` 的風險就包括：Google HTML 結構變動、rate limit、幣別解析、盤後/休市顯示與真即時價的差異。真正成熟的工程，不是沒有風險，而是風險先被寫出來。

#### 5.4 一句話區分 PRD 與 SDD

你可以把它背成：

* **PRD 是產品語言**：做什麼、對誰有價值。
* **SDD 是工程語言**：怎麼做、如何驗證、如何安全地做。

面試如果被問到這題，這樣答通常很穩。

---

## 第 6 章：規格驅動與滾雪球開發，才是 AI coding 的正確打開方式

課堂極力反對「一次叫 AI 寫完所有功能」。原因很簡單：那樣做的東西不易驗證、很難除錯、幾乎無法維護。講義把正確做法叫做 **Snowball / Iterative Development**，並補充了三個技巧：**Core-First Expansion、Dependency-Ordered Implementation、Modular Isolation**。

先做核心，再做錯誤處理，再做進階選項，再做輸出格式，再做最佳化；如果功能 B 依賴 A，就先做 A；不同功能盡量做成獨立函式或模組，這樣才方便測試。這套方法不是保守，而是聰明。因為當 Phase 4 壞掉時，你就能把懷疑範圍縮到 Phase 4，而不用回頭懷疑整個系統。補充講義把這點說得很直白：每一階段都要建立在前一階段已測試通過的基礎上。

這種思維和現在 agent 系統的做法高度一致。W3 把 agent 開發也做成 spec-driven：Role、Goal、Constraints、Output Format、Tool Schema、Eval Cases。說穿了，不管你是在寫 CLI、Web service，還是 Agent，核心都是同一件事：**先收斂，再實作；先定邊界，再放權限；先做可驗證版本，再做擴充。** 

---

## 第 7 章：Mermaid / UML，不是裝飾，是壓縮歧義的工具

W2 很明確地說：一張好的架構圖，勝過十段模糊的文字描述。因為圖把系統元件、順序、狀態與邏輯關係變成了可視化約束，AI 也因此更容易理解。講義列的常用圖型有：Flowchart、Sequence Diagram、Class Diagram、ER Diagram、State Diagram。

你可以這樣理解：

* **Flowchart**：用來講流程與分支。
* **Sequence Diagram**：用來講元件互動順序。
* **Class Diagram**：用來講類別與繼承。
* **ER Diagram**：用來講資料表。
* **State Diagram**：用來講狀態機。

W2 的 `stockcheck.py` 範例用 flowchart 畫出 `--ticker`、`filename`、`--avg_break`、CSV 輸出等路徑，這正是很好的工程習慣：**在寫 if/else 前先畫分支樹，在寫資料庫前先畫資料關係圖，在串 API 前先畫 sequence。** 

補一句很實務的話：很多面試官要的「白板系統設計」，本質上就是你能不能在沒有電腦的情況下，把 Mermaid/架構圖的腦內模型畫出來。

---

## 第 8 章：`stockcheck.py` 是一個小題目，但其實把工程核心全塞進去了

#### 8.1 這個題目的產品面

`stockcheck.py` 的目標用戶很清楚：個人投資者與學習者。前者要快速看自選股，後者拿它練 Python 爬網頁、CLI 設計、檔案處理。這是很典型的「小而完整」題目：使用者痛點明確、輸入/輸出清楚、可從簡單做到進階。

#### 8.2 這個題目的功能面

它的 FR 很漂亮。輸入是 `stocklist.txt`，每行 `SYMBOL:EXCHANGE`；CLI 介面是 `python stockcheck.py <filename>`，外加 `-o/--output`、`-v/--verbose`、`-h/--help`；查詢機制是組出 Google Finance URL，送 GET，從 HTML 解析價格與幣別；輸出支援 table、csv、json。這些規格一看就知道：它不是「查股價」而已，而是在練輸入格式、CLI 介面、抓取流程、資料抽取與多型輸出。

#### 8.3 這個題目的非功能面

真正把它拉成工程題的，是 NFR。W2 和補充講義要求：單檔腳本、不拆太多模組；依賴最小化；請求間隔 0.5–1 秒；單檔失敗不拖垮整批；明確 exit code；Python 3.10+；還有成功率與執行時間目標。這些要求聽起來細，但它們其實就是工程素養。 

#### 8.4 這個題目的風險面

補充講義也把風險寫得很像業界文件：頁面結構可能變、請求可能被封、幣別解析可能歪、盤後價格與即時價格語義不同。這一段非常值得學，因為新手最常犯的錯，是把成功 happy path 當成全部世界。真正的系統設計不是只寫「會成功的情況」，而是先寫「會怎麼壞」。

#### 8.5 這個題目的工程演化面

W2 把整個專案切成六步：

* Step 1：最小可執行版本，只做讀檔 + 查股價。
* Step 2：補格式化輸出、錯誤處理、CSV 輸出。
* Step 3：加入 SQLite 歷史資料與 `--his_insert`。
* Step 4：加入 `--ticker` 直接查單檔。
* Step 5：加入 `--avg_break` 做 MA5/10/20。
* Step 6：再做審查與最佳化，例如均線資料優先從 DB 讀，減少網路請求。

這個順序不是隨便排的。它其實遵守了依賴性與風險排序：

先證明「能抓到資料」；再證明「能穩定輸出」；再證明「能存下來」；再證明「能增加查詢路徑」；最後才做演算法與最佳化。這完全是你以後做任何專案都能複用的套路。

#### 8.6 如果你要把這個題目講給面試官聽

你可以這樣說：

> 我把專案拆成 fetch、parse、format、persist、analyze 五層。第一版只驗證 fetch + parse；第二版才加入 persistence；第三版再疊 domain logic。這樣一來，HTML 結構改變時只需要修 parser，資料格式變更只影響 formatter，歷史分析則獨立於即時抓取邏輯。

這種講法比「我有寫 stock checker」強太多。

---

## 第 9 章：安全、權限、維護、驗證——AI 時代最容易被忽略，但最值錢

#### 9.1 驗證比作者更重要

W2 直接指出：信任的根源不在於「是人寫還是 AI 寫」，而在於驗證機制。這句話非常重要，因為很多人對 AI code 的態度只停在情緒反應：不是盲信，就是全盤拒絕。真正工程思維是：不管誰寫的，都要測試、review、observe、trace。

#### 9.2 看不懂的 AI code，不要交付

課堂補充講義有一句超值得背：**如果你看不懂 AI 寫的 code，你就無法 maintain 它。** 這句話其實比「clean code」還更根本。因為可維護性不是美學問題，而是風險問題。不可 review 的系統，就是未爆彈。

#### 9.3 權限要比功能更早設計

當 AI agent 能碰 shell、外網、環境變數、API key 時，攻擊面就立刻放大。課堂補充建議用零信任與最小權限原則來設計 agent：限制它能看的 env、限制它能呼叫的工具、限制它能改的檔案範圍。這和 OSC 10th 的 security/protection 章節，以及 Computer Security 的 secure design principles 是同一條邏輯。 ([Wiley Catalog Images][1])

#### 9.4 四個一定要背的安全設計原則

**Least Privilege（最小權限）**：只給完成任務所需的最小權限。
**Fail-Safe Defaults（失敗即保守）**：預設拒絕，允許要明示授權。
**Economy of Mechanism（機制簡單）**：架構越複雜，越難驗證與維護。
**Complete Mediation（完整仲裁）**：每次敏感存取都重新檢查。
Computer Security: Art and Science 把這些放在 Chapter 14，頁碼分別是 457、458、459、460；Least Astonishment 在 464。([PTG Media][3])

把它翻成工程語言就是：

* 不要讓 stock tool 自帶不必要的寫檔或 shell 權限。
* 不要因為「應該沒人會這樣用」就省略輸入檢查。
* 不要為了炫技加一堆冷門套件與複雜框架。
* 不要只在登入時檢查一次權限，後續敏感操作卻不檢查。
* 不要讓工具輸出或錯誤行為出乎使用者預期。

#### 9.5 Modern agent system 其實就是 spec-driven security

W3 把 agent 工程寫得很清楚：System Prompt 要包含 Role、Goal、Constraints、Output Format；Tool Schema 是 API contract；Eval Cases 是測試集。這不只是 prompt 技巧，它其實就是安全工程的第一道防線。你不先定角色與邊界，就等於先放權限、後補風險。

---

## 第 10 章：真實世界應用，讓你知道這些觀念不是課堂空話

這些課程觀念在真實場景裡非常有感。

**醫療器材軟體（SaMD）**：PRD 與 SDD 不只是開發文件，更是合規文件。預期用途、資安機制、風險評估、追溯性若對不上，審查就會出問題。

**警政防詐與語音分析系統**：如果一開始就想要「語音轉文字 + 詐騙判讀 + 報告自動生成」一口氣完成，幾乎注定無法除錯；正確做法就是 Phase 1 先穩住 ASR，Phase 2 再做抽取與分類，Phase 3 再整合資料庫。

**高敏資料地端部署**：W3 補充筆記提到醫療與反詐等敏感資料常必須 on-prem；這時候 NFR 就會升級成硬體拓樸、GPU/VRAM、threading、network isolation、memory safety 等規格，甚至可能要用 Rust 重構瓶頸。 

**網路封包深度檢測（DPI）**：在這類線速系統裡，SDD 可能必須寫進 zero-copy I/O、指標傳遞、封包分析引擎的資料路徑，因為這已經不是單純「功能能不能做」，而是「有沒有可能在現實吞吐量下活下來」。

**工作流自動化與維運**：Mermaid 圖、workflow automation、n8n 串接警報與例行任務，則是 W2/W3 思想往維運延伸的自然結果。當你能把系統的圖畫清楚、契約定清楚，維運就能被自動化。 

---

## 第 11 章：四本書怎麼補這門課，哪一本到底最重要

#### 11.1 最重要：Operating System Concepts 10th

這本一定是主幹。Wiley 官方把 OSC 10th 的內容分成 Overview、Process Management、Process Synchronization、Memory Management、Storage Management、File System、Security and Protection、Advanced Topics；官方 companion site 還提供 study guide、review questions、exercises 和 source code。([Wiley][4])

你最該讀的章節地圖如下：

* **Ch.1 Introduction**：`What Operating Systems Do` p.4、`Security and Protection` p.33、`Virtualization` p.34。
* **Ch.2 Operating-System Structures**：`Operating-System Services` p.55、`System Calls` p.62、`Operating-System Debugging` p.95。
* **Ch.3 Processes**：`Process Concept` p.106、`Interprocess Communication` p.123、`Client-Server Systems` p.145。
* **Ch.4 Threads & Concurrency**：`Multicore Programming` p.162、`Multithreading Models` p.166、`Threading Issues` p.188。
* **Ch.6 Synchronization Tools**：`Critical-Section Problem` p.260、`Mutex Locks` p.270、`Semaphores` p.272、`Monitors` p.276、`Liveness` p.283。
* **Ch.8 Deadlocks**：`Deadlock in Multithreaded Applications` p.319、`Prevention` p.327、`Avoidance` p.330、`Detection` p.337。
* **Ch.9 Main Memory**：`Paging` p.360、`Structure of the Page Table` p.371。
* **Ch.10 Virtual Memory**：`Demand Paging` p.392、`Copy-on-Write` p.399、`Thrashing` p.419、`Allocating Kernel Memory` p.426。
* **Ch.12 I/O Systems**：`I/O Hardware` p.490、`Kernel I/O Subsystem` p.508、`Performance` p.521。
* **Ch.13 File-System Interface**：`Memory-Mapped Files` p.555。
* **Ch.14 File-System Implementation**：`Efficiency and Performance` p.582、`Recovery` p.586。
* **Ch.16 Security**：`The Security Problem` p.621、`Program Threats` p.625、`System and Network Threats` p.634、`Implementing Security Defenses` p.653。
* **Ch.17 Protection**：`Principles of Protection` p.668、`Access Matrix` p.675、`RBAC` p.683、`MAC` p.684、`Capability-Based Systems` p.685。
* **Ch.18 Virtual Machines**：`Overview` p.701、`Benefits and Features` p.704。
* **Ch.19 Networks and Distributed Systems**：`Network Structure` p.735、`Communication Structure` p.738、`Network and Distributed Operating Systems` p.749。([Wiley Catalog Images][1])

為什麼這本是主幹？因為只要你真的動手做 agent、CLI、database、crawler、RAG、local inference，你早晚都會回到 OS abstraction：process、thread、memory、file、network、protection。AI 幫你省掉的是部分 syntax，不是這些底層約束。

#### 11.2 CEH Study Guide：把你變成會想攻擊面的工程師

就「最新版」來說，Wiley 目前已經有 **CEH Certified Ethical Hacker v13 Study Guide**，2026 年 4 月出版，768 頁。([Wiley][5])

但如果你需要一個公開可驗證、章節與頁碼都清楚的 CEH 讀物來對照這門課，我比較建議先用 **Matt Walker 2025 年的 CEH Study Guide** 做章節導航：`Information Gathering for the Ethical Hacker` p.41、`Scanning and Enumeration` p.69、`Sniffing and Evasion` p.111、`Attacking a System` p.151、`Security in Cloud Computing` p.281、`Trojans and Other Attacks` p.299、`Cryptography` p.327、`Artificial Intelligence for the Ethical Hacker` p.385。([Google Books][6])

這本對 W2 最大的補強，是讓你在設計系統時自然多問幾題：

* 這個系統能被怎麼 information gathering？
* 會不會暴露可掃描的 port / service / metadata？
* 有沒有 sniffing / evasion / cloud config 的洞？
* 日誌與加密是否足以支持 incident response？

簡單講：**CEH 讓你不再只站在 builder 視角，而會多一個 attacker 視角。**

#### 11.3 Attacking Network Protocols：把「request/response」看成真實封包

No Starch 官方頁與 TOC 很清楚列出：這本書從 `The Basics of Networking` p.1、`Capturing Application Traffic` p.11、`Network Protocol Structures` p.37、`Analysis from the Wire` p.79、`A Crash Course in Analysis with Wireshark` p.81、`Network Protocol Security` p.145、`Case Study: Transport Layer Security` p.172、`The Root Causes of Vulnerabilities` p.207、`Memory-Safe vs. Memory-Unsafe Programming Languages` p.210、`Command Injection` p.228、`SQL Injection` p.228、`Finding and Exploiting Security Vulnerabilities` p.233、`Data Execution Prevention` p.267、`ASLR` p.270 一路鋪下去。([No Starch Press][7])

這本最適合補 W2 的地方有三個：

第一，它讓你知道網路不是黑箱。
第二，它把 Wireshark、strace、DTrace、ProcMon 這類「看現場真相」的工具放進心智模型。
第三，它把協定、封包、TLS、memory corruption、injection 與 exploit 接起來，讓你知道網路問題最後很可能會變成程式安全問題。([No Starch Press][7])

#### 11.4 Computer Security: Art and Science, 2nd：把你的設計從「能跑」升到「值得信任」

Pearson 官方與 sample pages 顯示，這本書對這門課非常補。它的主幹包括 `Chapter 2 Access Control Matrix` p.31、`Chapter 14 Design Principles` p.455，其中 `Least Privilege` p.457、`Fail-Safe Defaults` p.458、`Economy of Mechanism` p.459、`Complete Mediation` p.460、`Least Astonishment` p.464；後面還有 `Chapter 25 Auditing` p.879、`Chapter 26 Intrusion Detection` p.917、`Chapter 27 Attacks and Responses` p.959、`Chapter 28 Network Security` p.1005、`Chapter 29 System Security` p.1035，以及 `Chapter 31 Program Security`。([PTG Media][3])

這本對 W2 的價值在於：它會把你的 PRD / SDD / agent constraints / logging / audit / code review 這些工程習慣，變成有理論支撐的設計法則。它不是「資安考古題書」，而是**教你如何設計一個即使出問題也能被理解、被控制、被追查的系統**。([Pearson][8])

---

## 第 12 章：如果你真的想從零一路念到面試，最好的讀法是這樣

#### 12.1 概念主線只背這五句

1. **需求先於程式碼。**
2. **架構先於最佳化。**
3. **驗證先於信任。**
4. **最小權限先於方便。**
5. **可維護性先於花招。**

這五句幾乎把整門課壓完了。  

#### 12.2 學習順序

第一輪，你先把這份筆記讀熟，特別是第 2、4、5、6、8、9 章。
第二輪，自己做一個 **純 CLI、200–500 行、輸入輸出清楚、能延伸到 v2 的專案**。這其實就是 HW2 的訓練哲學。 

第三輪，強迫自己寫出一份 `sdd_v1.md`，再假設 v2 需求來了，要求自己做到**向下相容、架構變動最小化、Mermaid 圖同步更新**。HW2 的高分邏輯其實很清楚：不是看誰寫得最花，而是看誰的 v1 就已經預見了 v2 的演化方向。

第四輪，配 OSC 10th 把 process、thread、memory、I/O、file system、security/protection 補齊。這一步是你從「會用 AI」升級到「知道系統為什麼這樣設計」的關鍵。([Wiley Catalog Images][1])

#### 12.3 選技術棧的小技巧

補充講義有一個很實用的提醒：主流框架、主流工具、主流生態，通常讓 AI 的輔助品質更好；超冷門棧則更容易讓 AI 幻覺。對新手來說，這不是叫你盲目追熱門，而是先利用網路效應站穩，再慢慢擴張。

---

## 第 13 章：面試最常被問的 8 題，你可以直接這樣答

#### Q1：PRD 跟 SDD 差在哪？

PRD 定義產品目標、使用者需求與成功標準；SDD 把 PRD 轉成技術架構、模組、資料流、錯誤處理與測試計畫。PRD 講 **what/why**，SDD 講 **how**。

#### Q2：為什麼 AI coding 不能一次寫完？

因為一次產出的大型程式難驗證、難除錯、難維護。正確做法是從 MVP 開始，按依賴順序逐步擴充，讓每一階段都能單獨驗證。 

#### Q3：你怎麼跟 AI 協作？

我先收斂需求、寫 PRD/SDD、畫 Mermaid、定義 constraints 與 tests，再讓 AI 在邊界內高速實作；我自己負責架構審查、邏輯驗證、安全邊界與最終交付。 

#### Q4：Process 跟 Thread 差在哪？

Process 是執行中的程式與其資源集合；thread 是 process 內較輕量的執行流。多 thread 適合共享同一個 process 的資源，但也更容易碰到 race condition 與 synchronization 問題。([Wiley Catalog Images][1])

#### Q5：Race condition 跟 deadlock 差在哪？

Race condition 是「誰先碰到共享資源」造成結果不穩；deadlock 是彼此互等、誰都不能前進。前者像搶先寫同一筆資料，後者像兩把鎖互相卡住。([Wiley Catalog Images][1])

#### Q6：為什麼你會用 Mermaid？

因為它能把口語需求壓縮成結構化圖，減少歧義，幫助 AI 與人類一起理解系統流程、資料流與元件關係。

#### Q7：你怎麼看待 AI 生成但你看不懂的 code？

不採用，或者先重構到可理解、可 review、可測試為止。不能 maintain 的 code，不管是人寫還是 AI 寫，都不該交付。

#### Q8：什麼是 least privilege？

只給模組或 agent 完成工作所需的最小權限。例如查股價工具不需要 shell write-all 權限；能只讀檔就不要給刪檔權限；能只讀特定 env 就不要開全域 env。 ([PTG Media][3])

---

## 第 14 章：最後幫你濃縮成一段「真正像面試者」的自我表述

你可以把整門課的核心濃縮成這段話：

> 我現在看 AI 輔助開發，不是把它當自動寫碼機，而是把它當高速度實作層。真正關鍵的是需求定義、PRD/SDD、架構圖、約束條件、測試與風險控制。我習慣先把模糊需求升維成藍圖，再按 phase 降維成可執行版本；先做 MVP，再做資料落地、分析與最佳化；同時用最小權限、fail-safe defaults、可維護性與驗證機制去守住品質。這也是我理解的 agentic engineering：人負責方向與責任，AI 負責速度。

這段如果你真的理解了，W2 你就不是「有修過」，而是「有吃進去」。

---

如果你要，我下一則可以直接幫你把這份再壓成 **「期中/面試背誦版」**，做成 20 題必背口袋筆記。

[1]: https://catalogimages.wiley.com/images/db/pdf/9781119439257.toc.pdf "https://catalogimages.wiley.com/images/db/pdf/9781119439257.toc.pdf"
[2]: https://nostarch.com/download/samples/ANP_TOC.pdf "https://nostarch.com/download/samples/ANP_TOC.pdf"
[3]: https://ptgmedia.pearsoncmg.com/images/9780321712332/samplepages/9780321712332_Sample.pdf "https://ptgmedia.pearsoncmg.com/images/9780321712332/samplepages/9780321712332_Sample.pdf"
[4]: https://www.wiley.com/en-us/Operating%2BSystem%2BConcepts%2C%2B10th%2BEdition-p-9781119800361 "https://www.wiley.com/en-us/Operating%2BSystem%2BConcepts%2C%2B10th%2BEdition-p-9781119800361"
[5]: https://www.wiley.com/en-ca/CEH%2BCertified%2BEthical%2BHacker%2Bv13%2BStudy%2BGuide-p-00466072 "https://www.wiley.com/en-ca/CEH%2BCertified%2BEthical%2BHacker%2Bv13%2BStudy%2BGuide-p-00466072"
[6]: https://books.google.com/books/about/Certified_Ethical_Hacker_CEH_Study_Guide.html?id=RLZxEQAAQBAJ "https://books.google.com/books/about/Certified_Ethical_Hacker_CEH_Study_Guide.html?id=RLZxEQAAQBAJ"
[7]: https://nostarch.com/networkprotocols "https://nostarch.com/networkprotocols"
[8]: https://www.pearson.com/en-gb/subject-catalog/p/computer-security-art-and-science/P200000000134/9780134097176?srsltid=AfmBOorE0V-cASw1Q_EFgTmmywkyBUMuvfTn7evo9u4QCEzIo6Qg0-aJ "https://www.pearson.com/en-gb/subject-catalog/p/computer-security-art-and-science/P200000000134/9780134097176?srsltid=AfmBOorE0V-cASw1Q_EFgTmmywkyBUMuvfTn7evo9u4QCEzIo6Qg0-aJ"
