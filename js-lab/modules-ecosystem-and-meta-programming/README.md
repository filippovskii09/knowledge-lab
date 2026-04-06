# Modules, Ecosystem & Meta-programming

Цей блок закриває шар JavaScript, який часто стоїть **над синтаксисом**: модульну систему, протоколи перебору, interception через `Proxy` і runtime globalization через `Intl`. Це не просто “ще кілька API”, а механізми, які визначають, як код завантажується, обходить дані, перехоплює операції й форматує результати для реального світу.

---

## Scope

У цьому модулі шість основних частин:

1. Module System Internals.
2. Iterators & Generators.
3. Proxy & Reflect.
4. Intl API & Globalization.
5. Practice Lab.
6. Bug Lab.

---

## Розділи

### 1. [Module System Internals](./01-module-system-internals/README.md)
- `CJS` vs `ESM` на execution-рівні.
- module cache, live bindings, cyclic dependencies, evaluation order.

### 2. [Iterators & Generators](./02-iterators-and-generators/README.md)
- iterable protocol, iterator object, `Symbol.iterator`, `next()`.
- generators як зручні iterator factories.

### 3. [Proxy & Reflect](./03-proxy-and-reflect/README.md)
- interception layer для object operations.
- traps, invariants, `Reflect` як спосіб зберегти default semantics.

### 4. [Intl API & Globalization](./04-intl-api-and-globalization/README.md)
- `NumberFormat`, `DateTimeFormat`, `RelativeTimeFormat`, `PluralRules`.
- locale-aware formatting без хаотичних `.toLocaleString(...)`.

### 5. [Practice Lab](./05-practice-lab/README.md)
- модульні цикли, custom iterables, generators, proxy tasks, locale formatting drills.

### 6. [Bug Lab](./06-bug-lab/README.md)
- cyclic import bugs, broken iterators, proxy recursion, locale mismatches, formatter misuse.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

### Ключові інтерактиви

- [Module Graph Cycle Board](../visualisation/modules-ecosystem-and-meta-programming/01-module-system-internals/module-graph-cycle-board/index.html)
- [Iterator Protocol Board](../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/iterator-protocol-board/index.html)
- [Generator Yield Board](../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/generator-yield-board/index.html)
- [Proxy Reflect Flow Board](../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reflect-flow-board/index.html)
- [Proxy Reactivity Board](../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reactivity-board/index.html)
- [Intl Formatting Board](../visualisation/modules-ecosystem-and-meta-programming/04-intl-api-and-globalization/intl-formatting-board/index.html)

Усі теоретичні статті цього блоку мають єдиний навчальний шаблон:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Пояснювати різницю між `CJS` і `ESM` через execution model, а не лише через синтаксис.
2. Писати й дебажити custom iterables та generators.
3. Розуміти, що саме перехоплює `Proxy`, навіщо потрібен `Reflect` і де тут runtime-межі.
4. Форматувати числа, дати й plural-forms через `Intl` стабільно й передбачувано.
5. Діагностувати cyclic imports, broken iterators, proxy traps і locale bugs без магічного мислення.
6. Відрізняти protocol-level проблему від звичайної помилки в окремій функції.
