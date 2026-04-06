# SUMMARY: Functional Programming & Patterns

## Learning Route

1. Почни з [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md), бо без цього FP-підхід перетворюється на стиль, а не на модель керування станом.
2. Потім переходь до [02 Higher-Order Functions](./02-higher-order-functions/README.md), щоб навчитися працювати з функціями як зі значеннями.
3. Далі вивчи [03 Currying & Composition](./03-currying-and-composition/README.md), щоб зрозуміти, як збирати pipeline з малих transform-функцій.
4. Після цього закрий [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md), щоб мати повну модель алгоритмічного мислення в цьому блоці.
5. Закріпи все через [05 Practice Lab](./05-practice-lab/README.md).
6. Добий слабкі місця через [06 Bug Lab](./06-bug-lab/README.md).
7. Перевір repair-skills через [07 Bug Hunt Lab](./07-bug-hunt-lab/README.md).

---

## Mental Model

| Тема | Що треба винести |
| :--- | :--- |
| **Immutability** | Менше прихованих зв'язків між частинами програми |
| **Pure Function** | Та сама функція з тими ж аргументами дає той самий результат і не змінює світ навколо |
| **HOF** | Функція може бути інструментом керування логікою, а не лише місцем обчислення |
| **Currying** | Велику операцію можна будувати поетапно з дрібних спеціалізованих функцій |
| **Composition** | Data flow важливіший за місце розташування коду |
| **Recursion** | Деякі задачі природно мислити через “розв'яжи меншу версію цієї ж задачі” |
| **Tail-Call Thinking** | Розуміння tail position корисне, навіть якщо runtime не дає реальної TCO |

---

## Golden Rules

1. Не роби immutable update лише “бо так красиво”; роби його там, де потрібна predictability.
2. Не переписуй кожен `for` у `reduce`, якщо це робить код гірше читабельним.
3. Currying корисний там, де він створює reusable configurability, а не шифрує логіку.
4. Composition має скорочувати cognitive load, а не збільшувати його.
5. Рекурсія в JS — це інструмент моделі, а не універсальний спосіб виконання.
6. На TCO в production JavaScript покладатися не можна.

---

## Practice Route

- Якщо плутаєш mutation і reassignment: повернися до [01](./01-immutability-and-pure-functions/README.md).
- Якщо плутаєш HOF і callback hell: повернися до [02](./02-higher-order-functions/README.md).
- Якщо point-free code здається магією: повернися до [03](./03-currying-and-composition/README.md).
- Якщо recursion починає виглядати як синтаксичний трюк: повернися до [04](./04-recursion-and-tail-call-thinking/README.md).
- Для цілісного закріплення пройди [05 Practice Lab](./05-practice-lab/README.md) і [06 Bug Lab](./06-bug-lab/README.md).
- Для fix-oriented тренування проходь [07 Bug Hunt Lab](./07-bug-hunt-lab/README.md).

---

## Debug Route

- Для nested immutable updates відкривай [Nested Immutable Update Board](../visualisation/functional-programming-and-patterns/01-immutability-and-pure-functions/nested-immutable-update-board/index.html).
- Для вибору між `loop`, HOF і composition відкривай [Pipeline Refactor Board](../visualisation/functional-programming-and-patterns/03-currying-and-composition/pipeline-refactor-board/index.html).
- Для recursion diagnosis відкривай [Recursion Debug Board](../visualisation/functional-programming-and-patterns/04-recursion-and-tail-call-thinking/recursion-debug-board/index.html).
