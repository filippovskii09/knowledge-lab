# Glossary: Declaration Instantiation

Цей глосарій пояснює терміни, які потрібні саме для теми **Declaration Instantiation**. Його задача — не замінити статтю, а дати коротку карту понять перед deep dive.

## Core Terms

| Термін | Коротко | Приклад |
| :--- | :--- | :--- |
| **Declaration** | Синтаксичний запис у коді, який оголошує ім'я. | `var a`, `let b`, `function run() {}`, `class User {}` |
| **Declaration Instantiation** | Внутрішній етап, коли рушій готує declarations до виконання коду. | До першого рядка рушій уже знає про `a`, `run`, `User`. |
| **Binding** | Зв'язок між іменем і місцем, де зберігається його стан або значення. | `a -> undefined`, `user -> <uninitialized>` |
| **Identifier** | Ім'я, яке використовується в коді. | `a`, `user`, `createGreeter` |
| **Environment Record** | Внутрішнє сховище bindings. | Таблиця імен поточного scope. |
| **Initialization** | Момент, коли binding отримує початкове значення або виходить зі стану `uninitialized`. | `let a = 10` ініціалізує `a`. |
| **Assignment** | Запис нового значення в уже існуючий binding. | `a = 20` |
| **TDZ** | Період, коли binding уже існує, але його ще не можна читати. | `console.log(a); let a = 1;` |

## Declaration Types

| Declaration | Що створюється під час instantiation | Стартовий стан |
| :--- | :--- | :--- |
| `var a` | function-scoped або global Object ER binding | `undefined` |
| `let a` | lexical binding | `uninitialized` |
| `const a` | lexical binding | `uninitialized` |
| `class A {}` | lexical binding | `uninitialized` |
| `function f() {}` | binding + function object | `<function object>` |
| `var f = function() {}` | тільки `var f`; function object створиться під час execution | `undefined` |

## Function Terms

| Термін | Коротко | Приклад |
| :--- | :--- | :--- |
| **Formal Parameter** | Ім'я в дужках під час оголошення функції. | `function greet(name) {}` |
| **Argument** | Фактичне значення, передане під час виклику. | `greet("Artur")` |
| **Function Environment Record** | Environment Record конкретного виклику функції. | Містить parameters, `var`, function declarations, `this` для regular functions. |
| **FunctionDeclarationInstantiation** | Алгоритм підготовки bindings перед виконанням тіла функції. | Готує parameters, function declarations і `var`. |

## Global Scope Terms

| Термін | Коротко | Що туди потрапляє |
| :--- | :--- | :--- |
| **Global Environment Record** | Композитний record верхнього рівня classic script. | Об'єднує Object ER і Declarative ER. |
| **Object Environment Record** | Record, прив'язаний до звичайного об'єкта. У global scope прив'язаний до `globalThis` / `window`. | global `var`, global function declarations |
| **Declarative Environment Record** | Прихований record для lexical declarations. Не є property bag на `globalThis`. | global `let`, `const`, `class` |
| **Global Object** | Об'єкт глобального середовища. | `window` у браузері, `globalThis` як універсальна назва |

## Common Rules

| Правило | Наслідок |
| :--- | :--- |
| `var` створює binding з `undefined`, якщо такого binding ще немає. | `console.log(a); var a = 1;` дає `undefined`. |
| `let` / `const` / `class` створюють binding у стані `uninitialized`. | Читання до рядка оголошення дає `ReferenceError`. |
| Function declaration створює готовий function object до execution phase. | `run(); function run() {}` працює. |
| Formal parameters створюються до виконання тіла функції. | `function f(a) { console.log(a); } f(10);` бачить `a = 10`. |
| `var` не перезаписує existing parameter/function binding в `undefined`. | `function f(a) { var a; }` не скидає `a`. |
| Global `var` / function declaration стають properties на `globalThis` у classic script. | `var x = 1; globalThis.x === 1`. |
| Global `let` / `const` / `class` не стають properties на `globalThis`. | `let x = 1; globalThis.x === undefined`. |

## Not The Same

| Не плутати | Різниця |
| :--- | :--- |
| **Declaration** vs **Assignment** | Declaration створює/реєструє ім'я; assignment записує значення. |
| **Initialization** vs **Assignment** | Initialization дає binding перше дозволене значення; assignment змінює вже існуюче значення. |
| **Binding** vs **Value** | Binding — це місце/зв'язок для імені; value — те, що зараз лежить у цьому binding. |
| **Lexical Environment** vs **Environment Record** | Lexical Environment — контейнер + outer reference; Environment Record — внутрішня таблиця bindings. |
| **Formal Parameter** vs **Argument** | Parameter — ім'я в оголошенні; argument — значення у виклику. |
| **Global Scope** vs **Global Object** | Global scope — область видимості; Global Object — об'єкт, до якого прив'язаний Object ER. |
