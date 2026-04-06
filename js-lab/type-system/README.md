# Type System & Specification Details

Цей модуль пояснює не "магію JavaScript", а конкретні алгоритми специфікації, через які ця магія виникає. Його задача — дати чітку модель того, як працюють `==`, `===`, неявне приведення типів, `BigInt`, `Symbol` і well-known symbols.

---

## Scope

У цьому блоці ми закриваємо чотири ключові теми:

1. **Порівняння значень:** `Abstract Equality`, `Strict Equality`, `SameValue`, `Object.is`.
2. **Primitive coercion:** `ToPrimitive`, `ToNumber`, `ToString` і пов'язані пастки оператора `+`.
3. **Числова точність:** межа safe integers, `BigInt`, змішування `Number` та `BigInt`.
4. **Meta-протоколи мови:** `Symbol`, глобальний реєстр і well-known symbols на кшталт `Symbol.iterator`, `Symbol.toPrimitive`, `Symbol.hasInstance`.

---

## Розділи

### 1. [Abstract Equality vs Strict Equality](./01-abstract-vs-strict-equality/README.md)
- Що таке `==` і `===` на рівні алгоритмів ECMA-262.
- Чому `[] == ![]` дорівнює `true`.
- Чим `Object.is()` відрізняється від `===`.
- Додатково: інтерактив про `===`, `Object.is()` і `SameValueZero`.

### 2. [Primitive Coercion Algorithms](./02-primitive-coercion/README.md)
- Як працюють `ToPrimitive`, `ToNumber`, `ToString`.
- Чому `Date` поводиться не так, як звичайний object.
- Чому `obj + ""` і `` `${obj}` `` не завжди дають один і той самий шлях coercion.

### 3. [BigInt & Precision Issues](./03-bigint-and-precision-issues/README.md)
- Де `Number` втрачає точність.
- Коли потрібен `BigInt`.
- Які оператори та змішування типів дають `TypeError` або неочевидні результати.

### 4. [Symbols & Well-Known Symbols](./04-symbols-and-well-known-symbols/README.md)
- Як створювати унікальні ключі.
- Чим `Symbol()` відрізняється від `Symbol.for()`.
- Як `Symbol.iterator`, `Symbol.toPrimitive`, `Symbol.hasInstance` і `Symbol.toStringTag` змінюють поведінку об'єкта.

### 5. [Practice Lab: Coercion Bugs & Equality Traps](./05-practice-lab/README.md)
- Практичні задачі на equality, coercion, `BigInt` і symbol protocols.
- Короткі hints для самоперевірки.
- Маршрут повторення по всьому блоку.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

Усі основні статті в цьому блоці тепер мають:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`

---

## Що дає рівень 110%

Після проходження цього блоку ви повинні вміти:

1. Пояснити будь-який дивний equality case через конкретні кроки алгоритму.
2. Відрізняти coercion bug від звичайної логічної помилки.
3. Знати, коли `Number` вже небезпечний для цілочисельних ідентифікаторів і лічильників.
4. Використовувати `Symbol` не як екзотику, а як механізм для протоколів мови.
