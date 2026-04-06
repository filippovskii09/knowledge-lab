# Practice Lab: Modules, Ecosystem & Meta-programming

Цей lab потрібен, щоб перестати вгадувати поведінку runtime-шару й почати моделювати її покроково: module graph, iterator protocol, proxy traps, locale formatting.

---

> [!TIP]
> **[▶ Відкрити Module Graph Cycle Board](../../visualisation/modules-ecosystem-and-meta-programming/01-module-system-internals/module-graph-cycle-board/index.html)**

> [!TIP]
> **[▶ Відкрити Iterator Protocol Board](../../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/iterator-protocol-board/index.html)**

> [!TIP]
> **[▶ Відкрити Generator Yield Board](../../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/generator-yield-board/index.html)**

> [!TIP]
> **[▶ Відкрити Proxy Reflect Flow Board](../../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reflect-flow-board/index.html)**

> [!TIP]
> **[▶ Відкрити Proxy Reactivity Board](../../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reactivity-board/index.html)**

> [!TIP]
> **[▶ Відкрити Intl Formatting Board](../../visualisation/modules-ecosystem-and-meta-programming/04-intl-api-and-globalization/intl-formatting-board/index.html)**

---

## I. Tasks

### Task 1
Поясни, чому `ESM` cycle може дати неготовий binding навіть без явного syntax error.

### Task 2
Чим `require('./x')` і `import { x } from './x.js'` відрізняються на binding-рівні?

### Task 3
Напиши custom iterable для range `1..3` вручну через `Symbol.iterator`.

### Task 4
Напиши той самий range через generator.

### Task 5
Що зламається, якщо iterator ніколи не повертає `done: true`?

### Task 6
Чому generator не можна автоматично вважати async primitive?

### Task 7
Напиши logging proxy для `get` і `set` через `Reflect`.

### Task 8
Поясни, чому trap без `Reflect` часто небезпечніший за trap із `Reflect`.

### Task 9
Тобі треба показати одну суму в `uk-UA`, `en-US` і `de-DE`. Який API використаєш і чому?

### Task 10
Чому створювати новий `Intl.NumberFormat` у hot render-path — сумнівна ідея?

### Task 11
Поясни різницю між iterable і iterator.

### Task 12
Наведи приклад, де `PluralRules` корисніший за ручний `if (count === 1)`.

---

## II. Quick Hints

1. Binding timing.
2. Live binding vs exported object/value semantics.
3. `Symbol.iterator` + `next()`.
4. `function*`.
5. Infinite loop risk.
6. Sync protocol by default.
7. `new Proxy(target, { get, set })`.
8. Default semantics easier to preserve via `Reflect`.
9. `Intl.NumberFormat`.
10. Reuse formatter object.
11. One creates traversal, one performs it.
12. Real locales have more than two plural categories.

---

## III. Step-by-Step Answers

### Answer 1
- Основний механізм: module graph linking + evaluation order.
- У cycle одна сторона може звертатися до export до завершення його ініціалізації.
- Це не просто “undefined from nowhere”, а binding timing issue.

### Answer 2
- `ESM` imports зазвичай живуть як live bindings.
- `CJS` часто мислиться через exported object/value access і sync require execution.
- Тому mental model різний навіть при схожій цілі.

### Answer 3
- Потрібно повернути об'єкт із `next()`.
- Сам iterable має віддати iterator через `Symbol.iterator`.

### Answer 4
- `function* range() { yield ... }` прибирає ручний state machine.

### Answer 5
- `for...of` не зупиниться, якщо iterator не сигналізує завершення.

### Answer 6
- Бо generator не інтегрований автоматично з Promise scheduling.
- Це pause/resume iterator model, а не async runtime queue model.

### Answer 7
- `Reflect.get` і `Reflect.set` дозволяють зберегти default semantics.
- Trap додає logging, не ламаючи поведінку без потреби.

### Answer 8
- Manual semantics легше зламати.
- `Reflect` краще відповідає стандартним object operations.

### Answer 9
- `Intl.NumberFormat(locale, { style: 'currency', currency })`.
- Бо це runtime-aware formatter, а не string hack.

### Answer 10
- Бо formatter creation — це зайва робота, якщо конфігурація повторюється.

### Answer 11
- Iterable надає iterator.
- Iterator реально видає наступні значення.

### Answer 12
- Бо багато мов мають кілька plural categories, не лише singular/plural.

---

## IV. Suggested Review

1. Повернись у [01 Module System Internals](../01-module-system-internals/README.md), якщо cyclic imports ще виглядають магією.
2. Повернись у [02 Iterators & Generators](../02-iterators-and-generators/README.md), якщо `for...of` і generator ще плутаються.
3. Повернись у [03 Proxy & Reflect](../03-proxy-and-reflect/README.md), якщо `Reflect` усе ще здається optional noise.
4. Повернись у [04 Intl API & Globalization](../04-intl-api-and-globalization/README.md), якщо locale formatting ще виглядає “лише UI-шною дрібницею”.
