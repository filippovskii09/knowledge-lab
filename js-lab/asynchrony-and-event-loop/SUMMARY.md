# Asynchrony & Event Loop: Module Summary

Цей блок зводить у одну модель **browser runtime**, **Node.js runtime**, **queues**, **render timing**, **cancellation** і **parallel compute**.

---

## Mental Models

| Концепція | Коротка модель |
| :--- | :--- |
| Event Loop | Координатор між stack, queues і runtime-середовищем |
| Task | Окремий callback turn у host queue |
| Microtask | High-priority continuation, яка дренується повністю |
| `await` | Pause конкретної async function, а не thread |
| Render Opportunity | Момент, коли browser може перейти до paint |
| Starvation | Queue policy не дає дійти до інших корисних фаз |
| Cancellation | Керування життєвим циклом async operation |
| Web Worker | Окремий thread для compute, не для DOM |
| Node Phases | Runtime phases поверх server host environment |

---

## Golden Rules

1. `Promise.then` перемагає `setTimeout`, бо microtasks дренуються до next task.
2. DOM mutation не гарантує видимий paint у той самий момент.
3. `await` не блокує thread; він відкладає continuation.
4. Forgotten `await` часто дорівнює зламаному error path.
5. `requestAnimationFrame` — для кадрів, `setTimeout` — для delayed tasks.
6. Recursive microtasks можуть freeze-ити UI не гірше за sync loop.
7. `AbortController` — це lifecycle control, а не лише fetch helper.
8. Web Worker потрібен для CPU-heavy compute, а не для будь-якої асинхронності.
9. Browser event loop і Node event loop не можна змішувати як одну таблицю правил.

---

## Learning Route

1. Почни з [01 Browser Runtime Architecture](./01-browser-runtime-architecture/README.md), щоб зібрати фізичну карту runtime.
2. Одразу після цього читай [02 Microtasks vs Macrotasks](./02-microtasks-vs-macrotasks/README.md), бо без пріоритетів черг усе інше буде виглядати магією.
3. Потім закрий [03 Async/Await Under the Hood](./03-async-await-under-the-hood/README.md) і [05 Async Error Handling and Stack Traces](./05-async-error-handling-and-stack-traces/README.md), щоб зрозуміти реальну модель async control flow.
4. Далі пройди [04 Rendering and Event Loop](./04-rendering-and-event-loop/README.md), [06 requestAnimationFrame vs setTimeout](./06-requestanimationframe-vs-settimeout/README.md) і [07 Microtask Starvation](./07-microtask-starvation/README.md), бо саме тут народжується більшість UI scheduling bugs.
5. Після цього переходь у [08 AbortController and Cancellation](./08-abortcontroller-and-cancellation/README.md), [09 Web Workers](./09-web-workers/README.md) і [10 Node.js Event Loop](./10-nodejs-event-loop/README.md), а завершуй модуль через [11 Practice Lab](./11-practice-lab/README.md), [12 Bug Lab](./12-bug-lab/README.md) і [13 Render-Yield Lab](./13-render-yield-lab/README.md).

---

## Навігація

- [01 Browser Runtime Architecture](./01-browser-runtime-architecture/README.md)
- [02 Microtasks vs Macrotasks](./02-microtasks-vs-macrotasks/README.md)
- [03 Async/Await Under the Hood](./03-async-await-under-the-hood/README.md)
- [04 Rendering and Event Loop](./04-rendering-and-event-loop/README.md)
- [05 Async Error Handling and Stack Traces](./05-async-error-handling-and-stack-traces/README.md)
- [06 requestAnimationFrame vs setTimeout](./06-requestanimationframe-vs-settimeout/README.md)
- [07 Microtask Starvation](./07-microtask-starvation/README.md)
- [08 AbortController and Cancellation](./08-abortcontroller-and-cancellation/README.md)
- [09 Web Workers](./09-web-workers/README.md)
- [10 Node.js Event Loop](./10-nodejs-event-loop/README.md)
- [11 Practice Lab](./11-practice-lab/README.md)
- [12 Bug Lab](./12-bug-lab/README.md)
- [13 Render-Yield Lab](./13-render-yield-lab/README.md)
- [GLOSSARY.md](./GLOSSARY.md)
- [Order Prediction Debug Board](../visualisation/asynchrony-and-event-loop/11-practice-lab/order-prediction-debug-board/index.html)
- [Browser vs Node Order Board](../visualisation/asynchrony-and-event-loop/12-bug-lab/browser-vs-node-order-board/index.html)
- [Scheduler Comparison Board](../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/scheduler-comparison-board/index.html)
- [Render-Yield Debug Board](../visualisation/asynchrony-and-event-loop/13-render-yield-lab/render-yield-debug-board/index.html)
- [Cancellation + Stale Request Board](../visualisation/asynchrony-and-event-loop/08-abortcontroller-and-cancellation/cancellation-stale-request-board/index.html)
- [Async Error Propagation Debug Board](../visualisation/asynchrony-and-event-loop/05-async-error-handling-and-stack-traces/async-error-debug-board/index.html)
- [Worker vs Main-Thread Cost Board](../visualisation/asynchrony-and-event-loop/09-web-workers/worker-vs-main-thread-cost-board/index.html)
