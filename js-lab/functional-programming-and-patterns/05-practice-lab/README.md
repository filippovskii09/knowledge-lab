# Practice Lab: Functional Programming & Patterns

Цей lab потрібен, щоб перейти від “я розумію теорію” до “я можу переробити код без багів і без зайвої абстракції”. Завдання змішані: mutation, HOF, composition, recursion, readable refactoring.

---

> [!TIP]
> **[▶ Відкрити Immutability vs Mutation Board](../../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/immutability-vs-mutation-board/index.html)**

> [!TIP]
> **[▶ Відкрити Nested Immutable Update Board](../../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/nested-immutable-update-board/index.html)**

> [!TIP]
> **[▶ Відкрити HOF Pipeline Visualizer](../../visualisation/functional-programming-and-patterns/02-higher-order-functions/hof-pipeline-visualizer/index.html)**

> [!TIP]
> **[▶ Відкрити Currying vs Partial Application Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/currying-vs-partial-board/index.html)**

> [!TIP]
> **[▶ Відкрити Composition Chain Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/composition-chain-board/index.html)**

> [!TIP]
> **[▶ Відкрити Pipeline Refactor Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/pipeline-refactor-board/index.html)**

> [!TIP]
> **[▶ Відкрити Recursion Stack Visualizer](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-stack-visualizer/index.html)**

> [!TIP]
> **[▶ Відкрити Recursion vs Iteration Board](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-vs-iteration-board/index.html)**

> [!TIP]
> **[▶ Відкрити Recursion Debug Board](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-debug-board/index.html)**

---

## I. How To Use This Lab

Для кожної задачі проходь один і той самий маршрут:

1. Визнач, чи є side effects.
2. Визнач, чи є shared mutable state.
3. Подумай, чи підходить HOF, loop, composition або recursion.
4. Лише потім переписуй код.

---

## II. Tasks

### Task 1
```javascript
function addUser(users, user) {
  users.push(user);
  return users;
}
```
Що тут погано для predictability?

### Task 2
```javascript
function getTotal(prices) {
  let total = 0;
  for (const price of prices) {
    total += price;
  }
  return total;
}
```
Чи варто тут переходити на `reduce`? Аргументуй.

### Task 3
```javascript
const result = orders
  .filter(order => order.active)
  .reduce((acc, order) => {
    acc.push(order.total * 1.2);
    return acc;
  }, []);
```
Який простіший запис тут кращий?

### Task 4
```javascript
function rename(user, name) {
  user.name = name;
  return user;
}
```
Перепиши без mutation input.

### Task 5
```javascript
const startsWith = prefix => value => value.startsWith(prefix);
```
Це currying чи partial application у використанні?

### Task 6
```javascript
const normalize = value => value.trim().toLowerCase().replaceAll(' ', '-');
```
Розбий це на composition-friendly кроки.

### Task 7
```javascript
function factorial(n) {
  return n * factorial(n - 1);
}
```
Чого тут не вистачає?

### Task 8
```javascript
function flatten(list) {
  return list.reduce((acc, item) => acc.concat(item), []);
}
```
Коли цей код уже перестає бути добрим прикладом FP?

### Task 9
```javascript
function countVisible(items) {
  return items.filter(item => {
    console.log(item.id);
    return item.visible;
  }).length;
}
```
Чому ця функція не pure?

### Task 10
```javascript
const compose = (f, g) => value => f(g(value));
```
Яку умову мають виконувати `f` і `g`, щоб composition була стабільною?

### Task 11
Напиши curried validator для `minLength`, а потім використай його для двох різних полів.

### Task 12
Напиши функцію, яка повертає новий state після оновлення `user.profile.name` без mutation старого state.

### Task 13
Перепиши recursive sum через loop. Порівняй, що стало ясніше, а що менш виразним.

### Task 14
Для traversal дерева категорій вибери: recursion чи explicit stack? Поясни від чого залежить рішення.

### Task 15
Покажи приклад HOF, який повертає функцію, а не лише приймає її.

### Task 16
У тебе є pipeline з 7 дрібних функцій. За якими ознаками зрозуміти, що він уже over-composed?

---

## III. Quick Hints

1. Mutation input.
2. Не завжди; simple loop already clear.
3. `filter` + `map`.
4. Return new object.
5. Curried function used as configurator.
6. Виділи trim / lower / slugify.
7. Base case.
8. Коли concat у reduce створює overhead і код утрачає читабельність.
9. Логування — side effect.
10. Shape output/input має збігатися.
11. Подумай про `min => value => ...`.
12. Spread на кожному nested level.
13. Loop often safer for large linear input.
14. Depth, readability, stack risk.
15. Наприклад predicate factory.
16. Debugging стало важчим за вигоду.

---

## IV. Step-by-Step Answers

### Answer 1
- Основний механізм: shared mutable state.
- Проблема: `push` мутує початковий масив.
- Наслідок: усі інші місця, що тримають reference на `users`, бачать зміну.
- Кращий варіант: `return [...users, user];`

### Answer 2
- Основний механізм: вибір між readability і декларативністю.
- Простий `for` тут уже добре читається.
- `reduce` не обов'язково покращить код.
- Правильна відповідь: перейти можна, але це не automatic win.

### Answer 3
- Основний механізм: неправильне використання `reduce` як `map`.
- Код і відбирає, і трансформує, і мутує accumulator.
- Простіше: `orders.filter(o => o.active).map(o => o.total * 1.2)`.

### Answer 4
- Основний механізм: mutation input object.
- Кращий варіант: `return { ...user, name };`
- Це прибирає hidden side effect.

### Answer 5
- Основний механізм: unary configurator.
- `startsWith(prefix)` повертає нову функцію для value.
- Це currying-like pattern, корисний для reusable predicates.

### Answer 6
- Основний механізм: decomposition of transforms.
- Можливий варіант: `trim`, `toLower`, `slugifySpaces`.
- Потім їх можна скласти в pipeline.

### Answer 7
- Основний механізм: recursion needs base case.
- Без base case виклики не зупиняться.
- Треба додати щось на кшталт `if (n <= 1) return 1;`.

### Answer 8
- Основний механізм: FP style не гарантує pragmatic code.
- Якщо масив великий, repeated `concat` може бути шумним і менш ефективним.
- Треба дивитися на readability та cost.

### Answer 9
- Основний механізм: side effect.
- `console.log` робить функцію technically impure.
- Результат може бути той самий, але поведінка вже observable.

### Answer 10
- Основний механізм: shape compatibility.
- Output `g` має підходити як input для `f`.
- Інакше chain стане крихким або вимагатиме adapters.

### Answer 11
- Модель: `const minLength = min => value => value.length >= min;`
- Використання: `const min3 = minLength(3); const min8 = minLength(8);`

### Answer 12
- Модель: spread на кожному рівні вкладеності.
- Наприклад: `return { ...state, user: { ...state.user, profile: { ...state.user.profile, name } } };`

### Answer 13
- Рекурсія виразна, але loop безпечніший для великих input.
- У JS це важливий trade-off.

### Answer 14
- Якщо дерево природно рекурсивне й depth контрольована, recursion ок.
- Якщо дерево може бути дуже глибоким, explicit stack safer.

### Answer 15
- Приклад: `const hasRole = role => user => user.roles.includes(role);`

### Answer 16
- Ознаки: важко ставити breakpoints, неясні проміжні значення, складно логувати, важко пояснити pipeline уголос.

---

## V. Suggested Review

1. Повернись у [01 Immutability & Pure Functions](../01-immutability-and-pure-functions/README.md), якщо mutation і reassignment ще змішуються.
2. Повернись у [03 Currying & Composition](../03-currying-and-composition/README.md), якщо pipeline виглядає магічним.
3. Після цього переходь у [06 Bug Lab](../06-bug-lab/README.md), щоб перевірити себе на реальних поломках.
4. Потім добий repair-skills через [07 Bug Hunt Lab](../07-bug-hunt-lab/README.md).
