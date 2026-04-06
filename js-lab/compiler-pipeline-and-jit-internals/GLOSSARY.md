# Glossary: Compiler Pipeline & JIT Internals

## Parsing Layer

### Token
Мінімальна syntax-unit, яку parser використовує як вхід. Див. [01 Parsing & AST](./01-parsing-and-ast/README.md).

### Parser
Частина pipeline, яка перетворює token stream у структуроване дерево. Див. [01 Parsing & AST](./01-parsing-and-ast/README.md).

### AST
Abstract Syntax Tree — структурне представлення програми на syntax-рівні. Див. [01 Parsing & AST](./01-parsing-and-ast/README.md).

### Syntax Error
Помилка, яка виникає до runtime execution, коли код неможливо коректно розпарсити. Див. [01 Parsing & AST](./01-parsing-and-ast/README.md).

## Execution Layer

### Bytecode
Проміжне представлення, яке виконує interpreter. Див. [03 Bytecode Execution](./03-bytecode-execution/README.md).

### Interpreter
Компонент, який виконує інструкції по одній і не вимагає повної ahead-of-time native compilation. Див. [02 Ignition & TurboFan](./02-ignition-and-turbofan/README.md).

### Dispatch
Крок, де interpreter читає чергову інструкцію й вирішує, що робити далі. Див. [03 Bytecode Execution](./03-bytecode-execution/README.md).

### Machine Code
Низькорівневий код для CPU, який може бути згенерований optimizing compiler-ом. Див. [04 JIT Basics](./04-jit-basics/README.md).

## V8-Specific Terms

### Ignition
Interpreter у V8, який виконує bytecode і збирає feedback. Див. [02 Ignition & TurboFan](./02-ignition-and-turbofan/README.md).

### TurboFan
Optimizing compiler у V8 для hot code. Див. [02 Ignition & TurboFan](./02-ignition-and-turbofan/README.md).

### Feedback
Runtime-дані про реальні типи й shape execution, на яких базується optimization. Див. [04 JIT Basics](./04-jit-basics/README.md).

### Optimization
Перехід від загальнішого execution path до більш спеціалізованого й швидкого коду. Див. [04 JIT Basics](./04-jit-basics/README.md).

### Deoptimization
Відкат optimized code, коли runtime assumptions перестають бути правдивими. Див. [04 JIT Basics](./04-jit-basics/README.md).

### Speculation
Припущення optimizer-а про стабільність runtime behavior. Див. [04 JIT Basics](./04-jit-basics/README.md).
