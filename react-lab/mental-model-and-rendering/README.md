# React Mental Model & Rendering

Цей блок закриває **базову модель виконання React**. Його мета не просто навчити писати JSX, а дати відповідь на питання: **що саме React рахує, коли він це рахує, хто викликає компоненти, чому рендер має бути pure, як зберігається state identity і чому Hooks залежать від порядку**.

---

## Scope

У цьому модулі ми закриваємо десять ключових тем:

1. What React Actually Is.
2. JSX as Syntax Over Element Objects.
3. React Elements vs Components vs DOM Nodes.
4. Components and Hooks Must Be Pure.
5. Render Phase vs Commit Phase.
6. React Calls Components and Hooks.
7. Snapshot Model of a Render.
8. Root Lifecycle.
9. Strict Mode.
10. Rules of Hooks.

---

## Розділи

### 1. [What React Actually Is](./01-what-react-actually-is/README.md)
- React як **UI runtime**, а не template engine.
- Declarative tree, reconciliation mindset і tree updates.

### 2. [JSX as Syntax Over Element Objects](./02-jsx-as-syntax-over-element-objects/README.md)
- JSX як синтаксичний шар поверх element creation.
- Чому JSX не створює DOM напряму.

### 3. [React Elements vs Components vs DOM Nodes](./03-react-elements-vs-components-vs-dom-nodes/README.md)
- Різниця між описом, виконавцем і реальним host node.
- Чому плутанина між цими рівнями ламає mental model.

### 4. [Components and Hooks Must Be Pure](./04-components-and-hooks-must-be-pure/README.md)
- Idempotent rendering.
- Side effects, mutation during render і локальна чистота Hooks.

### 5. [Render Phase vs Commit Phase](./05-render-phase-vs-commit-phase/README.md)
- Що React обчислює в render phase.
- Коли насправді відбуваються DOM mutation, refs і effects.

### 6. [React Calls Components and Hooks](./06-react-calls-components-and-hooks/README.md)
- Чому компоненти не можна викликати як звичайні функції.
- Як React прив'язує state, reconciliation і scheduling до tree identity.

### 7. [Snapshot Model of a Render](./07-snapshot-model-of-a-render/README.md)
- Чому `props`, `state` і `context` фіксовані в межах одного render.
- Звідки беруться stale closures і "старі" event handlers.

### 8. [Root Lifecycle](./08-root-lifecycle/README.md)
- `createRoot`, `root.render`, `root.unmount`.
- Root як entry point для ownership над subtree.

### 9. [Strict Mode](./09-strict-mode/README.md)
- Development-only probes.
- Double render / effect / ref execution як детектор impurity.

### 10. [Rules of Hooks](./10-rules-of-hooks/README.md)
- Hook order invariant.
- Slot model: чому Hooks мають викликатися тільки top-level.

---

## Ключові інтерактиви

- [React Runtime Tree](../visualisation/mental-model-and-rendering/01-what-react-actually-is/react-runtime-tree/index.html)
- [JSX to Element Object](../visualisation/mental-model-and-rendering/02-jsx-as-syntax-over-element-objects/jsx-to-element-object/index.html)
- [React vs DOM Layers](../visualisation/mental-model-and-rendering/03-react-elements-vs-components-vs-dom-nodes/react-vs-dom-layers/index.html)
- [Purity vs Side Effects](../visualisation/mental-model-and-rendering/04-components-and-hooks-must-be-pure/purity-vs-side-effects/index.html)
- [Render vs Commit Timeline](../visualisation/mental-model-and-rendering/05-render-phase-vs-commit-phase/render-commit-timeline/index.html)
- [React Call Orchestrator](../visualisation/mental-model-and-rendering/06-react-calls-components-and-hooks/react-call-orchestrator/index.html)
- [Render Snapshot Board](../visualisation/mental-model-and-rendering/07-snapshot-model-of-a-render/render-snapshot-board/index.html)
- [Root Lifecycle Board](../visualisation/mental-model-and-rendering/08-root-lifecycle/root-lifecycle-board/index.html)
- [Strict Mode Probe](../visualisation/mental-model-and-rendering/09-strict-mode/strict-mode-probe/index.html)
- [Hook Slot Order](../visualisation/mental-model-and-rendering/10-rules-of-hooks/hook-slot-order/index.html)

---

## Стандарт статей цього блоку

Кожна теоретична стаття в блоці має:

- `Thesis`
- `Simple Explanation`
- `Technical Explanation`
- `Visual Mental Model`
- `Edge Cases / Pitfalls`
- `Self-Check Questions`
- `Short Answers / Hints`
- `Common Misconceptions`
- `When This Matters / When It Doesn't`
- `Suggested Practice`

---

## Що дає рівень 110%

Після проходження цього блоку ви повинні вміти:

1. Пояснити React як **tree runtime**, а не як “HTML generator”.
2. Відрізняти JSX, element object, component function і DOM node без змішування рівнів.
3. Пояснити, чому render має бути pure і чому side effects не можна пхати в body component.
4. Розрізняти render phase і commit phase та знати, де реально відбувається DOM work.
5. Розуміти render як **snapshot**, а Hooks як **state slots**, прив'язані до порядку виклику.
6. Діагностувати базові React bugs не інтуїцією, а через механіку root, render, commit, identity і hook order.
