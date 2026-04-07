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

## Ключові питання

Ключ до відповідей на питання:

1. Чому ця змінна **undefined**?
2. Як працює замикання на рівні пам'яті?
3. Чому **let** не спливає як **var**?
4. Розуміння **TDZ**, **Closure**, **Hoisting**, **Event Loop basics**
