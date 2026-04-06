# Asynchrony & Event Loop

Цей блок пояснює, як JavaScript поводиться **не лише як мова**, а як код усередині **runtime-середовища**: браузера або Node.js. Тут ми закриваємо event loop, microtasks, rendering, `async/await`, cancellation, Web Workers і Node.js phases так, щоб ними можна було користуватися без магічного мислення.

---

## Scope

У цьому модулі ми закриваємо тринадцять ключових тем:

1. Browser Runtime Architecture.
2. Microtasks vs Macrotasks.
3. Async/Await Under the Hood.
4. Rendering and Event Loop.
5. Async Error Handling and Stack Traces.
6. `requestAnimationFrame` vs `setTimeout`.
7. Microtask Starvation.
8. AbortController and Cancellation.
9. Web Workers.
10. Node.js Event Loop.
11. Practice Lab.
12. Bug Lab.
13. Render-Yield Lab.

---

## Розділи

### 1. [Browser Runtime Architecture](./01-browser-runtime-architecture/README.md)
- Stack, heap, Web APIs, queues і rendering pipeline.
- Event loop як coordinator, а не "другий JS thread".

### 2. [Microtasks vs Macrotasks](./02-microtasks-vs-macrotasks/README.md)
- Чому promises випереджають timers.
- Queue priority і drain semantics.

### 3. [Async/Await Under the Hood](./03-async-await-under-the-hood/README.md)
- `async function` як promise factory.
- `await` як continuation boundary.

### 4. [Rendering and Event Loop](./04-rendering-and-event-loop/README.md)
- Коли browser реально малює UI.
- Чому DOM mutation не гарантує paint.

### 5. [Async Error Handling and Stack Traces](./05-async-error-handling-and-stack-traces/README.md)
- Sync throw vs rejection.
- Forgotten `await`, unhandled rejections, async stacks.

### 6. [requestAnimationFrame vs setTimeout](./06-requestanimationframe-vs-settimeout/README.md)
- Frame-aligned scheduling vs delayed task scheduling.
- Правильний вибір API для animation.

### 7. [Microtask Starvation](./07-microtask-starvation/README.md)
- Як microtask recursion блокує tasks і render.
- Чому "асинхронно" не завжди означає "responsive".

### 8. [AbortController and Cancellation](./08-abortcontroller-and-cancellation/README.md)
- Signal-driven cancellation.
- Stale requests, cleanup discipline, lifecycle control.

### 9. [Web Workers](./09-web-workers/README.md)
- Справжній паралелізм для CPU-heavy роботи.
- Message passing, structured clone, transferables.

### 10. [Node.js Event Loop](./10-nodejs-event-loop/README.md)
- Timers, poll, check, close callbacks.
- `process.nextTick`, promise microtasks, `setImmediate`.

### 11. [Practice Lab](./11-practice-lab/README.md)
- Order prediction, rendering bugs, API choice, cancellation, workers, Node ordering.

### 12. [Bug Lab](./12-bug-lab/README.md)
- Реальні production-сценарії: stale data, swallowed rejections, starvation, wrong scheduler choices.

### 13. [Render-Yield Lab](./13-render-yield-lab/README.md)
- Окремий практичний блок про UI responsiveness.
- Spinner, layout thrash, microtask trap, `rAF` + heavy work, commit cost.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

### Ключові інтерактиви

- [Browser Runtime Architecture](../visualisation/asynchrony-and-event-loop/01-browser-runtime-architecture/runtime-architecture/index.html)
- [Microtask vs Task Scheduler](../visualisation/asynchrony-and-event-loop/02-microtasks-vs-macrotasks/microtask-vs-task-scheduler/index.html)
- [Async/Await Resume Flow](../visualisation/asynchrony-and-event-loop/03-async-await-under-the-hood/async-await-resume-flow/index.html)
- [Rendering Timeline](../visualisation/asynchrony-and-event-loop/04-rendering-and-event-loop/rendering-timeline/index.html)
- [Async Error Propagation](../visualisation/asynchrony-and-event-loop/05-async-error-handling-and-stack-traces/async-error-propagation/index.html)
- [Async Error Propagation Debug Board](../visualisation/asynchrony-and-event-loop/05-async-error-handling-and-stack-traces/async-error-debug-board/index.html)
- [rAF vs setTimeout Timeline](../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/raf-vs-timeout-frame-timeline/index.html)
- [Microtask Starvation](../visualisation/asynchrony-and-event-loop/07-microtask-starvation/microtask-starvation/index.html)
- [AbortController Signal Flow](../visualisation/asynchrony-and-event-loop/08-abortcontroller-and-cancellation/abortcontroller-signal-flow/index.html)
- [Cancellation + Stale Request Board](../visualisation/asynchrony-and-event-loop/08-abortcontroller-and-cancellation/cancellation-stale-request-board/index.html)
- [Web Workers Message Passing](../visualisation/asynchrony-and-event-loop/09-web-workers/web-workers-message-passing/index.html)
- [Worker vs Main-Thread Cost Board](../visualisation/asynchrony-and-event-loop/09-web-workers/worker-vs-main-thread-cost-board/index.html)
- [Node.js Event Loop Phases](../visualisation/asynchrony-and-event-loop/10-nodejs-event-loop/nodejs-event-loop-phases/index.html)
- [Order Prediction Debug Board](../visualisation/asynchrony-and-event-loop/11-practice-lab/order-prediction-debug-board/index.html)
- [Browser vs Node Order Board](../visualisation/asynchrony-and-event-loop/12-bug-lab/browser-vs-node-order-board/index.html)
- [Scheduler Comparison Board](../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/scheduler-comparison-board/index.html)
- [Render-Yield Debug Board](../visualisation/asynchrony-and-event-loop/13-render-yield-lab/render-yield-debug-board/index.html)
- [Render-Yield Lab](./13-render-yield-lab/README.md)

Усі основні теоретичні статті в цьому блоці мають:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Намалювати runtime path для browser async-коду і для Node.js async-коду окремо.
2. Пояснити, чому `Promise.then` випереджає `setTimeout`.
3. Пояснити, коли browser реально paint-ить UI, а коли ні.
4. Дебажити starvation, unhandled rejections, stale-request races і cancellation bugs.
5. Вибирати між `Promise`, `setTimeout`, `requestAnimationFrame`, `AbortController` і `Web Worker` за моделлю, а не за звичкою.
