# Execution Model: Recall Map

Цей файл не для читання як стаття. Його задача — швидко перевірити, чи ти можеш витягнути Execution Model з пам'яті.

---

## 60-Second Recall

Закрий статті й спробуй проговорити:

1. JS спочатку готує bindings.
2. Потім виконує код у Execution Context.
3. Кожен context має Lexical Environment.
4. Імена шукаються через `[[OuterEnv]]` chain.
5. Function call додає новий context у stack.
6. Function може зберегти старий Environment через closure.
7. `this` визначається не scope chain, а call-site.
8. Arrow function не має власного `this`.

Якщо ти можеш пояснити ці 8 пунктів без підглядання, базова карта Execution Model уже є.

---

## Alias Cards

### Declaration Instantiation

**Людська назва:** підготовка bindings перед виконанням.

**Питання:** як називається етап, коли JS створює bindings для `var`, `function`, `let`, `const` перед execution?

**Відповідь:** Declaration Instantiation.

**Навіщо:** пояснює hoisting, TDZ, `undefined`, function declarations.

---

### Lexical Environment

**Людська назва:** таблиця імен + посилання на батьківський scope.

**Питання:** де JS зберігає інформацію про те, які імена видимі в поточному місці?

**Відповідь:** Lexical Environment.

**Навіщо:** пояснює scope chain, closures, shadowing, block scope.

---

### Environment Record

**Людська назва:** сховище bindings усередині одного environment.

**Питання:** яка частина Lexical Environment зберігає самі імена та значення?

**Відповідь:** Environment Record.

**Навіщо:** пояснює, де фізично в моделі лежать `user`, `prefix`, `label`.

---

### Outer Reference

**Людська назва:** лінк на батьківський scope.

**Питання:** як JS переходить від локального scope до зовнішнього?

**Відповідь:** через `[[OuterEnv]]` / Outer Reference.

**Навіщо:** пояснює пошук імен і closures.

---

### Execution Context Stack

**Людська назва:** хто зараз виконується.

**Питання:** яка структура пояснює порядок function calls?

**Відповідь:** Execution Context Stack / Call Stack.

**Навіщо:** пояснює nested calls, recursion, stack overflow.

---

### This Binding

**Людська назва:** receiver поточного виклику.

**Питання:** чому `person.greet()` дає інший `this`, ніж `const fn = person.greet; fn()`?

**Відповідь:** через this binding, який визначається call-site.

**Навіщо:** пояснює methods, detached methods, `call`, `apply`, `bind`, `new`.

---

### Arrow Function

**Людська назва:** функція без власного `this`.

**Питання:** чому arrow callback часто “зберігає” зовнішній `this`?

**Відповідь:** arrow function не створює власний `this` binding і бере його з lexical environment.

**Навіщо:** пояснює callbacks, event handlers, object method traps.

---

## Explain the Example

Поясни цей код без статті:

```javascript
const user = "Artur";

function createGreeter(prefix) {
  const label = "student";

  return function greet() {
    console.log(this.name, prefix, user, label);
  };
}

const person = { name: "A", greet: createGreeter("hi") };
person.greet();
```

Мінімальна відповідь має містити:

1. Що підготувалося до execution.
2. Де живе `user`.
3. Що створюється при `createGreeter("hi")`.
4. Де живуть `prefix` і `label`.
5. Чому `greet` бачить `prefix` і `label` після завершення `createGreeter`.
6. Чому `this.name` читає `person.name`.
7. Що змінилось би, якби `greet` була arrow function.

---

## Diagnostic Prompts

Спробуй відповісти швидко:

1. Бачиш `undefined` до assignment. Яка тема?
2. Бачиш TDZ error. Які теми?
3. Змінна шукається не там, де очікував. Яка тема?
4. Замикання пам'ятає значення після return. Яка тема?
5. Плутаєш порядок nested calls. Яка тема?
6. `this` не той. Яка тема?
7. Arrow method поводиться дивно. Яка тема?

---

## Short Answers

1. Declaration Instantiation.
2. Declaration Instantiation + Lexical Environment.
3. Lexical Environment / Identifier Resolution.
4. Lexical Environment + Closure.
5. Execution Context Stack.
6. This Binding.
7. Arrow vs Regular Functions.

---

## Spaced Repetition Plan

1. Одразу після читання: пройди `60-Second Recall`.
2. Через 1 день: поясни приклад без підглядання.
3. Через 3 дні: пройди `Diagnostic Prompts`.
4. Через 7 днів: відкрий інтерактивну карту й проговори всі кроки.
5. Через 2-4 тижні: спробуй пояснити Execution Model на новому прикладі, не на цьому.
