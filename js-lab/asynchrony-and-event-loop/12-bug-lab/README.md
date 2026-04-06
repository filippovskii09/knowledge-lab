# Bug Lab: Asynchrony & Event Loop

Цей lab зібраний не для "вгадай порядок логів", а для реальних production-патернів, де async-модель ламає продукт: stale data, frozen UI, swallowed rejections, wrong scheduler choice.

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

## I. Diagnostic Cases

### Bug 1: Spinner Never Appears
```javascript
spinner.hidden = false;
expensiveTransform(data);
renderChart();
```

**Симптом:** Користувач не бачить spinner, хоча DOM уже змінено.

**Що треба знайти:** Який runtime boundary не був відданий browser-у?

---

### Bug 2: Old Search Result Overwrites New One
```javascript
async function search(query) {
  const data = await fetch(`/search?q=${query}`).then(r => r.json());
  render(data);
}
```

**Симптом:** Користувач вводить `react`, потім `redux`, але іноді бачить старіші результати.

**Що треба знайти:** Який race condition тут не враховано?

---

### Bug 3: Promise Rejection Disappears
```javascript
async function save() {
  throw new Error("save failed");
}

async function main() {
  try {
    save();
  } catch (err) {
    notify(err.message);
  }
}
```

**Симптом:** Error toast не показується, а в консолі іноді unhandled rejection.

**Що треба знайти:** Де саме порвався error path?

---

### Bug 4: UI Freezes Without a Huge for-loop
```javascript
function pump() {
  Promise.resolve().then(pump);
}

pump();
```

**Симптом:** UI замерзає, хоча у профайлі немає одного очевидного довгого синхронного циклу.

**Що треба знайти:** Який scheduling pattern блокує progress?

---

### Bug 5: Animation Jitters Even with 16ms Timeout
```javascript
function animate() {
  updatePosition();
  setTimeout(animate, 16);
}
animate();
```

**Симптом:** Анімація підлагує й відчувається нерівною.

**Що треба знайти:** Чому сама модель scheduling тут слабка?

---

### Bug 6: Worker Added, App Still Not Faster
```javascript
const worker = new Worker("worker.js");
worker.postMessage(hugeObject);
worker.onmessage = ({ data }) => render(data);
```

**Симптом:** UI трохи живіший, але загалом усе майже так само повільно.

**Що треба знайти:** Де міг з'їдатися виграш?

---

### Bug 7: Modal Closed, But Request Still Wins Later
```javascript
const controller = new AbortController();
modal.onClose = () => controller.abort();
const data = await fetch(url, { signal: controller.signal }).then(r => r.json());
setState(data);
```

**Симптом:** Після закриття modal іноді все одно приходить update.

**Що треба знайти:** Який guard або lifecycle check пропущено?

---

### Bug 8: Node Order Assumption Breaks in Production
```javascript
setTimeout(() => console.log("timeout"), 0);
setImmediate(() => console.log("immediate"));
```

**Симптом:** Локально порядок один, у складнішому серверному контексті — інший.

**Що треба знайти:** Чому ця ментальна модель надто спрощена?

---

## II. Quick Hints

1. DOM mutation ще не означає paint.
2. Треба думати про stale intent і cancellation.
3. Async function повертає promise.
4. Recursive microtasks теж можуть freeze-ити UI.
5. Animation треба прив'язувати до frames, а не delay.
6. Worker може програти на copy/coordination overhead.
7. Abort сам по собі не замінює guard на актуальність.
8. У Node порядок залежить від контексту scheduling.

---

## III. Step-by-Step Answers

### Bug 1
**Крок 1:** Spinner потрапив у DOM state.

**Крок 2:** Але після цього main thread одразу зайнятий expensive work.

**Крок 3:** Browser не має render opportunity.

**Висновок:** Потрібен явний yield або інший розподіл роботи, інакше paint не станеться вчасно.

### Bug 2
**Крок 1:** Кілька requests можуть завершитися в іншому порядку, ніж були відправлені.

**Крок 2:** Старий slower response може прийти останнім.

**Крок 3:** `render(data)` не знає, який запит актуальний.

**Висновок:** Потрібен latest-only guard і часто `AbortController`.

### Bug 3
**Крок 1:** `save()` без `await` не кидає sync throw в поточний `try/catch`.

**Крок 2:** Воно повертає rejected promise.

**Крок 3:** Локальний `catch` не бачить цю помилку.

**Висновок:** Треба `await save()` або `return save().catch(...)`.

### Bug 4
**Крок 1:** Кожен `.then(pump)` ставить нову microtask.

**Крок 2:** Runtime дренує microtasks повністю.

**Крок 3:** Task/render boundary не настає.

**Висновок:** Це microtask starvation.

### Bug 5
**Крок 1:** `setTimeout(16)` не синхронізований з paint.

**Крок 2:** Він живе в task queue і залежить від load/jitter.

**Крок 3:** Навіть невеликий drift робить анімацію нерівною.

**Висновок:** Для animation базово треба `requestAnimationFrame`.

### Bug 6
**Крок 1:** Worker прибирає compute з main thread, але не прибирає messaging overhead.

**Крок 2:** `hugeObject` може дорого копіюватися structured clone.

**Крок 3:** Якщо задача коротка або payload великий, профіт з'їдається.

**Висновок:** Потрібно міряти copy/transfer cost і, можливо, перейти на transferable payload.

### Bug 7
**Крок 1:** Abort може статися не в тій точці, яку ти інтуїтивно очікуєш.

**Крок 2:** Після await код ще може дійти до `setState`, якщо немає додаткового guard.

**Крок 3:** Компонент або modal уже могли бути неактуальні.

**Висновок:** Перевіряй `signal.aborted` або current lifecycle перед state update.

### Bug 8
**Крок 1:** `setTimeout` vs `setImmediate` — це Node-specific scheduling detail.

**Крок 2:** На top-level і після I/O callback поведінка може відрізнятися.

**Крок 3:** Якщо код покладається на один жорсткий порядок без контексту, він крихкий.

**Висновок:** Потрібно мислити фазами loop, а не запам'ятовувати міфічне абсолютне правило.

---

## IV. Suggested Review

Після цього bug lab варто повернутися до:

- [04 Rendering and Event Loop](../04-rendering-and-event-loop/README.md)
- [05 Async Error Handling and Stack Traces](../05-async-error-handling-and-stack-traces/README.md)
- [06 requestAnimationFrame vs setTimeout](../06-requestanimationframe-vs-settimeout/README.md)
- [07 Microtask Starvation](../07-microtask-starvation/README.md)
- [08 AbortController and Cancellation](../08-abortcontroller-and-cancellation/README.md)
- [09 Web Workers](../09-web-workers/README.md)
- [10 Node.js Event Loop](../10-nodejs-event-loop/README.md)
