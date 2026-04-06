# Bug Hunt Lab: Functional Programming & Patterns

Цей lab не питає “що тут не так?”. Він змушує **виправити код руками**. Кожен кейс короткий, але типовий: hidden mutation, wrong `reduce`, over-composition, recursion bug.

---

## I. How To Use This Lab

Для кожного кейсу йди в такому порядку:

1. Назви головний механізм поломки.
2. Скажи, що саме треба зберегти: purity, immutability, readability або stack safety.
3. Виправ код мінімальним достатнім способом.
4. Перевір, чи не став refactor складнішим за саму задачу.

---

## II. Bug Hunts

### Hunt 1: Mutating Push
```javascript
function addUser(users, user) {
  users.push(user);
  return users;
}
```
Виправ так, щоб старий масив не змінювався.

### Hunt 2: Broken Nested Update
```javascript
function rename(state, name) {
  const next = { ...state };
  next.user.profile.name = name;
  return next;
}
```
Виправ так, щоб old state лишався стабільним.

### Hunt 3: Side Effect Inside filter
```javascript
function getVisibleIds(items) {
  return items.filter(item => {
    analytics.push(item.id);
    return item.visible;
  }).map(item => item.id);
}
```
Перепиши так, щоб transform не мав hidden side effect.

### Hunt 4: Overused reduce
```javascript
function getNames(users) {
  return users.reduce((acc, user) => {
    if (user.active) {
      acc.push(user.name);
    }
    return acc;
  }, []);
}
```
Зроби варіант, який читається краще.

### Hunt 5: sort Mutation
```javascript
function sortUsers(users) {
  return users.sort((a, b) => a.name.localeCompare(b.name));
}
```
Виправ так, щоб caller не отримував несподівано змінений масив.

### Hunt 6: No Base Case
```javascript
function factorial(n) {
  return n * factorial(n - 1);
}
```
Додай коректний stopping logic.

### Hunt 7: No Progress to Base Case
```javascript
function walk(n) {
  if (n <= 0) return 0;
  return 1 + walk(n);
}
```
Виправ recursion так, щоб вона реально рухалася до зупинки.

### Hunt 8: Composition That Hides Intent
```javascript
const run = compose(withAudit, compose(normalize, compose(enrich, validate)));
```
Перепиши у форму, яку легше дебажити й пояснювати.

### Hunt 9: Shallow Freeze Assumption
```javascript
const state = Object.freeze({
  user: { profile: { name: 'Ann' } }
});

state.user.profile.name = 'Ira';
```
Що саме тут треба змінити в моделі коду, а не лише в одному рядку?

### Hunt 10: Huge Recursive Sum
```javascript
function sum(list, index = 0) {
  if (index >= list.length) return 0;
  return list[index] + sum(list, index + 1);
}
```
Перепиши так, щоб великий input не впирався в call stack.

---

## III. Quick Hints

1. `push` мутує input.
2. Shallow copy не рятує nested branch.
3. Аналітика має бути винесена за межу pure transform.
4. `filter` + `map` тут виразніші.
5. Копія перед `sort`.
6. Потрібен base case.
7. Потрібен measurable progress.
8. Або `pipe`, або named steps, або plain sequential code.
9. `Object.freeze` не дає deep immutability.
10. Loop або explicit accumulator.

---

## IV. Step-by-Step Fixes

### Fix 1
```javascript
function addUser(users, user) {
  return [...users, user];
}
```
Чому так: старий масив не мутується, а новий value прозорий для caller.

### Fix 2
```javascript
function rename(state, name) {
  return {
    ...state,
    user: {
      ...state.user,
      profile: {
        ...state.user.profile,
        name
      }
    }
  };
}
```
Чому так: копіюються всі рівні, які реально змінюються.

### Fix 3
```javascript
function getVisibleIds(items) {
  return items
    .filter(item => item.visible)
    .map(item => item.id);
}
```
Чому так: transform знову став pure. Якщо analytics потрібна, її треба робити окремо на boundary.

### Fix 4
```javascript
function getNames(users) {
  return users
    .filter(user => user.active)
    .map(user => user.name);
}
```
Чому так: selection і transform читаються краще, ніж reduce-акумулятор.

### Fix 5
```javascript
function sortUsers(users) {
  return [...users].sort((a, b) => a.name.localeCompare(b.name));
}
```
Чому так: caller не отримує mutated original array.

### Fix 6
```javascript
function factorial(n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}
```
Чому так: recursion тепер має stopping logic.

### Fix 7
```javascript
function walk(n) {
  if (n <= 0) return 0;
  return 1 + walk(n - 1);
}
```
Чому так: recursive call реально наближається до base case.

### Fix 8
```javascript
const run = value => {
  const validated = validate(value);
  const enriched = enrich(validated);
  const normalized = normalize(enriched);
  return withAudit(normalized);
};
```
Чому так: проміжні значення стали явними, debug cost упав.

### Fix 9
```javascript
const state = {
  user: { profile: { name: 'Ann' } }
};

const next = {
  ...state,
  user: {
    ...state.user,
    profile: {
      ...state.user.profile,
      name: 'Ira'
    }
  }
};
```
Чому так: тут треба не “вірити freeze”, а будувати модель immutable updates.

### Fix 10
```javascript
function sum(list) {
  let total = 0;
  for (const item of list) {
    total += item;
  }
  return total;
}
```
Чому так: loop прибирає ризик stack overflow на великому input.

---

## V. Suggested Route

1. Для nested update кейсів відкривай [Nested Immutable Update Board](../../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/nested-immutable-update-board/index.html).
2. Для `loop vs HOF vs composition` порівнянь відкривай [Pipeline Refactor Board](../../visualisation/functional-programming-and-patterns/03-currying-and-composition/pipeline-refactor-board/index.html).
3. Для recursion-багів відкривай [Recursion Debug Board](../../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-debug-board/index.html).
