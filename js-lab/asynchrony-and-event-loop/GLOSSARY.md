# Asynchrony & Event Loop Glossary

Короткий словник термінів із блоку `asynchrony-and-event-loop`.

---

## Core Runtime

- **Event Loop** — coordinator runtime-середовища, який вирішує, коли брати task, коли дренувати microtasks і коли може бути render opportunity. Див. [01](./01-browser-runtime-architecture/README.md).
- **Call Stack** — стек execution contexts поточного JS-коду. Див. [01](./01-browser-runtime-architecture/README.md).
- **Heap** — область пам'яті для об'єктів, promises, closures та інших heap allocations. Див. [01](./01-browser-runtime-architecture/README.md).
- **Web APIs** — browser host APIs: timers, fetch, DOM events, `requestAnimationFrame` тощо. Див. [01](./01-browser-runtime-architecture/README.md).
- **Task** — одиниця роботи в host queue, яку event loop бере по одній. Див. [01](./01-browser-runtime-architecture/README.md), [02](./02-microtasks-vs-macrotasks/README.md).
- **Macrotask** — неформальний популярний термін для task-категорії на противагу microtasks. Див. [02](./02-microtasks-vs-macrotasks/README.md).
- **Microtask** — high-priority continuation job, яка виконується після поточного task до переходу до наступного task. Див. [02](./02-microtasks-vs-macrotasks/README.md).
- **Drain** — повне спорожнення microtask queue в одному циклі. Див. [02](./02-microtasks-vs-macrotasks/README.md).
- **Ready Callback** — callback, який уже готовий до постановки або вже стоїть у черзі, але ще не виконується в stack. Див. [01](./01-browser-runtime-architecture/README.md).

---

## Async Control Flow

- **Continuation** — відкладене продовження виконання після `await` або promise resolution. Див. [03](./03-async-await-under-the-hood/README.md).
- **Async Boundary** — місце, де виконання розривається в часі: `await`, task callback, timer callback, worker message. Див. [03](./03-async-await-under-the-hood/README.md), [05](./05-async-error-handling-and-stack-traces/README.md).
- **Promise Reaction Job** — внутрішній job для `.then/.catch/.finally`, який потрапляє в microtask queue. Див. [02](./02-microtasks-vs-macrotasks/README.md), [03](./03-async-await-under-the-hood/README.md).
- **Rejection** — promise завершився помилкою. Див. [05](./05-async-error-handling-and-stack-traces/README.md).
- **Unhandled Rejection** — rejected promise без обробника. Див. [05](./05-async-error-handling-and-stack-traces/README.md).
- **Async Stack Trace** — reconstructed tooling view логічного async call chain. Див. [05](./05-async-error-handling-and-stack-traces/README.md).
- **Order Prediction** — практика покрокового моделювання sync code, microtasks, tasks і render boundaries без вгадування. Див. [11](./11-practice-lab/README.md).
- **Forgotten `await`** — ситуація, коли async function викликають без `await`, через що локальний `try/catch` і локальна послідовність коду поводяться не так, як очікує автор. Див. [03](./03-async-await-under-the-hood/README.md), [05](./05-async-error-handling-and-stack-traces/README.md).

---

## Rendering and Scheduling

- **Render Opportunity** — момент, коли browser може перейти до rendering pipeline. Див. [04](./04-rendering-and-event-loop/README.md).
- **Long Task** — task, який надто довго займає main thread і шкодить responsiveness. Див. [04](./04-rendering-and-event-loop/README.md).
- **Frame Budget** — час, який є на роботу до втрати плавності кадру. Див. [04](./04-rendering-and-event-loop/README.md), [06](./06-requestanimationframe-vs-settimeout/README.md).
- **Render Yield** — навмисне віддання control browser-у, щоб той отримав шанс зробити paint або обробити input перед наступною важкою порцією роботи. Див. [04](./04-rendering-and-event-loop/README.md), [13](./13-render-yield-lab/README.md).
- **`requestAnimationFrame`** — browser API для callback перед наступним paint. Див. [06](./06-requestanimationframe-vs-settimeout/README.md).
- **Jitter** — нерівномірність інтервалів виконання, яка робить animation рваною. Див. [06](./06-requestanimationframe-vs-settimeout/README.md).
- **Starvation** — ситуація, коли одна категорія робіт не дає іншим дійти до виконання. Див. [07](./07-microtask-starvation/README.md).
- **Microtask Starvation** — recursive / endless microtask drain, який блокує tasks і render. Див. [07](./07-microtask-starvation/README.md).
- **Layout Thrash** — чергування layout reads і layout-affecting writes, яке змушує browser заново перераховувати layout частіше, ніж потрібно. Див. [04](./04-rendering-and-event-loop/README.md), [13](./13-render-yield-lab/README.md).

---

## Cancellation and Workers

- **Cancellation** — контрольоване припинення актуальності async operation. Див. [08](./08-abortcontroller-and-cancellation/README.md).
- **AbortController** — об'єкт, який керує станом cancellation. Див. [08](./08-abortcontroller-and-cancellation/README.md).
- **AbortSignal** — read-only сигнал скасування, який передають у async consumers. Див. [08](./08-abortcontroller-and-cancellation/README.md).
- **Stale Request** — старий async result, який уже не відповідає поточному user intent. Див. [08](./08-abortcontroller-and-cancellation/README.md), [12](./12-bug-lab/README.md).
- **Latest-Only Guard** — перевірка на кшталт `if (id !== active) return`, яка не дає старішому completion path оновити UI після новішого user intent. Див. [08](./08-abortcontroller-and-cancellation/README.md), [11](./11-practice-lab/README.md).
- **Worker Thread** — окремий thread виконання для worker context. Див. [09](./09-web-workers/README.md).
- **Structured Clone** — механізм копіювання сумісних значень між threads/realms. Див. [09](./09-web-workers/README.md).
- **Transferable** — тип даних, ownership якого можна передати без копіювання. Див. [09](./09-web-workers/README.md).
- **Message Passing** — модель взаємодії main thread і worker через повідомлення, а не shared mutable DOM state. Див. [09](./09-web-workers/README.md).
- **DOM Commit Cost** — ціна фінального оновлення DOM на main thread після того, як compute уже завершився. Worker не прибирає цю частину вартості. Див. [09](./09-web-workers/README.md), [13](./13-render-yield-lab/README.md).

---

## Node.js Runtime

- **Timers Phase** — фаза Node event loop для готових timers. Див. [10](./10-nodejs-event-loop/README.md).
- **Poll Phase** — фаза I/O waiting and callback processing у Node. Див. [10](./10-nodejs-event-loop/README.md).
- **Check Phase** — фаза, де виконується `setImmediate`. Див. [10](./10-nodejs-event-loop/README.md).
- **Close Callbacks** — фаза close-related callbacks у Node. Див. [10](./10-nodejs-event-loop/README.md).
- **`process.nextTick`** — Node-specific early queue, яка дренується раніше за promise microtasks. Див. [10](./10-nodejs-event-loop/README.md).
- **`setImmediate`** — Node API для callback у check phase. Див. [10](./10-nodejs-event-loop/README.md).
- **Top-level Scheduling** — постановка callbacks без додаткового I/O context, де частина order assumptions у Node може бути контекстно залежною. Див. [10](./10-nodejs-event-loop/README.md).
