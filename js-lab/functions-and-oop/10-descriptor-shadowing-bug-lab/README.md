# 10. Descriptor + Shadowing Bug Lab

Цей lab не питає "що таке descriptor?" або "що таке shadowing?". Він ставить вас у режим діагностики: код уже поводиться дивно, а ваше завдання — знайти точний механізм поломки.

---

> [!TIP]
> **[▶ Запустити інтерактивний debug board (Descriptors + Shadowing)](../../visualisation/functions-and-oop/10-descriptor-shadowing-bug-lab/debug-board/index.html)**

---

## I. Debug Workflow

Для кожного кейсу проходьте один і той самий маршрут:

1. Це проблема **lookup**, **descriptor flags** чи **accessor behavior**?
2. Значення знайдене як **own property** чи через **prototype chain**?
3. Якщо assignment/delete не працює, що каже descriptor?
4. Якщо prototype getter "зник", чи не був він затінений own property?
5. Чи це справді mutation, чи лише зміна lookup path?

---

## II. Bugs

### Bug 1: Assignment Looks Broken
```javascript
const settings = {};

Object.defineProperty(settings, "theme", {
  value: "dark"
});

settings.theme = "light";
console.log(settings.theme);
```

**Симптом:** Розробник очікує `"light"`, але бачить старе значення.

**Що треба знайти:** Який descriptor flag тут блокує очікувану поведінку?

---

### Bug 2: Property Exists but Disappears from Keys
```javascript
const user = {};

Object.defineProperty(user, "token", {
  value: "abc",
  enumerable: false
});

console.log(user.token);
console.log(Object.keys(user));
```

**Симптом:** Властивість читається, але її "ніде немає" в `Object.keys`.

**Що треба знайти:** Чому lookup і enumeration показують різну картину?

---

### Bug 3: Delete Does Nothing
```javascript
const config = {};

Object.defineProperty(config, "version", {
  value: 1,
  configurable: false
});

delete config.version;
console.log(config.version);
```

**Симптом:** Після `delete` властивість не зникла.

**Що треба знайти:** Який descriptor flag контролює цей сценарій?

---

### Bug 4: Prototype Getter Раптом "Перестає Працювати"
```javascript
const parent = {
  get label() {
    return "parent";
  }
};

const child = Object.create(parent);
Object.defineProperty(child, "label", {
  value: "child"
});

console.log(child.label);
```

**Симптом:** Getter з прототипу "ніби зламався".

**Що треба знайти:** Чому lookup більше не доходить до prototype getter?

---

### Bug 5: "I Only Changed Child"
```javascript
const parent = { role: "user" };
const child = Object.create(parent);

child.role = "admin";

console.log(parent.role);
console.log(child.role);
```

**Симптом:** Один розробник каже "я змінив child", інший думає "значить parent теж оновився".

**Що треба знайти:** Це mutation чи shadowing?

---

### Bug 6: Shared Object Confusion
```javascript
const parent = { options: { theme: "dark" } };
const child = Object.create(parent);

child.options.theme = "light";

console.log(parent.options.theme);
```

**Симптом:** Розробник думає, що це shadowing, але змінюється і `parent`.

**Що треба знайти:** Чому це вже не shadowing?

---

### Bug 7: Method from Prototype "Replaced Itself"
```javascript
const parent = {
  run() {
    return "parent run";
  }
};

const child = Object.create(parent);
child.run = function () {
  return "child run";
};

console.log(child.run());
console.log(parent.run());
```

**Симптом:** Здається, що метод у prototype "переписався", але це не так.

**Що треба знайти:** Який lookup mechanism пояснює результат?

---

### Bug 8: Safe Dictionary Behaves "Too Empty"
```javascript
const dict = Object.create(null);

console.log(dict.toString);
console.log("toString" in dict);
```

**Симптом:** Об'єкт поводиться "занадто голо" порівняно зі звичайним `{}`.

**Що треба знайти:** Яку роль тут відіграє prototype absence?

---

## III. Quick Hints

1. Якщо assignment не працює, дивіться на `writable`.
2. Якщо властивість є, але її не видно в `Object.keys`, дивіться на `enumerable`.
3. Якщо `delete` не спрацював, дивіться на `configurable`.
4. Якщо prototype getter перестав брати участь у читанні, шукайте own property з тим самим ім'ям.
5. Якщо parent value не змінився, це часто shadowing.
6. Якщо змінився nested object у parent, це часто shared reference mutation.
7. Якщо child method відрізняється, але parent method лишився старим, це shadowing method property.
8. Якщо немає built-ins, перевірте, чи prototype не `null`.

---

## IV. Step-by-Step Answers

### Bug 1

**Крок 1:** Властивість створена через `Object.defineProperty`.

**Крок 2:** Явно задано лише `value`.

**Крок 3:** Для такої властивості `writable` не стає автоматично `true`.

**Висновок:** Assignment блокується descriptor semantics, а не "дивною поведінкою value".

### Bug 2

**Крок 1:** `user.token` читається через normal property lookup.

**Крок 2:** `Object.keys(user)` дивиться не на сам факт існування властивості, а на її `enumerable`.

**Крок 3:** Тут `enumerable: false`.

**Висновок:** Lookup і enumeration — різні механіки.

### Bug 3

**Крок 1:** `delete` контролюється не `writable`, а `configurable`.

**Крок 2:** Тут `configurable: false`.

**Крок 3:** Отже, властивість залишається.

**Висновок:** Це descriptor-level block, а не failure оператора `delete` як такого.

### Bug 4

**Крок 1:** Getter існує в prototype.

**Крок 2:** Але на `child` створена own property `label`.

**Крок 3:** `[[Get]]` зупиняється на own property і не доходить до prototype getter.

**Висновок:** Getter не "зламався"; його просто затінила own property.

### Bug 5

**Крок 1:** Присвоєння `child.role = "admin"` створює own property на `child`.

**Крок 2:** `parent.role` лишається старим.

**Крок 3:** Lookup path для `child.role` змінюється, але parent не мутується.

**Висновок:** Це класичний випадок shadowing.

### Bug 6

**Крок 1:** `child.options` спочатку знаходиться через prototype lookup.

**Крок 2:** Але `options` — це object reference.

**Крок 3:** `child.options.theme = "light"` мутує той самий nested object, а не створює нову own property `options`.

**Висновок:** Це shared reference mutation, а не shadowing.

### Bug 7

**Крок 1:** У `parent` є method `run`.

**Крок 2:** На `child` створено own method `run`.

**Крок 3:** Lookup для `child.run` зупиняється на own property; `parent.run` не змінюється.

**Висновок:** Це shadowing method property, а не mutation prototype method.

### Bug 8

**Крок 1:** `dict` створений через `Object.create(null)`.

**Крок 2:** У нього немає `Object.prototype` у chain.

**Крок 3:** Тому немає успадкованого `toString`, `hasOwnProperty` та інших built-ins.

**Висновок:** Це не "зламаний object", а свідомо створений safe dictionary без prototype interference.

---

## V. Suggested Review

Після цього lab варто повторити:

- [05 Property Descriptors](../05-property-descriptors/README.md)
- [07 Object.create vs Constructor Functions](../07-object-create-vs-constructor-functions/README.md)
- [08 Shadowing Properties](../08-shadowing-properties/README.md)
- [09 Practice Lab](../09-practice-lab/README.md)
