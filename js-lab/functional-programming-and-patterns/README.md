# Functional Programming & Patterns

Цей блок закриває **функціональне мислення в JavaScript** без культу навколо FP. Тут фокус не на академічній термінології, а на практичних речах: **predictability**, **testability**, **safe updates**, **reusable transforms** і здоровий підхід до рекурсії.

---

## Scope

У цьому модулі сім основних частин:

1. Immutability & Pure Functions.
2. Higher-Order Functions.
3. Currying & Composition.
4. Recursion & Tail-Call Thinking.
5. Practice Lab.
6. Bug Lab.
7. Bug Hunt Lab.

---

## Розділи

### 1. [Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md)
- Як прибирати побічні ефекти й робити поведінку коду передбачуваною.
- Коли immutable update реально потрібний, а коли це зайва церемонія.

### 2. [Higher-Order Functions](./02-higher-order-functions/README.md)
- Функції як значення.
- `map`, `filter`, `reduce`, custom HOF і межі їхньої читабельності.

### 3. [Currying & Composition](./03-currying-and-composition/README.md)
- Як збирати pipeline з малих функцій.
- Currying, partial application, composition і point-free style без магії.

### 4. [Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md)
- Base case, recursive case, stack growth.
- Чому TCO концептуально важливий, але в JS на нього не можна покладатися.

### 5. [Practice Lab](./05-practice-lab/README.md)
- Рефакторинг імперативного коду у функціональний.
- Вибір між loop, HOF, composition і recursion.

### 6. [Bug Lab](./06-bug-lab/README.md)
- Hidden mutation, shared references, broken reduce, recursion overflow.
- Production-сценарії, де “функціональний” код виявляється не таким уже функціональним.

### 7. [Bug Hunt Lab](./07-bug-hunt-lab/README.md)
- Короткі зламані приклади, які треба саме виправити.
- Мінімальні pragmatic refactor-и без академічного overkill.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

### Ключові інтерактиви

- [Immutability vs Mutation Board](../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/immutability-vs-mutation-board/index.html)
- [Nested Immutable Update Board](../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/nested-immutable-update-board/index.html)
- [HOF Pipeline Visualizer](../visualisation/functional-programming-and-patterns/02-higher-order-functions/hof-pipeline-visualizer/index.html)
- [Currying vs Partial Application Board](../visualisation/functional-programming-and-patterns/03-currying-and-composition/currying-vs-partial-board/index.html)
- [Composition Chain Board](../visualisation/functional-programming-and-patterns/03-currying-and-composition/composition-chain-board/index.html)
- [Pipeline Refactor Board](../visualisation/functional-programming-and-patterns/03-currying-and-composition/pipeline-refactor-board/index.html)
- [Recursion Stack Visualizer](../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-stack-visualizer/index.html)
- [Recursion vs Iteration Board](../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-vs-iteration-board/index.html)
- [Recursion Debug Board](../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-debug-board/index.html)

Усі теоретичні статті цього блоку мають:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Відрізняти pure function від impurity без вгадування.
2. Робити безпечні immutable updates без випадкового shared-state bug.
3. Обирати між loop і HOF за читабельністю та задачею.
4. Збирати невеликі композиційні pipeline без unreadable point-free коду.
5. Розуміти рекурсію як модель задачі, але не покладатися на TCO в JS runtime.
6. Діагностувати shallow-copy traps і over-composed refactors руками, а не інтуїцією.
