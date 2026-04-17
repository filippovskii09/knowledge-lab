# AI Fundamentals

Цей блок пояснює AI не як магічний чат, а як інженерну систему: **модель**, **prompt**, **context**, **tokens**, **retrieval**, **structured output**, **tools**, **integrations**, **MCP**, **skills**, **plugins** і **agent-like flows**.

Головна ціль блоку: навчитися дивитися на AI-рішення через компоненти, потоки даних, межі відповідальності та точки відмови.

---

## Scope

У цьому модулі ми закриваємо сім ключових тем:

1. Big Picture.
2. Models, Prompts, Context, Tokens, And Output.
3. AI Output Risk And Verification.
4. Engineering Tools, Integrations, And Ecosystem.
5. Structured Output, Embeddings, Retrieval, And Tools.
6. Components, Data Flow, Boundaries, And Constraints.
7. Pattern Selection And Tradeoffs.

---

## Learning Route

### 1. [Big Picture](./00-big-picture.md)
- AI як частина modern software development.
- Чому AI-рішення складається з кількох частин, а не з одного prompt.
- Де AI корисний, а де створює зайву складність.

### 2. [Models, Prompts, Context, Tokens, And Output](./01-models-prompts-context-tokens-and-output.md)
- Модель, prompt, context, tokens і generated output.
- Чому якість output залежить від контексту, меж і interaction design.
- Як думати про model call як про контрольований runtime step.

### 3. [AI Output Risk And Verification](./02-ai-output-risk-and-verification.md)
- Чому AI output може бути неправильним, неповним або переконливо оманливим.
- Як перевіряти AI-відповідь перед тим, як вона потрапить у код, документ або workflow.
- Чому verification має бути частиною дизайну системи.

### 4. [Engineering Tools, Integrations, And Ecosystem](./03-engineering-tools-integrations-and-ecosystem.md)
- Direct AI usage vs AI through integrations.
- Tools, integrations, skills, plugins, MCP connections and agents.
- Як AI підключається до IDE, design tools, docs і knowledge sources.

### 5. [Structured Output, Embeddings, Retrieval, And Tools](./04-structured-output-embeddings-retrieval-and-tools.md)
- Structured output для machine-readable responses.
- Embeddings і retrieval-supported flows.
- Tool-calling як спосіб дати AI контрольований доступ до зовнішніх дій.

### 6. [Components, Data Flow, Boundaries, And Constraints](./05-components-data-flow-boundaries-and-constraints.md)
- Як розкладати AI-систему на компоненти.
- Де проходять межі між model, application logic, external tools and human review.
- Як constraints захищають систему від неконтрольованої поведінки.

### 7. [Pattern Selection And Tradeoffs](./06-pattern-selection-and-tradeoffs.md)
- Prompting, retrieval, tool-augmented flows and agent-like designs.
- Коли ecosystem components додають цінність, а коли тільки ускладнюють систему.
- Як пояснювати AI patterns іншим інженерам.

---

## Стандарт статей цього блоку

Кожна стаття має:

- `Теза`
- `Приклад`
- `Просте пояснення`
- `Структурна модель`
- `Технічне пояснення`
- `Візуалізація`
- `Edge Cases / Підводні камені`
- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Пояснити AI-систему як pipeline, а не як “розумний prompt”.
2. Відрізняти model behavior від application logic, retrieval, tools і integrations.
3. Проєктувати AI-assisted workflow з context, constraints, verification and fallback.
4. Вибирати між prompting, retrieval, structured output, tool-calling and agent-like flows.
5. Розуміти, коли AI-компонент зменшує роботу, а коли створює нові ризики.

