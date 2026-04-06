# Bug Lab: Modules, Ecosystem & Meta-programming

Цей lab не про “поясни тему”, а про **знайди, чому runtime поводиться дивно**. Тут зібрані типові поломки модульної системи, iterator protocol, proxy traps і locale formatting.

---

## I. Diagnostic Cases

### Case 1: Cyclic Import Bug
```javascript
// a.js
import { bValue } from './b.js';
export const aValue = bValue + 1;

// b.js
import { aValue } from './a.js';
export const bValue = aValue + 1;
```
Чому це нестабільна конструкція?

### Case 2: Iterator Never Ends
```javascript
const iterable = {
  [Symbol.iterator]() {
    return {
      next() {
        return { value: 1, done: false };
      }
    };
  }
};
```
Що тут піде не так в `for...of`?

### Case 3: Broken done Signal
```javascript
next() {
  if (index >= items.length) {
    return { value: undefined, done: false };
  }
}
```
Чому це ламає protocol?

### Case 4: Proxy Recursion
```javascript
const proxy = new Proxy(target, {
  get(obj, key) {
    return proxy[key];
  }
});
```
Чому це небезпечно?

### Case 5: Missing Reflect in set Trap
```javascript
set(target, key, value) {
  target[key] = value;
  return true;
}
```
Чому це інколи занадто наївний trap?

### Case 6: New Formatter Every Render
```javascript
function renderPrice(value) {
  return new Intl.NumberFormat('uk-UA', {
    style: 'currency',
    currency: 'UAH'
  }).format(value);
}
```
Що тут неідеально навіть якщо output правильний?

### Case 7: Locale Assumption Bug
```javascript
price.toLocaleString();
```
Чому цього мало для серйозного продукту?

### Case 8: Generator Misread as Async
```javascript
function* work() {
  yield fetch('/api/data');
}
```
Чому це саме по собі не робить код async workflow system?

---

## II. Quick Hints

1. Circular evaluation timing.
2. Infinite iteration.
3. `done` must be truthful.
4. Trap calls itself again.
5. Default semantics may be subtler.
6. Recreate formatter too often.
7. Implicit locale strategy.
8. `yield` != Promise scheduling.

---

## III. Step-by-Step Answers

### Answer 1
- Основний механізм: cyclic dependency + initialization timing.
- Один export читає інший до стабільної ініціалізації.
- Треба ламати cycle або відкладати похідні обчислення.

### Answer 2
- Iterator ніколи не завершується.
- `for...of` продовжить просити нові значення безкінечно.

### Answer 3
- Protocol каже: завершення має бути сигналізоване через `done: true`.
- Брехливий `done` ламає consumer expectations.

### Answer 4
- `get` читає знову через proxy, а не через target/Reflect.
- Це запускає той самий trap рекурсивно.

### Answer 5
- Manual assignment не завжди коректно відтворює default semantics receiver/prototype logic.
- `Reflect.set` зазвичай безпечніший як базова делегація.

### Answer 6
- Formatter створюється знову і знову без потреби.
- Краще reuse-ити один formatter object.

### Answer 7
- Немає explicit locale strategy.
- Result може відрізнятися між environments і вимогами продукту.

### Answer 8
- Generator лише видає значення й pause-иться.
- Хтось зовнішній ще має керувати yielded Promises.

---

## IV. Suggested Review

1. Повернись у [01 Module System Internals](../01-module-system-internals/README.md), якщо cycles ще виглядають як “рандомний import bug”.
2. Повернись у [02 Iterators & Generators](../02-iterators-and-generators/README.md), якщо `done` semantics ще не відчуваються автоматично.
3. Повернись у [03 Proxy & Reflect](../03-proxy-and-reflect/README.md), якщо proxy traps ще здаються “простими wrapper functions”.
4. Повернись у [04 Intl API & Globalization](../04-intl-api-and-globalization/README.md), якщо locale formatting ще недооцінене.
