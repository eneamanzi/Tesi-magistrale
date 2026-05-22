# Checklist Tesi: Assessment Sicurezza API

## Stati
`[Stato: Da fare]`  -> capitolo da scrivere completamente, è assente

`[Stato: CHECK]`    -> capitolo scritto per la prima volta, controllare com'è e fare *commenti di review* su quanto prodotto dentro /Z-comments.md

`[Stato: POST-CHECK]`    -> capitolo *riscritto sulla base dei commenti*, devo rileggerlo e approvarlo con *OK* o riemtterlo in *CHECK*

`[Stato: OK]`    -> capitolo finito e approvato da me

`[Stato: RELATORE]`    -> capitolo finito e approvato da me e relatore


## 1. Introduzione

### 1.1 Motivazione e Contesto
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 1.2 Definizione del Problema e Gaps nella Ricerca
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 1.3 Obiettivi della Ricerca
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 1.4 Organizzazione della Tesi
- [ ] Completare/Revisionare `[Stato: Da fare]`

---

## 2. Background e Stato dell'Arte

### 2.1 Paradigmi delle Architetture API Moderne
- [ ] 2.1.1 Evoluzione dei Sistemi Distribuiti `[Stato: Da fare]`
- [ ] 2.1.2 Tassonomia degli Stili Architetturali e di Comunicazione `[Stato: Da fare]`
- [ ] 2.1.3 Il Fenomeno dell'API Sprawl `[Stato: Da fare]`

### 2.2 Il Pattern dell'API Gateway in Ottica Zero-Trust
- [ ] 2.2.1 Analisi Comparativa dei Modelli di Esposizione in Rete `[Stato: Da fare]`
- [ ] 2.2.2 Criteri di Selezione e Giustificazione Architetturale `[Stato: Da fare]`
- [ ] 2.2.3 Enforcing del Paradigma Zero-Trust `[Stato: Da fare]`

### 2.3 Tassonomia delle Minacce e Vulnerabilità Logiche
- [ ] 2.3.1 Il Semantic Gap e l'Evoluzione del Panorama delle Minacce `[Stato: Da fare]`
- [ ] 2.3.2 Categorie di Fallimento Architetturale `[Stato: Da fare]`
- [ ] 2.3.3 Dal Modello Teorico alla Necessità di Valutazione Strutturata `[Stato: Da fare]`

### 2.4 L'Evoluzione del Testing di Sicurezza: dall'Analisi Cieca ai Contratti
- [ ] 2.4.1 Paradigmi Tradizionali e i Limiti del DAST/SAST `[Stato: Da fare]`
- [ ] 2.4.2 Asimmetria Informativa e il "Box Gradient" `[Stato: Da fare]`
- [ ] 2.4.3 Contract-Driven Security e Approcci Ibridi `[Stato: Da fare]`

---

## 3. Metodologia, Architettura e Principi di Design

### 3.1 Principi Fondamentali: il Perché delle Scelte Architetturali
- [X] 3.1.1 Agnosticismo Applicativo (D1.P1) `[Stato: OK]` 
- [X] 3.1.2 La Specifica OpenAPI come Unico Oracolo Formale (D3.P2) `[Stato: OK]` 
- [X] 3.1.3 Config-Driven Development (D3.P1) `[Stato: OK]` 
- [X] 3.1.4 Riproducibilità Deterministica (D3.P4) `[Stato: OK]` 

### 3.2 Architettura dell'Assessment Engine
- [ ] 3.2.1 Flusso di Dipendenze Monodirezionale (D1.P2) `[Stato: POST-CHECK]` 
- [ ] 3.2.2 Scheduling Basato su DAG e Orchestrazione Deterministica (D2.P2) `[Stato: POST-CHECK]` 
- [ ] 3.2.3 Split State e Immutabilità (D1.P3) `[Stato: POST-CHECK]` 
- [ ] 3.2.4 Gateway-Agnostic Adapter (D1.P6) `[Stato: CHECK]`
- [ ] 3.2.5 Streaming Evidence Store (D4.P1) `[Stato: CHECK]`
- [ ] 3.2.6 Assenza di Dipendenze di Stato Esterno (D3.P5) `[Stato: CHECK]`

### 3.3 Domini di Sicurezza e Box Gradient Applicato
- [ ] 3.3.1 Tassonomia degli Otto Domini di Assurance `[Stato: CHECK]`
- [ ] 3.3.2 Il Box Gradient come Mapping dalle Precondizioni al Privilegio (D3.P3) `[Stato: CHECK]`

---

## 4. Implementazione

### 4.1 La Pipeline di Esecuzione a Sette Fasi e il Core Engine
- [ ] 4.1.1 Fail-Safe Error Isolation (D4.P3) `[Stato: CHECK]`
- [ ] 4.1.2 Gerarchia delle Eccezioni con Phase Mapping (D4.P4) `[Stato: CHECK]`

### 4.2 Discovery Dinamico e Risoluzione del Grafo
- [ ] 4.2.1 Discovery Dinamico via pkgutil (D2.P1) `[Stato: CHECK]`
- [ ] 4.2.2 Scheduling Topologico e DAGScheduler (D2.P2) `[Stato: CHECK]`
- [ ] 4.2.3 Invarianti di TestResult a Livello di Tipo (D4.P9) `[Stato: CHECK]`

### 4.3 Architettura dei Test Nativi e Contratto BaseTest
- [ ] 4.3.1 Gerarchia Duale BaseTest / ExternalToolTest (D1.P4) `[Stato: CHECK]`
- [ ] 4.3.2 Auth Abstraction Layer e Idempotenza dei Token (D2.P5) `[Stato: CHECK]`
- [ ] 4.3.3 Tracciabilità Normativa e Distinzione Finding/InfoNote (D5.P1, D5.P2) `[Stato: CHECK]`
- [ ] 4.3.4 Safe HTTP Probing Policy e Oracle a Tre Esiti (D4.P7) `[Stato: CHECK]`

### 4.4 Gerarchia dei Connettori e Integrazione Tool Esterni
- [ ] 4.4.1 Gerarchia a Tre Livelli e Separazione Dati/Valutazione (D1.P5, D2.P3) `[Stato: CHECK]`
- [ ] 4.4.2 Lifecycle dei Connector e Dependency Injection (D2.P4) `[Stato: CHECK]`
- [ ] 4.4.3 Classificazione A/B, Path Seed e Catalogo dei Payload (D2.P6, D2.P7, D2.P8) `[Stato: CHECK]`
- [ ] 4.4.4 Isolamento della Dipendenza AGPL (D7.P2) `[Stato: CHECK]`

### 4.5 Implementazione del Gateway Adapter e Teardown LIFO
- [ ] 4.5.1 KongGatewayAdapter: Accesso Read-Only all’Admin API `[Stato: CHECK]`
- [ ] 4.5.2 Degradazione Controllata a Tre Livelli (D4.P5) `[Stato: CHECK]`
- [ ] 4.5.3 Teardown Best-Effort in Ordine LIFO (D4.P6) `[Stato: CHECK]`
- [ ] 4.5.4 Astrazione Trasparente dell’URL di Deployment (D7.P3) `[Stato: CHECK]`

### 4.6 Evidence Store e Sanitizzazione delle Credenziali
- [ ] 4.6.1 Ciclo di Vita dello Streaming Evidence Store (D4.P1) `[Stato: CHECK]`
- [ ] 4.6.2 Sanitizzazione Centralizzata delle Credenziali (D4.P2) `[Stato: CHECK]`
- [ ] 4.6.3 Dual Audit Trail e Report Domain-Centric (D5.P5) `[Stato: CHECK]`

---

## 5. Validazione sperimentale e risultati

### 5.1 Topologia del Testbed Sperimentale
- [ ] 5.1.1 Architettura del Testbed `[Stato: CHECK]`
- [ ] 5.1.2 Configurazione Intenzionale per la Copertura dei Finding `[Stato: CHECK]`
- [ ] 5.1.3 Struttura RBAC e Provisioning degli Utenti `[Stato: CHECK]`

### 5.2 Release-Readiness e Integrità Architetturale
- [ ] 5.2.1 Analisi Statica del Codebase `[Stato: CHECK]`
- [ ] 5.2.2 Dual-Layer Type Safety (D6.P3) `[Stato: CHECK]`
- [ ] 5.2.3 Indicatori di Qualità dell’Ingegneria di Produzione `[Stato: CHECK]`

### 5.3 Copertura Funzionale e Idempotenza dell’Assessment
- [ ] 5.3.1 Analisi dei Risultati per Dominio `[Stato: CHECK]`
- [ ] 5.3.2 Idempotenza e Validazione del Teardown `[Stato: CHECK]`

### 5.4 Footprint Computazionale e Benchmarking del DAG
- [ ] 5.4.1 Regime di Esecuzione: IO-Bound, non CPU-Bound `[Stato: CHECK]`
- [ ] 5.4.2 Topologia del DAG e Implicazioni sull’Ordinamento dell’Esecuzione `[Stato: CHECK]`

### Sintesi della Validazione
- [ ] Completare/Revisionare `[Stato: CHECK]`

---

## 6. Discussione e Sviluppi Futuri

### 6.1 Analisi Critica e Limiti del Paradigma Contract-Driven
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 6.2 Applicabilità Industriale e Integrazione DevSecOps
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 6.3 Sviluppi Futuri (Prospettiva di Ricerca Dottorale)
- [ ] Roadmap Milestone 2 — Estensioni operative `[Stato: Da fare]`
- [ ] Traiettorie di Ricerca Avanzata `[Stato: Da fare]`

---

## 7. Conclusioni

### 7.1 Sintesi del Lavoro e Risoluzione del Problema Iniziale
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 7.2 Contributi Scientifici e Ingegneristici
- [ ] Completare/Revisionare `[Stato: Da fare]`

### 7.3 Considerazioni Finali sull'Assurance Continuo
- [ ] Completare/Revisionare `[Stato: Da fare]`