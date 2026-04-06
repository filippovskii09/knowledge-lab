# SUMMARY: Modules, Ecosystem & Meta-programming

## Learning Route

1. Почни з [01 Module System Internals](./01-module-system-internals/README.md), бо module loading model впливає на все інше.
2. Потім переходь до [02 Iterators & Generators](./02-iterators-and-generators/README.md), щоб зрозуміти protocol-based iteration.
3. Далі вивчи [03 Proxy & Reflect](./03-proxy-and-reflect/README.md), бо це ключ до interception і реактивних механік.
4. Після цього закрий [04 Intl API & Globalization](./04-intl-api-and-globalization/README.md), щоб навчитися працювати з локалями на рівні runtime.
5. Закріпи все через [05 Practice Lab](./05-practice-lab/README.md).
6. Добий production traps через [06 Bug Lab](./06-bug-lab/README.md).

---

## Mental Model

| Тема | Що треба винести |
| :--- | :--- |
| **Modules** | Код не просто "підтягується", а проходить linking і evaluation з чітким порядком |
| **Iterators** | Перебір у JS — це protocol, а не магія `for...of` |
| **Generators** | Generator спрощує побудову iterator logic, але не є async by default |
| **Proxy** | Object operations можна перехоплювати, але не безкарно |
| **Reflect** | Дає доступ до default object semantics усередині trap-ів |
| **Intl** | Локалі й форматування — це runtime concern, а не cosmetic string helper |

---

## Golden Rules

1. Не зводь `CJS vs ESM` до `require` vs `import`; дивись на loading і bindings.
2. Iterator завжди має чесно керувати `done` і `value`.
3. Не використовуй generator як “майже async/await”. Це інший механізм.
4. У `Proxy` не ламай invariants і не забувай про `Reflect`.
5. Не створюй новий `Intl` formatter у hot path без причини.
6. Locale formatting має бути явною частиною бізнес-вимог, а не випадковим `.toLocaleString()`.

---

## Debug Route

- Для module cycles відкривай [Module Graph Cycle Board](../visualisation/modules-ecosystem-and-meta-programming/01-module-system-internals/module-graph-cycle-board/index.html).
- Для iterator protocol відкривай [Iterator Protocol Board](../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/iterator-protocol-board/index.html).
- Для generator flow відкривай [Generator Yield Board](../visualisation/modules-ecosystem-and-meta-programming/02-iterators-and-generators/generator-yield-board/index.html).
- Для proxy semantics відкривай [Proxy Reflect Flow Board](../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reflect-flow-board/index.html) і [Proxy Reactivity Board](../visualisation/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/proxy-reactivity-board/index.html).
- Для locale formatting відкривай [Intl Formatting Board](../visualisation/modules-ecosystem-and-meta-programming/04-intl-api-and-globalization/intl-formatting-board/index.html).


---

## Review Route

1. Якщо плутається loading model, повернись у `/Users/arturfilippovskij/Desktop/study-projects/js-lab/modules-ecosystem-and-meta-programming/01-module-system-internals/README.md`.
2. Якщо `for...of`, generator і `done` ще не відчуваються автоматично, повтори `/Users/arturfilippovskij/Desktop/study-projects/js-lab/modules-ecosystem-and-meta-programming/02-iterators-and-generators/README.md`.
3. Якщо `Proxy` здається магією, а `Reflect` noise, повтори `/Users/arturfilippovskij/Desktop/study-projects/js-lab/modules-ecosystem-and-meta-programming/03-proxy-and-reflect/README.md`.
4. Якщо locale formatting і далі виглядає як cosmetic helper, повтори `/Users/arturfilippovskij/Desktop/study-projects/js-lab/modules-ecosystem-and-meta-programming/04-intl-api-and-globalization/README.md`.
