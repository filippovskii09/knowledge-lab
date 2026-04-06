# Memory & Data Structures Glossary

Цей глосарій збирає ключові терміни з усього модуля `memory-and-data-structures`. Його мета не замінити статті, а дати швидку опору для нових, технічних або потенційно неочевидних слів.

---

## I. Memory Model

- **Stack** — навчальна модель короткоживучої пам'яті для call frames і bindings. Зручна для пояснення lifetime виконання, але не є повним описом фізичної реалізації рушія. Див. [01 Stack vs Heap](./01-stack-vs-heap/README.md).
- **Heap** — область пам'яті для довільних динамічних структур: об'єктів, масивів, функцій, буферів і довгоживучих значень. Див. [01 Stack vs Heap](./01-stack-vs-heap/README.md), [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **Allocation** — виділення пам'яті під нове значення або структуру даних. Див. [01 Stack vs Heap](./01-stack-vs-heap/README.md), [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md).
- **Reference Value** — значення, яке вказує на об'єкт у Heap. У JavaScript воно теж копіюється **by value**. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Shared Reference** — ситуація, коли дві змінні містять однакове посилальне значення на той самий об'єкт. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Mutation** — зміна даних усередині існуючого об'єкта або масиву. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Shallow Copy** — копія лише верхнього рівня структури. Вкладені об'єкти залишаються спільними. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Deep Copy** — копія, яка розриває зв'язок і на рівні вкладених структур. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Immutability** — підхід, за якого зміни стану роблять через створення нових значень, а не мутацію старих. Див. [02 References & Mutation](./02-references-and-mutation/README.md).
- **Lifetime** — скільки часу значення залишається живим у програмі. Див. [01 Stack vs Heap](./01-stack-vs-heap/README.md), [05 Garbage Collection](./05-garbage-collection/README.md).

---

## II. Execution and Engine

- **Execution Context** — службова "капсула" виконання коду, яка тримає інформацію про активний код, середовище змінних та інші внутрішні деталі. Див. [02b Closures & Memory Retention](./02b-closures-and-memory-retention/README.md).
- **Stack Frame** — один кадр стеку викликів, пов'язаний із конкретним викликом функції. Див. [01 Stack vs Heap](./01-stack-vs-heap/README.md), [02b Closures & Memory Retention](./02b-closures-and-memory-retention/README.md).
- **Environment Record** — внутрішня структура, де рушій зберігає bindings для змінних, параметрів і функцій. Див. [02b Closures & Memory Retention](./02b-closures-and-memory-retention/README.md).
- **Lexical Environment** — абстракція специфікації ECMAScript, яка поєднує `Environment Record` і посилання на зовнішнє середовище. Див. [02b Closures & Memory Retention](./02b-closures-and-memory-retention/README.md), [05 Garbage Collection](./05-garbage-collection/README.md).
- **Hidden Class / Shape** — внутрішня структура V8, яка описує форму об'єкта і допомагає оптимізувати доступ до властивостей. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Inline Cache (IC)** — механізм кешування доступу до властивостей або викликів на основі стабільної форми даних. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Monomorphic** — сценарій, коли функція стабільно працює з однією формою об'єкта. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Polymorphic** — сценарій, коли функція бачить кілька форм об'єктів. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Megamorphic** — сценарій, коли форм даних надто багато, і кешування втрачає ефективність. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Offset** — зміщення властивості в пам'яті відносно базового layout об'єкта. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **Transition Tree** — внутрішня модель переходів між shape-ами об'єкта, коли до нього додають властивості. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Fast Properties** — більш оптимізований режим зберігання властивостей об'єкта у V8. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md).
- **Dictionary Mode** — повільніший режим доступу до властивостей, коли форма об'єкта стає менш стабільною. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Deoptimization** — відкат рушія до повільнішого шляху виконання через непередбачувані дані або втрату стабільності припущень. Див. [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Hot Path** — ділянка коду, яка виконується часто і тому особливо важлива для продуктивності. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Cold Path** — ділянка коду, яка виконується рідко і зазвичай не потребує мікрооптимізацій. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).

---

## III. Arrays and Binary Data

- **Elements Kind** — внутрішня класифікація масивів у V8 залежно від типу і щільності елементів. Див. [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **PACKED Elements** — щільний масив без "дірок", який рушій може обробляти ефективніше. Див. [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **HOLEY Elements** — масив із порожніми індексами, який часто гірше оптимізується. Див. [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Small Integer (SMI)** — компактне представлення маленьких цілих чисел у V8. Див. [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **ArrayBuffer** — контейнер сирих байтів фіксованого розміру. Див. [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **TypedArray** — типізоване представлення поверх `ArrayBuffer`, яке інтерпретує байти як послідовність чисел певного типу. Див. [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **DataView** — низькорівневий інтерфейс для читання й запису різних типів даних у `ArrayBuffer` на конкретних offset-ах. Див. [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **Binary Data** — дані, представлені не як звичайні JS-об'єкти чи рядки, а як послідовності байтів. Див. [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).
- **Endian-ness** — порядок байтів у багатобайтному числовому значенні. Див. [07 Typed Arrays & ArrayBuffer](./07-arraybuffer-typedarray-and-binary-data/README.md).

---

## IV. Data Structures

- **Plain Object** — звичайний JS-об'єкт, який часто використовується як сутність із фіксованими полями. Див. [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).
- **Map** — колекція "ключ -> значення" з явним API та підтримкою довільних типів ключів. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md), [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).
- **Set** — колекція унікальних значень. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md), [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).
- **WeakMap** — key-value структура, де ключі мають бути об'єктами і не утримуються сильно самою колекцією. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md), [05 Garbage Collection](./05-garbage-collection/README.md).
- **WeakSet** — weak-колекція унікальних object values без повної ітерації. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md).
- **Lookup Collection** — структура даних, оптимізована насамперед під пошук по ключу або перевірку наявності. Див. [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).
- **Metadata Storage** — допоміжна структура даних для зберігання службової інформації, прив'язаної до іншого об'єкта. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md).
- **Membership Check** — перевірка, чи належить елемент колекції. Див. [06 Map, Set, WeakMap, WeakSet](./06-map-set-weakmap-weakset/README.md), [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).
- **Trade-off** — компроміс між кількома властивостями структури або алгоритму: читабельністю, пам'яттю, швидкістю, API чи стабільністю форми. Див. [08 Choosing Data Structures](./08-choosing-data-structures-in-js/README.md).

---

## V. Garbage Collection and Leaks

- **Garbage Collection (GC)** — автоматичне прибирання недосяжних об'єктів у пам'яті. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Reachability** — правило, за яким об'єкт вважається живим, якщо до нього можна дійти від коренів. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **GC Root** — стартова точка для пошуку живих об'єктів: `globalThis`, активний стек, timers, DOM roots, active handles тощо. Див. [05 Garbage Collection](./05-garbage-collection/README.md), [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md).
- **Mark-and-Sweep** — базова ідея GC: спочатку позначити досяжні об'єкти, потім прибрати решту. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Generational GC** — підхід, за якого пам'ять ділиться на покоління, бо більшість об'єктів живе недовго. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Young Generation** — область для нових об'єктів, які часто швидко вмирають. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Old Generation** — область для об'єктів, що пережили кілька циклів прибирання. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Scavenge** — алгоритм очищення молодого покоління у V8. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Incremental Marking** — поступове маркування об'єктів маленькими порціями. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Concurrent Marking / Sweeping** — частина роботи GC, що може виконуватись паралельно з основним потоком. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Stop-The-World** — пауза, під час якої виконання JS зупиняється заради роботи GC. Див. [05 Garbage Collection](./05-garbage-collection/README.md).
- **Memory Leak** — ситуація, коли об'єкт більше не потрібен програмі, але все ще reachable. Див. [05 Garbage Collection](./05-garbage-collection/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Closure Retention** — утримання даних у пам'яті через замикання, яке продовжує посилатись на зовнішні значення. Див. [02b Closures & Memory Retention](./02b-closures-and-memory-retention/README.md), [05 Garbage Collection](./05-garbage-collection/README.md).
- **Detached DOM Tree** — DOM-вузол, який вже прибраний зі сторінки, але досі утримується посиланнями з JS. Див. [05 Garbage Collection](./05-garbage-collection/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Singleton State** — довгоживучий глобальний або модульний стан, який може випадково тримати зайві дані. Див. [05 Garbage Collection](./05-garbage-collection/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).

---

## VI. Profiling and Diagnostics

- **Heap Snapshot** — статичний знімок стану пам'яті в конкретний момент часу. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Heap Snapshot Diff** — порівняння двох snapshot-ів для виявлення об'єктів, які залишились після сценарію. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Shallow Size** — пам'ять, яку займає сам об'єкт без урахування того, що він утримує. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md).
- **Retained Size** — сумарна пам'ять, яка залишається живою через цей об'єкт. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Retained Path** — ланцюжок посилань від GC root до об'єкта, який пояснює, чому він досі живий. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Allocation Instrumentation** — профілювання, що показує динаміку створення нових об'єктів під час взаємодії. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md).
- **Allocation Churn** — ситуація, коли програма надто інтенсивно створює короткоживучі об'єкти і тисне на GC, навіть без справжнього leak. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Sawtooth Pattern** — графік пам'яті з постійним ростом і періодичним падінням після GC. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md).
- **Baseline Snapshot** — перший контрольний snapshot перед сценарієм відтворення проблеми. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).
- **Reproducible Scenario** — стабільний сценарій, який можна повторити багато разів для перевірки пам'яті або продуктивності. Див. [09 Memory Profiling](./09-memory-profiling-in-devtools/README.md), [10 Memory Leak Lab](./10-memory-leak-lab/README.md).

---

## VII. Practical Notes

- **Cargo Cult Optimization** — бездумне застосування правил оптимізації без вимірювань і контексту. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Micro-benchmark** — маленький синтетичний тест, який не завжди відображає реальну продуктивність у застосунку. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Shape Stability** — стабільність структури об'єкта, корисна для оптимізацій рушія. Див. [03 Hidden Classes & IC](./03-v8-hidden-classes-and-ic/README.md), [04 Deoptimization](./04-deoptimization-pitfalls/README.md).
- **Persistent Update Pattern** — підхід, коли зміни стану роблять через створення нової структури з максимальним перевикористанням старих частин. Див. [02 References & Mutation](./02-references-and-mutation/README.md).

---

> [!TIP]
> Якщо термін незрозумілий навіть після цього глосарію, поверніться до відповідної статті і знайдіть його в контексті прикладу. Для тем пам'яті та рушія контекст важливіший за коротке словникове визначення.
