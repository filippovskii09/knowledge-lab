# Glossary: Functional Programming & Patterns

## Core Terms

### Pure Function
Функція, яка для однакових вхідних даних повертає однаковий результат і не має observable side effects. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

### Side Effect
Будь-яка зміна зовнішнього стану або observable interaction: mutation, I/O, log, network, DOM update, timer registration. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

### Referential Transparency
Властивість виразу, який можна замінити його значенням без зміни поведінки програми. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

### Immutable Update
Створення нового значення замість зміни старого. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

### Structural Sharing
Підхід, коли нова структура перевикористовує незмінені частини старої замість повного deep copy. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

### Shallow Copy Trap
Ситуація, коли top-level copy створено, але nested references лишилися спільними, тому старий state все одно непомітно псується. Див. [01 Immutability & Pure Functions](./01-immutability-and-pure-functions/README.md).

## Higher-Order Functions

### Higher-Order Function
Функція, яка приймає іншу функцію як аргумент або повертає функцію як результат. Див. [02 Higher-Order Functions](./02-higher-order-functions/README.md).

### Callback
Функція, передана для пізнішого виклику. Див. [02 Higher-Order Functions](./02-higher-order-functions/README.md).

### Reducer
Функція, яка акумулює значення під час `reduce`. Див. [02 Higher-Order Functions](./02-higher-order-functions/README.md).

## Composition Terms

### Currying
Перетворення функції з кількома аргументами на ланцюг unary-функцій. Див. [03 Currying & Composition](./03-currying-and-composition/README.md).

### Partial Application
Попереднє фіксування частини аргументів функції без повного currying. Див. [03 Currying & Composition](./03-currying-and-composition/README.md).

### Composition
Поєднання функцій так, щоб output однієї був input для іншої. Див. [03 Currying & Composition](./03-currying-and-composition/README.md).

### Point-Free Style
Стиль запису, де явно не згадуються дані, а тільки комбінуються функції. Див. [03 Currying & Composition](./03-currying-and-composition/README.md).

### Over-Composition
Стан, коли pipeline уже настільки дробний або абстрактний, що debug cost і cognitive load перевищують користь від composability. Див. [03 Currying & Composition](./03-currying-and-composition/README.md).

## Recursion Terms

### Base Case
Умова зупинки рекурсії. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).

### Recursive Case
Крок, у якому функція викликає саму себе для меншої підзадачі. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).

### Stack Overflow
Стан, коли занадто глибокий chain викликів переповнює call stack. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).

### Tail Position
Позиція, у якій recursive call є останньою операцією функції. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).

### Tail Call Optimization
Оптимізація, за якої tail calls не ростять stack frame. Концептуально важлива, але на неї не можна покладатися в сучасному JS runtime. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).

### Recursive Progress
Властивість recursion-кроку реально наближати задачу до base case. Якщо progress немає, recursion формально виглядає правильно, але ніколи не зупиняється. Див. [04 Recursion & Tail-Call Thinking](./04-recursion-and-tail-call-thinking/README.md).
