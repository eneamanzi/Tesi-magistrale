Ho ri-analizzato byte per byte l'intero corpus dei tuoi file LaTeX (`1-introduction.tex`, `2-background.tex`, `3-methodology.tex`, `4-implementation.tex`, `5-experiments.tex`, `6-discussion.tex`).

Confermo l'assoluta solidità della tua tesi. Per portarla a un livello di eccellenza tale da poterci estrarre un paper (dove lo spazio è limitato e la sintesi visiva è tutto), la strategia deve essere chirurgica: **nessuna immagine decorativa, solo diagrammi che formalizzano concetti o riducono il carico cognitivo del lettore**.

Ecco la roadmap definitiva e aggiornata, strutturata per capitoli, con **conferme**, **modifiche di tiro** e **nuovi inserimenti** emersi dalla rilettura profonda.

---

### Capitolo 2: Background e Stato dell'Arte

* **[NUOVO] Tabella: Tassonomia OWASP API Security e Semantic Gap**
* **Dove:** Sezione 2.3.1 (*Il Semantic Gap...*).
* **Cosa:** Una tabella che elenca le top vulnerabilità citate (BOLA API1, BFLA API5, Mass Assignment API3, SSRF API7). Colonne: *Vulnerabilità OWASP*, *Natura* (Sintattica/Semantica), *Visibilità WAF/DAST Tradizionale* (Cieco / Rilevabile).
* **Perché:** Il testo spiega benissimo perché il WAF non vede il BOLA, ma una tabella fissa il concetto per tutto il resto della tesi.


* **[CONFERMA] Figura: Il "Combinatorial Wall" e il Contract-Driven**
* **Dove:** Sezione 2.4.1.
* **Cosa:** Diagramma a due vie. Via A: Fuzzer Sintattico $\rightarrow$ Payload Invalidi $\rightarrow$ Rifiuto 400 Bad Request. Via B: Fuzzer OpenAPI $\rightarrow$ Payload Validi $\rightarrow$ Logica di Business Applicativa.


* **[MODIFICA] Tabella: Confronto tra i paradigmi di testing**
* **Dove:** Fine della Sezione 2.4.3.
* **Rispetto a prima:** Includi esplicitamente le colonne *Dipendenza dall'Oracolo* e *Riproducibilità*, che sono i due cardini su cui costruirai il Capitolo 3. Compara SAST, DAST (ZAP), Fuzzer OpenAPI (RESTler/Schemathesis) e APIGuard.



### Capitolo 3: Metodologia, Architettura e Principi di Design

* **[CONFERMA ASSOLUTA] Figura: Architettura di APIGuard Assurance**
* **Dove:** Inizio Sezione 3.2 (*Principi Fondamentali*) o subito prima.
* **Cosa:** Diagramma a blocchi. A sinistra gli input (`config.yaml`, `openapi.yaml`). Al centro l'Engine. A destra il target (Kong + Forgejo). In basso l'Evidence Store.
* **Dettaglio cruciale aggiunto:** Il blocco centrale DEVE mostrare visivamente lo *Split State* (D1.P3): un box con un lucchetto per il `TargetContext` (immutabile) e un box per il `TestContext` (mutabile, con i canali Token, Teardown e Shared Data).


* **[CONFERMA] Figura: Il Grafo Aciclico Diretto (DAG)**
* **Dove:** Sezione 3.2.2 (*Scheduling Basato su DAG...*).
* **Cosa:** Un grafo orientato. Mostra i nodi (es. `Test 1.1`, `Test 0.1`) raggruppati in un grande box chiamato "Batch/Phase A". Frecce che da `Test 1.1` puntano a `Test 1.4` e `Test 2.1` nel box "Batch/Phase B".
* **Perché:** Rende istantaneamente comprensibile il concetto di risoluzione topologica descritto nel testo.



### Capitolo 4: Implementazione

* **[NUOVO] UML Sequence Diagram: Il ciclo di vita di un'esecuzione (Fase 5)**
* **Dove:** Sezione 4.1 (*La Pipeline...*) o 4.2 (*Fail-Safe Error Isolation*).
* **Cosa:** Diagramma di sequenza UML. Attori: `Engine`, `BaseTest`, `SecurityClient`, `Target`. Mostra l'Engine che chiama `execute()`, il blocco `try/catch` interno al test che cattura un'eccezione imprevista e restituisce il `TestResult(ERROR)` all'Engine, dimostrando che l'Engine non si ferma mai.
* **Perché:** Le proprietà di Error Isolation (D4.P3) sono spiegate a testo, ma un Sequence Diagram è il formalismo accademico per eccellenza per dimostrare questo tipo di contratti tra classi.


* **[CONFERMA] UML Class Diagram: Gerarchia Duale e Connector**
* **Dove:** Tra la Sezione 4.3.1 e 4.4.1.
* **Cosa:** Albero di ereditarietà. Da una parte i test nativi, dall'altra `ExternalToolTest` che compone `BaseConnector`, che a sua volta si divide in Library e Subprocess.


* **[CONFERMA] Flowchart: La Sanitizzazione a Imbuto (D4.P2)**
* **Dove:** Sezione 4.6.2.
* **Cosa:** Un diagramma di flusso che mostra il "Raw Output" attraversare in sequenza 1. Key-pattern matching, 2. JWT detection, 3. Header prefix. E parallelo a questo, il validatore Pydantic per le transazioni native.



### Capitolo 5: Esperimenti

* **[CONFERMA ASSOLUTA] Figura: Topologia di Rete dell'Ambiente di Test**
* **Dove:** Sezione 5.1.1 (dove hai lasciato il commento `% TODO`).
* **Cosa:** Diagramma infrastrutturale. `apiguard-assurance` (host) $\rightarrow$ `Kong` (porte 8443, 8000, 8001) $\rightarrow$ `Forgejo` $\leftrightarrow$ `PostgreSQL`.
* **Perché:** Senza questa figura, un paper accademico viene rimbalzato perché manca la documentazione visiva dell'Experimental Setup.


* **[NUOVO] Grafico: Distribuzione dei Finding per Test/Dominio**
* **Dove:** Sezione 5.3.1 (*Analisi dei Risultati per Dominio*).
* **Cosa:** Un grafico a barre o un pie-chart (generato preferibilmente in PGFPlots o matplotlib esportato in PDF) che mostri visivamente la mole dei 98 finding. Spicca visivamente l'enorme blocco del Test 1.1 (74 finding) rispetto agli altri.
* **Perché:** Le tabelle con i numeri ci sono già (Tabella 5.3), ma un grafico dà la proporzione immediata di *dove* si concentrano le vulnerabilità in un ambiente reale (Auth vs Hardening vs Disponibilità).



### Capitolo 6: Discussione e Sviluppi Futuri

* **[CONFERMA] Diagramma Decisionale (Decision Tree): Integrazione CI/CD**
* **Dove:** Sezione 6.2.1 (*Semantic Exit Codes...*).
* **Cosa:** Diagramma di un nodo di pipeline. Runner CI/CD $\rightarrow$ Esegue `apiguard run`. Switch a 4 vie per gli exit codes (0, 1, 2, 10) e relative azioni di automazione (es. blocco merge, alert Slack).


* **[NUOVO] Figura Concettuale: Evoluzione a Piattaforma Modulare**
* **Dove:** Sezione 6.3.2 (*Traiettorie di Ricerca Aperta -> APIGuard come piattaforma modulare*).
* **Cosa:** Un diagramma "Core + Plugins". Al centro l'infrastruttura immutabile (Engine, DAG, Store), attorno i moduli intercambiabili (REST/OAS, GraphQL, gRPC).
* **Perché:** I paper finiscono spesso illustrando le "Future Works" con uno schema architetturale di come il sistema evolverà per accogliere i nuovi protocolli.



### Sintesi finale

Le priorità assolute, se hai tempo limitato per disegnare, sono:

1. **L'architettura del sistema (Cap. 3)**.
2. **Il Class Diagram delle interfacce (Cap. 4)**.
3. **La topologia del testbed (Cap. 5)**.

Il resto aggiunge grandissimo pregio accademico, ma questi tre sono i pilastri visivi che trasformeranno una tesi "solo testo" in un lavoro pronto per la pubblicazione scientifica.