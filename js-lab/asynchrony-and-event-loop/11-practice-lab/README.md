# Practice Lab: Asynchrony & Event Loop

Цей lab потрібен, щоб перестати вгадувати order і почати **моделювати runtime покроково**. Завдання змішані: browser, rendering, cancellation, Web Workers, Node.js.

> [!TIP]
> **[▶ Запустити інтерактивний Order Prediction Debug Board](../../visualisation/asynchrony-and-event-loop/11-practice-lab/order-prediction-debug-board/index.html)**

> [!TIP]
> **[▶ Відкрити Browser vs Node Order Board](../../visualisation/asynchrony-and-event-loop/12-bug-lab/browser-vs-node-order-board/index.html)**

> [!TIP]
> **[▶ Відкрити Scheduler Comparison Board](../../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/scheduler-comparison-board/index.html)**

> [!TIP]
> **[▶ Відкрити Render-Yield Lab](../13-render-yield-lab/README.md)**

> [!TIP]
> **[▶ Відкрити Cancellation + Stale Request Board](../../visualisation/asynchrony-and-event-loop/08-abortcontroller-and-cancellation/cancellation-stale-request-board/index.html)**

> [!TIP]
> **[▶ Відкрити Async Error Propagation Debug Board](../../visualisation/asynchrony-and-event-loop/05-async-error-handling-and-stack-traces/async-error-debug-board/index.html)**

> [!TIP]
> **[▶ Відкрити Worker vs Main-Thread Cost Board](../../visualisation/asynchrony-and-event-loop/09-web-workers/worker-vs-main-thread-cost-board/index.html)**

---

## I. How To Use This Lab

Для кожної задачі проходь один і той самий маршрут:

1. Визнач, що тут sync, що task, що microtask.
2. Познач, чи є render boundary.
3. Познач, чи є separate thread або cancellation signal.
4. Лише після цього прогнозуй порядок або behavior.

---

## II. Tasks

### Task 1
```javascript
console.log("A");
setTimeout(() => console.log("B"), 0);
Promise.resolve().then(() => console.log("C"));
console.log("D");
```

Що виведеться і в якому порядку?

### Task 2
```javascript
console.log("A");
queueMicrotask(() => console.log("B"));
Promise.resolve().then(() => console.log("C"));
console.log("D");
```

Що гарантовано про порядок `B` і `C`?

### Task 3
```javascript
async function run() {
  console.log("1");
  await Promise.resolve();
  console.log("2");
}

run();
console.log("3");
```

Чому `3` з'явиться не там, де інтуїтивно чекає частина людей?

### Task 4
```javascript
spinner.style.display = "block";
for (let i = 0; i < 1e9; i++) {}
```

Чому spinner може не з'явитися до завершення циклу?

### Task 5
```javascript
spinner.style.display = "block";
await Promise.resolve();
for (let i = 0; i < 1e9; i++) {}
```

Чи гарантовано це дасть browser шанс намалювати spinner?

### Task 6
```javascript
function loop() {
  Promise.resolve().then(loop);
}
loop();
setTimeout(() => console.log("timer"), 0);
```

Чому timer може не спрацювати дуже довго або взагалі в межах практичного спостереження?

### Task 7
```javascript
let controller = new AbortController();
fetch(url1, { signal: controller.signal });
controller.abort();
fetch(url2, { signal: controller.signal });
```

Що тут концептуально не так?

### Task 8
```javascript
let active = 0;
async function search(q) {
  const id = ++active;
  const data = await fetch(`/search?q=${q}`).then(r => r.json());
  if (id !== active) return;
  render(data);
}
```

Який баг цей код намагається стримати, навіть без AbortController?

### Task 9
```javascript
const worker = new Worker("worker.js");
worker.postMessage(hugeObject);
```

У якому сценарії це не дасть очікуваного виграшу?

### Task 10
```javascript
setTimeout(() => updateFrame(), 16);
```

Чому це слабка базова модель для animation?

### Task 11
```javascript
async function main() {
  try {
    save();
  } catch (err) {
    report(err);
  }
}
```

Яка типова помилка тут схована?

### Task 12
```javascript
process.nextTick(() => console.log("tick"));
Promise.resolve().then(() => console.log("promise"));
console.log("sync");
```

Який порядок логів очікується в Node.js?

### Task 13
```javascript
setTimeout(() => console.log("timeout"), 0);
setImmediate(() => console.log("immediate"));
```

Чому це погана задача, якщо від тебе вимагають одну "абсолютно правильну" відповідь без контексту?

### Task 14
```javascript
requestAnimationFrame(() => {
  expensiveWork();
});
```

Чому навіть правильний API не гарантує smooth animation?

### Task 15
```javascript
const controller = new AbortController();
modal.onClose = () => controller.abort();
const response = await fetch(url, { signal: controller.signal });
setState(await response.json());
```

Який guard або додаткова перевірка тут часто ще потрібні?

### Task 16
Тобі треба:
- плавна animation
- heavy JSON transform
- cancellable search
- delayed retry через 5 секунд

Підбери для кожної задачі правильний інструмент: `requestAnimationFrame`, `Worker`, `AbortController`, `setTimeout`, `Promise`.

---

## III. Quick Hints

1. Синхронний код завжди перший.
2. FIFO важливий лише всередині однієї черги.
3. `await` = continuation later.
4. DOM mutation не дорівнює paint.
5. Microtask не дорівнює render yield.
6. Recursive promise chain = starvation risk.
7. Aborted controller не перевикористовують як "свіжий" signal.
8. Це race guard по latest request id.
9. Copy cost може вбити профіт.
10. Animation треба прив'язувати до frame lifecycle.
11. Forgotten `await`.
12. `nextTick` має вищий пріоритет у Node.
13. Порядок context-dependent.
14. Heavy callback все ще з'їдає frame budget.
15. Після `await` lifetime міг уже змінитися.
16. Думай від задачі, не від моди.

---

## IV. Suggested Practice

1. Спочатку пройди 5-6 задач у [Order Prediction Debug Board](../../visualisation/asynchrony-and-event-loop/11-practice-lab/order-prediction-debug-board/index.html).
2. Потім відкрий [Browser vs Node Order Board](../../visualisation/asynchrony-and-event-loop/12-bug-lab/browser-vs-node-order-board/index.html) і програй однакові сценарії в двох runtime-середовищах.
3. Окремо перевір, як змінюється порядок у Node між `Top-level` і `Inside I/O callback`.
4. Для UI scheduling окремо програй [Scheduler Comparison Board](../../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/scheduler-comparison-board/index.html) і перевір, чому `Promise` не замінює render yield, а `setTimeout(16)` не замінює `rAF`.
5. Для race conditions і cancellation окремо програй [Cancellation + Stale Request Board](../../visualisation/asynchrony-and-event-loop/08-abortcontroller-and-cancellation/cancellation-stale-request-board/index.html).
6. Для error model окремо програй [Async Error Propagation Debug Board](../../visualisation/asynchrony-and-event-loop/05-async-error-handling-and-stack-traces/async-error-debug-board/index.html).
7. Для Web Worker trade-offs окремо програй [Worker vs Main-Thread Cost Board](../../visualisation/asynchrony-and-event-loop/09-web-workers/worker-vs-main-thread-cost-board/index.html).

---

## IV. Step-by-Step Answers

### Task 1
**Крок 1:** `A` і `D` — sync.

**Крок 2:** `Promise.then` іде в microtask queue.

**Крок 3:** `setTimeout` — у task queue після timer readiness.

**Висновок:** `A`, `D`, `C`, `B`.

### Task 2
**Крок 1:** Обидва callbacks — microtasks.

**Крок 2:** Вони виконаються після sync частини.

**Крок 3:** Порядок між ними визначається порядком enqueue.

**Висновок:** `A`, `D`, `B`, `C`.

### Task 3
**Крок 1:** `1` виконується синхронно всередині `run()`.

**Крок 2:** `await` розбиває функцію на current part і continuation.

**Крок 3:** `3` ще належить поточному sync turn зовні.

**Висновок:** `1`, `3`, `2`.

### Task 4
**Крок 1:** Spinner у DOM уже змінений.

**Крок 2:** Але цикл тримає current task живим.

**Крок 3:** Paint не має коли статися.

**Висновок:** Користувач побачить spinner тільки після завершення циклу.

### Task 5
**Крок 1:** `await Promise.resolve()` дає лише microtask boundary.

**Крок 2:** Browser не зобов'язаний paint-ити між sync task і microtask continuation.

**Крок 3:** Потім знову йде важкий sync loop.

**Висновок:** Ні, це не гарантія paint.

### Task 6
**Крок 1:** Кожен `.then(loop)` ставить нову microtask.

**Крок 2:** Microtasks дренуються повністю.

**Крок 3:** Timer чекає next task boundary, яка не настає.

**Висновок:** Це starvation.

### Task 7
**Крок 1:** Один і той самий controller вже aborted.

**Крок 2:** Його signal лишається aborted.

**Крок 3:** Другий `fetch` отримує вже "зіпсований" signal.

**Висновок:** Для нової операції треба новий controller.

### Task 8
**Крок 1:** Повільніший старий запит може прийти пізніше за новий.

**Крок 2:** `active` зберігає ідентифікатор latest intent.

**Крок 3:** Старий результат ігнорується.

**Висновок:** Це захист від stale response overwrite race.

### Task 9
**Крок 1:** Якщо `hugeObject` треба дорого копіювати, structured clone може бути болючим.

**Крок 2:** Якщо сама задача коротка, overhead перевищить виграш.

**Висновок:** Worker не завжди окупається.

### Task 10
**Крок 1:** `setTimeout` не синхронізований з paint.

**Крок 2:** Він живе в task queue і схильний до jitter.

**Висновок:** Для animation базово краще `requestAnimationFrame`.

### Task 11
**Крок 1:** `save()` без `await` повертає promise.

**Крок 2:** `try/catch` не ловить rejection автоматично.

**Висновок:** Тут forgotten `await`.

### Task 12
**Крок 1:** `sync` виводиться першим.

**Крок 2:** У Node далі йде `process.nextTick` queue.

**Крок 3:** Потім promise microtasks.

**Висновок:** `sync`, `tick`, `promise`.

### Task 13
**Крок 1:** Це Node-specific ordering.

**Крок 2:** Без контексту top-level vs I/O callback задача неповна.

**Висновок:** Одна "абсолютна" відповідь тут методологічно погана.

### Task 14
**Крок 1:** rAF лише ставить callback у правильний момент.

**Крок 2:** Але heavy work все одно блокує frame budget.

**Висновок:** Правильний API не компенсує завеликий callback cost.

### Task 15
**Крок 1:** Abort може статися між `await fetch` і `setState`.

**Крок 2:** Компонент/екран міг уже бути неактуальним.

**Висновок:** Часто потрібен guard на актуальність або `signal.aborted` перед state update.

### Task 16
**Крок 1:** Плавна animation -> `requestAnimationFrame`.

**Крок 2:** Heavy JSON transform -> `Worker`.

**Крок 3:** Cancellable search -> `AbortController`.

**Крок 4:** Delayed retry -> `setTimeout`.

**Крок 5:** `Promise` лишається механікою композиції async result, а не заміною всіх scheduler APIs.

---

## V. Suggested Review

Після цього lab варто повернутися до:

- [01 Browser Runtime Architecture](../01-browser-runtime-architecture/README.md)
- [02 Microtasks vs Macrotasks](../02-microtasks-vs-macrotasks/README.md)
- [03 Async/Await Under the Hood](../03-async-await-under-the-hood/README.md)
- [04 Rendering and Event Loop](../04-rendering-and-event-loop/README.md)
- [05 Async Error Handling and Stack Traces](../05-async-error-handling-and-stack-traces/README.md)
- [06 requestAnimationFrame vs setTimeout](../06-requestanimationframe-vs-settimeout/README.md)
- [07 Microtask Starvation](../07-microtask-starvation/README.md)
- [08 AbortController and Cancellation](../08-abortcontroller-and-cancellation/README.md)
- [09 Web Workers](../09-web-workers/README.md)
- [10 Node.js Event Loop](../10-nodejs-event-loop/README.md)
