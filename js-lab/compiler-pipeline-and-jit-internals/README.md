# Compiler Pipeline & JIT Internals

Цей блок закриває внутрішній шлях виконання JavaScript: від сирцевого коду до `AST`, від `AST` до bytecode, від bytecode до interpreter execution і далі до optimized machine code. Це шар, де закінчується міф “JS просто інтерпретується” і починається реальний runtime pipeline.

---

## Scope

У цьому модулі шість основних частин:

1. Parsing & AST.
2. Ignition & TurboFan.
3. Bytecode Execution.
4. JIT Basics.
5. Practice Lab.
6. Bug Lab.

---

## Розділи

### 1. [Parsing & AST](./01-parsing-and-ast/README.md)
- tokenization, parsing, AST nodes, syntax errors.
- чому `AST` потрібне не лише рушію, а й tooling.

### 2. [Ignition & TurboFan](./02-ignition-and-turbofan/README.md)
- interpreter pipeline у V8.
- feedback collection, hot code, optimization, deoptimization.

### 3. [Bytecode Execution](./03-bytecode-execution/README.md)
- що таке bytecode і навіщо він існує.
- як interpreter виконує послідовність інструкцій.

### 4. [JIT Basics](./04-jit-basics/README.md)
- profiling, speculative optimization, assumptions, deopt.
- чому JIT не дорівнює “код одразу стає native”.

### 5. [Practice Lab](./05-practice-lab/README.md)
- parsing/runtime distinction, AST reasoning, bytecode tracing, JIT questions.

### 6. [Bug Lab](./06-bug-lab/README.md)
- syntax/runtime confusion, wrong optimization assumptions, deopt misunderstandings.

---

## Додатково

- [SUMMARY.md](./SUMMARY.md)
- [GLOSSARY.md](./GLOSSARY.md)

### Ключові інтерактиви

- [Parsing AST Board](../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/parsing-ast-board/index.html)
- [Tokenization vs AST Board](../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/tokenization-vs-ast-board/index.html)
- [V8 Pipeline Board](../visualisation/compiler-pipeline-and-jit-internals/02-ignition-and-turbofan/v8-pipeline-board/index.html)
- [Bytecode Stepper Board](../visualisation/compiler-pipeline-and-jit-internals/03-bytecode-execution/bytecode-stepper-board/index.html)
- [JIT Feedback Board](../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/jit-feedback-board/index.html)
- [Optimization Deopt Board](../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/optimization-deopt-board/index.html)

Усі теоретичні статті цього блоку мають єдиний навчальний шаблон:

- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження блоку ви повинні вміти:

1. Пояснювати шлях `source -> tokens -> AST -> bytecode -> interpreter -> optimized machine code`.
2. Відрізняти syntax-stage проблеми від runtime-stage проблем.
3. Пояснювати роль `Ignition` і `TurboFan` без міфів.
4. Розуміти, чому optimization залежить від runtime feedback і може бути скасована.
5. Відрізняти general engine model від конкретного `V8` naming layer.
