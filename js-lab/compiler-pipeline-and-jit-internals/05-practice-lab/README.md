# Practice Lab: Compiler Pipeline & JIT Internals

Цей lab потрібен, щоб перестати повторювати загальні слова про “компіляцію JS” і почати розкладати pipeline на конкретні етапи: syntax, AST, bytecode, interpreter, feedback, optimization.

---

> [!TIP]
> **[▶ Відкрити Parsing AST Board](../../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/parsing-ast-board/index.html)**

> [!TIP]
> **[▶ Відкрити Tokenization vs AST Board](../../visualisation/compiler-pipeline-and-jit-internals/01-parsing-and-ast/tokenization-vs-ast-board/index.html)**

> [!TIP]
> **[▶ Відкрити V8 Pipeline Board](../../visualisation/compiler-pipeline-and-jit-internals/02-ignition-and-turbofan/v8-pipeline-board/index.html)**

> [!TIP]
> **[▶ Відкрити Bytecode Stepper Board](../../visualisation/compiler-pipeline-and-jit-internals/03-bytecode-execution/bytecode-stepper-board/index.html)**

> [!TIP]
> **[▶ Відкрити JIT Feedback Board](../../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/jit-feedback-board/index.html)**

> [!TIP]
> **[▶ Відкрити Optimization Deopt Board](../../visualisation/compiler-pipeline-and-jit-internals/04-jit-basics/optimization-deopt-board/index.html)**

---

## I. Tasks

### Task 1
Поясни різницю між syntax error і runtime error на pipeline-рівні.

### Task 2
Чим token stream відрізняється від AST?

### Task 3
Наведи приклад, де код синтаксично валідний, але падає вже під час execution.

### Task 4
Поясни, навіщо рушію потрібне проміжне представлення між source і machine code.

### Task 5
Що таке bytecode на ментальному рівні?

### Task 6
Яку роль виконує `Ignition`?

### Task 7
Яку роль виконує `TurboFan`?

### Task 8
Чому optimizer залежить від feedback, а не лише від тексту функції?

### Task 9
Що таке hot code?

### Task 10
Чому optimized code може бути скасований?

### Task 11
Поясни різницю між bytecode і machine code.

### Task 12
Чому “JS або інтерпретується, або компілюється” — хибна дихотомія?

### Task 13
Чому benchmark без warm-up може дати хибні висновки про швидкість?

### Task 14
Який зв'язок між stable runtime behavior і speculative optimization?

---

## II. Quick Hints

1. Різні стадії pipeline.
2. Плоскі елементи vs дерево.
3. Валідний syntax ще не гарантує валідний runtime.
4. Execution-friendly representation.
5. Інструкції для VM.
6. Interpreter execution.
7. Optimizing compiler.
8. Бо реальний runtime важливіший за голий текст.
9. Часто виконуваний код.
10. Assumption broken.
11. VM layer vs CPU layer.
12. Сучасний pipeline змішаний і adaptive.
13. Ти міряєш не стабілізований execution state.
14. Стабільність дає optimizer-у ґрунт для спеціалізації.

---

## III. Step-by-Step Answers

### Answer 1
- Syntax error виникає до нормального execution.
- Runtime error виникає вже після того, як код пройшов syntax-stage.
- Це різні класи проблем і різні етапи pipeline.

### Answer 2
- Tokens — це плоскі syntax units.
- AST — це ієрархічна структура програми.
- Парсер переходить від першого до другого.

### Answer 3
- Наприклад, `foo()` при відсутньому `foo`.
- Код синтаксично валідний, але валиться на execution stage.

### Answer 4
- Бо source зручний для людини, machine code — для CPU.
- Bytecode/intermediate representation дає керований execution path для VM.

### Answer 5
- Це instruction-like representation для interpreter-а.
- Воно ближче до execution, ніж AST.

### Answer 6
- Виконує bytecode.
- Дає стартовий execution path і збирає runtime feedback.

### Answer 7
- Оптимізує hot code.
- Будує спеціалізованіший шлях під стабільні runtime-патерни.

### Answer 8
- Бо optimizerу важливо, як код реально викликається.
- Один і той самий текст може поводитися по-різному на різних inputs.

### Answer 9
- Це код, який виконується часто enough, щоб optimization мала сенс.

### Answer 10
- Бо optimized path тримається на assumptions.
- Якщо assumptions порушені, потрібен safe fallback.

### Answer 11
- Bytecode виконує VM/interpreter.
- Machine code виконує CPU напряму.

### Answer 12
- Бо сучасний JS pipeline має і interpreter stage, і JIT optimization stage.
- Це adaptive model, а не бінарний вибір.

### Answer 13
- Бо ти можеш міряти холодний старт без зібраного feedback.
- Реальна steady-state performance може бути іншою.

### Answer 14
- Стабільний runtime behavior дозволяє робити сильніші припущення.
- Без стабільності optimizer втрачає ґрунт.

---

## IV. Suggested Review

1. Повернись у [01 Parsing & AST](../01-parsing-and-ast/README.md), якщо syntax-stage ще змішується з runtime-stage.
2. Повернись у [02 Ignition & TurboFan](../02-ignition-and-turbofan/README.md), якщо interpreter/optimizer loop ще не читається цілісно.
3. Повернись у [03 Bytecode Execution](../03-bytecode-execution/README.md), якщо bytecode все ще здається “невідомим чорним ящиком”.
4. Повернись у [04 JIT Basics](../04-jit-basics/README.md), якщо assumptions, hotness і deopt ще сприймаються магічно.
