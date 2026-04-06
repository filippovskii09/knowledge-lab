# Functions & OOP

Цей блок пояснює, як у JavaScript реально працюють функції, об'єкти, класи і прототипи. Не на рівні "синтаксису, який ми пишемо", а на рівні внутрішніх механік: `[[Environment]]`, `[[Get]]`, `[[Call]]`, `[[Construct]]`, property descriptors, delegation і object composition.

---

## Scope

У цьому модулі ми закриваємо десять основних тем:

1. `[[Environment]]` і механіку closures.
2. Prototype chain lookup і внутрішню операцію `[[Get]]`.
3. `class` як синтаксичний шар поверх constructor/prototype model.
4. Function internal slots: `[[Call]]` vs `[[Construct]]`.
5. Property descriptors: `writable`, `enumerable`, `configurable`.
6. OOP patterns: composition vs inheritance.
7. `Object.create` vs constructor functions.
8. Shadowing properties.
9. Практичний lab на типові пастки цього блоку.
10. Окремий діагностичний lab для descriptor/shadowing scenarios.

---

## Розділи

### 1. [`[[Environment]]` Reference](./01-environment-reference/README.md)
- Як function object зберігає lexical environment.
- Чому closure переживає завершення зовнішньої функції.
- Як це пов'язано з retention і leaks.

### 2. [Prototype Chain Lookup](./02-prototype-chain/README.md)
- Як працює `[[Get]]`.
- Де тут accessor descriptors, `Receiver` і prototype lookup.
- Чому `Object.setPrototypeOf()` варто уникати в hot code.

### 3. [Syntactic Sugar](./03-class-syntactic-sugar/README.md)
- Що саме ховає `class`.
- Як методи опиняються в `.prototype`.
- Які semantics `class` відрізняють його від plain constructor function.

### 4. [Function Internal Slots](./04-function-internal-slots/README.md)
- Різниця між `[[Call]]` і `[[Construct]]`.
- Чому не кожна function може бути constructor.
- Як `new` залежить від `[[Construct]]`.

### 5. [Property Descriptors](./05-property-descriptors/README.md)
- `writable`, `enumerable`, `configurable`.
- Data descriptor vs accessor descriptor.
- Як descriptors визначають поведінку властивостей.

### 6. [Composition vs Inheritance](./06-oop-patterns-composition-vs-inheritance/README.md)
- Коли делегування і композиція кращі за ієрархії.
- Як оцінювати coupling і behavior reuse.
- Практичні trade-offs для JS-коду.

### 7. [Object.create vs Constructor Functions](./07-object-create-vs-constructor-functions/README.md)
- Дві моделі створення об'єктів із прототипом.
- Де одна модель точніша або простіша за іншу.
- Як це пов'язано з explicit delegation.

### 8. [Shadowing Properties](./08-shadowing-properties/README.md)
- Як own property затіняє prototype property.
- Чим shadowing відрізняється від mutation у прототипі.
- Як це впливає на lookup і читабельність.

### 9. [Practice Lab](./09-practice-lab/README.md)
- Практичні задачі на closures, prototypes, descriptors, constructors і shadowing.
- Короткі hints для самоперевірки.

### 10. [Descriptor + Shadowing Bug Lab](./10-descriptor-shadowing-bug-lab/README.md)
- Діагностичні кейси, де код поводиться "дивно".
- Покроковий розбір: descriptor flags vs lookup path vs shadowing vs shared reference mutation.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

### Ключові інтерактиви

- [Closures Visualizer](../visualisation/functions-and-oop/01-closures/index.html)
- [Prototype Chain Visualizer](../visualisation/functions-and-oop/02-prototype-chain/index.html)
- [The `new` Keyword Algorithm](../visualisation/functions-and-oop/03-new-keyword/index.html)
- [Call vs Construct](../visualisation/functions-and-oop/04-function-internal-slots/call-vs-construct/index.html)
- [Property Descriptors](../visualisation/functions-and-oop/05-property-descriptors/descriptors/index.html)
- [Object.create Variants](../visualisation/functions-and-oop/07-object-create-vs-constructor-functions/object-create-variants/index.html)
- [Shadowing Lookup](../visualisation/functions-and-oop/08-shadowing-properties/shadowing-lookup/index.html)
- [Descriptor + Shadowing Debug Board](../visualisation/functions-and-oop/10-descriptor-shadowing-bug-lab/debug-board/index.html)

Усі основні теоретичні статті в цьому блоці мають:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Пояснити, чому closure живе після завершення батьківської функції.
2. Пройти lookup властивості через `[[Get]]` покроково.
3. Відрізнити `class`-синтаксис від базової prototype model.
4. Пояснити різницю між callable function і constructable function.
5. Використовувати descriptors, не ламаючи власні API.
6. Вибирати між composition, inheritance, `Object.create` і constructors не за модою, а за моделлю поведінки.
