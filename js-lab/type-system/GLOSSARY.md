# Type System Glossary

Короткий глосарій термінів із блоку `type-system`.

---

## Equality

- **Abstract Equality Comparison** — алгоритм для `==`, який може запускати coercion перед фінальним порівнянням. Див. [01](./01-abstract-vs-strict-equality/README.md).
- **Strict Equality Comparison** — алгоритм для `===` без неявного приведення типів. Див. [01](./01-abstract-vs-strict-equality/README.md).
- **SameValue** — алгоритм, доступний через `Object.is()`. Див. [01](./01-abstract-vs-strict-equality/README.md).
- **SameValueZero** — варіант рівності, який використовують `Set`, `Map`, `includes`. Див. [01](./01-abstract-vs-strict-equality/README.md).
- **Reference Identity** — порівняння object values за посиланням, а не за структурою. Див. [01](./01-abstract-vs-strict-equality/README.md).

---

## Coercion

- **Coercion** — неявне приведення значення до іншого типу за правилами мови. Див. [02](./02-primitive-coercion/README.md).
- **ToPrimitive** — abstract operation, яка перетворює object у primitive. Див. [02](./02-primitive-coercion/README.md).
- **OrdinaryToPrimitive** — стандартний fallback-процес через `valueOf()` / `toString()`. Див. [02](./02-primitive-coercion/README.md).
- **ToNumber** — abstract operation, яка перетворює значення на `Number`. Див. [02](./02-primitive-coercion/README.md).
- **ToString** — abstract operation, яка перетворює значення на string form. Див. [02](./02-primitive-coercion/README.md).
- **Hint** — підказка для `ToPrimitive`: `"string"`, `"number"` або `"default"`. Див. [02](./02-primitive-coercion/README.md).

---

## Numbers

- **Safe Integer** — ціле число, яке `Number` може представити без втрати integer precision. Див. [03](./03-bigint-and-precision-issues/README.md).
- **`Number.MAX_SAFE_INTEGER`** — найбільше безпечне ціле число для `Number`. Див. [03](./03-bigint-and-precision-issues/README.md).
- **Precision Boundary** — межа, після якої сусідні цілі числа можуть уже не відрізнятись точно. Див. [03](./03-bigint-and-precision-issues/README.md).
- **BigInt** — primitive type для довільно великих цілих чисел. Див. [03](./03-bigint-and-precision-issues/README.md).
- **Integer Division** — ділення без дробової частини в `BigInt` arithmetic. Див. [03](./03-bigint-and-precision-issues/README.md).
- **Floating-Point Precision** — окремий клас проблем із дробовими числами на `Number`. Див. [03](./03-bigint-and-precision-issues/README.md).

---

## Symbols

- **Symbol** — primitive type для унікальних значень. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **Global Symbol Registry** — механізм `Symbol.for()` / `Symbol.keyFor()`. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **Well-Known Symbol** — офіційний symbol hook, який читає сама мова. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **`Symbol.iterator`** — hook iterable protocol. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **`Symbol.toPrimitive`** — hook custom coercion protocol. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **`Symbol.hasInstance`** — hook для поведінки `instanceof`. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **`Symbol.toStringTag`** — hook для `Object.prototype.toString`. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **Iterator Protocol** — домовленість мови: отримати iterator через `Symbol.iterator`, а далі читати `next()` results до `done: true`. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **Iterator Object** — object із методом `next()`, який повертає iterator result objects. Див. [04](./04-symbols-and-well-known-symbols/README.md).
- **Iterator Result Object** — object формату `{ value, done }`, який керує ходом і завершенням ітерації. Див. [04](./04-symbols-and-well-known-symbols/README.md).
