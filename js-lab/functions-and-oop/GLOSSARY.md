# Functions & OOP Glossary

Короткий словник термінів із блоку `functions-and-oop`.

---

## Functions and Closures

- **`[[Environment]]`** — внутрішнє посилання function object на lexical environment, де її створили. Див. [01](./01-environment-reference/README.md).
- **Lexical Environment** — середовище bindings для змінних і параметрів. Див. [01](./01-environment-reference/README.md).
- **Closure** — функція плюс reachable lexical environment, який вона утримує доступним після завершення зовнішньої функції. Див. [01](./01-environment-reference/README.md).
- **Retention Path** — ланцюг посилань, який не дає GC зібрати дані. Див. [01](./01-environment-reference/README.md).

---

## Prototypes and Objects

- **`[[Prototype]]`** — внутрішнє посилання об'єкта на його prototype. Див. [02](./02-prototype-chain/README.md).
- **Prototype Chain** — lookup path через послідовність прототипів до `null`. Див. [02](./02-prototype-chain/README.md).
- **`[[Get]]`** — внутрішня операція читання властивості. Див. [02](./02-prototype-chain/README.md).
- **Receiver** — об'єкт, який стає `this` для getter call у `[[Get]]`. Див. [02](./02-prototype-chain/README.md).
- **Own Property** — властивість, яка лежить безпосередньо на самому об'єкті, а не приходить з prototype chain. Див. [02](./02-prototype-chain/README.md), [08](./08-shadowing-properties/README.md).
- **Shadowing** — own property перекриває prototype property того ж імені. Див. [08](./08-shadowing-properties/README.md).

---

## Constructors and Classes

- **`[[Call]]`** — internal method звичайного виклику function. Див. [04](./04-function-internal-slots/README.md).
- **`[[Construct]]`** — internal method construct semantics для `new`. Див. [04](./04-function-internal-slots/README.md).
- **Callable** — значення, яке можна викликати як функцію. Див. [04](./04-function-internal-slots/README.md).
- **Constructable** — значення, яке можна використовувати з `new`. Див. [04](./04-function-internal-slots/README.md).
- **Syntactic Sugar** — зручний syntax поверх старішої моделі без її скасування. Див. [03](./03-class-syntactic-sugar/README.md).

---

## Properties and Descriptors

- **Property Descriptor** — структурований опис властивості і її поведінки. Див. [05](./05-property-descriptors/README.md).
- **Data Descriptor** — descriptor з `value` і `writable`. Див. [05](./05-property-descriptors/README.md).
- **Accessor Descriptor** — descriptor з `get` і/або `set`. Див. [05](./05-property-descriptors/README.md).
- **Getter** — функція, яка виконується під час читання властивості замість прямого повернення збереженого `value`. Див. [05](./05-property-descriptors/README.md), [08](./08-shadowing-properties/README.md).
- **Setter** — функція, яка виконується під час запису у властивість замість прямої зміни `value`. Див. [05](./05-property-descriptors/README.md).
- **Descriptor Flags** — набір прапорців `writable`, `enumerable`, `configurable`, які змінюють поведінку властивості. Див. [05](./05-property-descriptors/README.md), [10](./10-descriptor-shadowing-bug-lab/README.md).
- **`writable`** — чи можна змінити value. Див. [05](./05-property-descriptors/README.md).
- **`enumerable`** — чи бере участь властивість у звичайній enumeration. Див. [05](./05-property-descriptors/README.md).
- **`configurable`** — чи можна видаляти/перевизначати descriptor. Див. [05](./05-property-descriptors/README.md).

---

## OOP Patterns

- **Inheritance** — reuse через prototype/class hierarchy. Див. [06](./06-oop-patterns-composition-vs-inheritance/README.md).
- **Composition** — reuse через збирання поведінки з окремих частин. Див. [06](./06-oop-patterns-composition-vs-inheritance/README.md).
- **Constructor Function** — function, яка використовується через `new` для створення instance state. Див. [07](./07-object-create-vs-constructor-functions/README.md).
- **`Object.create`** — explicit creation API для об'єкта з заданим prototype. Див. [07](./07-object-create-vs-constructor-functions/README.md).
- **Explicit Delegation** — модель, де ми явно задаємо, кому саме об'єкт делегує lookup через `Object.create(proto)`. Див. [07](./07-object-create-vs-constructor-functions/README.md).
- **Safe Dictionary** — object без `Object.prototype`, часто через `Object.create(null)`. Див. [07](./07-object-create-vs-constructor-functions/README.md).
