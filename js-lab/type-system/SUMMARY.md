# Type System & Specification Details: Module Summary

Цей блок зводить до купи чотири великі ідеї: рівність, coercion, числову точність і протоколи мови на `Symbol`.

---

## Mental Models

| Концепція | Коротка модель |
| :--- | :--- |
| `==` | Не "м'яке порівняння", а каскад конкретних coercion rules |
| `===` | Передбачуване порівняння без неявного приведення типів |
| `Object.is()` | Точніше порівняння для `NaN` і signed zero |
| `ToPrimitive` | Міст між object world і primitive world |
| `BigInt` | Точні великі цілі, але не decimal/floating-point fix |
| `Symbol` | Унікальний ключ і точка входу в language protocols |

---

## Golden Rules

1. Якщо ви не можете пояснити equality case покроково, значить ви ще не зрозуміли алгоритм.
2. Coercion треба приборкувати на boundaries, а не в середині бізнес-логіки.
3. `Number` безпечний не для всіх цілих чисел.
4. `BigInt` вирішує integer precision, але не decimal precision.
5. `Symbol` — це не приватність, а identity і протоколи.

---

## Practical Checklist

- [ ] Чи не покладається логіка на неявне `==` там, де потрібна явна нормалізація типів?
- [ ] Чи не потрапляють `""`, `"0"` або `null` у numeric logic без явного парсингу?
- [ ] Чи не перевищують integer values safe range для `Number`?
- [ ] Чи не змішуються `Number` і `BigInt` без чіткої моделі?
- [ ] Чи справді тут потрібен `Symbol`, а не звичайний рядковий ключ?

---

## Навігація

- [01 Abstract Equality vs Strict Equality](./01-abstract-vs-strict-equality/README.md)
- [02 Primitive Coercion Algorithms](./02-primitive-coercion/README.md)
- [03 BigInt & Precision Issues](./03-bigint-and-precision-issues/README.md)
- [04 Symbols & Well-Known Symbols](./04-symbols-and-well-known-symbols/README.md)
- [05 Practice Lab: Coercion Bugs & Equality Traps](./05-practice-lab/README.md)
- [GLOSSARY.md](./GLOSSARY.md)
