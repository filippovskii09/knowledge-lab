# 09. Practice Lab

Цей lab збирає разом closures, prototypes, constructors, descriptors і shadowing. Мета — не вгадати результат, а правильно назвати механізм, який його породжує.

---

## I. Practice Workflow

Для кожної задачі проходьте однакову послідовність:

1. Який механізм тут головний: `[[Environment]]`, `[[Get]]`, `[[Construct]]`, descriptors, shadowing, composition?
2. Де живе значення: own property, prototype, lexical environment?
3. Чи є тут lookup, construct, call, accessor execution або retention path?
4. Лише після цього формулюйте відповідь.

---

## II. Tasks

### Task 1
```javascript
function make() {
  let x = 1;
  return function () {
    return x;
  };
}
```
Що саме утримує `x` живим?

### Task 2
```javascript
const parent = { value: 10 };
const child = Object.create(parent);
child.value = 20;
```
Що тут сталося: mutation чи shadowing?

### Task 3
```javascript
const parent = {
  get label() {
    return this.name;
  }
};

const child = Object.create(parent);
child.name = "Ada";
child.label;
```
Чому getter читає `child.name`?

### Task 4
```javascript
const sum = (a, b) => a + b;
new sum(1, 2);
```
Чому тут помилка?

### Task 5
```javascript
const obj = {};
Object.defineProperty(obj, "id", {
  value: 42
});
obj.id = 100;
```
Чому присвоєння не поводиться як звичайний plain assignment?

### Task 6
```javascript
function User(name) {
  this.name = name;
}

const user = Object.create(User.prototype);
```
Що тут є, а чого тут ще не сталося порівняно з `new User("Ada")`?

### Task 7
```javascript
class Button {
  click() {
    return this.name;
  }
}

const btn = new Button();
const fn = btn.click;
fn();
```
Чому клас не "врятував" `this`?

### Task 8
```javascript
const safeDict = Object.create(null);
```
Чому цей випадок важливий окремо від звичайного `{}`?

---

## III. Short Answers / Hints

1. Function object через `[[Environment]]`.
2. Shadowing: створена own property на child.
3. Через `Receiver` у getter path.
4. Arrow function має `[[Call]]`, але не має `[[Construct]]`.
5. Бо поведінку визначає descriptor, а не лише value.
6. Prototype link уже є, але constructor body ще не виконувався.
7. Бо method reference detached від receiver.
8. Бо в об'єкта немає `Object.prototype` у chain.

---

## IV. Step-by-Step Answers

### Task 1: `make()` і `x`

**Крок 1:** Визначаємо головний механізм — це `[[Environment]]`.

**Крок 2:** `x` живе не "всередині коду функції", а в lexical environment функції `make`.

**Крок 3:** Повернена inner function зберігає посилання на це середовище через `[[Environment]]`.

**Висновок:** `x` живим утримує function object, яке лишилося reachable після `return`.

### Task 2: `child.value = 20`

**Крок 1:** Визначаємо головний механізм — property lookup + shadowing.

**Крок 2:** До присвоєння `child` не має own property `value`, тому читання йде в `parent`.

**Крок 3:** Після присвоєння на `child` з'являється own property `value`.

**Висновок:** Це shadowing, а не mutation `parent.value`.

### Task 3: getter і `child.label`

**Крок 1:** Головний механізм — `[[Get]]` з accessor descriptor.

**Крок 2:** Getter знайдено в `parent`.

**Крок 3:** Але викликається він із `Receiver = child`.

**Висновок:** Усередині getter `this === child`, тому читається `child.name`.

### Task 4: `new sum(1, 2)`

**Крок 1:** Головний механізм — `[[Construct]]`.

**Крок 2:** `sum` — arrow function.

**Крок 3:** Arrow function callable, але не constructable.

**Висновок:** Помилка виникає тому, що в arrow function немає `[[Construct]]`.

### Task 5: `Object.defineProperty(obj, "id", { value: 42 })`

**Крок 1:** Головний механізм — property descriptor.

**Крок 2:** Властивість створено не через plain assignment, а через descriptor API.

**Крок 3:** Якщо прапорці не вказані явно, вони не стають автоматично `true`.

**Висновок:** Присвоєння поводиться не як звичайний assignment, бо descriptor суворіший за plain field.

### Task 6: `Object.create(User.prototype)`

**Крок 1:** Головний механізм — explicit prototype linking.

**Крок 2:** Новий object уже делегує в `User.prototype`.

**Крок 3:** Але constructor body `User(name)` ще не виконувався.

**Висновок:** Prototype link уже є, але state initialization через constructor ще не сталося.

### Task 7: `const fn = btn.click; fn();`

**Крок 1:** Головний механізм — semantics місця виклику для `this`.

**Крок 2:** Class method живе у prototype і лишається звичайною function.

**Крок 3:** Коли метод відривають від receiver, виклик уже не знає про `btn`.

**Висновок:** `class` не дає autobind; проблема в detached method reference.

### Task 8: `Object.create(null)`

**Крок 1:** Головний механізм — special prototype choice.

**Крок 2:** У такого object немає `Object.prototype` у ланцюжку.

**Крок 3:** Отже, немає успадкованих `toString`, `hasOwnProperty` та інших built-in properties.

**Висновок:** Це важливо для safe dictionaries і точного lookup без втручання з боку `Object.prototype`.

---

## V. Suggested Review

Після цього lab варто повернутися до:

- [01 `[[Environment]]` Reference](../01-environment-reference/README.md)
- [02 Prototype Chain Lookup](../02-prototype-chain/README.md)
- [03 Syntactic Sugar](../03-class-syntactic-sugar/README.md)
- [04 Function Internal Slots](../04-function-internal-slots/README.md)
- [05 Property Descriptors](../05-property-descriptors/README.md)
- [07 Object.create vs Constructor Functions](../07-object-create-vs-constructor-functions/README.md)
- [08 Shadowing Properties](../08-shadowing-properties/README.md)
- [10 Descriptor + Shadowing Bug Lab](../10-descriptor-shadowing-bug-lab/README.md)
