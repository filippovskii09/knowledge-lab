# Bug Lab: Functional Programming & Patterns

Цей lab не про “написати красиво”, а про **знайти, чому код поводиться дивно**. Тут зібрані кейси, де mutation, shared references, over-composition і recursion дають дуже земні production-баги.

---

> [!TIP]
> Для кейсів із mutation і shared references тримай під рукою [Immutability vs Mutation Board](../../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/immutability-vs-mutation-board/index.html).

> [!TIP]
> Для nested update traps відкривай [Nested Immutable Update Board](../../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/nested-immutable-update-board/index.html).

> [!TIP]
> Для кейсів із transform-пайплайнами відкривай [HOF Pipeline Visualizer](../../visualisation/functional-programming-and-patterns/02-higher-order-functions/hof-pipeline-visualizer/index.html) і [Composition Chain Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/composition-chain-board/index.html).

> [!TIP]
> Для вибору між `loop`, HOF і composition відкривай [Pipeline Refactor Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/pipeline-refactor-board/index.html).

> [!TIP]
> Для recursion bugs звіряйся з [Recursion Stack Visualizer](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-stack-visualizer/index.html).

> [!TIP]
> Для діагностики `missing base case`, `no progress` і `stack overflow risk` відкривай [Recursion Debug Board](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-debug-board/index.html).

---

## I. Diagnostic Cases

### Case 1: Hidden Mutation
```javascript
function markDone(task) {
  task.done = true;
  return task;
}
```
Чому після одного виклику міняється стан в іншому місці UI?

### Case 2: Shared Nested Reference
```javascript
const next = { ...state };
next.user.profile.name = 'Ira';
```
Чому старий state теж ніби “оновився”?

### Case 3: Broken Reduce
```javascript
const grouped = items.reduce((acc, item) => {
  acc[item.type].push(item);
  return acc;
}, {});
```
Чому це падає не одразу зрозуміло й де прихована пастка?

### Case 4: Over-Composed Pipeline
```javascript
const run = compose(withAudit, compose(normalize, compose(enrich, validate)));
```
Чому цей код поганий навіть якщо технічно працює?

### Case 5: Fake Purity
```javascript
function getPrice(item) {
  analytics.push(item.id);
  return item.price;
}
```
Чому функція виглядає pure, але не є такою?

### Case 6: Missing Base Case
```javascript
function walk(node) {
  return node.children.map(walk);
}
```
Що тут треба перевірити перед recursion?

### Case 7: Stack Overflow in Practice
```javascript
function sum(list, index = 0) {
  if (index >= list.length) return 0;
  return list[index] + sum(list, index + 1);
}
```
Чому цей код може впасти на великому input, хоча алгоритм правильний?

### Case 8: sort Side Effect
```javascript
function getSorted(users) {
  return users.sort((a, b) => a.name.localeCompare(b.name));
}
```
Чому це небезпечно для predictability?

---

## II. Quick Hints

1. Reference sharing.
2. Shallow copy не копіює nested object.
3. `acc[item.type]` може бути `undefined`.
4. Cognitive load більший за користь.
5. Hidden side effect.
6. Чи існує childless/base case?
7. Stack depth.
8. `sort` mutates original array.

---

## III. Step-by-Step Answers

### Answer 1
- Основний механізм: mutation shared object.
- Якщо цей `task` десь ще використовується, усі бачать новий `done`.
- Кращий варіант: `return { ...task, done: true };`

### Answer 2
- Основний механізм: shallow copy only top level.
- `state.user.profile` лишився тим самим reference.
- Треба копіювати кожен nested level, який змінюється.

### Answer 3
- Основний механізм: accumulator shape не ініціалізовано.
- Спочатку треба створити масив: `acc[item.type] ??= [];`
- Інакше код падає на `.push`.

### Answer 4
- Основний механізм: over-abstraction.
- Дуже важко читати flow і ставити debug breakpoints.
- Краще розкласти pipeline на іменовані кроки або `pipe` left-to-right.

### Answer 5
- Основний механізм: hidden side effect in analytics array.
- Функція читається як getter, але змінює зовнішній state.
- Це підступний impurity bug.

### Answer 6
- Основний механізм: recursion without safe stopping logic.
- Треба перевірити, що `children` існує і що leaf-node повертається без нового recurse.

### Answer 7
- Основний механізм: runtime stack limit.
- Алгоритм логічно коректний, але runtime може не витримати глибину.
- Loop або explicit accumulator часто safer.

### Answer 8
- Основний механізм: in-place mutation.
- `sort` змінює оригінальний масив, тому caller може несподівано отримати reordered data.
- Безпечніше: `return [...users].sort(...)`.

---

## IV. Suggested Review

1. Повернись у [01 Immutability & Pure Functions](../01-immutability-and-pure-functions/README.md), якщо hidden mutation ще не ловиться автоматично.
2. Повернись у [02 Higher-Order Functions](../02-higher-order-functions/README.md), якщо `reduce` усе ще здається “відповіддю на все”.
3. Повернись у [04 Recursion & Tail-Call Thinking](../04-recursion-and-tail-call-thinking/README.md), якщо recursion ризики ще недооцінені.
4. Після цього переходь у [07 Bug Hunt Lab](../07-bug-hunt-lab/README.md), щоб не лише діагностувати, а й руками виправляти короткі кейси.
