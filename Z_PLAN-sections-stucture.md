# Scaletta Capitoli

- [1. Introduzione](#1-introduzione)
  - [1.1 Motivazione e Contesto](#11-motivazione-e-contesto)
  - [1.2 Definizione del Problema e Gaps nella Ricerca](#12-definizione-del-problema-e-gaps-nella-ricerca)
  - [1.3 Obiettivi della Ricerca](#13-obiettivi-della-ricerca)
  - [1.4 Organizzazione della Tesi](#14-organizzazione-della-tesi)
- [2. Background e Stato dell'Arte](#2-background-e-stato-dellarte)
  - [2.1 Paradigmi delle Architetture API Moderne](#21-paradigmi-delle-architetture-api-moderne)
    - [2.1.1 Evoluzione dei Sistemi Distribuiti](#211-evoluzione-dei-sistemi-distribuiti)
    - [2.1.2 Tassonomia degli Stili Architetturali e di Comunicazione](#212-tassonomia-degli-stili-architetturali-e-di-comunicazione)
    - [2.1.3 Il Fenomeno dell'API Sprawl](#213-il-fenomeno-dellapi-sprawl)
  - [2.2 Il Pattern dell'API Gateway in Ottica Zero-Trust](#22-il-pattern-dellapi-gateway-in-ottica-zero-trust)
    - [2.2.1 Analisi Comparativa dei Modelli di Esposizione in Rete](#221-analisi-comparativa-dei-modelli-di-esposizione-in-rete)
    - [2.2.2 Criteri di Selezione e Giustificazione Architetturale](#222-criteri-di-selezione-e-giustificazione-architetturale)
    - [2.2.3 Enforcing del Paradigma Zero-Trust](#223-enforcing-del-paradigma-zero-trust)
  - [2.3 Tassonomia delle Minacce e Vulnerabilità Logiche](#23-tassonomia-delle-minacce-e-vulnerabilità-logiche)
    - [2.3.1 Il Semantic Gap e l'Evoluzione del Panorama delle Minacce](#231-il-semantic-gap-e-levoluzione-del-panorama-delle-minacce)
    - [2.3.2 Categorie di Fallimento Architetturale](#232-categorie-di-fallimento-architetturale)
    - [2.3.3 Dal Modello Teorico alla Necessità di Valutazione Strutturata](#233-dal-modello-teorico-alla-necessità-di-valutazione-strutturata)
  - [2.4 L'Evoluzione del Testing di Sicurezza: dall'Analisi Cieca ai Contratti](#24-levoluzione-del-testing-di-sicurezza-dallanalisi-cieca-ai-contratti)
    - [2.4.1 Paradigmi Tradizionali e i Limiti del DAST/SAST](#241-paradigmi-tradizionali-e-i-limiti-del-dastsast)
    - [2.4.2 Asimmetria Informativa e il "Box Gradient"](#242-asimmetria-informativa-e-il-box-gradient)
    - [2.4.3 Contract-Driven Security e Approcci Ibridi](#243-contract-driven-security-e-approcci-ibridi)
- [3. Metodologia, Architettura e Principi di Design](#3-metodologia-architettura-e-principi-di-design)
  - [3.1 Principi Fondamentali: il Perché delle Scelte Architetturali](#31-principi-fondamentali-il-perché-delle-scelte-architetturali)
  - [3.2 Architettura dell'Assessment Engine](#32-architettura-dellassessment-engine)
  - [3.3 Domini di Sicurezza e Box Gradient Applicato](#33-domini-di-sicurezza-e-box-gradient-applicato)
- [4. Implementazione](#4-implementazione)
  - [4.1 La Pipeline di Esecuzione a Sette Fasi e il Core Engine](#41-la-pipeline-di-esecuzione-a-sette-fasi-e-il-core-engine)
  - [4.2 Discovery Dinamico e Risoluzione del Grafo (DAG)](#42-discovery-dinamico-e-risoluzione-del-grafo-dag)
  - [4.3 Architettura dei Test Nativi e Contratto BaseTest (Domini 0-7)](#43-architettura-dei-test-nativi-e-contratto-basetest-domini-0-7)
  - [4.4 Gerarchia dei Connettori e Integrazione Tool Esterni](#44-gerarchia-dei-connettori-e-integrazione-tool-esterni)
  - [4.5 Implementazione del Gateway Adapter e Teardown LIFO](#45-implementazione-del-gateway-adapter-e-teardown-lifo)
  - [4.6 Evidence Store e Sanitizzazione delle Credenziali](#46-evidence-store-e-sanitizzazione-delle-credenziali)
- [5. Validazione Sperimentale e Risultati](#5-validazione-sperimentale-e-risultati)
  - [5.1 Topologia del Testbed Sperimentale (Forgejo + Kong)](#51-topologia-del-testbed-sperimentale-forgejo--kong)
  - [5.2 Release-Readiness e Integrità Architetturale](#52-release-readiness-e-integrità-architetturale)
  - [5.3 Copertura Funzionale e Idempotenza dell'Assessment](#53-copertura-funzionale-e-idempotenza-dellassessment)
  - [5.4 Footprint Computazionale e Benchmarking del DAG](#54-footprint-computazionale-e-benchmarking-del-dag)
- [6. Discussione e Sviluppi Futuri](#6-discussione-e-sviluppi-futuri)
  - [6.1 Analisi Critica e Limiti del Paradigma Contract-Driven](#61-analisi-critica-e-limiti-del-paradigma-contract-driven)
  - [6.2 Applicabilità Industriale e Integrazione DevSecOps](#62-applicabilità-industriale-e-integrazione-devsecops)
  - [6.3 Sviluppi Futuri (Prospettiva di Ricerca Dottorale)](#63-sviluppi-futuri-prospettiva-di-ricerca-dottorale)
    - [Roadmap Milestone 2 — Estensioni operative](#roadmap-milestone-2--estensioni-operative)
    - [Traiettorie di Ricerca Avanzata](#traiettorie-di-ricerca-avanzata)
- [7. Conclusioni](#7-conclusioni)
  - [7.1 Sintesi del Lavoro e Risoluzione del Problema Iniziale](#71-sintesi-del-lavoro-e-risoluzione-del-problema-iniziale)
  - [7.2 Contributi Scientifici e Ingegneristici](#72-contributi-scientifici-e-ingegneristici)
  - [7.3 Considerazioni Finali sull'Assurance Continuo](#73-considerazioni-finali-sullassurance-continuo)



## 1. Introduzione

TODO: checkare se i contenuti di queste sections sono adatti (lo facciamo come ultimo step in quanto è ultimo capitolo da scrivere)

### 1.1 Motivazione e Contesto
L'evoluzione verso architetture a microservizi cloud-native e la conseguente esposizione incontrollata della superficie di attacco delle API: contesto quantitativo del problema (crescita delle API esposte, dati di incident recenti su violazioni API) e introduzione della necessità di strumenti di assessment automatizzato.

### 1.2 Definizione del Problema e Gaps nella Ricerca
Analisi dei limiti intrinseci degli approcci attuali, identificati come tre gap distinti:

* **G1 — Cecità Semantica degli Scanner Tradizionali:** Gli scanner DAST operano sulla sintassi delle richieste HTTP, non sulla semantica dei contratti che quelle richieste dovrebbero rispettare. Vulnerabilità di tipo BOLA, SSRF applicativo e token revocation bypass non sono rilevabili da uno scanner che non conosce la business logic del target.
* **G2 — Assenza di Agnosticismo:** Gli strumenti esistenti di security assessment per API sono o altamente specifici per un vendor (es. strumenti Kong-only) o generici al punto da non sfruttare la specifica OpenAPI come oracolo. Non esiste un framework che combini agnosticismo applicativo con testing guidato dal contratto.
* **G3 — Mancanza di Riproducibilità Verificabile:** Il penetration testing tradizionale è point-in-time e manuale. Non esiste, nella letteratura e negli strumenti disponibili, un approccio che garantisca formalmente che lo stesso assessment, rieseguito sullo stesso target, produca output deterministicamente identico — prerequisito per l'integrazione in pipeline CI/CD come quality gate.

### 1.3 Obiettivi della Ricerca
La tesi risponde ai tre gap identificati attraverso i seguenti obiettivi di ricerca:

* **O1:** Progettare e implementare un framework di security assessment API che sia applicativo-agnostico (D1.P1), derivando tutta la conoscenza del target esclusivamente dalla specifica OpenAPI e dal file di configurazione, senza riferimenti hardcoded a nessun sistema specifico.
* **O2:** Dimostrare che un approccio contract-driven, che utilizza la specifica OpenAPI come oracolo formale, supera i limiti del fuzzing cieco nell'identificazione di vulnerabilità logiche e semantiche nelle API REST.
* **O3:** Garantire la riproducibilità deterministica dell'assessment (D3.P4) e validarla empiricamente, producendo un tool integrabile in pipeline CI/CD tramite semantic exit codes (D6.P1).

### 1.4 Organizzazione della Tesi
Panoramica logica dei capitoli successivi per guidare il lettore attraverso lo sviluppo del framework. Il Capitolo 2 stabilisce il background teorico e la tassonomia delle minacce. Il Capitolo 3 presenta la metodologia e le scelte architetturali. Il Capitolo 4 descrive l'implementazione. Il Capitolo 5 valida empiricamente il sistema. Il Capitolo 6 discute i limiti e le traiettorie future. Il Capitolo 7 conclude.

---

## 2. Background e Stato dell'Arte

### 2.1 Paradigmi delle Architetture API Moderne

#### 2.1.1 Evoluzione dei Sistemi Distribuiti
Il passaggio storico dalle architetture monolitiche enterprise ai pattern a microservizi disaccoppiati e poliglotti.

#### 2.1.2 Tassonomia degli Stili Architetturali e di Comunicazione
Rassegna critica e comparativa dei principali protocolli attuali:
* *REST (Representational State Transfer):* Paradigma stateless basato su risorse e verbi HTTP standard.
* *gRPC (Google Remote Procedure Call):* Comunicazione ad alte prestazioni basata su HTTP/2 e Protocol Buffers.
* *GraphQL:* Interrogazione flessibile guidata dal client tramite un singolo endpoint tipizzato.
* *SOAP (Simple Object Access Protocol):* Protocollo legacy fortemente strutturato basato su XML e contratti WSDL.
* *WebSocket e WebHooks:* Modelli di comunicazione bidirezionale persistente e pattern event-driven basati su callback asincrone.

#### 2.1.3 Il Fenomeno dell'API Sprawl
Definizione formale della proliferazione incontrollata degli endpoint, disallineamento della documentazione e nascita delle *Shadow* e *Deprecated APIs*.

---

### 2.2 Il Pattern dell'API Gateway in Ottica Zero-Trust

#### 2.2.1 Analisi Comparativa dei Modelli di Esposizione in Rete
Rassegna sistematica delle infrastrutture di routing e ingress attuali:
* *Kubernetes Ingress e Gateway API:* Gestione nativa del traffico e astrazione dei layer di routing nei cluster containerizzati.
* *Service Mesh e Sidecar Proxy:* Micro-segmentazione del traffico est-ovest, osservabilità profonda inter-servizio e mutua autenticazione (mTLS).
* *Serverless Ingress:* Gestione dinamica ed effimera del traffico per architetture guidate da funzioni (FaaS).
* *API Gateway Enterprise:* Punto di terminazione centralizzato per traffico nord-sud con funzionalità di rate limiting, trasformazione dei payload e token translation.

#### 2.2.2 Criteri di Selezione e Giustificazione Architetturale
Argomentazione formale sui motivi ingegneristici che rendono l'API Gateway lo strato ottimale per APIGuard, isolando i requisiti di sistema dal codice applicativo.

#### 2.2.3 Enforcing del Paradigma Zero-Trust
Centralizzazione del controllo degli accessi, principio del minimo privilegio (PoLP) ed eliminazione della fiducia implicita nel perimetro di rete.

---

### 2.3 Tassonomia delle Minacce e Vulnerabilità Logiche

#### 2.3.1 Il Semantic Gap e l'Evoluzione del Panorama delle Minacce
Le architetture a microservizi hanno spostato il baricentro degli attacchi informatici dalle vulnerabilità sintattiche alle falle semantiche. Un WAF tradizionale intercetta SQL injection perché riconosce pattern sintattici nella request HTTP; non può intercettare una richiesta perfettamente formata che viola una regola di business logic, perché quella regola non è espressa in nessuno strato del protocollo che il WAF ispeziona.

Il framework OWASP API Security Top 10 (2023) formalizza questa transizione: le prime cinque categorie (Broken Object Level Authorization API1, Broken Authentication API2, Broken Object Property Level Authorization API3, Unrestricted Resource Consumption API4, Broken Function Level Authorization API5) sono tutte vulnerabilità semantiche. Non si manifestano come payload malformati; si manifestano come richieste sintatticamente valide che violano le assunzioni implicite del sistema sul chiamante.

Il semantic gap è la distanza tra ciò che un tool di testing può osservare (la forma della request/response HTTP) e ciò che una vulnerabilità logica richiede di capire (chi ha il diritto di fare cosa, in quale contesto, con quali risorse). Colmare questo gap richiede che il tool possegga una rappresentazione formale del contratto API, ossia la specifica OpenAPI, e la usi come oracolo per valutare le risposte, non come semplice documentazione.

#### 2.3.2 Categorie di Fallimento Architetturale
Raggruppamento teorico delle minacce moderne in tre macro-aree di rischio, ricavato dalla mappatura del framework OWASP API Security Top 10 2023 sulle classi di fallimento architetturale:

* *Difetti di Autorizzazione e Gestione dello Stato:* Incoerenze tra l'identità del chiamante e i permessi sugli oggetti che richiede. BOLA (Broken Object Level Authorization, API1:2023). BFLA (Broken Function Level Authorization, API5:2023). Entrambe le classi richiedono, per essere rilevate, la capacità di effettuare richieste con credenziali di ruoli distinti e confrontarne le risposte: un workflow multi-step non supportato dai scanner HTTP generici.
* *Sovraesposizione e Flussi di Dati:* Violazioni del principio di least privilege nel payload di risposta (API3:2023) e nell'accettazione del payload di richiesta. Il mass assignment, ovvero l'iniezione di campi non documentati in un POST che il backend mappa direttamente sul database senza whitelist, e la restituzione di campi sensibili nella response (password hash, API key, PII) sono entrambi invisibili a un tool che non conosce lo schema previsto: a livello HTTP, la transazione appare corretta.
* *Abuso di Topologia e Integrazione:* Sfruttamento dell'infrastruttura distribuita come vettore di attacco indiretto. SSRF (API7:2023) sfrutta endpoint che accettano URL controllabili dall'utente (webhook, mirror, proxy) per far sì che il server effettui richieste verso infrastrutture interne o cloud metadata endpoint. Il rate limiting assente (API4:2023) espone il sistema all'esaurimento controllato delle risorse. Entrambe le classi operano attraverso funzionalità legittime del sistema, non attraverso payload malformati.

#### 2.3.3 Dal Modello Teorico alla Necessità di Valutazione Strutturata
Considerazioni conclusive su come questa eterogeneità di minacce non possa essere affrontata con un singolo strumento di test, rendendo necessaria una mappatura rigorosa tra categorie di rischio e specifici Domini di Assurance. Ponte metodologico verso il Capitolo 3.

---

### 2.4 L'Evoluzione del Testing di Sicurezza: dall'Analisi Cieca ai Contratti

#### 2.4.1 Paradigmi Tradizionali e i Limiti del DAST/SAST
Analisi critica degli approcci classici. Spiegazione del "combinatorial wall" e dell'elevato tasso di rigetto (HTTP 400) causato dal fuzzing cieco contro endpoint API con validazione strutturale dei payload.

#### 2.4.2 Asimmetria Informativa e il "Box Gradient"
Inquadramento teorico dei livelli di visibilità nel software testing. Espansione del concetto di Box Gradient (Black, Grey, White Box) per dimostrare come il grado di conoscenza pregressa determini la capacità reale di scoprire vulnerabilità logiche e semantiche.

#### 2.4.3 Contract-Driven Security e Approcci Ibridi
L'impiego delle specifiche formali (OpenAPI/Swagger) come "Ground Truth" per abbattere l'asimmetria informativa. Spiegazione di come il testing guidato dai contratti superi gli ostacoli sintattici, instradando l'orchestrazione verso l'analisi profonda della logica di business.

---

## 3. Metodologia, Architettura e Principi di Design

*Apertura del capitolo: il design di APIGuard Assurance è formalizzato in 39 proprietà architetturali, organizzate in sette categorie. La tabella seguente costituisce la mappa di riferimento dell'intero sistema. Ogni proprietà viene discussa in profondità nel capitolo appropriato (questo capitolo o il successivo) e può essere rintracciata usando la tabella come indice.*

| Categoria | Proprietà |
|---|---|
| Architettura & Design | D1.P1, D1.P2, D1.P3, D1.P4, D1.P5, D1.P6 |
| Estensibilità & Manutenibilità | D2.P1, D2.P2, D2.P3, D2.P4, D2.P5, D2.P6, D2.P7, D2.P8 |
| Config & Riproducibilità | D3.P1, D3.P2, D3.P3, D3.P4, D3.P5 |
| Robustezza & Sicurezza | D4.P1, D4.P2, D4.P3, D4.P4, D4.P5, D4.P6, D4.P7, D4.P8, D4.P9 |
| Qualità & Osservabilità | D5.P1, D5.P2, D5.P3, D5.P4, D5.P5 |
| CI/CD & DevEx | D6.P1, D6.P2, D6.P3 |
| Packaging & Deployment | D7.P1, D7.P2, D7.P3 |

---

### 3.1 Principi Fondamentali: il Perché delle Scelte Architetturali
Presentazione dei quattro fondamenti da cui discendono tutte le decisioni di design successive. Queste proprietà rispondono alla domanda "perché il sistema esiste in questa forma", non ancora a "come è fatto".

* **Agnosticismo Applicativo (D1.P1):** Il tool non contiene nessun riferimento hardcoded a un'applicazione specifica. Tutta la conoscenza del target è derivata a runtime da due sole sorgenti: `config.yaml` e la specifica OpenAPI. Questa proprietà è la principale giustificazione accademica del lavoro: un tool che funziona su un solo target è uno script; uno che funziona su qualsiasi API REST documentata è un contributo metodologico.

* **OpenAPI come Single Source of Truth (D3.P2):** La specifica OpenAPI non è documentazione, ma il vincolo contrattuale che guida l'intera pipeline. È l'oracolo che definisce la superficie d'attacco legittima, discrimina endpoint documentati da Shadow API, e permette di costruire payload strutturalmente validi invece di ricorrere al fuzzing cieco. Il "paradosso del Ground Truth" (cosa succede quando il contratto è sbagliato) viene discusso come limite strutturale nella Sezione 6.1.

* **Config-Driven Development (D3.P1):** Ogni parametro di tuning operativo risiede in `config.yaml`. Il codice non contiene literal decisionali hardcoded. Stesso `config.yaml` sullo stesso target produce sempre lo stesso risultato. Questa proprietà è il prerequisito di D3.P4 e il fondamento dell'integrabilità in pipeline CI/CD standardizzate.

* **Reproducibility (D3.P4):** Il determinismo dell'esecuzione come garanzia di validità scientifica. Un assessment non riproducibile non è un assessment: è un'osservazione irripetibile. D3.P4 è il presupposto per cui i risultati del Capitolo 5 hanno valore dimostrativo e non soltanto descrittivo. La dimostrazione empirica è in Sezione 5.3.

---

### 3.2 Architettura dell'Assessment Engine
Descrizione strutturale del sistema: come i componenti sono organizzati, come si relazionano, e perché quella struttura è stata scelta rispetto alle alternative. Ogni proprietà in questa sezione risponde a una frizione architetturale specifica.

* **Flusso di Dipendenze Monodirezionale (D1.P2):** Il grafo delle dipendenze tra moduli è strettamente aciclico: `core/` ← `connectors/` ← `tests/` ← `engine.py`. Modificare un test non può rompere `core/`. Questa proprietà è il prerequisito per la manutenibilità a lungo termine e per la futura estensibilità tramite plugin di terze parti.

* **DAG-Based Scheduling e Orchestrazione Deterministica (D2.P2):** L'ordine di esecuzione dei test è determinato da un Directed Acyclic Graph costruito a partire dalle dipendenze dichiarate da ogni test. Il DAG garantisce che test con dipendenze funzionali vengano eseguiti nell'ordine corretto senza race condition. L'output è una sequenza di batch: all'interno di ogni batch i test sono indipendenti, i batch sono sequenziali tra loro. Il legame diretto con D3.P4, ovvero il determinismo del DAG come fondamento della riproducibilità, viene esplicitato qui come catena causale.

* **Split State e Immutabilità (D1.P3):** Lo stato del sistema è diviso in due oggetti con caratteristiche opposte. `TargetContext` (`frozen=True` Pydantic) è creato una volta e mai modificato: nessun test può alterare la visione del sistema che gli altri leggono. `TestContext` è mutabile via interfacce tipizzate esplicite. La separazione è enforced a livello di tipo, non per convenzione. Il costo accettato è la rigidità del `TargetContext`, giustificato dal fatto che il target non cambia durante un singolo assessment run.

* **Gateway-Agnostic Adapter (D1.P6):** D1.P6 estende il principio di agnosticismo di D1.P1 dallo strato applicativo allo strato di controllo del gateway. I test WHITE_BOX accedono al piano di configurazione del gateway tramite `BaseGatewayAdapter`, un ABC con metodi uniformi. L'implementazione concreta (Kong) è selezionata a runtime dal `config.yaml`. Il disaccoppiamento permette di sostituire Kong con qualsiasi altro gateway senza modificare i test. Il limite intrinseco di questa astrazione, la tensione tra generalità dell'interfaccia e profondità delle verifiche vendor-specific, è discusso nella Sezione 6.1.

* **Streaming Evidence Store (D4.P1):** Per ogni test, l'`EvidenceStore` scrive ogni record su file JSONL con flush immediato, eliminando strutturalmente la classe di bug del design precedente a buffer fisso: con `deque(maxlen=100)`, i primi record venivano evicti silenziosamente, generando `Finding.evidence_ref` che puntavano a record inesistenti: audit trail rotto senza errori visibili. L'architettura JSONL garantisce la non-repudiabilità di ogni finding: ogni FAIL è corredato da evidenza HTTP dimostabile e riproducibile.

* **Zero External State Dependency (D3.P5):** Il tool non dipende da nessun database esterno, message broker o cache a runtime. Tutto lo stato vive in memoria di processo o in file locali. Questo vincolo è il prerequisito diretto di D6.P1 (exit codes affidabili per CI/CD): un tool con dipendenze di stato esterno non può garantire che il proprio exit code rifletta fedelmente lo stato dell'assessment senza service readiness check preventivi.

---

### 3.3 Domini di Sicurezza e Box Gradient Applicato
Presentazione della tassonomia originale degli 8 Domini di Assurance e della sua relazione con il Box Gradient (D3.P3). Questa sezione è il punto di convergenza tra la teoria del Capitolo 2 e la struttura operativa del tool.

* **Tassonomia degli 8 Domini:** Domain-0 (API Discovery), Domain-1 (Identity & Authentication), Domain-2 (Authorization), Domain-3 (Data Integrity), Domain-4 (Availability & Resilience), Domain-5 (Observability — Milestone 2), Domain-6 (Configuration & Hardening), Domain-7 (Business Logic & Sensitive Flows). La suddivisione rispecchia la gerarchia di fiducia di un sistema API: non ha senso verificare l'autorizzazione (D2) se non si è prima verificato che l'autenticazione funzioni (D1); non ha senso verificare l'autenticazione se non si conosce la superficie di attacco (D0). La gerarchia non è una convenzione organizzativa, è una catena logica di precondizioni.

* **Applicazione del Box Gradient (D3.P3):** APIGuard non è vincolato a un unico stile di test. Il gradiente Black/Grey/White Box è mappato strutturalmente alle priorità: i test P0 sono BLACK_BOX perché simulano un attaccante esterno senza credenziali: simulare l'attaccante è l'unico modo per ottenere evidenza non contaminata da privilegi impliciti. I test P1/P2 sono prevalentemente GREY_BOX perché richiedono token validi per almeno due ruoli distinti: senza quello stato autenticato, il test non raggiunge nemmeno la logica che intende sondare. I test P3 sono WHITE_BOX perché accedono all'Admin API del gateway per configuration audit. Questa mappatura non è una tassonomia teorica applicata retroattivamente, ma il prodotto delle precondizioni che ciascuna garanzia di sicurezza impone al tester.

---

## 4. Implementazione

*Le 39 proprietà architetturali formalizzate nel Capitolo 3 trovano in questo capitolo la loro traduzione in codice Python. Non tutte vengono discusse con lo stesso grado di profondità: alcune proprietà strutturano interi componenti e ricevono trattamento dedicato; altre emergono come conseguenza naturale delle scelte descritte e vengono citate nel contesto; altre ancora, di natura prettamente implementativa, compaiono in nota o nella tabella tassonomica di riferimento del Capitolo 3. In ogni caso, nessuna proprietà viene ignorata: il lettore che vuole rintracciare la realizzazione di una specifica proprietà può usare la tabella come indice.*

### 4.1 La Pipeline di Esecuzione a Sette Fasi e il Core Engine
Descrizione del mapping fisico-logico: le 7 fasi dell'assessment corrispondono alle cartelle della repository (`config/`, `discovery/`, `core/`, `tests/`, `report/`). Implementazione di `engine.py` come orchestratore puro: esegue le fasi nell'ordine corretto, non contiene logica di dominio.

Proprietà discusse in questa sezione:
* **Fail-Safe Error Isolation (D4.P3):** Il contratto di `BaseTest.execute()` impone che nessuna eccezione si propaghi verso l'engine. L'assenza di `try/except` attorno a `test.execute()` in `engine.py` non è una dimenticanza, è la dichiarazione esplicita che il contratto è del test, non dell'engine. Un test in eccezione produce `TestResult(ERROR)` e la pipeline prosegue.
* **Custom Exception Hierarchy con Phase Mapping (D4.P4):** 11 classi di eccezione custom con mapping esplicito alla fase della pipeline in cui si verificano. Eccezioni di Phase 1-4 sono fatali; eccezioni di Phase 5-6 sono recuperate localmente. La scelta documentata di non avere `ExternalToolNotFoundError` (un tool mancante è condizione operativa attesa, non un errore) è un esempio della precisione semantica della gerarchia.

---

### 4.2 Discovery Dinamico e Risoluzione del Grafo (DAG)
Implementazione del `TestRegistry`: come il tool scopre i test a runtime senza un registro centrale hardcoded tramite `pkgutil.walk_packages`. Il `DAGScheduler` (`core/dag.py`): impiego di `graphlib.TopologicalSorter` per tradurre le dipendenze `depends_on` in `ScheduledBatch` sequenziali, e logica di stall detection per prevenire loop infiniti.

Proprietà discusse in questa sezione:
* **Dynamic Test Discovery (D2.P1):** Zero-registration via `pkgutil`. Aggiungere un test richiede creare un file nella directory corretta: nessun altro file viene modificato. Il plugin system come traiettoria futura è una conseguenza diretta, non un piano aggiunto a posteriori.
* **Type-Level TestResult Invariant Enforcement (D4.P9):** Tre invarianti su `TestResult` sono enforced al momento della costruzione da un `model_validator` Pydantic: FAIL richiede `findings` non vuoto, SKIP richiede `skip_reason`, PASS richiede `findings` vuoto. Il validator è il single point of truth, non una convenzione distribuita nei caller.

---

### 4.3 Architettura dei Test Nativi e Contratto BaseTest (Domini 0-7)
La struttura interna dei test: il contratto imposto da `BaseTest` e l'uso obbligatorio delle `ClassVar`. Il pattern di orchestrazione interna `execute()`: come i test interagiscono con `SecurityClient` e `TestContext` restituendo sempre un `TestResult` senza propagare eccezioni.

Nota sulla copertura dei domini: Milestone 1 implementa D0, D1, D2, D3, D4, D6, D7. Domain-5 (Observability) è pianificato per Milestone 2.

Proprietà discusse in questa sezione:
* **Dual Test Hierarchy (D1.P4):** La separazione dei contratti `BaseTest` e `ExternalToolTest` previene che un `ExternalToolTest` erediti metodi inutilizzabili (es. `_log_transaction()` che accede a `SecurityClient`). Non è estetica, è prevenzione di errori per costruzione.
* **Auth Abstraction Layer (D2.P5):** Il dispatcher `auth.py` è idempotente: N test che chiamano `acquire_tokens()` producono un solo login HTTP. Aggiungere un nuovo metodo di autenticazione richiede una nuova implementazione e un ramo nel dispatcher, senza modifiche ai test esistenti.
* **Methodology Traceability (D5.P1):** Ogni test porta come `ClassVar` i riferimenti normativi della garanzia che verifica: `cwe_id`, `tags` (OWASP, NIST, RFC). Ogni `Finding` propaga `references`. I risultati sono tracciabili agli standard, non sono annotazioni arbitrarie del tool.
* **Finding/InfoNote Semantic Distinction (D5.P2):** `Finding` è evidenza di una violazione (presente solo in FAIL, conta nel totale). `InfoNote` è annotazione informativa su un PASS (non cambia lo status, non conta come violazione). L'invariante PASS-senza-Finding è enforced da D4.P9.
* **Safe HTTP Probing Policy (D4.P7):** Oracle a tre esiti: ENFORCED (401/403), BYPASSED (2xx), INCONCLUSIVE (qualsiasi altro stato); e segregazione degli endpoint in Tier A (path fissi, risposta interpretabile) e Tier B (path parametrici, risposta dipende dalla qualità del seed). Un tool che segna FAIL ogni 404 su path parametrici genera falsi positivi inaccettabili. Il fallback sicuro `"apiguard-probe"` per i DELETE parametrici garantisce che anche un gateway misconfigured non causi perdita di dati sul target.

---

### 4.4 Gerarchia dei Connettori e Integrazione Tool Esterni
Implementazione della Three-Tier Connector Hierarchy: `BaseConnector` (ABC puro), `BaseSubprocessConnector` (tool invocati come subprocess: nuclei, testssl.sh), `BaseLibraryConnector` (package Python-native: sslyze). Parsing standardizzato dell'output (`ConnectorResult`) e iniezione automatica dei connettori in `ExternalToolTest`.

Proprietà discusse in questa sezione:
* **Three-Tier Connector Hierarchy (D1.P5):** Un `SslyzeConnector` non eredita `BINARY_NAME` né `_run_subprocess()`, metodi irrilevanti per una libreria Python. La gerarchia minimizza la superficie di interfaccia inutilizzabile e rende esplicita la natura dell'integrazione (subprocess vs libreria).
* **Separation of Data from Evaluation (D2.P3):** Il connector restituisce dati grezzi nel modello `ConnectorResult`; è l'`ExternalToolTest` a valutarli contro il proprio oracle. Lo stesso `NucleiConnector` è riusabile da test con logiche di valutazione diverse senza modifiche.
* **Connector Lifecycle con Dependency Injection (D2.P4):** Il check di disponibilità (`is_available()`) viene eseguito una sola volta per gruppo di test che usano lo stesso tool. Con N test che dipendono da nuclei, il filesystem viene interrogato una sola volta: un singolo WARNING nel log invece di N entry identiche.
* **Category A/B Connector Classification (D2.P6):** Connector Cat A sono prerequisiti per la completezza dei test HYBRID. Connector Cat B espandono la copertura senza essere necessari. La classificazione guida le priorità di sviluppo e l'accettazione di contributi esterni.
* **Path Seed System (D2.P7):** Risolve il problema dei path parametrici con dimostrazione quantitativa: senza seed su Forgejo, i path con `{owner}` e `{repo}` producono INCONCLUSIVE; con seed configurato, gli stessi path producono ENFORCED o BYPASSED. Prima-dopo citabile in Cap. 5.
* **Test Data Catalog Architecture (D2.P8):** I payload di attacco risiedono in moduli pure-data (`src/tests/data/`) senza logica. Aggiungere un nuovo vettore SSRF richiede una riga nel catalogue, non una modifica alla logica del test. In contesti enterprise dove i payload devono essere approvati separatamente dal codice, questa separazione è un prerequisito.
* **License-Gated Optional Dependency (D7.P2):** `sslyze` (AGPL v3) è isolato in `[project.optional-dependencies.sslyze]`. Il core rimane MIT-clean. Chi installa l'extra accetta consapevolmente l'AGPL. Esempio concreto di come le decisioni di licensing influenzino l'architettura.

---

### 4.5 Implementazione del Gateway Adapter e Teardown LIFO
Sviluppo del `KongGatewayAdapter`: come il motore Python interroga l'Admin API di Kong DB-less per eseguire test White-Box (Domini 3, 4, 6). Fase 6 (Teardown): implementazione del cleanup best-effort tramite la coda LIFO in `TestContext.drain_resources()`.

Proprietà discusse in questa sezione:
* **Graceful Degradation Multi-Livello (D4.P5):** Tre livelli di degradazione controllata: tool esterno assente → SKIP via `_skip_reason_from_registry`; Admin API non configurata → tutti i test WHITE_BOX ritornano SKIP con motivo esplicito; `external_tools.enabled = false` → registry ritorna lista vuota senza scansionare il filesystem. In ambiente senza Admin API esposta i risultati sono parziali ma corretti, non errori a cascata.
* **Best-Effort Teardown LIFO (D4.P6):** I test che creano risorse registrano l'endpoint di cancellazione nel `TestContext` al momento stesso della creazione. L'ordine LIFO garantisce che risorse con dipendenze implicite siano eliminate nell'ordine corretto. Un fallimento di teardown è un warning operativo, non un'invalidazione scientifica dell'assessment. Validazione empirica: 0 risorse leakate nell'audit di Milestone 1, discussa in 5.3.
* **Deployment-Transparent URL Abstraction (D7.P3):** `TargetContext.effective_base_url` astrae la differenza tra deployment standalone (`localhost`) e Docker Compose (nome servizio Compose). Risolto una volta in Phase 3 e frozen nel `TargetContext`: zero logica condizionale di deployment nei connector.

---

### 4.6 Evidence Store e Sanitizzazione delle Credenziali
Implementazione dello Streaming Evidence Store e del meccanismo centralizzato di sanitizzazione. Presentazione del Dual Audit Trail: `evidence.json` come forensic trail tecnico e `assessment_report.html` come deliverable operativo.

Proprietà discusse in questa sezione:
* **Streaming Evidence Store — implementazione (D4.P1):** Il ciclo di vita `begin_test` / scrittura per-record / `end_test` / `merge_and_finalize` in Phase 7. Confronto esplicito con il design precedente a `deque(maxlen=100)`: il difetto, ovvero l'audit trail rotto in silenzio, è la motivazione più efficace per la scelta attuale.
* **Evidence Sanitization (D4.P2):** La sanitizzazione centralizzata tramite tripla copertura (key-pattern regex su 11 pattern, JWT heuristic per valori stringa indipendentemente dalla chiave, header prefix matching) garantisce che nessun connector che dimentica di redactare un campo sensibile crei una violazione nell'audit trail. La centralizzazione è il contributo: non è una convenzione che i developer devono ricordare, è una garanzia strutturale. In una tesi sulla sicurezza delle API, la proprietà che impedisce alle credenziali di finire nei log merita trattamento dedicato.
* **Report Domain-Centric Split (D5.P5):** La partizione per `domain × source` nel report è la conseguenza diretta di come l'Evidence Store aggrega i dati. Per ogni dominio il report distingue risultati nativi (con evidenza HTTP diretta) da risultati di tool specializzati (con raw output del tool), senza richiedere sezioni fisicamente separate.

---

## 5. Validazione Sperimentale e Risultati

*Questo capitolo dimostra empiricamente la solidità architetturale di APIGuard Assurance attraverso metriche di esecuzione, stabilità del motore e coerenza dei risultati su un ambiente target controllato.*

### 5.1 Topologia del Testbed Sperimentale (Forgejo + Kong)
Descrizione dell'ambiente di validazione: provisioning via Docker Compose di Forgejo 14.0.3 esposto tramite Kong 3.9 DB-less. Motivazione della scelta: API documentate (OpenAPI/Swagger nativo), gestione token (API key), RBAC a tre ruoli, superficie d'attacco realistica per i Domini 0-7. Configurazione dei plugin Kong (response-transformer per security headers, rate-limiting commentato per mostrare i finding di 4.1).

### 5.2 Release-Readiness e Integrità Architetturale
Dimostrazione della qualità del codice prodotto: analisi statica (0 errori Ruff, 0 finding Bandit severity medium+, 0 dead code Vulture, 0 CVE pip-audit) e type-safety rigorosa.

Proprietà discussa in questa sezione:
* **Dual-Layer Type Safety (D6.P3):** 0 errori mypy su 90 file sorgente in strict mode. La dual-layer enforcement (mypy a compile-time + Pydantic a runtime) copre due classi di bug distinte: errori di tipo nella logica interna ed errori sui dati alle system boundaries. Un tool che si propone come strumento di assurance deve dimostrare di applicare lo stesso rigore alla propria implementazione.

### 5.3 Copertura Funzionale e Idempotenza dell'Assessment
Analisi dei risultati logici: 98 finding totali distribuiti su 18 test attivi (9 PASS, 7 FAIL, 2 SKIP). Dimostrazione empirica dell'idempotenza: due run indipendenti producono risultati byte-identici (Δ wall-clock 0.32%), 0 risorse leakate. Validazione del Teardown Best-Effort (D4.P6) e della Reproducibility (D3.P4) con dati numerici tracciabili all'audit di Milestone 1.

### 5.4 Footprint Computazionale e Benchmarking del DAG
Analisi delle performance del motore Python su setup single-host contro Forgejo 14.0.3 + Kong DB-less (dati da §A.2 e §B.9 dell'audit di Milestone 1): wall-clock medio 286s (media su due run: 290.14s e 290.81s), peak resident set size 287–295 MB, output totale on-disk 4.5 MB. L'utilizzo CPU medio del 26% indica che il run è dominato dagli HTTP round-trip verso il target, non dal calcolo locale. Discussione di come la topologia DAG (16 test in Phase A, 2 in Phase B) non solo prevenga le race condition ma mantenga un profilo di risorse compatibile con l'esecuzione in pipeline CI/CD senza hardware dedicato.

---

## 6. Discussione e Sviluppi Futuri

### 6.1 Analisi Critica e Limiti del Paradigma Contract-Driven
Discussione oggettiva sui tre limiti strutturali del sistema, ciascuno radicato in una proprietà architetturale specifica:

* **Il Paradosso del Ground Truth (limite di D3.P2):** Il tool assume che la specifica OpenAPI fornita sia corretta, completa e non manipolata. Una specifica obsoleta o deliberatamente alterata produce un assessment parziale senza che il sistema possa rilevarlo. Questo è un open problem nella letteratura sul contract-driven testing, non un difetto specifico di APIGuard Assurance.

* **La Tensione dell'Astrazione (limite di D1.P6):** Il Gateway-Agnostic Adapter garantisce compatibilità multi-vendor a costo di esporre solo i controlli concettualmente generalizzabili a qualsiasi gateway. Un test che volesse accedere a feature Kong-specifiche senza equivalente in altri gateway (es. plugin ordering con effetti sulla sicurezza) dovrebbe castare al tipo concreto, rompendo l'agnosticismo del test stesso. Il design corrente non usa questa possibilità, e questo è il trade-off da dichiarare.

* **La Dipendenza dall'Admin API (limite di D4.P5):** In ambienti cloud managed (Amazon API Gateway, Azure APIM) l'Admin API non è mai esposta pubblicamente. La graceful degradation funziona (tutti i test WHITE_BOX ritornano SKIP con motivo esplicito), ma la copertura dell'assessment si riduce ai soli domini black-box e grey-box. Nella prassi industriale questo limite si affronta con accordi specifici che concedono accesso privilegiato durante l'assessment, un modello operativo in cui APIGuard Assurance si inserisce naturalmente configurando il campo `gateway_adapter` nel `config.yaml`.

### 6.2 Applicabilità Industriale e Integrazione DevSecOps
Valutazione di come APIGuard possa essere integrato come quality gate automatizzato in pipeline CI/CD.

Proprietà discusse in questa sezione:
* **Semantic Exit Codes (D6.P1):** Quattro exit code semanticamente distinti (0 clean, 1 FAIL, 2 ERROR, 10 infrastrutturale) permettono l'integrazione in qualsiasi pipeline CI/CD con un semplice check sul codice di uscita. La distinzione tra "il tool non si è avviato" (10) e "il tool si è avviato e ha trovato problemi" (1) è essenziale per la diagnostica automatica.
* **Fail-Fast P0 Escalation (D4.P8):** Combinato con D6.P1, abilita un quality gate a due velocità: fail-fast sui test P0 (interruzione immediata alla prima violazione perimetrale confermata) per risparmiare wall-clock nei casi chiari, assessment completo negli altri. La distinzione tra D4.P8 (quando fermarsi) e D6.P1 (cosa comunicare dopo il completamento) è il punto architetturale da chiarire.

### 6.3 Sviluppi Futuri (Prospettiva di Ricerca Dottorale)
Le traiettorie di sviluppo si articolano su due scale temporali distinte: estensioni operative pianificate a breve termine nella roadmap di Milestone 2, e traiettorie di ricerca aperte che richiedono validazione sperimentale autonoma.

#### Roadmap Milestone 2 — Estensioni operative
Conseguenze dirette dell'architettura attuale, identificate dalla roadmap in `PROJECT_status.md` e dalle sezioni "Sviluppo futuro" delle singole proprietà:
* Domain-5 Observability: unico dominio non implementato in M1, con test 5.1 e 5.2 già pianificati.
* jwt_tool connector (Phase C del DAG): sblocca la classe di test che dipendono da manipolazione JWT avanzata, attualmente bloccati in attesa del connector.
* BOLA/IDOR testing con OFFAT: generazione dinamica di test per broken object level authorization, Domain-2.
* Vegeta per Race Condition: load testing rigoroso per vulnerabilità TOCTOU su endpoint sensibili.
* interactsh per SSRF blind: OOB oracle per rilevare SSRF che non producono risposta osservabile nel canale normale.

#### Traiettorie di Ricerca Avanzata
Direzioni che l'architettura attuale abilita ma che richiedono ricerca e validazione sperimentale indipendente, non semplice implementazione:
* **Plugin system (D2.P1):** Il discovery dinamico via `pkgutil` è già compatibile con moduli di test contribuiti da terze parti. Un package `apiguard-tests-graphql` è inseribile senza modifiche al core.
* **Parallelizzazione batch (D2.P2):** La struttura a batch del DAG è già parallelizzabile con un `ThreadPoolExecutor` localizzato in Phase 5. Le questioni di thread-safety su `TestContext` ed `EvidenceStore` sono note e documentate, ma richiedono analisi formale prima dell'implementazione.
* **Auto-seed dall'OpenAPI spec (D2.P7):** Derivare il seed cercando i campi `example:` / `x-example:` nella spec, riducendo il lavoro manuale di configurazione.
* **ML/LLM per inferenza contratti:** Traiettoria che affronta il paradosso del Ground Truth di D3.P2, rendere il tool indipendente dalla documentazione fornita tramite inferenza della specifica dall'analisi del traffico reale. È un open problem nella letteratura sul contract-driven testing, con sfide aperte sulla correttezza dell'inferenza e sulla gestione dei falsi positivi generati da specifiche parziali.

---

## 7. Conclusioni

### 7.1 Sintesi del Lavoro e Risoluzione del Problema Iniziale
Ritorno alla tesi fondamentale: riassunto di come l'approccio Contract-Driven (D3.P2) abbia colmato il "Semantic Gap" discusso nel Capitolo 2, superando la cecità sintattica dei fuzzer tradizionali. Conferma che un approccio ibrido, guidato dalla specifica OpenAPI e svincolato dal target (D1.P1), è superiore all'analisi statica o dinamica isolate.

### 7.2 Contributi Scientifici e Ingegneristici
Elenco degli artefatti concreti prodotti dalla ricerca:

1. Il design di un **Assessment Engine deterministico basato su DAG** per l'orchestrazione di test di sicurezza su API REST documentate.
2. La formalizzazione delle **39 Proprietà Architetturali distribuite su 7 domini** come modello di design riutilizzabile e indipendente dall'implementazione.
3. La **Tassonomia a 8 Domini** associata al Box Gradient (D3.P3) come metodo originale di classificazione dei test di sicurezza in funzione delle precondizioni informative del tester.
4. Una **codebase release-ready** (0 errori mypy strict su 90 file, 100% green static analysis) validata empiricamente contro un target reale (Forgejo 14.0.3 + Kong 3.9 DB-less), con idempotenza dimostrata su run multiple.

### 7.3 Considerazioni Finali sull'Assurance Continuo
La "morale" della tesi: il passaggio concettuale dal tradizionale Penetration Testing (manuale, point-in-time, opaco) all'Automated Security Assurance (continuo, config-driven, riproducibile). APIGuard non è solo un tool che trova vulnerabilità, ma una dimostrazione che la sicurezza delle API può diventare una disciplina rigorosa di Ingegneria del Software: verificabile, tracciabile, e integrabile nel ciclo di sviluppo senza richiedere intervento manuale a ogni release.