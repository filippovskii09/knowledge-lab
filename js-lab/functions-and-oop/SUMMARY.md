# Functions & OOP: Module Summary

Цей блок зводить разом closures, prototype lookup, constructors, descriptors і OOP-патерни в одну object model JavaScript.

---

## Mental Models

| Концепція | Коротка модель |
| :--- | :--- |
| `[[Environment]]` | Function object тримає шлях до lexical environment |
| `[[Get]]` | Читання властивості як lookup по own property і далі по prototype chain |
| `class` | Синтаксичний шар поверх constructor/prototype model |
| `[[Call]]` | Звичайний виклик функції |
| `[[Construct]]` | Constructor semantics для `new` |
| Descriptor | Правила поведінки властивості, а не лише значення |
| Composition | Reuse через збирання поведінки з окремих частин |
| Shadowing | Own property перекриває prototype property |

---

## Golden Rules

1. Closure — це reference to environment, а не копія локальних змінних.
2. Prototype chain — це lookup і delegation, а не копіювання методів.
3. `class` не скасовує prototype model.
4. Не кожна function constructable.
5. Властивість у JS — це descriptor плюс lookup semantics.
6. Composition і inheritance треба вибирати за моделлю поведінки, а не за модою.

---

## Learning Route

1. Почни з [01 `[[Environment]]` Reference](./01-environment-reference/README.md), щоб зрозуміти, що function object зберігає не лише код, а і посилання на середовище.
2. Перейди до [02 Prototype Chain Lookup](./02-prototype-chain/README.md), бо майже вся OOP-поведінка в JS тримається на lookup і delegation.
3. Після цього читай [03 Syntactic Sugar](./03-class-syntactic-sugar/README.md) і [04 Function Internal Slots](./04-function-internal-slots/README.md), щоб не плутати зручний синтаксис з реальною моделлю виклику і конструювання.
4. Далі закрий [05 Property Descriptors](./05-property-descriptors/README.md) і [08 Shadowing Properties](./08-shadowing-properties/README.md), бо саме тут з'являється більшість "дивної" поведінки об'єктів.
5. Наприкінці пройди [06 OOP Patterns: Composition vs Inheritance](./06-oop-patterns-composition-vs-inheritance/README.md), [07 Object.create vs Constructor Functions](./07-object-create-vs-constructor-functions/README.md), а потім обидва labs: [09 Practice Lab](./09-practice-lab/README.md) і [10 Descriptor + Shadowing Bug Lab](./10-descriptor-shadowing-bug-lab/README.md).

---

## Навігація

- [01 `[[Environment]]` Reference](./01-environment-reference/README.md)
- [02 Prototype Chain Lookup](./02-prototype-chain/README.md)
- [03 Syntactic Sugar](./03-class-syntactic-sugar/README.md)
- [04 Function Internal Slots](./04-function-internal-slots/README.md)
- [05 Property Descriptors](./05-property-descriptors/README.md)
- [06 OOP Patterns: Composition vs Inheritance](./06-oop-patterns-composition-vs-inheritance/README.md)
- [07 Object.create vs Constructor Functions](./07-object-create-vs-constructor-functions/README.md)
- [08 Shadowing Properties](./08-shadowing-properties/README.md)
- [09 Practice Lab](./09-practice-lab/README.md)
- [10 Descriptor + Shadowing Bug Lab](./10-descriptor-shadowing-bug-lab/README.md)
- [GLOSSARY.md](./GLOSSARY.md)
