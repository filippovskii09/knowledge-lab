# Glossary: Modules, Ecosystem & Meta-programming

## Modules

### Module Record
Специфікаційна модель модуля: його imports, exports, environment і linking metadata. Див. [01 Module System Internals](./01-module-system-internals/README.md).

### Live Binding
У `ESM` import дивиться на поточне exported binding, а не на snapshot value. Див. [01 Module System Internals](./01-module-system-internals/README.md).

### Module Cache
Механізм, через який модуль зазвичай ініціалізується один раз, а потім перевикористовується. Див. [01 Module System Internals](./01-module-system-internals/README.md).

### Cyclic Dependency
Ситуація, коли модулі імпортують одне одного прямо або через ланцюг. Див. [01 Module System Internals](./01-module-system-internals/README.md).

## Iteration

### Iterable
Об'єкт, який реалізує `Symbol.iterator()` і може бути використаний у `for...of`. Див. [02 Iterators & Generators](./02-iterators-and-generators/README.md).

### Iterator
Об'єкт із методом `next()`, що повертає `{ value, done }`. Див. [02 Iterators & Generators](./02-iterators-and-generators/README.md).

### Generator
Спеціальна функція, яка створює iterator object і зберігає свій execution state між `next()` викликами. Див. [02 Iterators & Generators](./02-iterators-and-generators/README.md).

### Yield
Оператор, який повертає значення назовні й ставить generator на pause. Див. [02 Iterators & Generators](./02-iterators-and-generators/README.md).

## Proxy Layer

### Trap
Метод у handler-об'єкті `Proxy`, що перехоплює певну операцію над target. Див. [03 Proxy & Reflect](./03-proxy-and-reflect/README.md).

### Invariant
Правило, яке `Proxy` не має права ламати, інакше runtime кидає помилку. Див. [03 Proxy & Reflect](./03-proxy-and-reflect/README.md).

### Reflect
Набір методів для виклику default object semantics у контрольований спосіб. Див. [03 Proxy & Reflect](./03-proxy-and-reflect/README.md).

## Intl

### Locale
Комбінація мовних і регіональних налаштувань, що впливає на форматування. Див. [04 Intl API & Globalization](./04-intl-api-and-globalization/README.md).

### Formatter
Об'єкт `Intl.*Format`, який повторно використовують для стабільного форматування. Див. [04 Intl API & Globalization](./04-intl-api-and-globalization/README.md).

### Plural Rules
Правила вибору граматичної форми залежно від числа. Див. [04 Intl API & Globalization](./04-intl-api-and-globalization/README.md).

### resolvedOptions
Метод formatter-об'єкта, що показує, які опції реально застосував runtime. Див. [04 Intl API & Globalization](./04-intl-api-and-globalization/README.md).
