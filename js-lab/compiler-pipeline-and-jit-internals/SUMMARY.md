# SUMMARY: Compiler Pipeline & JIT Internals

## Learning Route

1. Почни з [01 Parsing & AST](./01-parsing-and-ast/README.md), бо без цього незрозуміло, що саме рушій отримує на вході.
2. Потім переходь до [02 Ignition & TurboFan](./02-ignition-and-turbofan/README.md), щоб побачити high-level V8 pipeline.
3. Далі закрий [03 Bytecode Execution](./03-bytecode-execution/README.md), бо bytecode — це міст між source і execution.
4. Після цього вивчи [04 JIT Basics](./04-jit-basics/README.md), щоб зрозуміти optimization і deoptimization.
5. Закріпи все через [05 Practice Lab](./05-practice-lab/README.md).
6. Добий типові міфи й production traps через [06 Bug Lab](./06-bug-lab/README.md).

---

## Mental Model

| Тема | Що треба винести |
| :--- | :--- |
| **Parsing** | Код спочатку стає структурою, а не виконується одразу |
| **AST** | Дерево описує сенс програми на syntax-рівні |
| **Bytecode** | Це проміжне представлення для interpreter execution |
| **Ignition** | Interpreter, який запускає bytecode і збирає feedback |
| **TurboFan** | Optimizing compiler для hot code |
| **JIT** | Швидкість з'являється через feedback-driven optimization, а не магію |

---

## Golden Rules

1. Не плутай syntax error з runtime error.
2. Не думай, що `AST` — це лише tooling concept; це частина реального pipeline.
3. Bytecode — не machine code.
4. `Ignition` і `TurboFan` — це різні ролі в pipeline, а не два синоніми “компілятора”.
5. Optimized code тримається на assumptions.
6. Якщо assumptions ламаються, deopt — це нормальний механізм, а не містична поломка.

---

## Debug Route

- Для syntax pipeline відкривай [Parsing AST Board](../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/parsing-ast-board/index.html).
- Для різниці між tokens і AST відкривай [Tokenization vs AST Board](../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/tokenization-vs-ast-board/index.html).
- Для загального V8 flow відкривай [V8 Pipeline Board](../visualisation/compiler-pipeline-and-jit-internals/02-ignition-and-turbofan/v8-pipeline-board/index.html).
- Для instruction-level intuition відкривай [Bytecode Stepper Board](../visualisation/compiler-pipeline-and-jit-internals/03-bytecode-execution/bytecode-stepper-board/index.html).
- Для feedback/optimization reasoning відкривай [JIT Feedback Board](../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/jit-feedback-board/index.html).
- Для assumptions і deopt відкривай [Optimization Deopt Board](../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/optimization-deopt-board/index.html).

---

## Review Route

1. Якщо плутається синтаксичний pipeline, повернись у [01 Parsing & AST](./01-parsing-and-ast/README.md).
2. Якщо `Ignition` і `TurboFan` ще здаються абстрактними назвами, повтори [02 Ignition & TurboFan](./02-ignition-and-turbofan/README.md).
3. Якщо bytecode усе ще виглядає як “майже machine code”, повтори [03 Bytecode Execution](./03-bytecode-execution/README.md).
4. Якщо optimization/deopt сприймаються магічно, повтори [04 JIT Basics](./04-jit-basics/README.md).
