# Execution Model

Цей модуль присвячений механіці виконання JS коду.

Розглянемо JS, як набір правил, за якими двигун виділяє память, 
створює області видимості та керує викликами функцій. 

## Big Picture First

Перед зануренням у `Declaration Instantiation`, `Lexical Environment`, `Execution Context Stack`, `this` і arrow functions почніть із цілісної карти:

- [00 Big Picture: Execution Model](./00-big-picture/README.md)
- [Recall Map](./00-big-picture/RECALL.md)
- [Execution Model Atlas](../visualisation/execution-model/00-big-picture/execution-model-atlas/index.html)

Цей overview пояснює, **навіщо потрібна кожна підтема**, як вони пов'язані між собою і коли відкривати конкретний deep dive.

## Learning Route

1. [00 Big Picture: Execution Model](./00-big-picture/README.md) — спочатку цілісна карта.
2. [01 Declaration Instantiation](./01-declaration-instantiation/README.md) — як JS готує імена перед виконанням.
3. [02 Lexical Environment](./02-lexical-environment/README.md) — де живуть імена і як вони шукаються.
4. [03 Execution Context Stack](./03-execution-context-stack/README.md) — хто зараз виконується.
5. [04 This Binding](./04-this-binding/README.md) — хто є `this` для regular function.
6. [05 Arrow vs Regular Functions](./05-arrow-vs-regular/README.md) — чи функція має власний `this`.
7. [06 Practice Lab](./06-practice-lab/README.md) — prediction tasks: передбачити результат і назвати механізм.
8. [07 Bug Lab](./07-bug-lab/README.md) — diagnostic tasks: від симптому знайти правильну “папку” Execution Model.
9. [Recall Map](./00-big-picture/RECALL.md) — повторити через 1-7 днів без підглядання.

## Ключові питання

Ключ до відповідей на питання:

1. Чому ця змінна **undefined**?
2. Як працює замикання на рівні пам'яті?
3. Чому **let** не спливає як **var**?
4. Розуміння **TDZ**, **Closure**, **Hoisting**, **Event Loop basics**
