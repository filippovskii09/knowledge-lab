# Bug Lab: Compiler Pipeline & JIT Internals

Цей lab не про “дай визначення”, а про діагностику неправильних ментальних моделей. Тут зібрані типові помилки мислення про parsing, bytecode, interpreter і JIT.

---

## I. Diagnostic Cases

### Case 1: Syntax Bug Mistaken for Runtime Bug
```javascript
const total = ;
console.log(total);
```
Чому це не runtime failure в класичному сенсі?

### Case 2: Bytecode == Machine Code
Команда каже: “Bytecode уже майже native, значить interpreter cost неважливий”.
Чому це некоректне твердження?

### Case 3: TurboFan Runs Immediately
```javascript
function once(x) {
  return x + 1;
}
once(1);
```
Чому не варто уявляти, що така функція миттєво піде в optimized native code?

### Case 4: Optimized Once == Optimized Forever
Код був швидким у benchmark, а в production почав поводитися інакше після зміни shape input-ів.
Яка ментальна помилка тут сталася?

### Case 5: Hotness Assumed Without Evidence
Розробник aggressively оптимізує utility, яка викликається кілька разів на сторінці.
Чому це може бути хибним фокусом?

### Case 6: Stable Text, Unstable Runtime
```javascript
function readId(obj) {
  return obj.id;
}
```
Чому одна і та сама функція може бути хорошим кандидатом для optimization в одному місці й поганим в іншому?

### Case 7: AST Treated as Tooling-Only Concept
Хтось каже: “AST мене не стосується, це лише для Babel”.
Чому це слабка модель?

### Case 8: Deopt Interpreted as Engine Failure
Після зміни runtime pattern optimized path скасовується, і команда робить висновок, що рушій “ламається”.
Чому це неправильний висновок?

---

## II. Quick Hints

1. Код не проходить syntax-stage.
2. VM layer не дорівнює CPU layer.
3. Немає evidence для immediate optimization.
4. Assumptions can break.
5. Cold code may not justify the effort.
6. Runtime behavior важливіший за текст функції.
7. Engine теж працює зі структурою програми.
8. Deopt — adaptive fallback.

---

## III. Step-by-Step Answers

### Answer 1
- Parser не може побудувати валідну структуру.
- Код не доходить до нормального execution path.
- Це syntax-stage failure.

### Answer 2
- Bytecode — це representation для VM/interpreter.
- Native machine code — це окремий нижчий шар.
- Звідси й різні performance властивості.

### Answer 3
- Optimizer зазвичай потребує runtime feedback і hotness.
- Один виклик сам по собі не дає сильного сигналу для optimization.

### Answer 4
- Було припущення, що runtime залишиться стабільним.
- Але optimization тримається на assumptions, а не на обіцянці назавжди.

### Answer 5
- Якщо code path холодний, вартість reasoning і refactor може перевищити реальний виграш.
- Спочатку потрібне evidence про hot path.

### Answer 6
- Текст функції незмінний, але shapes і values можуть бути різні.
- Саме runtime pattern визначає optimization potential.

### Answer 7
- AST — це не лише tooling convenience.
- Це нормальний спосіб структурувати програму перед execution phases.

### Answer 8
- Deopt — safety mechanism.
- Він показує, що рушій адаптується до нової реальності виконання.

---

## IV. Suggested Review

1. Повернись у [01 Parsing & AST](../01-parsing-and-ast/README.md), якщо syntax-stage ще недооцінений.
2. Повернись у [02 Ignition & TurboFan](../02-ignition-and-turbofan/README.md), якщо interpreter/optimizer roles ще змішані.
3. Повернись у [03 Bytecode Execution](../03-bytecode-execution/README.md), якщо bytecode і machine code все ще плутаються.
4. Повернись у [04 JIT Basics](../04-jit-basics/README.md), якщо deopt і assumptions ще виглядають як містика.
