Capito. Cerco direttamente nella knowledge base i file `.tex` dalla repo corretta.Ottimo. Ho trovato contenuto reale dei file `.tex`. Ora recupero tutti i capitoli sistematicamente.Ho ora una visione estremamente precisa di tutti i capitoli. Procedo con l'analisi finale.

---

Sulla base della lettura integrale di tutti i file `.tex` della tesi, ecco la mia analisi autonoma e indipendente, che valuta le proposte di Gemini, le conferma, le corregge dove necessario, e aggiunge osservazioni derivate dalla lettura diretta del testo.

---

## Inventario di figure e tabelle già presenti

Prima di valutare cosa aggiungere, è essenziale sapere cosa c'è già.

**Tabelle esistenti (confermate nel LaTeX):**
- `tab:property-index` (Cap. 3): mappa di navigazione delle 39 proprietà verso le sezioni. Già presente.
- `tab:pipeline-fasi` (Cap. 4): tabella pipeline 7 fasi con moduli. Già presente.
- `tab:risultati-per-test` (Cap. 5): risultati per test con status e finding count. Già presente.
- `tab:idempotenza-kpi` (Cap. 5): KPI comparativi Run 1 vs Run 2. Già presente.
- `tab:performance-baseline` (Cap. 5): metriche di sistema (wall-clock, memoria). Già presente.

**Figure esistenti (confermate nel LaTeX):**
- `fig:src-layout` (Cap. 4): albero `dirtree` della struttura `src/` con mapping alle fasi. Già presente.

**Conclusione:** la tesi è attualmente molto densa di testo e tabelle numeriche, ma povera di figure. Non vi è **nessun diagramma architetturale**, nessun grafico di dati, nessuna figura nei Capitoli 1, 2, 3, 6 e 7.

---

## Analisi per capitolo: cosa aggiungere e perché

### Capitolo 1 — Introduzione

**Nessuna figura o tabella necessaria.** Il capitolo introduce tre gap (G1, G2, G3) e tre obiettivi (O1, O2, O3): la struttura narrativa è chiara e non guadagna nulla da un supporto visivo. Le figure architetturali appartengono ai Capitoli 3 e 4. Inserire qui qualcosa sarebbe riempitivo.

Valutazione delle proposte di Gemini: nessuna proposta per questo capitolo. Concordo.

---

### Capitolo 2 — Background e Stato dell'Arte

**Proposta A — Tabella: Semantic Gap e visibilità degli strumenti**
`\label{tab:semantic-gap}` in §2.3.1

Il testo spiega con precisione perché BOLA, BFLA, Mass Assignment e SSRF sfuggono ai WAF tradizionali. Il concetto è il cardine dell'intera motivazione della tesi. Una tabella lo fissa in forma sintetica e diventa riferimento per tutto il resto. Gemini propone quattro colonne: Vulnerabilità OWASP, Natura (Sintattica/Semantica), Visibilità WAF/DAST, Rilevabilità APIGuard. Aggiungo una quinta colonna **Prerequisito informativo** (nessuno / token autenticato / Admin API) che anticipa il Box Gradient del Cap. 3 e motiva quella scelta metodologica in anticipo.

**Priorità: alta. Valore aggiunto: alto.**

**Proposta B — Figura: Il combinatorial wall (fuzzer sintattico vs. contract-driven)**
`\label{fig:combinatorial-wall}` in §2.4.1

Il testo descrive verbalmente i due percorsi. Un diagramma a due corsie (Fuzzer Sintattico → 400 Bad Request / Fuzzer OpenAPI → Logica applicativa) rende immediatamente leggibile la distinzione tra approcci. La figura è già standard nella letteratura sul property-based testing. **Realizzabile in TikZ puro, nessun file esterno.**

**Priorità: alta. Valore aggiunto: alto.**

**Proposta C — Tabella: Confronto paradigmi di testing**
`\label{tab:testing-comparison}` in §2.4.3

Gemini propone una tabella comparativa tra SAST, DAST, Fuzzer OpenAPI e APIGuard. La lettura del testo conferma che §2.4.3 conclude con la transizione verso il contract-driven ma non cristallizza mai i confronti in forma tabulare. La tabella è giustificata. Le colonne più importanti, verificate rispetto al contenuto effettivo del testo, sono: **Paradigma**, **Conoscenza del contratto**, **Dipendenza dall'oracolo**, **Riproducibilità**, **Copertura semantica**. Le ultime due sono esattamente le proprietà su cui si costruisce il Cap. 3, quindi questa tabella funziona da ponte metodologico.

**Priorità: alta. Valore aggiunto: alto.**

---

### Capitolo 3 — Metodologia

**Proposta D — Figura: Architettura di APIGuard Assurance (diagramma a blocchi)**
`\label{fig:architettura-apiguard}` in §3.2 (inizio, prima di §3.2.1)

Questo è il contributo visivo più importante dell'intera tesi. Il testo di §3.2 introduce in sequenza: flusso monodirezionale (D1.P2), DAG (D2.P2), Split State (D1.P3), Gateway Adapter (D1.P6), Evidence Store (D4.P1). Il lettore che legge queste sezioni senza una figura deve costruire mentalmente la topologia del sistema da zero. Un diagramma a blocchi che mostri: input a sinistra (`config.yaml`, `openapi.yaml`), Engine al centro con il blocco Split State visivamente differenziato (TargetContext con lucchetto + TestContext mutabile), target a destra (Kong → Forgejo), Evidence Store in basso, è indispensabile. **Realizzabile in TikZ con gli stili già definiti in `Presentazione/main.tex`.**

**Priorità: massima. Assenza accademica inammissibile per una tesi di architettura software.**

**Proposta E — Figura: Il DAG di dipendenza (grafo orientato con batch)**
`\label{fig:dag-topology}` in §3.2.2

Il testo descrive la topologia a tre fasi (Phase A, B, C) con batch sequenziali. Il grafo con i nodi reali (`0.1`, `1.1`, `1.4`, `2.1`, `ext.1.5`) raggruppati in batch è una figura che serve concretamente al lettore per capire come lo scheduling topologico si traduce in ordine di esecuzione. La tabella `tab:risultati-per-test` del Cap. 5 ha senso pieno solo se il lettore ha già visto questo grafo. **Realizzabile in TikZ.**

**Priorità: alta.**

**Proposta F — Tabella: Tassonomia degli 8 domini con Box Gradient**
`\label{tab:domini-box-gradient}` in §3.3

La `tab:property-index` esiste già per le 39 proprietà. Non esiste però una tabella che mappi esplicitamente i domini di sicurezza con la loro strategia di testing (BLACK/GREY/WHITE Box), la priorità (P0-P3) e l'implementazione in M1. Il testo di §3.3 introduce questa mappatura narrativamente. Una tabella la cristallizza come riferimento per tutta la tesi successiva. Colonne: Dominio, Descrizione sintetica, Strategia, Priorità, Stato M1.

**Priorità: alta. Questa tabella viene citata nei Cap. 4 e 5.**

---

### Capitolo 4 — Implementazione

**Proposta G — UML Sequence Diagram: ciclo di vita Fase 5 (Error Isolation)**
`\label{fig:sequence-error-isolation}` in §4.1

La proprietà D4.P3 (Fail-Safe Error Isolation) è descritta con precisione: il contratto `execute()` non propaga eccezioni verso l'engine. Un sequence diagram con attori `Engine`, `BaseTest`, `SecurityClient` che mostra il flusso normale e il percorso con eccezione (che produce `TestResult(ERROR)` senza bloccare la pipeline) è il formalismo accademico per eccellenza per questa classe di garanzie. Il testo lo dice, il diagramma lo dimostra. **Realizzabile in TikZ o come figura drawio.**

**Priorità: alta.**

**Proposta H — UML Class Diagram: Gerarchia duale BaseTest / ExternalToolTest + Connector**
`\label{fig:class-hierarchy}` tra §4.3 e §4.4

Il testo descrive la gerarchia duale ma il lettore che non conosce il codice fa fatica a costruire la struttura mentale. Il diagramma mostra: `BaseTest` (astratta) ← test nativi D0-D7 / `ExternalToolTest` (astratta) + composizione con `BaseConnector` ← `BaseLibraryConnector` + `BaseSubprocessConnector`. Questo è il contributo architetturale chiave del Cap. 4 e merita un formalismo UML. **Realizzabile in TikZ.**

**Priorità: alta.**

**Proposta I — Flowchart: Sanitizzazione a imbuto (D4.P2)**
`\label{fig:sanitization-funnel}` in §4.6

Il testo descrive la tripla copertura: key-pattern regex, JWT heuristic, header prefix. Un flowchart a imbuto che mostra il raw output attraversare i tre filtri in sequenza prima di essere scritto nell'EvidenceStore è didatticamente potente in una tesi sulla sicurezza delle API. La centralizzazione è il contributo, e il diagramma la rende autoevidente.

**Priorità: media.** Il testo lo spiega già bene; il diagramma aggiunge valore ma non è indispensabile come le proposte precedenti.

---

### Capitolo 5 — Esperimenti

**Proposta J — Figura: Topologia di rete del testbed**
`\label{fig:testbed-topology}` in §5.1.1

Il testo descrive il testbed (host → Kong porte 8443/8000/8001 → Forgejo ↔ PostgreSQL, tre account RBAC) ma non c'è nessuna figura. In ogni paper di sicurezza che descrive un experimental setup, la topologia di rete è sempre visualizzata. La sua assenza è la lacuna più grave della tesi dal punto di vista della pubblicabilità. Un revisore che riceve questo lavoro senza la figura chiede esplicitamente di aggiungerla.

**Priorità: massima.**

**Proposta K — Grafico a barre: Distribuzione dei finding per test**
`\label{fig:finding-distribution}` in §5.3.1

La `tab:risultati-per-test` esiste già con tutti i numeri. Ma il fatto che il test 1.1 da solo produca 74 dei 98 finding (75.5%) è un'informazione che deve essere visibile a colpo d'occhio. Un grafico a barre orizzontale dove ogni test è una barra proporzionale al suo finding count rende immediatamente evidente la concentrazione nell'autenticazione perimetrale. La tabella e il grafico non si duplicano: la tabella dà i numeri esatti, il grafico dà la proporzione. **Realizzabile in PGFPlots, tutti i dati sono già nella tesi.**

**Priorità: alta.**

---

### Capitolo 6 — Discussione

**Proposta L — Flowchart: Decision tree degli exit code nella pipeline CI/CD**
`\label{fig:cicd-exit-codes}` in §6.2.1

Il testo di §6.2.1 descrive i quattro exit code con precisione. La sezione è già ottima in prosa. Un diagramma a nodo di pipeline (runner CI/CD → `apiguard run` → switch a 4 vie: 0 CLEAN, 1 FAIL, 2 ERROR, 10 INFRA → azioni conseguenti) aggiunge il valore operativo concreto che rende la sezione citabile in contesti industriali. La figura non illustra il testo, lo completa con il routing automatico.

**Priorità: alta.**

**Proposta M — Figura concettuale: Evoluzione a piattaforma modulare**
`\label{fig:modular-platform}` in §6.3.2

Un diagramma Core + Plugin (Engine/DAG/Store immutabili al centro, moduli REST/OAS, GraphQL, gRPC intercambiabili attorno) illustra la traiettoria di ricerca aperta. Le tesi che finiscono con uno schema architetturale delle future work ottengono maggiore credibilità sulle traiettorie indicate. Realizzabile in TikZ.

**Priorità: media.** Aggiunge pregio ma è l'ultima da fare se il tempo è limitato.

---

### Capitolo 7 — Conclusioni

**Nessuna figura o tabella necessaria.** Le conclusioni sintetizzano senza introdurre nuovi dati. Qualsiasi figura qui sarebbe una ripetizione di quanto già presentato.

---

## Riepilogo prioritizzato

| Priorità | ID | Capitolo | Sezione | Tipo | Descrizione sintetica |
|---|---|---|---|---|---|
| **Massima** | D | Cap. 3 | §3.2 | Figura TikZ | Architettura APIGuard (blocchi + Split State) |
| **Massima** | J | Cap. 5 | §5.1.1 | Figura TikZ | Topologia di rete del testbed |
| **Alta** | A | Cap. 2 | §2.3.1 | Tabella | Semantic Gap e visibilità strumenti (+ col. prerequisito) |
| **Alta** | B | Cap. 2 | §2.4.1 | Figura TikZ | Combinatorial wall (due vie) |
| **Alta** | C | Cap. 2 | §2.4.3 | Tabella | Confronto paradigmi di testing |
| **Alta** | E | Cap. 3 | §3.2.2 | Figura TikZ | DAG con batch reali |
| **Alta** | F | Cap. 3 | §3.3 | Tabella | 8 domini con Box Gradient, priorità, stato M1 |
| **Alta** | G | Cap. 4 | §4.1 | Figura TikZ | UML Sequence: Error Isolation (D4.P3) |
| **Alta** | H | Cap. 4 | §4.3-4.4 | Figura TikZ | UML Class: gerarchia duale + Connector |
| **Alta** | K | Cap. 5 | §5.3.1 | Grafico PGFPlots | Distribuzione finding per test (barre) |
| **Alta** | L | Cap. 6 | §6.2.1 | Figura TikZ | Decision tree exit code CI/CD |
| **Media** | I | Cap. 4 | §4.6 | Flowchart TikZ | Sanitizzazione a imbuto (D4.P2) |
| **Media** | M | Cap. 6 | §6.3.2 | Figura TikZ | Piattaforma modulare (future work) |

---

**Come vuoi procedere?** Posso iniziare a generare il LaTeX per qualsiasi di queste figure o tabelle, nell'ordine che preferisci. La raccomandazione è iniziare dalla **Proposta D** (architettura) e dalla **Proposta J** (testbed), perché sono i due pilastri visivi su cui poggia l'intera comprensione del lavoro.