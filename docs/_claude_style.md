# MY_STYLE_BASELINE.md

---

## 1. GRAMMATICAL PERSON

Use the **impersonal/passive voice** for describing system behavior, architecture, and facts:
*"Il sistema è progettato per..."*, *"Il modulo viene istanziato..."*, *"La policy è applicata a..."*

Use the **academic first-person plural** only when taking ownership of a design decision or observation:
*"Abbiamo scelto di..."*, *"Si è optato per..."*, *"Abbiamo osservato come..."*

Never use the singular first person. Never use second person.

---

## 2. ENGINEERING TRADE-OFFS

When describing a technical choice, argument adds more than description alone. If a design decision exists, its justification should be present, not because every sentence needs a trade-off structure, but because a choice without a stated reason is opaque. This applies to discretionary design decisions: choices where an alternative existed and was rejected. It does not apply to external constraints or stated requirements, where framing a trade-off would be artificial.

When a trade-off is relevant, the pattern is: describe the chosen approach, name what was sacrificed, explain why the sacrifice is acceptable.

*Example: "Pydantic v2 è stato preferito a TypedDict per la validazione dei modelli a runtime perché i modelli Pydantic applicano i tipi al momento della costruzione dell'oggetto, non solo in fase di analisi statica. Il costo accettato è il maggior overhead di importazione, giustificato dal fatto che errori di configurazione vengono intercettati immediatamente all'avvio del tool invece di propagarsi silenziosamente durante l'esecuzione dei test."*

---

## 3. TRANSITIONS

Transitions must declare the logical relationship between ideas, not merely accumulate them. The test: before using a connective, name the relationship it expresses (cause, contrast, specification, consequence). If the relationship cannot be named, restructure the sentence instead of adding a conjunction.

**Functional alternatives by relationship type:**

- To add related information: *"A questi, vanno ad aggiungersi..."* / *"Va sottolineato come..."*
- To introduce a consequence: *"Di conseguenza..."* / *"Ne deriva che..."* / *"Questo comporta..."*
- To contrast: *"Dall'altro lato..."* / *"A differenza di..."* / *"Al contrario..."*
- To introduce a detail: *"Nel dettaglio..."* / *"In particolare..."* / *"Nello specifico..."*
- To reference back: *"Come accennato..."* / *"Come illustrato nella Sezione X..."*
- To introduce a list: *"Tra questi si identificano:"* / *"I principali elementi sono:"*
- To conclude within a paragraph: *"In questo modo..."* / *"Si ottiene quindi..."*

**Contrast example:**

*Weak (accumulates without declaring the relationship):*
"Il tool orchestra 18 test distribuiti su 8 domini. Inoltre, è progettato per essere API-agnostico."

*Strong (relationship declared explicitly via colon):*
"Il tool orchestra 18 test distribuiti su 8 domini, ciascuno progettato senza riferimento a un target specifico: l'agnosticismo applicativo (D1.P1) non è una feature aggiuntiva, ma il presupposto che rende il framework deployabile su qualsiasi API REST documentata."

Note: the strong version is longer because it makes the relationship explicit, not because length signals quality.

---

## 4. VOCABULARY

**Precision action verbs:** orchestrare, disaccoppiare, istanziare, astrarre, delegare, propagare, iniettare, serializzare, validare, esporre, raccogliere, verificare. Avoid generic verbs: fare, usare, creare, mettere.

**Domain adjectives:** deterministico, agnostico, stateless, isolato, idempotente, modulare, scalabile, riproducibile. Avoid qualitative adjectives: buono, veloce, semplice, efficace.

**Jargon retention:** retain any established technical term that has no Italian equivalent with equivalent precision. The list below is indicative, not exhaustive; apply the same criterion to any term not listed: deployment, pipeline, overhead, runtime, framework, payload, testing, assessment, gateway, middleware, token, endpoint, bypass, fuzzing, hardening, pattern, design, parsing, scope, logging, monitoring, timeout, buffer, cache, threat modeling, attack surface, misconfiguration, exploit, teardown, connector, scheduler, orchestrator.

---

## 5. INFORMATION DENSITY

- Anchor quantitative claims to their source: prefer *"come verificato in §A.2 (286s, n=2 run)"* over a bare number. Never present a metric without stating what was measured and under what conditions.
- Quantify where structurally natural: prefer *"3 componenti indipendenti"* over *"alcuni componenti"*. Do not force quantification where it reads as padding.
- Reference figures and tables inline: *"come mostrato nella Figura X"*, not pre-announced.

---

## 6. CRITICAL ARGUMENTATION — MASTER'S LEVEL

- **From Descriptive to Argumentative:** When a component is described, frame it as a response to a specific need or friction where relevant. Not every sentence requires this framing; it applies where a choice was made, not where a fact is simply stated.
- **The "Why" and "At What Cost":** Custom implementations should be justified against the alternatives considered. The standard that was rejected and the reason for rejection belong in the prose, not in a footnote.
- **Literature Positioning:** Anchor technical choices to the gaps identified in the state-of-the-art. Claims that float without connection to the existing literature are isolated claims, not academic contributions.
- **Narrative Connection Between Properties:** When multiple architectural properties appear in sequence, make the relationship between them explicit where one exists. Properties that are causally linked, prerequisite-dependent, or in trade-off tension should be connected explicitly rather than presented as a flat list. Not every property has a relationship to the next; where none exists, parallel presentation is correct. Where one exists, the connective must name it: causality, prerequisite, extension, or trade-off compensation.

The example on literature positioning and the example on critical discussion of limits in Section 8 demonstrate these principles in context.

Sections 6 and 7 operate on different planes and do not override each other. Section 6 governs what is argued and whether a justification is present. Section 7 governs how the argument is constructed syntactically and structurally. Both apply simultaneously.

---

## 7. PROSE VARIATION

AI-generated academic prose is detectable primarily through two measurable signals: **burstiness** (structural uniformity across sentences and paragraphs) and **perplexity** (predictability of lexical choices). Both must be actively counteracted.

### Em Dash — Absolute prohibition

The em dash (—) is categorically forbidden in all output. It is the single most recognizable marker of AI-generated prose and must never appear. Replace it with:
- a comma where the relationship is additive or qualifying
- a colon where the second clause specifies or explains the first
- parentheses for inline enumerations or clarifications
- a full stop where two independent claims are better separated
- syntactic restructuring where none of the above fits

*Forbidden:* "Un controllo perimetrale — verificare che il gateway rifiuti richieste — non presuppone conoscenza interna."
*Correct:* "Un controllo perimetrale, inteso come la verifica che il gateway rifiuti richieste non autenticate, non presuppone conoscenza dell'infrastruttura interna."

*Forbidden:* "Strumenti pensati per il testing tradizionale — scanner di vulnerabilità, fuzzer stateless — non sono progettati per questo spazio."
*Correct:* "Strumenti pensati per il testing tradizionale (scanner di vulnerabilità, fuzzer stateless) non sono progettati per questo spazio."

### Burstiness — Sentence and paragraph length variation

Human academic writing mixes sentence lengths deliberately. AI output clusters toward medium length, producing a metronomic rhythm that detectors measure directly.

- Alternate between short incisive sentences and long syntactically complex ones. Never produce three or more consecutive sentences of similar length.
- Allow paragraph asymmetry: some claims are complete in two sentences; not every paragraph requires the same depth of treatment.
- Use Italian syntax for variation: subject-verb inversion, fronted complements, participial constructions where they read naturally. *"Di tale scelta si discuterà..."* rather than always *"Si discuterà di tale scelta..."*
- Prefer subordination over coordination: relative clauses and participial constructions over unbroken chains of coordinating conjunctions. This does not prohibit individual use of "ma" or "però" for contrast: it targets the pattern of stringing three or more main clauses with conjunctions where a single complex sentence would be more precise.

### Perplexity — Lexical choice

Among technically accurate synonyms, prefer the one that is less immediately predictable, calibrated to the register of a software engineering thesis, not to creative writing. The goal is precision with a non-obvious formulation, not elevation of register.

*Low perplexity:* "garantire l'immutabilità del contesto"
*Higher perplexity, same register:* "congelare lo stato del contesto a monte della pipeline"

The operational test: if the word is the first one that comes to mind when completing that sentence, look for the second. If the second is technically more precise, use it. If it merely sounds unusual, discard it.

### Structural non-linearity

A paragraph does not have to open with its claim. Italian academic prose can place the conclusion first and reconstruct the reasoning that led there, establish a specific case before generalizing, or present a solution before naming the problem it solves. Like certain film structures, the opening scene can be the ending, provided the causal chain remains reconstructible by the reader.

Valid structures include: frizione → soluzione → costo → giustificazione, its inverse, dato specifico → generalizzazione, soluzione → problema che la motiva, osservazione → inferenza → implicazione. What is not valid is the mechanical repetition of the same structure across every paragraph of a chapter. Example A in Section 8 demonstrates this: it opens with the consequence (immutability is not a stylistic choice) and reconstructs the cause afterward.

Two structures are counterintuitive enough to require a concrete demonstration.

*Soluzione → problema (solution precedes the problem it solves):*

> Il `DAGScheduler` delega la risoluzione dell'ordine topologico a `graphlib.TopologicalSorter`, la libreria standard di Python introdotta nella 3.9. Il problema che questa scelta risolve è la dipendenza tra test: alcuni richiedono che certi altri abbiano già prodotto risorse sul target, e l'esecuzione in ordine arbitrario produrrebbe errori non deterministici invece di fallimenti puliti.

*Osservazione → inferenza → implicazione (evidence first, claim last):*

> Su 90 file sorgente analizzati con mypy in modalità strict, il type checker non ha rilevato nessuna violazione. Da questo si inferisce che il contratto tra i componenti, espresso tramite type hints, è consistente lungo l'intera catena di dipendenze: nessun punto di chiamata riceve un tipo incompatibile con quello dichiarato dal callee. L'implicazione è che errori di interfaccia tra moduli vengono intercettati a tempo di analisi statica, prima ancora che il codice venga eseguito contro un target reale.

---

## 8. CALIBRATION EXAMPLES

These examples illustrate the difference between AI-flat prose and the target register. Use them as a calibration reference when generating or evaluating any paragraph. The target versions are not templates: they demonstrate the combined application of burstiness, perplexity, em dash prohibition, and structural variation.

### Example A — Describing an architectural component (Cap. 4)

**AI-flat** (uniform sentence length, low perplexity, em dash, no structural argument):

> Il `TargetContext` è un componente fondamentale del sistema. È progettato per contenere le informazioni relative al target. Utilizza il pattern di immutabilità per garantire che i dati non vengano modificati durante l'esecuzione. Questo approccio consente di evitare race condition — e garantisce la coerenza dei dati tra i vari test.

**Target** (non-linear structure: opens with consequence, reconstructs cause; burstiness varied, perplexity raised, em dash absent):

> L'immutabilità del `TargetContext` non è una scelta stilistica, ma la risposta a un problema preciso. Durante l'esecuzione di 18 test in parallelo, ciascuno con accesso alla rappresentazione del target, basterebbero poche scritture concorrenti non sincronizzate per corrompere la base informativa da cui ogni verdetto dipende. Congelare lo stato a monte, prima che la pipeline si ramifichi, isola il problema alla radice: nessun test può accidentalmente alterare ciò che gli altri leggono. Il costo accettato è la rigidità. Una volta costruito, il `TargetContext` non si aggiorna, giustificato dal fatto che il target non cambia durante un singolo assessment run.

---

### Example B — Presenting an experimental result (Cap. 5)

**AI-flat** (generic qualifiers, no data, no causal reasoning):

> I risultati ottenuti sono stati molto positivi. Il tool ha dimostrato un'ottima idempotenza tra le esecuzioni. Infatti, i due run hanno prodotto gli stessi risultati. Questo dimostra che il sistema è affidabile e riproducibile.

**Target** (data anchored, causal chain explicit, no generic qualifiers):

> Su due run indipendenti contro lo stesso target, il sistema ha prodotto risultati byte-identici: 9 PASS, 7 FAIL, 2 SKIP, 98 finding totali, con un delta sul wall-clock di 0,32% (286,04s vs 286,96s). L'idempotenza non era scontata: test che creano risorse sul target, le interrogano e le rimuovono introducono dipendenze di stato che, se mal gestite, producono risultati diversi al secondo run. Che il teardown LIFO abbia drenato 4 risorse con 0 fallimenti in entrambe le esecuzioni è la conferma empirica che la pipeline non lascia effetti collaterali osservabili.

---

### Example C — Positioning literature (Cap. 2)

**AI-flat** (descriptive, isolated, no gap identification):

> Fielding (2000) ha introdotto il paradigma REST. Questo approccio è basato su risorse e utilizza i verbi HTTP standard. È diventato molto popolare nello sviluppo di API moderne. Tuttavia, presenta alcuni limiti nel contesto della sicurezza.

**Target** (critical positioning, gap connected to own work, structure: contribution → limit → implication):

> Il paradigma REST, formalizzato da Fielding nel 2000 come vincolo architetturale sulle interazioni client-server, ha definito il vocabolario su cui si fonda ancora oggi la maggior parte delle API pubbliche. Ciò che quella formalizzazione non prevedeva era la proliferazione incontrollata degli endpoint che caratterizza le architetture a microservizi: REST descrive come esporre una risorsa, non quante risorse esporre né come governarne il ciclo di vita. Di conseguenza, il problema che questo lavoro affronta non è una carenza del paradigma in sé, ma l'assenza di strumenti capaci di verificare sistematicamente che i vincoli del paradigma siano effettivamente applicati a runtime.

---

### Example D — Critical discussion of a limit (Cap. 6)

**AI-flat** (vague, defensive, no technical precision):

> Il tool presenta alcuni limiti. Ad esempio, richiede una specifica OpenAPI valida per funzionare correttamente. Questo potrebbe rappresentare una limitazione in alcuni contesti. Tuttavia, nella maggior parte dei casi questo requisito è soddisfatto.

**Target** (limit stated precisely, structurally unavoidable nature explained, positioned in literature):

> Il vincolo più stringente dell'approccio contract-driven adottato è anche il più difficile da eliminare: il tool deriva tutta la conoscenza del target dalla specifica OpenAPI fornita. Una specifica incompleta, obsoleta o deliberatamente alterata produce un assessment parziale senza che il sistema possa rilevarne l'incoerenza. Non si tratta di un bug, ma di un limite strutturale del paradigma: strumenti che assumono la correttezza del contratto non possono verificare il contratto stesso. Questo problema non è esclusivo di APIGuard Assurance, ma si applica a qualsiasi approccio basato su specifiche formali, e rimane un open problem nella letteratura sul testing contract-driven.

---

### Example E — Explaining a methodological choice (Cap. 3)

**AI-flat** (taxonomic description without motivation):

> Il box gradient è una metodologia che divide i test in tre livelli. Il primo livello è Black Box, dove non si ha conoscenza del sistema. Il secondo è Grey Box, dove si ha conoscenza parziale. Il terzo è White Box, dove si ha accesso completo. Questa divisione è utile per organizzare i test in modo efficace.

**Target** (classification derived from preconditions, not imposed from above):

> Assegnare a ogni test un livello di visibilità non è una scelta organizzativa, ma una conseguenza diretta di ciò che si vuole misurare. Un controllo perimetrale, inteso come la verifica che il gateway rifiuti richieste non autenticate, non presuppone conoscenza dell'infrastruttura interna: il risultato atteso è lo stesso indipendentemente da chi effettua la richiesta, e simulare un attaccante esterno è l'unico modo per ottenere un'evidenza non contaminata da privilegi impliciti. Un controllo di autorizzazione RBAC, al contrario, richiede token validi per almeno due ruoli distinti: senza quello stato autenticato, il test non può nemmeno raggiungere la logica che intende sondare. Ne deriva che il gradiente Black/Grey/White Box non è una tassonomia teorica applicata retroattivamente, ma il prodotto delle precondizioni che ciascuna garanzia di sicurezza impone al tester.

---

### Example F — Introduction / Conclusions (Cap. 1, Cap. 7)

**AI-flat** (generic opening, no technical precision, circular close):

> Le API sono diventate fondamentali nel panorama tecnologico moderno. La sicurezza delle API è quindi molto importante. Questo lavoro propone un tool per migliorare la sicurezza delle API. Il tool è stato sviluppato con un approccio innovativo e produce risultati significativi.

**Target** (opens with the structural problem, not a generic claim; no magniloquence, no circular close):

> La superficie di attacco delle architetture a microservizi non cresce linearmente con il numero di servizi: cresce con il numero di interazioni tra servizi, ciascuna mediata da un'interfaccia programmabile che può essere scoperta, interrogata e abusata indipendentemente dal contesto applicativo. Strumenti pensati per il testing tradizionale (scanner di vulnerabilità, fuzzer stateless) non sono progettati per questo spazio: operano sulla sintassi delle richieste HTTP, non sulla semantica dei contratti che quelle richieste dovrebbero rispettare. APIGuard Assurance nasce precisamente in questo gap: un engine che deriva la conoscenza del target dalla sua specifica formale e la usa per costruire un assessment riproducibile, prioritizzato e tracciabile.