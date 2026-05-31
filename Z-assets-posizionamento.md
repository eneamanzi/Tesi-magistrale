# Guida Operativa: Figure e Tabelle della Tesi

**Versione:** analisi completa post-lettura integrale di tutti i capitoli  
**Asset totali proposti in z-assets.tex:** 16 (3 tabelle + 13 figure)  
**Verdetto complessivo:** 14 INCLUDI · 0 ESCLUDI · 2 DISCUTI  

---

## Indice rapido

| Label | Tipo | Capitolo | Verdetto |
|---|---|---|---|
| `tab:semantic-gap` | Tabella | Cap. 2 §2.3.1 | INCLUDI (ctrl+F corretto) |
| `tab:testing-comparison` | Tabella | Cap. 2 §2.4.3 | INCLUDI |
| `tab:domini-box-gradient` | Tabella | Cap. 3 §3.3.1 | DISCUTI (sovrapposizione) |
| `fig:combinatorial-wall` | Figura | Cap. 2 §2.4.1 | INCLUDI |
| `fig:architettura-apiguard` | Figura | Cap. 3 §3.2 | INCLUDI (essenziale) |
| `fig:dag-topology` | Figura | Cap. 3 §3.2.2 | INCLUDI |
| `fig:sequence-error-isolation` | Figura | Cap. 4 §subsec:fail-safe | INCLUDI |
| `fig:class-hierarchy` | Figura | Cap. 4 §subsec:dual-hierarchy | INCLUDI |
| `fig:sanitization-funnel` | Figura | Cap. 4 §subsec:sanitization | INCLUDI |
| `fig:testbed-topology` | Figura | Cap. 5 §sec:testbed | INCLUDI (TODO presente) |
| `fig:finding-distribution` | Figura | Cap. 5 §sec:coverage-idempotenza | DISCUTI (ridondanza) |
| `fig:cicd-decision-tree` | Figura | Cap. 6 §subsec:exit-codes | INCLUDI |
| `fig:modular-platform` | Figura | Cap. 6 §subsec:ricerca-aperta | INCLUDI |
| `fig:coverage-map` | Figura | Cap. 5 §subsec:analisi-domini | INCLUDI |
| `fig:testcontext-channels` | Figura | Cap. 4 §subsec:split-state-impl | INCLUDI |
| `fig:exception-hierarchy` | Figura | Cap. 4 §subsec:exception-hierarchy | INCLUDI |

---

## Note metodologiche sulla lettura

Prima di entrare nel dettaglio di ogni asset, alcune osservazioni trasversali emerse dalla lettura integrale dei capitoli.

Il capitolo 5 contiene un commento TODO esplicito alla riga 44 del file 5-experiments.tex: `% TODO: inserire figura con diagramma architetturale del testbed` che corrisponde esattamente a `fig:testbed-topology`. Questo asset ha priorità assoluta di inserimento.

Il capitolo 2 termina bruscamente alla descrizione di Schemathesis, senza alcuna sintesi comparativa dei paradigmi esaminati. `tab:testing-comparison` risolve questa mancanza e deve essere trattata come elemento strutturale, non decorativo.

Il capitolo 3, sezione `sec:architettura`, introduce i componenti dell'engine in prosa senza nessun supporto visivo. `fig:architettura-apiguard` è l'unica visualizzazione di alto livello del sistema e la sua assenza si avverte nella lettura.

I due asset indicati come DISCUTI non vengono esclusi a priori: la raccomandazione è che si discuta la posizione prima di inserirli, per evitare ridondanza con materiale tabellare già presente nel testo.

---

## Formato delle schede

Per ogni asset vengono fornite le seguenti informazioni:

- **Valore aggiunto:** perché l'asset merita un posto nella tesi
- **Posizione del blocco:** i due testi da cercare con Ctrl+F nel file .tex corrispondente per individuare il punto esatto di inserimento (il blocco LaTeX va inserito TRA i due testi)
- **File .tex di riferimento:** il file in cui effettuare la ricerca
- **Posizione del riferimento nel testo:** dove inserire il comando `\ref{}` nel corpo del testo, con le parole circostanti
- **Modifica consigliata al testo:** la frase esatta da aggiungere o modificare per introdurre il riferimento
- **Note:** osservazioni su sovrapposizioni, conflitti con ctrl+F originale, o avvertenze

---

---

# TABELLE

---

## `tab:semantic-gap` — Tassonomia OWASP API Security Top 10

**Verdetto:** INCLUDI  
**Capitolo target:** 2 — Background, §`subsec:semantic-gap`  
**Proprietà collegata:** nessuna proprietà APIGuard diretta; inquadramento dello stato dell'arte

### Valore aggiunto

Il testo di §2.3.1 descrive BOLA, Broken Auth, BOPLA, BFLA e SSRF in prosa distribuita tra due sottosezioni. La tabella li raccoglie in un'unica vista strutturata che aggiunge due colonne assenti nel testo: la visibilità degli strumenti tradizionali (WAF/DAST) e il prerequisito informativo necessario alla rilevazione. Questa combinazione rende immediato il divario semantico che il capitolo vuole argomentare e prepara il terreno per il box gradient nel capitolo successivo.

**Avvertenza:** il ctrl+F indicato nel file z-assets.tex ("La transizione verso architetture a microservizi ha spostato il baricentro delle vulnerabilità") non corrisponde a nessuna stringa presente nel file 2-background.tex. I ctrl+F corretti sono quelli indicati di seguito.

### Posizione del blocco (Ctrl+F)

**File:** `2-background.tex`

**TESTO PRIMA** (cerca questa stringa nel file):
```
richiesta sintatticamente corretta che viola le assunzioni del sistema sull'identità, i privilegi o il comportamento atteso del chiamante.
```

**TESTO DOPO** (il blocco va inserito tra le due stringhe):
```
Colmare il semantic gap richiede che lo strumento disponga di una rappresentazione formale
```

### Posizione del riferimento nel testo

Il riferimento deve essere inserito nella stessa frase che descrive le categorie OWASP, che attualmente recita:

> "...le prime categorie di rischio, tra cui Broken Object Level Authorization (API1), Broken Authentication (API2), Broken Object Property Level Authorization (API3) e Broken Function Level Authorization (API5), sono tutte vulnerabilità semantiche."

**Modifica consigliata:** aggiungere prima del punto finale della frase:

```latex
, come sintetizzato nella Tabella~\ref{tab:semantic-gap}
```

Risultato: "...sono tutte vulnerabilità semantiche, come sintetizzato nella Tabella~\ref{tab:semantic-gap}."

---

## `tab:testing-comparison` — Confronto paradigmi di security testing

**Verdetto:** INCLUDI  
**Capitolo target:** 2 — Background, fine §`subsec:contract-driven`  
**Proprietà collegata:** nessuna proprietà APIGuard diretta; sintesi dello stato dell'arte

### Valore aggiunto

Il capitolo 2 termina alla riga 174 del file con la descrizione di Schemathesis, senza nessuna chiusura sintetica. La tabella confronta SAST, DAST (ZAP), Fuzzer OAS (RESTler/Schemathesis) e APIGuard Assurance su quattro assi: conoscenza del contratto, oracle formale, riproducibilità e copertura semantica. Serve come punto di arrivo del capitolo, sintetizzando il percorso argomentativi da §2.4.1 a §2.4.3 e posizionando esplicitamente APIGuard nel panorama degli strumenti esaminati. L'ultima riga in grassetto che riguarda APIGuard riepiloga le proprietà che i capitoli successivi dimostrano in dettaglio.

### Posizione del blocco (Ctrl+F)

**File:** `2-background.tex`

**TESTO PRIMA:**
```
i verdetti dipendono dalle proprietà definite dall'utente, non da un oracolo derivato dal contratto dell'endpoint.
```

**TESTO DOPO:** fine del file (la tabella è l'ultimo elemento del capitolo)

### Posizione del riferimento nel testo

Aggiungere una frase di raccordo immediatamente dopo la fine del paragrafo su Schemathesis (ossia dopo "...non da un oracolo derivato dal contratto dell'endpoint."), prima della tabella stessa:

**Frase da aggiungere:**
```latex
La Tabella~\ref{tab:testing-comparison} sintetizza le differenze strutturali tra i paradigmi esaminati, riportando per ciascuno il tipo di conoscenza del contratto sfruttata, la disponibilità di un oracle formale e il livello di copertura semantica raggiungibile.
```

---

## `tab:domini-box-gradient` — Domini, Box Gradient e stato implementativo

**Verdetto:** DISCUTI  
**Capitolo target:** 3 — Metodologia, §`subsec:domini-tassonomia`

### Motivo della discussione

Nel capitolo 3, §3.3.1, sono già presenti due tabelle:

- `tab:domini`: elenca i 8 domini con titolo e ambito di verifica
- `tab:box-gradient`: elenca le 3 strategie con prerequisiti e razionale

La tabella proposta `tab:domini-box-gradient` aggiungerebbe una terza tabella nello stesso contesto, con colonne parzialmente sovrapposte (Dominio, Oggetto di verifica) e colonne nuove (Strategia per dominio, Priorità, Stato implementativo).

Il valore aggiunto concreto risiede nelle due colonne nuove: la colonna **Strategia** che associa ogni dominio alla sua strategia BLACK/GREY/WHITE (informazione non presente nelle due tabelle esistenti), e la colonna **Implementato** che indica lo stato di implementazione nella Milestone 1. Nessuna delle due tabelle esistenti fornisce questo mapping.

**Opzione A (preferita):** estendere `tab:domini` con le colonne Strategia e Implementato, eliminando la necessità di una terza tabella separata. Il costo è la revisione del codice LaTeX di `tab:domini` (già nel testo).

**Opzione B:** inserire `tab:domini-box-gradient` come proposto, accettando la presenza di tre tabelle nello stesso contesto. Il testo di raccordo deve esplicitare che questa è una vista integrata, non una ripetizione.

### Posizione del blocco (se si sceglie Opzione B)

**File:** `3-methodology.tex`

**TESTO PRIMA:**
```
Questa catena logica si riflette nelle dipendenze dichiarate dai singoli test che operano su questi domini, il cui meccanismo di risoluzione è descritto nella Sezione~\ref{subsec:dag}.
```

**TESTO DOPO:**
```
Domain-5 occupa una posizione particolare nella tassonomia: il dominio è architetturalmente predisposto
```

### Posizione del riferimento nel testo (se si sceglie Opzione B)

Aggiungere una frase di raccordo prima della tabella:

```latex
La Tabella~\ref{tab:domini-box-gradient} integra la vista precedente con la strategia operativa assegnata a ciascun dominio e lo stato di implementazione nella Milestone~1.
```

---

---

# FIGURE

---

## `fig:combinatorial-wall` — Il Combinatorial Wall

**Verdetto:** INCLUDI  
**Capitolo target:** 2 — Background, §`subsec:dast-sast`  
**Proprietà collegata:** nessuna proprietà APIGuard diretta; illustra il limite del fuzzing cieco

### Valore aggiunto

La figura mostra due percorsi paralleli: Via A (fuzzer sintattico, payload casuali, 400 Bad Request, logica invisibile) e Via B (engine contract-driven, payload validi dalla spec OAS, 2xx/4xx semantici, logica visibile). Illustra il concetto di "muro combinatorio" che il testo descrive alla riga 150 di 2-background.tex. Il capitolo 3, §3.2 (subsec:openapi-sot) fa riferimento esplicito a questo concetto con "come discusso nel Capitolo 2". La figura crea un aggancio visivo che il lettore ritrova al momento del riferimento incrociato.

### Posizione del blocco (Ctrl+F)

**File:** `2-background.tex`

**TESTO PRIMA:**
```
questo è il limite strutturale del fuzzing cieco applicato alle \gls{API} REST~\cite{MISSING:atlidakis:2019:restler}.
```

**TESTO DOPO:**
```
Quando invece il contratto è disponibile, la \gls{OAS} diventa la prima e più precisa fonte di conoscenza:
```

### Posizione del riferimento nel testo

Modificare la frase che descrive il problema del fuzzing cieco per aggiungere il riferimento alla figura:

**Testo originale:**
> "questo è il limite strutturale del fuzzing cieco applicato alle API REST~\cite{MISSING:atlidakis:2019:restler}."

**Testo modificato:**
```latex
questo è il limite strutturale del fuzzing cieco applicato alle \gls{API} REST~\cite{MISSING:atlidakis:2019:restler}, illustrato schematicamente nella Figura~\ref{fig:combinatorial-wall}.
```

---

## `fig:architettura-apiguard` — Architettura di alto livello APIGuard

**Verdetto:** INCLUDI (essenziale)  
**Capitolo target:** 3 — Metodologia, §`sec:architettura` (inizio)  
**Proprietà collegata:** D1.P3 Split State, D2.P2 DAG, D4.P1 EvidenceStore

### Valore aggiunto

Il capitolo 3 non contiene nessuna rappresentazione visiva dell'architettura complessiva. La sezione §3.2 introduce sette sottosezioni che descrivono componenti diversi (DAG, Split State, Gateway Adapter, EvidenceStore) senza mai mostrare come si relazionano tra loro. La figura mette in relazione config.yaml + OAS come input, TargetContext (frozen) + TestContext (mutable) + DAG Scheduler come engine, Kong + Forgejo come target, EvidenceStore come output. È l'unica vista d'insieme del sistema disponibile nel capitolo metodologico.

### Posizione del blocco (Ctrl+F)

**File:** `3-methodology.tex`

**TESTO PRIMA:**
```
Le proprietà discusse nella sezione precedente costituiscono la base del sistema. Le scelte di questa sezione si aggiungono ad esse, ciascuna rispondendo a un'esigenza architetturale specifica che le proprietà fondamentali lasciano aperta.
```

**TESTO DOPO:**
```
\subsection{Flusso di Dipendenze Monodirezionale (D1.P2)}\label{subsec:dep-flow}
```

### Posizione del riferimento nel testo

Modificare la prima frase della sezione §3.2 per aggiungere un rimando alla figura:

**Testo originale:**
> "Le proprietà discusse nella sezione precedente costituiscono la base del sistema."

**Testo modificato:**
```latex
Le proprietà discusse nella sezione precedente costituiscono la base del sistema, i cui componenti principali e le loro relazioni sono illustrati nella Figura~\ref{fig:architettura-apiguard}.
```

---

## `fig:dag-topology` — Topologia del DAG nell'assessment corrente

**Verdetto:** INCLUDI  
**Capitolo target:** 3 — Metodologia, §`subsec:dag`  
**Proprietà collegata:** D2.P2 DAG-Based Dependency Scheduling

### Valore aggiunto

La figura mostra la topologia concreta: Phase A (16 test senza dipendenze, in giallo) e Phase B (test 1.4 e 2.1 con `depends_on=["1.1"]`, in blu), con Phase C pianificata in grigio tratteggiato. Il testo descrive il meccanismo ma non lo istanzia visivamente nella topologia corrente. La distinzione cromatica tra le fasi rende immediatamente comprensibile il meccanismo di ordinamento topologico. Va notato che nel capitolo 5 esiste già `tab:dag-topology` che riporta gli stessi dati in forma tabellare come parte dei risultati sperimentali. Queste due risorse non sono ridondanti: la figura (capitolo 3) illustra il concetto architetturale, la tabella (capitolo 5) riporta i dati dell'assessment specifico.

### Posizione del blocco (Ctrl+F)

**File:** `3-methodology.tex`

**TESTO PRIMA:**
```
Salvaguardia contro lo stallo: se il grafo risulta ancora attivo ma non riesce a estrarre nessun test pronto, il sistema emette un errore strutturato che elenca i test mai schedulati e interrompe l'esecuzione in modo controllato, fornendo all'operatore la diagnostica necessaria senza dover ricostruire lo stato interno del grafo.
```

**TESTO DOPO:**
```
L'ordinamento topologico puro non garantisce un ordine unico tra test pronti allo stesso livello:
```

### Posizione del riferimento nel testo

Aggiungere una frase di raccordo subito prima della figura (la frase diventa anche il testo di raccordo tra l'elenco delle proprietà e la figura):

```latex
La topologia del \gls{DAG} nell'assessment di validazione, con le due fasi di esecuzione risultanti, è illustrata nella Figura~\ref{fig:dag-topology}.
```

**Nota:** questa frase va inserita come ultimo elemento dell'itemize (o subito dopo la chiusura del blocco itemize), prima della figura stessa.

---

## `fig:sequence-error-isolation` — Ciclo di vita di un test con error isolation

**Verdetto:** INCLUDI  
**Capitolo target:** 4 — Implementazione, §`subsec:fail-safe`  
**Proprietà collegata:** D4.P3 Fail-Safe Error Isolation

### Valore aggiunto

La sezione subsec:fail-safe descrive due scenari in prosa: il ciclo normale (execute → request → HTTP response → TestResult(PASS/FAIL)) e lo scenario di eccezione (eccezione catturata internamente → TestResult(ERROR), pipeline prosegue). Il sequence diagram mostra i due scenari separati da una linea di demarcazione visiva, con i quattro attori (Engine, BaseTest, SecurityClient, Target). Il valore aggiunto rispetto alla prosa è la visualizzazione del confine esatto di responsabilità tra l'engine e il test, che è il punto architetturalmente più sottile della sezione.

### Posizione del blocco (Ctrl+F)

**File:** `4-implementation.tex`

**TESTO PRIMA:**
```
La solidità complessiva del sistema non è condizionata dalla correttezza di nessun singolo test.
```

**TESTO DOPO:**
```
\subsection{Gerarchia delle Eccezioni con Phase Mapping (D4.P4)}\label{subsec:exception-hierarchy}
```

### Posizione del riferimento nel testo

Modificare l'ultima frase di subsec:fail-safe per aggiungere il riferimento:

**Testo originale:**
> "La solidità complessiva del sistema non è condizionata dalla correttezza di nessun singolo test."

**Testo modificato:**
```latex
La solidità complessiva del sistema non è condizionata dalla correttezza di nessun singolo test, come illustrato dal sequence diagram in Figura~\ref{fig:sequence-error-isolation}.
```

---

## `fig:class-hierarchy` — Gerarchia duale BaseTest/ExternalToolTest e connettori

**Verdetto:** INCLUDI  
**Capitolo target:** 4 — Implementazione, §`subsec:dual-hierarchy` (fine)  
**Proprietà collegata:** D1.P4 Dual Test Hierarchy, D1.P5 Three-Tier Connector Hierarchy

### Valore aggiunto

La sezione subsec:dual-hierarchy descrive in prosa tre gerarchie distinte: BaseTest con i test nativi, ExternalToolTest con i test esterni, BaseConnector con BaseLibraryConnector/BaseSubprocessConnector e le implementazioni concrete. Il diagramma UML le rende visibili in un'unica vista, con le relazioni di ereditarietà (open triangle arrow) e di composizione (diamond arrow) tra ExternalToolTest e BaseConnector. Questa è esattamente la tipologia di informazione per cui i diagrammi di classe UML sono lo strumento convenzionale nelle pubblicazioni accademiche di architettura software.

### Posizione del blocco (Ctrl+F)

**File:** `4-implementation.tex`

**TESTO PRIMA:**
```
Il campo \texttt{TestResult.source} con tipo \texttt{Literal["native",~"external"]} propaga la distinzione fino al report, dove i risultati nativi e quelli di tool specializzati vengono riportati con sezioni visivamente distinte all'interno dello stesso dominio.
```

**TESTO DOPO:**
```
\subsection{Invarianti di \texttt{TestResult} a Livello di Tipo (D4.P9)}\label{subsec:testresult-invariants}
```

### Posizione del riferimento nel testo

Aggiungere una frase di raccordo subito prima della figura (tra la fine della descrizione della gerarchia duale e l'inizio della sottosezione sugli invarianti):

```latex
La struttura complessiva delle tre gerarchie è illustrata nel diagramma di Figura~\ref{fig:class-hierarchy}.
```

---

## `fig:sanitization-funnel` — Sanitizzazione a imbuto in tre stadi

**Verdetto:** INCLUDI  
**Capitolo target:** 4 — Implementazione, §`subsec:sanitization`  
**Proprietà collegata:** D4.P2 Evidence Sanitization

### Valore aggiunto

La sezione subsec:sanitization descrive i tre stadi della sanitizzazione in un elenco numerato: key-pattern matching, JWT heuristic, header prefix matching. Il diagramma a imbuto aggiunge due informazioni non presenti nella prosa: il percorso del flusso dati attraverso i tre stadi in sequenza (con routing esplicito dei record che fanno match verso [REDACTED] e dei record puliti che proseguono), e la struttura visiva che evidenzia la natura "a cascata" del presidio. La sovrapposizione dei tre meccanismi, che la prosa descrive come copertura complementare, diventa immediatamente leggibile nel diagramma.

### Posizione del blocco (Ctrl+F)

**File:** `4-implementation.tex`

**TESTO PRIMA:**
```
intercettando i token che compaiono nei valori di header \gls{HTTP} inclusi nei record di evidenza.
```
(Questa è la fine del terzo item dell'enumerate, che descrive l'header prefix matching)

**TESTO DOPO:**
```
La sovrapposizione dei tre meccanismi copre scenari che nessuno dei tre individualmente intercetterebbe:
```

### Posizione del riferimento nel testo

Modificare il testo di raccordo che precede la lista dei tre stadi per includere il riferimento alla figura. La frase di raccordo si trova prima dell'enumerate block:

**Testo originale:**
> "...applica tre tecniche in sequenza sul dizionario `raw_output` grezzo :"

**Testo modificato:**
```latex
...applica tre tecniche in sequenza sul dizionario \texttt{raw\_output} grezzo, illustrate nella Figura~\ref{fig:sanitization-funnel}:
```

---

## `fig:testbed-topology` — Topologia dell'ambiente di validazione

**Verdetto:** INCLUDI (obbligatorio, TODO esplicito presente nel file)  
**Capitolo target:** 5 — Esperimenti, §`subsec:architettura-testbed`  
**Proprietà collegata:** nessuna proprietà diretta; descrive l'infrastruttura sperimentale

### Valore aggiunto

Il file 5-experiments.tex contiene alla riga 44 il commento:

```
% TODO: inserire figura con diagramma architetturale del testbed (Kong, Forgejo, PostgreSQL, tool, lab-net, porte)
```

Questo commento descrive esattamente `fig:testbed-topology`. L'inserimento è già pianificato nel file sorgente. La figura mostra: Host (apiguard-assurance) in arancione, Kong 3.9 con le tre porte (:8000, :8443, :8001) in blu, Forgejo 14.0.3 in verde, PostgreSQL come backend, utenti RBAC con i tre account (thesis-admin, user-a, user-b) nel network Docker Compose. Senza questa figura il testbed è descritto solo in `tab:versioni-testbed` e nella prosa, senza alcuna rappresentazione delle connessioni tra componenti.

### Posizione del blocco (Ctrl+F)

**File:** `5-experiments.tex`

**TESTO PRIMA:**
```
La scelta conferma inoltre in modo concreto l'agnosticismo applicativo discusso nella Sezione~\ref{subsec:agnosticismo}: il tool non contiene nessun riferimento specifico a Forgejo: cambiare target significa aggiornare i valori nel \texttt{config.yaml} (URL del gateway, percorso della specifica, path seed, credenziali), non modificare il codice.
```

**TESTO DOPO:**
```
\subsection{Composizione e Connettività dell'Ambiente di Test}\label{subsec:architettura-testbed}
```

**Nota:** il commento TODO alla riga 44 si trova dentro la sottosezione subsec:architettura-testbed. Il blocco figura va inserito PRIMA della sezione heading (nella sezione sec:testbed, prima dell'inizio della prima sottosezione), oppure si può rimuovere il commento TODO e inserire la figura esattamente al suo posto (riga 44), che è all'interno di subsec:architettura-testbed dopo il primo paragrafo.

**Posizione alternativa (più precisa, sostituisce il TODO):**

**TESTO PRIMA (alternativa):**
```
% TODO: inserire figura con diagramma architetturale del testbed (Kong, Forgejo, PostgreSQL, tool, lab-net, porte)
```

**TESTO DOPO (alternativa):**
```
\begin{table}[ht]
```
(che è il codice di `tab:versioni-testbed`)

### Posizione del riferimento nel testo

Nella prosa di subsec:architettura-testbed, modificare la frase che descrive i quattro servizi del network Docker:

**Testo originale:**
> "L'ambiente di test è composto da quattro servizi che comunicano all'interno di un network Docker dedicato (`lab-net`):"

**Testo modificato:**
```latex
L'ambiente di test è composto da quattro servizi che comunicano all'interno di un network Docker dedicato (\texttt{lab-net}), come illustrato nella Figura~\ref{fig:testbed-topology}:
```

---

## `fig:finding-distribution` — Distribuzione dei 98 finding per test

**Verdetto:** DISCUTI  
**Capitolo target:** 5 — Esperimenti, §`sec:coverage-idempotenza`

### Motivo della discussione

Nel capitolo 5 è già presente `tab:risultati-per-test` (righe 304-342 di 5-experiments.tex) che riporta, per ciascuno dei 18 test: Test ID, Dominio, Tipo (Nativo/Esterno), Status (PASS/FAIL/SKIP) e Finding count. La tabella è completa e comprende tutti i test, non solo quelli che hanno prodotto finding.

Il grafico a barre proposto mostra la distribuzione dei finding solo per i 7 test che hanno prodotto almeno un finding (0.1: 16, 0.2: 1, 4.1: 2, 7.2: 1, 1.1: 74, ext.sslyze: 1, ext.testssl: 3), visualizzando la dominanza di test 1.1 (74 finding su 98 totali).

**Ridondanza:** i dati del grafico sono un sottoinsieme di quelli già presenti in `tab:risultati-per-test`. Il valore aggiunto specifico del grafico è la visualizzazione immediata della distribuzione disomogenea (1.1 produce il 75.5% dei finding). Questo punto è già argomentato nel testo alla riga 349: "Il test~1.1 da solo produce 74 dei 98 finding totali (75.5%)".

**Domanda da prendere in considerazione:** il grafico aggiunge abbastanza oltre la tabella e la prosa per giustificare la sua presenza? In contesti di pubblicazione accademica, la presenza di un grafico e di una tabella con gli stessi dati richiede che ognuno dei due apporti qualcosa che l'altro non può offrire. In questo caso la tabella è più informativa (copre tutti i 18 test), mentre il grafico è più immediato visivamente per la distribuzione.

**Opzione A:** mantenere solo `tab:risultati-per-test` (già presente), senza aggiungere `fig:finding-distribution`.

**Opzione B:** inserire `fig:finding-distribution` e aggiungere un riferimento esplicito alla dominanza di test 1.1 che la tabella non rende visivamente immediata.

### Posizione del blocco (se si sceglie Opzione B)

**File:** `5-experiments.tex`

**TESTO PRIMA:**
```
Prima di analizzare i risultati per dominio, è utile presentare una lettura trasversale dei tre esiti.
```

**TESTO DOPO:**
```
I 7 \texttt{FAIL}, con il dettaglio dei finding per test nella Tabella~\ref{tab:risultati-per-test}
```

### Posizione del riferimento nel testo (se si sceglie Opzione B)

```latex
La Figura~\ref{fig:finding-distribution} illustra la distribuzione disomogenea dei 98 finding: il test~1.1 da solo ne produce 74 (75,5\%), una concentrazione che la lettura per dominio nella Sezione~\ref{subsec:analisi-domini} interpreta nel contesto del contratto OpenAPI di Forgejo.
```

---

## `fig:cicd-decision-tree` — Routing degli exit code nella pipeline CI/CD

**Verdetto:** INCLUDI  
**Capitolo target:** 6 — Discussione, §`subsec:exit-codes`  
**Proprietà collegata:** D6.P1 Semantic Exit Codes

### Valore aggiunto

La sezione subsec:exit-codes descrive i quattro exit code (0 CLEAN, 1 FAIL, 2 ERROR, 10 INFRA) e le loro azioni corrispondenti nella pipeline. Il diagramma aggiunge la dimensione visiva del decision tree: Runner CI/CD → apiguard run → exit code → azione. I quattro percorsi colorati (verde, rosso, arancio, grigio) rendono il routing immediatamente leggibile da un lettore con background DevOps/DevSecOps. Il diagramma è particolarmente utile per una sezione che ha applicabilità pratica diretta nei team di sviluppo.

### Posizione del blocco (Ctrl+F)

**File:** `6-discussion.tex`

**TESTO PRIMA:**
```
Con codici semanticamente distinti questo routing è automatizzabile senza leggere i log.
```

**TESTO DOPO:**
```
Sistemi di \gls{CI/CD} come GitHub Actions o GitLab \gls{CI}
```

### Posizione del riferimento nel testo

Modificare la frase di chiusura del paragrafo sui codici per aggiungere il riferimento:

**Testo originale:**
> "Con codici semanticamente distinti questo routing è automatizzabile senza leggere i log."

**Testo modificato:**
```latex
Con codici semanticamente distinti questo routing è automatizzabile senza leggere i log, come schematizzato nella Figura~\ref{fig:cicd-decision-tree}.
```

---

## `fig:modular-platform` — Evoluzione verso piattaforma modulare

**Verdetto:** INCLUDI  
**Capitolo target:** 6 — Discussione, §`subsec:ricerca-aperta`, paragrafo "APIGuard come piattaforma modulare"  
**Proprietà collegata:** D2.P1 Dynamic Test Discovery (pkgutil)

### Valore aggiunto

La figura mostra la visione architetturale del sistema come piattaforma a stella: Core (Engine, DAG Scheduler, EvidenceStore) al centro, REST/OAS come modulo attivo (freccia continua), GraphQL/gRPC/WebSocket come moduli pianificati (frecce tratteggiate). È una figura di "future work" che illustra il modello di estensibilità, appropriata per la sezione sulle traiettorie di ricerca. La distinzione visiva tra frecce continue e tratteggiate comunica immediatamente lo stato di implementazione di ciascun modulo. Il testo alla riga 155 di 6-discussion.tex descrive esattamente questa architettura in prosa; la figura la rende navigabile in un colpo d'occhio.

### Posizione del blocco (Ctrl+F)

**File:** `6-discussion.tex`

**TESTO PRIMA:**
```
garantendo che i finding prodotti da moduli distinti siano confrontabili nel report finale.
```

**TESTO DOPO:**
```
\paragraph{Coverage augmentation progressiva.}
```

### Posizione del riferimento nel testo

Nella descrizione del paragrafo "APIGuard come piattaforma modulare", aggiungere il riferimento alla figura verso la fine del paragrafo, dopo la descrizione dell'architettura a stella:

```latex
La Figura~\ref{fig:modular-platform} illustra l'architettura a stella risultante, con il core invariato e i moduli di protocollo come unità intercambiabili.
```

**Nota:** la frase va inserita prima dell'elenco delle "sfide di ricerca principali" (l'ultima parte del paragrafo), non alla fine assoluta.

---

## `fig:coverage-map` — Mappa di copertura dell'assessment di validazione

**Verdetto:** INCLUDI  
**Capitolo target:** 5 — Esperimenti, §`subsec:analisi-domini` (inizio)  
**Proprietà collegata:** D3.P3 Box Gradient

### Valore aggiunto

La figura combina tre dimensioni in un'unica vista: dominio di assurance (riga), Box Gradient strategy (indicata nell'intestazione di ciascun dominio), test attivi per dominio (nodi colorati per esito PASS/FAIL/SKIP), con i test esterni in corsivo. Nessuna delle tabelle già presenti nel capitolo 5 fornisce questa vista combinata: `tab:risultati-per-test` ordina i test sequenzialmente senza il raggruppamento per dominio visivo, `tab:idempotenza-kpi` mostra i totali aggregati. La mappa è lo strumento di riferimento per la lettura per dominio che segue immediatamente in `subsec:analisi-domini`, e ne riduce la necessità di testo descrittivo prolisso.

### Posizione del blocco (Ctrl+F)

**File:** `5-experiments.tex`

**TESTO PRIMA:**
```
\subsection{Analisi dei Risultati per Dominio}\label{subsec:analisi-domini}
```

**TESTO DOPO:**
```
L'assessment ha prodotto 98 finding distribuiti su 7 \texttt{FAIL}, 9 \texttt{PASS} e 2 \texttt{SKIP}
```

### Posizione del riferimento nel testo

Aggiungere una frase di raccordo immediatamente dopo l'heading della sottosezione (prima della prima frase della prosa):

```latex
La Figura~\ref{fig:coverage-map} riporta la mappa di copertura dell'assessment di validazione, con il raggruppamento per dominio, la strategia Box Gradient associata e l'esito di ciascun test.
```

---

## `fig:testcontext-channels` — Tre canali tipizzati del TestContext

**Verdetto:** INCLUDI  
**Capitolo target:** 4 — Implementazione, §`subsec:split-state-impl` (fine)  
**Proprietà collegata:** D1.P3 Split State e Immutabilità

### Valore aggiunto

La sezione subsec:split-state-impl descrive il TestContext attraverso i suoi tre canali tipizzati: token (con le costanti ROLE_ADMIN, ROLE_USER_A, ROLE_USER_B), teardown (registrazione LIFO e drain order), shared data (convenzione di naming `{test_id}.{nome_dato}`). La figura mostra questi tre canali affiancati con le rispettive API, le chiavi costanti per il canale token, il pattern di naming per il canale shared, e la fase del ciclo di vita (Fase 5 e Fase 6) in cui ciascun canale è attivo. È il complemento naturale alla descrizione della sezione: il TestContext come singolo "contenitore mutabile" diventa intelligibile come struttura a tre canali distinti.

### Posizione del blocco (Ctrl+F)

**File:** `4-implementation.tex`

**TESTO PRIMA:**
```
il canale dati condivisi permette a test in batch successivi di consumare risultati prodotti da batch precedenti tramite \texttt{set\_shared}/\texttt{get\_shared}, con la convenzione \texttt{"\{test\_id\}.\{nome\_dato\}"} che rende esplicito quale test ha prodotto ogni valore.
```

**TESTO DOPO:**
```
\section{Discovery Dinamico e Risoluzione del Grafo}\label{sec:discovery-dag}
```

### Posizione del riferimento nel testo

Aggiungere una frase di chiusura della sottosezione subsec:split-state-impl, dopo la descrizione del terzo canale e prima della figura stessa:

```latex
La Figura~\ref{fig:testcontext-channels} illustra la struttura interna del \texttt{TestContext} con i tre canali tipizzati, le rispettive \gls{API} di accesso e la corrispondenza con le fasi del ciclo di vita dell'engine.
```

---

## `fig:exception-hierarchy` — Gerarchia delle 11 eccezioni custom

**Verdetto:** INCLUDI  
**Capitolo target:** 4 — Implementazione, §`subsec:exception-hierarchy` (dopo `tab:exception-hierarchy`)  
**Proprietà collegata:** D4.P4 Exception Hierarchy

### Valore aggiunto

Nel capitolo 4 è già presente `tab:exception-hierarchy` (righe 205-237 di 4-implementation.tex) che elenca le 11 classi in forma tabellare piatta con: classe, file di definizione, comportamento. La figura aggiunge la dimensione gerarchica che la tabella non può rappresentare: l'albero con `ToolBaseError` come radice, tre categorie colorate (bloccanti in rosso fasi 1-4, recuperate in arancio fasi 5-6, CLI in grigio), con ramificazioni verso le 11 foglie. La distinzione cromatica è l'elemento che trasforma una lista piatta in un modello mentale utilizzabile per la comprensione dell'architettura di gestione degli errori. Le due risorse sono complementari, non ridondanti: la tabella fornisce le informazioni di dettaglio, la figura fornisce la struttura.

### Posizione del blocco (Ctrl+F)

**File:** `4-implementation.tex`

**TESTO PRIMA:**
```
  \caption{Gerarchia delle eccezioni custom (Fasi 1--4 bloccanti; Fasi 5--6 recuperate localmente).}
  \label{tab:exception-hierarchy}
\end{table}
```

**TESTO DOPO:**
```
La prima scelta che riflette una decisione di design consapevole e non un vincolo tecnico, riguarda la collocazione di \texttt{GatewayAdapterError}
```

### Posizione del riferimento nel testo

Modificare la frase che introduce `tab:exception-hierarchy` nel testo per aggiungere anche il riferimento alla figura:

**Testo originale:**
> "...riportate nella Tabella~\ref{tab:exception-hierarchy} con la relativa fase."

**Testo modificato:**
```latex
...riportate nella Tabella~\ref{tab:exception-hierarchy} con la relativa fase, la cui struttura gerarchica è illustrata nella Figura~\ref{fig:exception-hierarchy}.
```

---

---

# RIEPILOGO FINALE

## Asset da inserire senza discussione (14)

| Label | File .tex | Posizione | Azione richiesta |
|---|---|---|---|
| `tab:semantic-gap` | 2-background.tex | Dopo OWASP paragraph §2.3.1 | Inserire; correggere ctrl+F |
| `tab:testing-comparison` | 2-background.tex | Fine capitolo 2 | Inserire; aggiungere frase di raccordo |
| `fig:combinatorial-wall` | 2-background.tex | Dopo "limite strutturale fuzzing cieco" §2.4.1 | Inserire; modificare frase finale |
| `fig:architettura-apiguard` | 3-methodology.tex | Inizio §sec:architettura | Inserire; modificare prima frase |
| `fig:dag-topology` | 3-methodology.tex | Dopo itemize correttezza strutturale §subsec:dag | Inserire; aggiungere frase di raccordo |
| `fig:sequence-error-isolation` | 4-implementation.tex | Fine §subsec:fail-safe | Inserire; modificare ultima frase |
| `fig:class-hierarchy` | 4-implementation.tex | Fine §subsec:dual-hierarchy | Inserire; aggiungere frase di raccordo |
| `fig:sanitization-funnel` | 4-implementation.tex | Tra enumerate e "sovrapposizione tre meccanismi" §subsec:sanitization | Inserire; modificare frase intro enumerate |
| `fig:testbed-topology` | 5-experiments.tex | Sostituire commento TODO §subsec:architettura-testbed | Inserire; modificare prima frase subsec |
| `fig:coverage-map` | 5-experiments.tex | Inizio §subsec:analisi-domini | Inserire; aggiungere frase di raccordo |
| `fig:testcontext-channels` | 4-implementation.tex | Fine §subsec:split-state-impl | Inserire; aggiungere frase di chiusura |
| `fig:exception-hierarchy` | 4-implementation.tex | Dopo `tab:exception-hierarchy` §subsec:exception-hierarchy | Inserire; modificare frase con \ref |
| `fig:cicd-decision-tree` | 6-discussion.tex | Dopo "routing automatizzabile senza log" §subsec:exit-codes | Inserire; modificare ultima frase |
| `fig:modular-platform` | 6-discussion.tex | Fine paragrafo "APIGuard come piattaforma modulare" §subsec:ricerca-aperta | Inserire; aggiungere frase di raccordo |

## Asset da discutere prima dell'inserimento (2)

| Label | Motivo | Raccomandazione |
|---|---|---|
| `tab:domini-box-gradient` | Terza tabella in §3.3.1, sovrapposizione con `tab:domini` e `tab:box-gradient` | Valutare se integrare le colonne "Strategia" e "Implementato" direttamente in `tab:domini` piuttosto che aggiungere una tabella separata |
| `fig:finding-distribution` | Ridondanza con `tab:risultati-per-test` già presente | Decidere se il valore visivo del grafico giustifica la presenza accanto alla tabella già esistente, oppure se mantenere solo la tabella |