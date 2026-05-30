# TAICA AIASE W3 Note

下面這份我幫你重寫成一份真正能拿來反覆讀、反覆背、反覆拿去做作業與面試的 **「一本到面試版詳細筆記」**。主體以你上傳的 **W3：From Agentic Product to Agentic Engineering** 為核心，再把課綱、HW2 的 SDD / 向下相容要求、以及前面錄音整理中提到的 **anti-DDoS、MVP、記憶體管理、地端部署、RAG、Token 控管、Prompt Injection、Rust / n8n / Mermaid** 等內容全部串成一條完整學習路線。這門課本來就不是只教 Prompt，而是要你從需求、架構、實作、部署、維運、觀測到安全，一路做出可展示的生成式 AI 系統；W3 則是整條路線的中樞轉折。

---

# **taica_aiase_W3：From Agentic Product to Agentic Engineering**
一本到面試版：Agentic Engineering 詳細筆記，把課綱、HW2 的 SDD / 向下相容要求、以及前面 course 中提到的 **anti-DDoS、MVP、記憶體管理、地端部署、RAG、Token 控管、Prompt Injection、Rust / n8n / Mermaid** 等內容全部串成一條完整學習路線。

## 0. 先講結論：這週最重要的一句話

**Agentic Engineering = 把 LLM 從「只會回答」的模型，變成「會規劃、會呼叫工具、會觀察結果、會持續迭代、但仍受規格與安全邊界約束」的工程系統。**
如果你把這句話真的讀懂，後面所有名詞——ReAct、RAG、MCP、HITL、Guardrails、Eval、Observability、LLMOps——都會開始有位置。W3 的核心就是：**AI 不再只是函式庫，而是程式控制流程的一部分；因此你要學的就不是單點技巧，而是整個系統如何可靠地讓 AI 參與決策。**

---

## 1. 這門課到底要把你訓練成什麼人？

這門課不是要把你訓練成「很會問 AI 的人」，而是要把你訓練成能設計、實作、部署、維運與防禦生成式 AI 系統的人。課綱明確寫到，學生要能理解整體架構、熟悉 SDLC、建構 RAG、整合 CI/CD 與 LLMOps、掌握 Agent workflow / MCP / agent-to-agent、理解 token 經濟學與幻覺抑制、以及實作 prompt injection 防禦與 response auditing。換句話說，這不是一門「模型介紹課」，而是一門 **AI 系統工程課**。

所以，W3 之所以關鍵，是因為它讓你第一次真正從「我會用 ChatGPT」跨到「我知道怎麼設計一個 Agent 系統」。課程目標也明寫：理解架構、設計單一與多 Agent 系統、撰寫 Spec、設計防禦策略、建立 Observability、做工程選型。這六件事，剛好就是面試時最容易把「只是會用工具」與「真的懂工程」分開的地方。

---

## 2. 為什麼現在不能只當「寫 code 的人」？

課程前半段用了很多 AI 時代的職場衝擊來鋪陳：工程師的純虛擬工作內容最容易被 AI 吃掉，因此真正不容易被取代的能力，會慢慢轉向 **系統設計、問題定義、跨域溝通、審查與判斷**。W3 明確把未來的鐵三角拆成：
人類負責市場與問題拆解的 Navigator、負責架構與監督的 Agent Architect、以及負責大量執行的 AI Agents。這其實在告訴你：**你的價值不再只在寫出某一段 code，而在定義什麼該被做、怎麼做、做到哪裡停、怎麼保證不出事。**

這也是為什麼課堂花很大篇幅談 **AI-Native**、談 SaaS 正在被 outcome-based 服務侵蝕、談 Palantir 式的垂直深耕。因為未來市場不只需要一個「功能」，而是需要一個能自動完成成果的「系統」。對學生來說，最重要的轉念是：
不是問「我會哪個框架？」
而是問「我能不能把模糊需求轉成可靠流程？」

面試時，這一段可以翻成一句很強的話：
**AI 讓實作成本下降，但讓架構、邊界、驗證與責任變得更重要。**

---

## 3. 什麼是 Agent？先用最白話的方式理解

### 3.1 傳統 LLM 跟 Agent 的差別

傳統 LLM 的心智模型是：

使用者輸入 → 模型回文字 → 結束。

Agentic 系統的心智模型則是：

使用者給目標 → Agent 思考 → 選工具 → 執行 → 觀察結果 → 再思考 → 再行動 → 直到達成目標或被中止。

這裡最大的本質差異叫做 **控制流程轉移**。以前 if/else 是你寫死的；現在是模型根據當前狀態動態決定下一步。所以你的工程任務也從「確保每條路徑正確」變成「確保模型在各種情況下都不會亂跑」。這就是 Agentic Engineering 最難、也最有價值的地方。

### 3.2 你一定要會背的五個層次

課程把 LLM 應用分成五層：

1. **Completion**：單輪問答，例如翻譯、摘要。
2. **Chain**：固定流程串接，例如先摘要再翻譯。
3. **RAG**：先查資料再回答。
4. **Agent**：模型自己決定何時用哪個工具。
5. **Multi-Agent**：多個 Agent 分工合作。

這五層很好用，因為它讓你一眼看出一個系統到底在什麼成熟度。很多人說自己做的是 agent，其實只是多步驟 chain；很多人說自己做的是 multi-agent，其實只是把同一個模型切成幾個 prompt 而已。真正的判斷標準是：
**流程是人類寫死的，還是模型動態決定的？**

---

## 4. Agent 的四大要素：Perception、Memory、Reasoning、Action

這四個字你一定要真正內化，因為它們幾乎可以拿來拆任何 Agent 系統，也非常適合當面試回答骨架。課程也把它明確列成核心框架。

### 4.1 Perception：Agent 看得到什麼？

**白話定義**：Perception 是 Agent 的眼睛、耳朵與感測器。
**工程定義**：所有會進入模型上下文的輸入，包括文字、JSON、CSV、圖片、PDF、工具回傳結果、系統錯誤訊息與環境狀態。
**核心觀念**：在 Agent 世界裡，垃圾輸入不只是產生爛回答，而是會污染後面整條推理鏈。這就是為什麼工具輸出格式設計很重要。

**例子**
你做一個收據轉 Excel Agent。它不是只看「圖片」而已，而是要看：
OCR 結果是不是結構化？日期格式是否統一？金額欄位是否可解析？是否有錯誤標記？
如果 OCR 工具只吐一大坨凌亂文字，後面的 Agent 就很容易判錯欄位。這就是 perception engineering。

**常犯錯**
把工具回傳當作「隨便能看懂的文字」。
其實越是 Agent 系統，越該把工具輸出整理成清楚的欄位、型別與狀態碼。

**面試說法**
「我會先檢查 agent 的 perception 層，確認輸入是不是對模型友善，因為錯誤輸入會被多步驟推理放大。」

---

### 4.2 Memory：Agent 怎麼記住東西？

課程把記憶分成四類：
**In-context**、**Episodic**、**Semantic**、**Procedural**。

**In-context memory** 是當前 context window 內的短期記憶；
**Episodic memory** 是跨任務保存的歷史紀錄；
**Semantic memory** 就是知識庫，通常透過 RAG 取得；
**Procedural memory** 則是技能本身，也就是 tools / code / callable functions。

這裡最容易被零基礎同學誤解的是：
**模型 API 本身通常是 stateless 的。**
也就是說，它不會替你自動記得上一輪對話；你必須自己在伺服器端管理 session，把歷史上下文再送回模型。錄音整理也特別強調了這點。

**生活例子**
ChatGPT 左邊每一個聊天視窗，本質上都像一個 session。
你換新視窗再問前一個視窗談過的事，它通常不知道。
企業客服 Agent 也是一樣：如果不設計 session / memory store，它根本不會連續地記得你上一輪抱怨過什麼。

**工程問題不是「能不能記」，而是三件事：**
什麼時候寫入？
什麼時候讀出？
什麼時候遺忘？

**面試說法**
「我不會把所有記憶都丟進 context。短期狀態放 in-context，知識查詢交給 RAG，跨任務紀錄放 episodic store，技能能力則透過 tool registry 管理。」

---

### 4.3 Reasoning：Agent 怎麼想？

課程列了四種主流推理方式：
ReAct、Reflection、Chain-of-Thought、Tree-of-Thought。真正工程裡最常見的是前兩個：**ReAct** 與 **Reflection**。

Reasoning 不是「讓模型變聰明」這麼抽象，它的工程問題其實很務實：

* 何時該規劃？
* 何時該停？
* 何時該懷疑自己？
* 何時該請人確認？
* 何時該換工具或降級？

所以真正的 reasoning design，不只是 prompt 寫漂亮，而是 **把停止條件、錯誤回報、風險等級與自我修正機制都設計進去。**

---

### 4.4 Action：Agent 怎麼改變世界？

很多人會把「會回話」跟「會行動」混為一談，但課程非常明確：
Tool / Function Calling 的本質，是 LLM 輸出一個結構化的意圖，再由外部程式真正執行。也就是說，模型不是直接操作世界，而是透過工具介面表達它想做什麼。

**白話翻譯**
LLM 像腦袋，工具像手腳。
沒有工具，它只有想法；有工具，它才真的能查、算、寫、送、改、部署。

**例子**
send_email、read_file、create_issue、query_db、run_code、deploy_service 都是 actions。

**這一段最重要的工程原則有三個：**
原子性、可組合性、安全邊界。
一個工具最好只做一件清楚的事，才不會讓模型誤用；工具輸出最好能接到下一個工具；危險操作一定要有明確授權與可回滾設計。

---

## 5. 你一定要會的三大 Agent Pattern

### 5.1 ReAct：最基礎、最重要、最常用

ReAct = **Reason + Act**。
流程是：Thought → Action → Observation → 再 Thought。
這是今天幾乎所有能工作的 Agent 系統最基本的骨架。課堂舉的例子是先找科技公司、再查股價、再算平均。這種一邊想一邊做的循環，就是 ReAct。

**適用場景**
需要查資料、需要多步驟工具呼叫、需要依觀察結果調整下一步的任務。

**優點**
簡單、彈性高、可直接上手。

**缺點**
容易迴圈過久；若沒有好停止條件與錯誤回報，會一直亂試。

**面試一句話**
「ReAct 適合開放型任務，因為它允許模型根據 observation 動態調整行動，而不是預先寫死流程。」

---

### 5.2 Reflection：生成之後，強迫自己批評自己

Reflection 是：
先產生答案，再讓另一個 critic 視角去挑毛病，再修正。
這很適合拿來做程式碼審查、文件定稿、測試補洞、風險評估。課程也提醒：critic 的標準必須明確，否則會變成無限修稿機器。

**你可以把它想成：**
寫作時先有初稿，再有編輯。
工程裡它最像 code review。

**面試一句話**
「Reflection 的價值不在多跑一次模型，而在把品質評估顯式化，讓系統具備自我審查能力。」

---

### 5.3 Plan-and-Execute：長任務先想清楚再做

如果任務很長、很複雜、成本很高，就不適合一路 ReAct 到底。
Plan-and-Execute 會先產生完整計畫，再交給 executor 逐步執行，最後再由 evaluator 檢查品質。它比 ReAct 穩，因為很多規劃錯誤可以在執行前就被抓出來。

**典型情境**
「幫我分析 50 份 PDF，找出研究方法相似群組，做出文獻綜述大綱。」
這種任務若沒有先規劃，執行過程非常容易漂移。

---

## 6. 為什麼會需要 Multi-Agent？

很多人一開始就想做 Multi-Agent，這通常是錯的。課程很明確：**先讓單一 Agent 可靠，再考慮拆分。** 因為 Multi-Agent 帶來的不是魔法，而是新的分散式系統問題：狀態同步、任務切分、錯誤傳播、路由決策、衝突解決。

真正需要 Multi-Agent 的原因，課程列了四個：

1. context window 不夠；
2. 單一 agent 不夠專業；
3. 想做平行化；
4. 想建立互相制衡的驗證機制。

### 6.1 幾種常見拓樸

**Orchestrator-Subagent**：協調者負責拆任務，子 agent 各自做專業工作。
**Supervisor**：中央持有全域狀態，動態決定把任務派給誰。
**Pipeline**：線性加工，非常好理解，但任何一節出錯都可能整條斷。
**Debate**：兩個 agent 互相挑戰，再由 judge 收斂答案。非常適合高風險決策與安全審查。

**很像現實公司的分工：**
研究員找資料、分析師整理、編輯潤稿、主管核准。
只不過這些角色部分被 agent 化了。

---

## 7. MCP、RAG、Session：三個常被混淆但其實完全不同的東西

### 7.1 MCP 是什麼？

MCP（Model Context Protocol）是工具整合協定。
它的重點不是「多一個工具」，而是 **讓不同 Agent 可以用統一方式去接不同工具與資源**，降低 n 個 Agent × m 個工具的客製整合地獄。課程把 MCP 元件拆成 tools、resources、prompts；也指出它對 codebase 理解、Git / CI / DB 整合、multi-agent 協作與新人 onboarding 都很重要。

### 7.2 RAG 是什麼？

RAG 不是 Agent，也不是記憶體的全部。
RAG 是把 **知識檢索** 接進回答流程。
它的價值是減少幻覺，讓模型先根據檢索到的事實再生成答案。錄音整理把它用在企業知識問答、人資規章、向量資料庫、語意搜尋等場景，這些都很典型。

### 7.3 Session memory 是什麼？

Session memory 是你在服務端幫對話維持狀態。
它解決的是「模型 API 無狀態」的問題，而不是知識正確性。
所以：

* RAG 解決「不知道正確知識」；
* Session memory 解決「不記得剛剛聊到哪」；
* MCP 解決「怎麼統一連工具」。

這三件事不能混為一談。

---

## 8. CLI-first：為什麼課堂一直強調命令列工作流？

因為 Chat 視窗只能讓你「得到建議」，CLI Agent 才能讓你「完成工程」。
W3 明講：Chat 是思考工具，CLI 是執行工具；工程能力真正成長，通常發生在你讓 agent 讀 repo、跑測試、改檔、執行命令、接 CI/CD、接工具鏈的時候，而不是在瀏覽器裡貼幾段程式碼的時候。

課程之所以看重 CLI-first，有四個原因：

1. 它強迫透明度；
2. 它可組合、可腳本化；
3. 它不容易脈絡斷裂；
4. 它更接近真實工程環境。

錄音整理也呼應了這一點：實務上常先從 CLI 做出基礎版本，再接 Jupyter / Colab / Streamlit / Gradio 當展示層或測試層，中間甚至要寫 adapter 把不同介面串起來。這其實就是「先把核心能力做好，再包裝介面」的工程思維。

**面試很常問：為什麼不是直接 Web UI？**
答法很簡單：
**因為 CLI 讓核心流程更容易測試、腳本化、版本控制與自動化，先把內核穩住，再做 UI。**

---

## 9. SDD：這堂課真正想教你的核心習慣

### 9.1 為什麼 SDD 這麼重要？

課程對 SDD 的定義非常硬：
SDD 不是模糊的 PRD，而是 **可執行規格**。
在 Agent 世界裡，System Prompt 就是行為規格，Tool Schema 就是 API Contract，Eval Cases 就是測試規格。也就是說，Agent 系統不是靠靈感維護，而是靠規格驅動迭代。

這也是 HW2 要你做的事：
先交 v1.0 SDD 與 CLI 程式；
截止後由 Agent 讀你的規格與實作，自動產出 v2.0 需求；
你再用向下相容的方式完成架構演化。
這其實非常像真實工程：**需求後來改了，但舊介面不能爆；架構要升級，但既有用戶不能痛。**

### 9.2 一份好的 SDD 會包含什麼？

HW2 已經把答案寫給你了：

* Project overview
* CLI interface specification
* Data model
* Module design
* Error handling
* Test cases
* v2 階段再加 Mermaid 架構圖、Sequence / Flowchart、Backward compatibility 設計、Migration strategy、README 的設計決策說明。

### 9.3 這件事跟找工作有什麼關係？

非常有關。
因為公司最怕的不是新功能做不出來，而是：

* 需求變了你只會重寫；
* 規格不清你只會猜；
* 舊介面不能動你就卡死；
* 架構圖、README、測試案例、遷移策略全部講不清楚。

HW2 的評分標準也非常直白：
重視 SDD 品質、重視向下相容、重視最小化架構變動、重視 README 裡你對設計決策的解釋。最高分策略甚至直接寫出來：**v1.0 就先預見 v2.0 的可能方向，讓後續幾乎不用大重構。** 這本質上就是 junior 跟更成熟工程師的差別。

---

## 10. 「雪球式開發」：AI 時代最務實的工程哲學

錄音整理與 W3 都反覆強調：
不要一開始就要求 AI 幫你寫一個巨大、完整、包山包海的系統。
因為你若對問題理解不夠，AI 只會更快地幫你把錯誤放大。真正正確的方式是從最小可用系統開始，逐步加功能、逐步驗證、逐步擴張。這就是課程說的 **雪球式開發**。

課程的 6 步驟其實非常值得背：

1. 單工具、單輪對話；
2. 多工具選擇；
3. 加迴圈與停止條件；
4. 加 memory；
5. 加 reflection；
6. 最後才拆成 multi-agent。

**這個哲學的底層精神是：**
能除錯的複雜度，才是好複雜度。
一個一開始就很酷的系統，如果無法定位錯在哪，其實等於沒工程價值。

---

## 11. 安全、風險、責任：Agentic 系統最容易被低估的部分

### 11.1 Prompt Injection

課程把 prompt injection 放得很前面，因為 Agent 系統一旦會讀網頁、讀文件、讀外部資料，就可能被惡意內容騙去執行不該做的事。這跟傳統 injection 很像，但更危險，因為它攻擊的是模型的「理解與決策」。W3 也明白寫到：這是整個 AI 產業的開放難題之一。

### 11.2 Goal Misalignment

有時 agent 不是不聰明，而是太會找捷徑。
你要它「快速完成」，它可能犧牲品質；
你要它「找到答案」，它可能用不該用的資料。
所以 constraints、guardrails、risk policy 不能省。

### 11.3 過度自主

課程也明講：高風險操作一定要設 HITL。
低風險如讀檔、查資料可自動；
中風險如寫檔、付費 API 建議確認；
高風險如刪資料、轉帳、部署 production 必須人工核准。

### 11.4 最小權限與沙箱

Agent 最危險的地方，不是它會思考，而是它真的有權限。
所以課程要求你把檔案系統、資料庫、API、程式執行環境、網路存取都縮在最小授權內；Cowork 案例也用 VM / 沙箱 / folder mount 來限制操作範圍。

### 11.5 工程責任不能推給工具

錄音整理裡有一段很值得記：第三方只賣你 license，不替你對專案結果負責；AI 也一樣。最後責任還是在開發團隊身上。這段非常像現實商業世界。工程師不能說「這是 AI 決定的」。系統邊界、工具權限、審核流程、錯誤回滾，都是你設計的，所以責任也回到你身上。

---

## 12. 可觀測性與 Eval：為什麼沒有這兩個，Agent 幾乎不可能上線？

### 12.1 Observability 三大支柱

Agent 系統比傳統系統更需要 observability，因為執行路徑是動態的、相同輸入可能走不同路徑、錯誤可能在很後面才爆、而且多 agent 的因果鏈很難追。課堂把觀測拆成三大支柱：

* **Traces**：完整執行鏈；
* **Metrics**：延遲、成功率、token、retry 等數值；
* **Logs**：結構化事件紀錄。

你要能回答：
這個任務花了多久？
總共叫了幾次工具？
哪一步最慢？
哪一步重試最多？
哪個 prompt 版本造成成功率下降？
如果你答不出來，系統就還沒到可維運。

### 12.2 Eval-Driven Development

課程另一個非常強的觀念是：
**不要靠直覺改 prompt。先建立 eval，再改。**
Eval 可以是 exact match、semantic match、LLM-as-judge。核心流程是：建立 golden dataset、定義標準、自動化執行、追蹤 regression。這套觀念其實就是把傳統測試工程搬進 LLM 時代。

### 12.3 Prompt 版本管理與 LLMOps

W3 也把 prompt versioning、LangSmith / Langfuse / Weave、部署模式、LLMOps 循環、token 預算控管講得很完整。
你可以把 LLMOps 理解成：
**開發 → 評估 → 部署 → 監控 → 回頭調整**。
如果沒有這條 loop，系統通常只會停在 demo。 

---

## 13. Token、Session、Cache、成本：不懂這些，AI 專案很快就會燒錢

錄音整理把 token 成本講得很務實：
API 計費直接綁 token，若你每輪都把很長的歷史對話整包送進去，成本會快速暴增。所以實務上要做 sliding window、摘要替換、語意快取、工具結果截斷與模型分層。W3 也給了對應策略表。

這裡最容易考倒人的面試問法是：

**Q：為什麼 chat history 不能一直無限累加？**
因為它同時打爆三件事：context window、延遲、成本。
而且太長的舊訊息還會稀釋新任務的重要性。

---

## 14. anti-DDoS、Rate Limiting、Retry：外部服務整合的基本功

這部分是很多只會寫 demo 的人最常忽略的。錄音整理明確提到：
如果你對股票或其他外部資料來源短時間內連發上千次請求，很容易被判定為攻擊而被封鎖，所以程式要設 timing interval、sleep，必要時做 exponential backoff。這不是小技巧，而是接外部服務的基本禮貌與工程穩定性。

W3 則把 retry / fallback / escalation 系統化地寫成四層：

1. 自動重試；
2. 降級到備用工具；
3. 告訴 agent 失敗了，讓它自行改策略；
4. 關鍵錯誤升級給人類。

這段很像 SRE / distributed systems 的思維，所以也正是這門課真正有工程味的地方。

---

## 15. 地端部署、Prompt Injection、防污染、n8n：從 demo 走向真實場景

錄音整理的最後一段其實非常適合拿來當「商業級 AI 系統」範例。
它談的是高敏資料場景，例如反詐騙語音分析、醫療敏感音檔。在這種情境下，資料不能隨便上雲，所以要考慮 **On-Premise**、GPU 叢集、本地 ASR / LLM、低延遲架構，以及針對 prompt injection / data poisoning 的特別防禦。它還談到用 n8n 做監控與自動化工作流、在高併發下用 Rust 改寫底層服務突破 Python 瓶頸。這整段很好地示範了：AI 工程不是只有模型本身，而是整個運算環境與治理體系。

---

## 16. 為什麼老師一直提記憶體管理？因為這是最容易被 AI 初學者忽略的真相

錄音整理裡有兩段非常值得背。
第一段是資深工程師直接砍掉底層模組重寫，因為記憶體管理設計從根上有問題。第二段是投入很多硬體成本，結果系統因為架構糟糕與記憶體管理差，只能撐 500 個併發使用者。這兩段其實都在講一件事：**硬體無法補救壞架構。**

這也正是你前面一直要我強調 **Operating System Concepts, 10th** 的原因。因為很多 Agent 系統最後死掉，不是因為 prompt 不夠漂亮，而是因為：

* process / thread 切分不好；
* queue / IPC 設計亂；
* memory leak；
* context 管理太肥；
* lock / concurrency 出問題；
* I/O 與 file system 壓力沒想清楚；
* sandbox / permission 邊界太鬆。

這些本質上都已經不是「AI 技巧」，而是 **系統工程**。

---

## 17. 為什麼 Operating System Concepts 10/e 是最重要的外部補書？

因為這本書可以把課堂上看似新潮的 Agent 系統，全部拉回底層現實。

### 17.1 先讀這一組：把 Agent 看成受控的系統能力呼叫

先讀 **1.1 What Operating Systems Do（p.4）**、**1.6 Security and Protection（p.33）**、**1.7 Virtualization（p.34）**、**2.1 Operating-System Services（p.55）**、**2.3 System Calls（p.62）**。
這一組會幫你建立一個很關鍵的對應：**Agent 的 tool call，本質上就是高階應用對底層系統能力的受控呼叫。** 沙箱、權限、系統服務、system call 這些概念，都是 Agent 工具使用的底層語言。([Wiley Catalog Images][1])

### 17.2 再讀這一組：把 Agent / Worker / Queue 看成 process 與 concurrency 問題

接著讀 **3.1 Process Concept（p.106）**、**3.4 Interprocess Communication（p.123）**、**3.8 Communication in Client-Server Systems（p.145）**、**4.1 Overview（p.160）**、**5.1 Basic Concepts（p.200）**、**6.5 Mutex Locks（p.270）**、**8.1 System Model（p.318）**、**8.4 Methods for Handling Deadlocks（p.326）**。
這一組對應到的就是 API server、background worker、queue、multi-agent communication、共享狀態、競態條件、死鎖與調度。只要你的系統要「多步驟」「多任務」「多人同時使用」，這些章節就直接變成現實問題。([Wiley Catalog Images][1])

### 17.3 第三組最重要：記憶體與擴容

然後讀 **9.1 Background（p.349）**、**9.3 Paging（p.360）**、**10.2 Demand Paging（p.392）**、**10.6 Thrashing（p.419）**、**10.8 Allocating Kernel Memory（p.426）**、**20.6 Memory Management（p.795）**。
這一組直接對應錄音裡反覆提醒的「記憶體管理」與「系統撐不住」。RAG cache、長對話 context、embedding index、worker process、模型服務，如果你不知道 page fault、swap、thrashing、allocation 壓力在幹嘛，你就很難真正理解為什麼 demo 可以，上線卻卡死。([Wiley Catalog Images][1])

### 17.4 第四組：資料、保護、虛擬化、分散式

再讀 **12.1 Overview（p.489）**、**12.4 Kernel I/O Subsystem（p.508）**、**13.1 File Concept（p.529）**、**13.4 Protection（p.550）**、**15.4 File Sharing（p.602）**、**15.6 Remote File Systems（p.605）**、**16.1 The Security Problem（p.621）**、**16.5 User Authentication（p.648）**、**17.2 Principles of Protection（p.668）**、**17.8 Role-Based Access Control（p.683）**、**17.9 Mandatory Access Control（p.684）**、**18.1 Overview（p.701）**、**18.6 Virtualization and Operating-System Components（p.719）**、**19.3 Communication Structure（p.738）**、**19.5 Design Issues in Distributed Systems（p.753）**、**19.6 Distributed File Systems（p.757）**。
這一組會把你對 sandbox、RBAC、MCP server、remote file access、分散式 worker、on-prem / VM 的理解，從表面名詞變成可推理的系統知識。([Wiley Catalog Images][1])

### 17.5 這本書要怎麼讀才最有效？

最有效的讀法不是逐章背定義，而是每讀一節都問自己：

* 這對應我系統裡哪個元件？
* 這個元件在高併發下會怎麼壞？
* 這個問題是 process / memory / I/O / permission / distributed 哪一層？
* 如果 agent 做錯一步，底層哪個資源會先爆？

這樣讀，作業系統就不再是考古，而是 AI 工程的底層現實課。

---

## 18. 另外三本書怎麼配這門課讀？

### 18.1 CEH Study Guide：建立攻擊者思維

這本比較像「攻擊面 checklist」。
可優先看 **Chapter 2 Information Gathering for the Ethical Hacker（p.41）**、**Chapter 3 Scanning and Enumeration（p.69）**、**Chapter 4 Sniffing and Evasion（p.111）**、**Chapter 5 Attacking a System（p.151）**、**Servers and Applications（p.193）**、**Chapter 11 Cryptography（p.327）**、**Social Engineering and Physical Security（p.359）**、**Chapter 13 Artificial Intelligence for the Ethical Hacker（p.385）**、**Putting It All Together（p.401）**。
對這門課來說，它最有價值的地方是讓你知道：你設計的 agent、API、tool server、crawler、internal knowledge bot，會被怎麼摸、怎麼掃、怎麼繞。([Google Books][2])

### 18.2 Attacking Network Protocols：把「網路風險」變成封包與根因

這本很適合補協定與漏洞直覺。
建議看 **Chapter 2 Capturing Application Traffic（p.11）**、**Chapter 3 Network Protocol Structures（p.37）**、**Chapter 5 Analysis from the Wire（p.79）**、**Chapter 7 Network Protocol Security（p.145）**，其中 **TLS Handshake（p.172）**、**Endpoint Authentication（p.174）**；再讀 **Chapter 9 The Root Causes of Vulnerabilities（p.207）**，其中 **Authentication Bypass（p.209）**、**Memory Corruption Vulnerabilities（p.210）**、**Memory Exhaustion Attacks（p.222）**、**CPU Exhaustion Attacks（p.224）**、**Command Injection / SQL Injection（p.228）**；最後看 **Chapter 10 Finding and Exploiting Security Vulnerabilities（p.233）**，其中 **Fuzz Testing（p.234）**、**Vulnerability Triaging（p.236）**。
這本特別適合搭配課程裡的 anti-DDoS、rate limiting、retry、prompt injection、工具暴露面一起看。([No Starch Press][3])

### 18.3 Computer Security: Art and Science, 2nd：把安全做成設計原則

這本最適合補「設計觀」。
先看 **Ch.1 An Overview of Computer Security** 裡的 **Policy and Mechanism（p.9）**、**Assurance（p.12）**、**Specification / Design / Implementation（p.14–15）**；再看 **Ch.14 Design Principles（p.455）**，尤其 **Least Privilege（p.457）**、**Fail-Safe Defaults（p.458）**、**Economy of Mechanism（p.459）**、**Complete Mediation（p.460）**、**Open Design（p.461）**；接著看 **Ch.24 Vulnerability Analysis（p.825）**、**Ch.25 Auditing（p.879）**、**Ch.26 Intrusion Detection（p.917）**。
這本會讓你理解：為什麼 guardrails、HITL、audit log、RBAC、response auditing 不是加分功能，而是設計一開始就該存在的東西。([Matt's Web Pages][4])

---

## 19. 把這份筆記拿去做作業，該怎麼落地？

最直接的方法，就是每做一個專題，都逼自己回答下面 10 題：

1. 使用者真正的目標是什麼？
2. 這個系統是 Completion、Chain、RAG、Agent，還是 Multi-Agent？
3. Perception 是什麼？輸入格式怎麼清理？
4. Memory 怎麼分：in-context、RAG、episodic、procedural？
5. Reasoning 選 ReAct、Reflection 還是 Plan-and-Execute？
6. Action 有哪些 tools？tool schema 清不清楚？
7. 哪些操作要 HITL？哪些只能 read-only？
8. 失敗時會怎麼 retry、fallback、escalate？
9. 有沒有 traces、metrics、logs、eval、prompt versioning？
10. 如果使用者從 10 個變 10 萬個，process / queue / memory / I/O / permission 哪裡先爆？

只要這 10 題答得出來，你的專題通常就已經比大部分單純 demo 強很多。

---

## 20. 面試最常見的 10 題，你可以怎麼答

### Q1：什麼是 Agentic Engineering？

答：它是把 LLM 從單次回答模型，提升成能根據目標自主決策、呼叫工具、觀察結果、持續迭代的系統元件；工程重點不只在 prompt，而在 state、tool contract、risk boundary、observability 與 eval。

### Q2：Agent 跟 workflow chain 差在哪？

答：chain 的流程是人類預先寫死的；agent 的流程是模型動態決定的。差別在控制流程是否轉移給模型。

### Q3：為什麼 CLI-first 比純 chat 更適合工程？

答：因為 CLI 更接近真實 repo、命令執行、測試、自動化與 CI/CD。Chat 適合思考，CLI 適合完成工程。

### Q4：RAG 跟 session memory 有什麼差別？

答：RAG 解決知識正確性；session memory 解決上下文連續性；兩者用途不同，不應混用概念。

### Q5：怎麼防 prompt injection？

答：不能只靠 prompt，要做 input guardrails、來源隔離、least privilege、HITL、tool allowlist 與 output auditing。高風險場景還要把 agent 放進 sandbox。

### Q6：怎麼評估 agent 是否變好了？

答：先建 golden dataset，再做 exact match / semantic match / LLM-as-judge 的 eval；每次 prompt 版本更動都要自動重跑，避免 regression。

### Q7：什麼時候該用 multi-agent？

答：當單一 agent 遇到 context 限制、專業化不足、需要平行化或需要交叉驗證時，才值得拆分；否則先把單一 agent 做穩比較重要。

### Q8：為什麼要做 backward compatibility？

答：因為真實系統不可能每次需求更新就要求所有舊使用者重學介面。向下相容是工程成熟度的表現，也是 HW2 的核心訓練目標。

### Q9：生產環境最重要監控什麼？

答：trace 看整條執行鏈、metrics 看 latency / token / success rate / retry、logs 看結構化事件；沒有 observability，幾乎無法維運 agent 系統。

### Q10：為什麼作業系統知識對 AI 工程還重要？

答：因為 agent 一旦進入真實世界，最後都會落到 process、IPC、thread、memory、I/O、permission、virtualization、distributed systems 的問題。這些不是 AI 花招，而是系統是否能上線的基礎。([Wiley Catalog Images][1])

---

## 21. 最後幫你壓成一句真正該背的總結

**這堂課在教的，不是怎麼把 AI 接上去，而是怎麼把 AI 變成一個可規格化、可測試、可觀測、可擴展、可防禦、可負責任的系統。**
你只要把這句話吃透，再把今天這份筆記裡的四個主幹真正背起來——

1. Agent 四要素：Perception / Memory / Reasoning / Action
2. 工程主幹：SDD / Tool Schema / Eval / Observability
3. 可靠性主幹：HITL / Guardrails / Retry / Least Privilege
4. 底層現實：Process / Memory / I/O / Security / Virtualization / Distributed Systems

那你不只是能交作業，而是已經開始具備「把 AI 專案做成工程產品」的能力了。

下一步最適合把這份再壓成一份 **「考前 10 頁可背誦版」**，把每一段濃縮成口試與面試能直接講出口的版本。

[1]: https://catalogimages.wiley.com/images/db/pdf/9781119439257.toc.pdf "https://catalogimages.wiley.com/images/db/pdf/9781119439257.toc.pdf"
[2]: https://books.google.com/books/about/Certified_Ethical_Hacker_CEH_Study_Guide.html?id=RLZxEQAAQBAJ "https://books.google.com/books/about/Certified_Ethical_Hacker_CEH_Study_Guide.html?id=RLZxEQAAQBAJ"
[3]: https://nostarch.com/download/samples/ANP_TOC.pdf "https://nostarch.com/download/samples/ANP_TOC.pdf"
[4]: https://nob.cs.ucdavis.edu/book/book-aands2/files/ComputerSecurity2e_TOC.pdf "https://nob.cs.ucdavis.edu/book/book-aands2/files/ComputerSecurity2e_TOC.pdf"
