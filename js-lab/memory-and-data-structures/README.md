# Block II: Memory & Data Structures

Вітаємо у другому великому блоці JS-Lab. Якщо в першому розділі ми розібрали, **як** виконується код, то тут занурюємося у питання: **де** він виконується, як дані фізично розміщуються у пам'яті, як поводяться посилання і яку структуру даних варто обирати під задачу.

Автоматичне керування пам'яттю в JavaScript часто створює ілюзію, що пам'ять нескінченна і безкоштовна. Це не так. Для сильного JS-розробника важливо розуміти не лише **memory model**, а й **trade-offs між структурами даних**, вплив алокацій на продуктивність і способи профілювання реальних витоків пам'яті.

---

## 1. Scope Модуля

Цей блок складається з двох частин:
- **Memory Model:** Stack vs Heap, references, mutation, closures, V8 optimizations, deoptimization, Garbage Collection.
- **Data Structures:** `Array`, `Map`, `Set`, `WeakMap`, `WeakSet`, `TypedArray`, `ArrayBuffer`, а також вибір правильної структури під задачу.

**Теза:** Модуль має пояснювати не тільки "де живуть дані", а й "яку структуру даних вибрати" та "як перевірити, що пам'ять поводиться саме так, як ви очікуєте".

---

## 2. The "Hardware" Perspective

З точки зору рушія, оперативна пам'ять це обмежений ресурс.
- **Stack:** Швидка, але маленька ділянка для миттєвих операцій.
- **Heap:** Велика "куча", де дані можуть жити довго, але доступ до них повільніший, а прибирання складніше.

JavaScript-розробник має розуміти цей баланс, щоб не перевантажувати Heap непотрібними об'єктами і не обирати структури даних, які створюють зайві алокації або поганий доступ до даних.

---

## 3. Roadmap Блоку

### 01. [Stack vs Heap](./01-stack-vs-heap/README.md)
*Чому примітиви й об'єкти поводяться по-різному?*
Будуємо ментальну модель розділення Stack і Heap та одразу позначаємо, де це навчальна модель, а де деталі рушія.

### 02. [References & Mutation](./02-references-and-mutation/README.md)
*Чому `const` об'єкт можна змінювати?*
Розбираємо shared references, shallow vs deep copy, immutability patterns і межі `structuredClone`.

### 02b. [Closures & Memory Retention](./02b-closures-and-memory-retention/README.md)
*Чому функція може утримувати змінні після завершення зовнішнього виклику?*
Розбираємо closure як механізм збереження lexical environment і як міст між references, GC та memory leaks.

### 03. [V8 Optimizations: Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md)
*Секрет швидкості JavaScript.*
Як V8 оптимізує доступ до властивостей, що таке monomorphism, і коли shape stability реально важлива.

### 04. [Deoptimization & Performance Pitfalls](./04-deoptimization-pitfalls/README.md)
*Що ламає швидкість вашого коду?*
Коли рушій відкатується до повільнішого шляху виконання і як відрізняти корисні heuristics від cargo cult.

### 05. [Garbage Collection Mechanics](./05-garbage-collection/README.md)
*Як JS прибирає за собою.*
Reachability, Mark-and-Sweep, Generational GC, closure retention і memory leaks у браузері та Node.js.

### 06. [Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md)
*Коли об'єкт уже не найкращий словник?*
Порівнюємо plain object з `Map`, `Set`, `WeakMap`, `WeakSet` і пояснюємо зв'язок weak-структур з GC.

### 07. [ArrayBuffer, TypedArray and Binary Data](./07-arraybuffer-typedarray-and-binary-data/README.md)
*Що робити, коли треба працювати не з JS-об'єктами, а з байтами?*
Базова модель binary data у JavaScript і сценарії, де `TypedArray` кращі за звичайні масиви.

### 08. [Choosing Data Structures in JS](./08-choosing-data-structures-in-js/README.md)
*Як вибрати структуру даних під пошук, унікальність, кешування або порядок?*
Порівнюємо `Object vs Map`, `Array vs Set` і фіксуємо практичні trade-offs.

### 09. [Memory Profiling in DevTools](./09-memory-profiling-in-devtools/README.md)
*Як перевіряти пам'ять на практиці, а не на інтуїції?*
Heap Snapshot diff, retained paths, allocation instrumentation і покроковий profiling workflow.

### 10. [Memory Leak Lab](./10-memory-leak-lab/README.md)
*Повний практичний сценарій: leak, діагностика, fix, verify.*
Один наскрізний лаб із leaking modal/component, DevTools workflow і перевіркою виправлення.

---

## 4. Глосарій Термінів

| Термін | Коротке визначення |
| :--- | :--- |
| **Reference Value** | Значення, яке вказує на об'єкт у Heap. У JS воно теж передається **by value**. |
| **Allocation** | Процес виділення місця в RAM під нову змінну, об'єкт або буфер. |
| **Monomorphism** | Стан, коли функція стабільно працює з даними однієї "форми". |
| **Deoptimization** | Відкат рушія до повільнішого шляху виконання через непередбачувані дані або shape changes. |
| **Reachability** | Критерій GC: об'єкт живе, поки до нього можна дійти від коренів. |
| **Retained Path** | Ланцюжок посилань, який утримує об'єкт живим у Heap. |

Повний глосарій модуля: [GLOSSARY.md](./GLOSSARY.md)

---

> [!IMPORTANT]
> Частина цього блоку є **навчальною моделлю**, а частина описує **поведінку конкретного рушія V8**. У статтях ми будемо явно позначати цю межу, щоб уникати неточних узагальнень.

**[ВПЕРЕД ДО РОЗДІЛУ 01: STACK VS HEAP ->](./01-stack-vs-heap/README.md)**
