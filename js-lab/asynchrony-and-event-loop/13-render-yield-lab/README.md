# Render-Yield Lab

Цей lab закриває окремий практичний пласт: **UI responsiveness**. Тут недостатньо знати, що таке task, microtask чи `requestAnimationFrame`. Треба вміти відповісти на практичне питання: **коли browser реально отримає шанс намалювати кадр і обробити input**.

> [!TIP]
> **[▶ Відкрити Scheduler Comparison Board](../../visualisation/asynchrony-and-event-loop/06-requestanimationframe-vs-settimeout/scheduler-comparison-board/index.html)**

> [!TIP]
> **[▶ Відкрити інтерактивну візуалізацію Rendering Timeline](../../visualisation/asynchrony-and-event-loop/04-rendering-and-event-loop/rendering-timeline/index.html)**

> [!TIP]
> **[▶ Відкрити Render-Yield Debug Board](../../visualisation/asynchrony-and-event-loop/13-render-yield-lab/render-yield-debug-board/index.html)**

---

## I. How To Use This Lab

Для кожного кейсу проходь однаковий маршрут:

1. Знайди, де DOM state вже змінено, але paint ще не відбувся.
2. Визнач, що саме блокує render opportunity: sync work, microtask drain, layout thrash чи важкий `rAF` callback.
3. Виріши, який тип yield реально потрібен: task boundary, frame-aligned callback, chunking work, worker offload.
4. Лише після цього переписуй код.

---

## II. Diagnostic Cases

### Case 1: Spinner Never Appears
```javascript
spinner.hidden = false;
expensiveTransform(data);
renderChart();
```

**Симптом:** spinner у DOM уже є, але користувач бачить його лише після завершення важкої роботи або не бачить взагалі як окремий стан.

**Що треба знайти:** чому зміна DOM не перейшла в pixels.

---

### Case 2: Fake Yield via Promise
```javascript
spinner.hidden = false;
await Promise.resolve();
expensiveTransform(data);
```

**Симптом:** розробник очікував, що `await` дасть browser шанс намалювати loader, але UI все одно не оновився вчасно.

**Що треба знайти:** чому microtask boundary не дорівнює render boundary.

---

### Case 3: Layout Thrash in Loop
```javascript
for (const item of items) {
  const width = card.offsetWidth;
  card.style.width = width + 10 + "px";
}
```

**Симптом:** UI смикається, CPU росте, кадри пропускаються навіть без одного очевидного `while(true)`.

**Що треба знайти:** який read/write pattern провокує зайві layout recalculations.

---

### Case 4: requestAnimationFrame, But Still Janky
```javascript
function tick() {
  requestAnimationFrame(tick);
  expensivePhysicsStep();
  expensiveDOMPatch();
}

tick();
```

**Симптом:** використовується `requestAnimationFrame`, але animation все одно рвана.

**Що треба знайти:** чому правильний scheduler сам по собі не рятує від dropped frames.

---

### Case 5: Microtask Pump Freezes UI
```javascript
function pump() {
  queueMicrotask(pump);
}

pump();
spinner.hidden = false;
```

**Симптом:** інтерфейс ніби "живий" у коді, але browser не доходить до paint/input.

**Що треба знайти:** який starvation pattern тут створено.

---

### Case 6: One Huge Render Prep Step
```javascript
button.disabled = true;
status.textContent = "Processing...";
prepareRows(hugeDataset);
mountTable();
```

**Симптом:** кнопка не візуально disable-иться вчасно, статус не встигає показатися, таблиця з'являється тільки в кінці довгого фризу.

**Що треба знайти:** де work треба chunk-нути або винести з main thread.

---

### Case 7: setTimeout Helps, But Animation Still Feels Wrong
```javascript
box.classList.add("visible");
setTimeout(() => {
  runStep();
}, 0);
```

**Симптом:** після переходу з sync work на `setTimeout` UI ніби став трохи кращим, але animation або transition усе ще поводяться нестабільно.

**Що треба знайти:** чому task boundary іноді допомагає, але не дає frame-aligned behavior.

---

### Case 8: Worker Added, UI Still Glitches on Commit
```javascript
worker.onmessage = ({ data }) => {
  applyHugeDOMPatch(data);
};
```

**Симптом:** compute вже не на main thread, але великий commit у DOM все одно ламає responsiveness.

**Що треба знайти:** чому worker вирішує не всю проблему, якщо final render step занадто важкий.

---

## III. Quick Hints

1. DOM mutation не означає миттєвий paint.
2. `await Promise.resolve()` зазвичай yield-ить тільки в microtask queue.
3. Layout thrash часто виникає через чергування `read -> write -> read -> write`.
4. `requestAnimationFrame` лише ставить callback перед paint; він не робить callback дешевим.
5. Безкінечні microtasks можуть блокувати render так само ефективно, як sync loop.
6. Якщо work не вміщується у frame budget, його треба chunk-нути або винести.
7. `setTimeout(..., 0)` дає task boundary, але не дає нормальної animation semantics.
8. Worker не прибирає ціну великого DOM commit на main thread.

---

## IV. Step-by-Step Answers

### Case 1
**Крок 1:** `spinner.hidden = false` змінює DOM state.

**Крок 2:** Але одразу після цього main thread зайнятий `expensiveTransform(data)`.

**Крок 3:** Browser не має render opportunity до завершення поточного task.

**Висновок:** потрібен реальний yield до browser або розбиття heavy work на шматки. Просто змінити DOM недостатньо.

### Case 2
**Крок 1:** `await Promise.resolve()` продовжить виконання через microtask.

**Крок 2:** Browser дренує microtasks до render opportunity.

**Крок 3:** `expensiveTransform(data)` заходить назад у main thread ще до paint.

**Висновок:** microtask boundary не дорівнює paint boundary. Для loader/spinner це часто неправильна техніка.

### Case 3
**Крок 1:** `card.offsetWidth` читає layout-dependent значення.

**Крок 2:** `card.style.width = ...` мутує layout-affecting property.

**Крок 3:** Якщо такий патерн повторюється в циклі, browser може змушено багато разів перераховувати layout.

**Висновок:** це layout thrash. Треба батчити reads і writes окремо, а не змішувати їх у кожній ітерації.

### Case 4
**Крок 1:** `requestAnimationFrame` вибраний правильно лише на рівні scheduler.

**Крок 2:** Але callback містить `expensivePhysicsStep()` і `expensiveDOMPatch()`.

**Крок 3:** Якщо callback сам по собі перевищує frame budget, кадри дропаються.

**Висновок:** `rAF` не лікує дорогий callback. Потрібно спрощувати роботу, chunk-нути її або переносити частину поза main thread.

### Case 5
**Крок 1:** `queueMicrotask(pump)` ставить наступну microtask до того, як browser дійде до render/task boundary.

**Крок 2:** Queue дренується повністю.

**Крок 3:** Нові microtasks постійно додаються раніше, ніж runtime доходить до paint.

**Висновок:** це microtask starvation, тому spinner і input не отримують шанс на progress.

### Case 6
**Крок 1:** Кнопка і статус змінені, але `prepareRows(hugeDataset)` одразу забирає main thread.

**Крок 2:** Browser не встигає відмалювати проміжний UI state.

**Крок 3:** Навіть якщо compute частково оптимізований, один величезний prep step все одно з'їдає responsiveness.

**Висновок:** розбивай підготовку на частини, yield-ь між chunk-ами або винось compute у worker.

### Case 7
**Крок 1:** `setTimeout(..., 0)` справді може дати browser шанс завершити поточний turn і намалювати щось між task-ами.

**Крок 2:** Але timer callback не синхронізований з frame lifecycle.

**Крок 3:** Для animation чи visual transitions цього недостатньо: залишається jitter і втрачається стабільний frame alignment.

**Висновок:** task boundary іноді корисний як yield, але не замінює `requestAnimationFrame` там, де потрібен frame-aware scheduling.

### Case 8
**Крок 1:** Worker забрав compute, але `applyHugeDOMPatch(data)` усе одно виконується на main thread.

**Крок 2:** Якщо patch занадто великий, commit знову блокує render/input.

**Крок 3:** Отже, вузьке місце вже не compute, а main-thread render commit.

**Висновок:** worker допомагає тільки частині pipeline. DOM commit теж треба робити дозовано й акуратно.

---

## V. Rewrite Drills

### Drill 1
Перепиши `Case 1` так, щоб loader гарантовано мав шанс з'явитися до heavy work.

### Drill 2
Перепиши `Case 3` так, щоб reads і writes були рознесені.

### Drill 3
Перепиши `Case 4` так, щоб важка частина не жила цілком усередині одного `rAF` callback.

### Drill 4
Перепиши `Case 6` у two-phase model:
- швидкий UI update
- chunked processing
- incremental render

### Drill 5
Для кожного кейсу вибери основний інструмент:
- `Promise`
- `setTimeout`
- `requestAnimationFrame`
- chunking
- `Worker`

---

## VI. Suggested Review

Після цього lab варто повернутися до:

- [04 Rendering and Event Loop](../04-rendering-and-event-loop/README.md)
- [06 requestAnimationFrame vs setTimeout](../06-requestanimationframe-vs-settimeout/README.md)
- [07 Microtask Starvation](../07-microtask-starvation/README.md)
- [09 Web Workers](../09-web-workers/README.md)
- [11 Practice Lab](../11-practice-lab/README.md)
- [12 Bug Lab](../12-bug-lab/README.md)
