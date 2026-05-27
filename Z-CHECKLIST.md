# Checklist Tesi: Assessment Sicurezza API

## Stati
`[Stato: Da fare]`  -> capitolo da scrivere completamente, è assente

`[Stato: CHECK]`    -> capitolo scritto per la prima volta, controllare com'è e fare *commenti di review* su quanto prodotto dentro /Z-comments.md

`[Stato: POST-CHECK]`    -> capitolo *riscritto sulla base dei commenti*, devo rileggerlo e approvarlo con *OK* o riemtterlo in *CHECK*

`[Stato: OK]`    -> capitolo finito e approvato da me

`[Stato: RELATORE]`    -> capitolo finito e approvato da me e relatore

---

## 1. Introduzione
### 1.1 Motivazione e Contesto
- [ ] `[Stato: CHECK]`
### 1.2 Definizione del Problema e Gap nella Ricerca
- [ ] `[Stato: CHECK]`
### 1.3 Obiettivi della Ricerca
- [ ] `[Stato: CHECK]`
### 1.4 Organizzazione della Tesi
- [ ] `[Stato: CHECK]`

---

## 2. Background e Stato dell'Arte
### 2.1 Paradigmi delle Architetture API Moderne
- [ ] 2.1.1 Evoluzione dei Sistemi Distribuiti `[Stato: CHECK]`
- [ ] 2.1.2 Tassonomia degli Stili Architetturali e di Comunicazione `[Stato: CHECK]`
- [ ] 2.1.3 Il Fenomeno dell'API Sprawl `[Stato: CHECK]`
### 2.2 Il Pattern dell'API Gateway in Ottica Zero-Trust
- [ ] 2.2.1 Analisi Comparativa dei Modelli di Esposizione in Rete `[Stato: CHECK]`
- [ ] 2.2.2 Criteri di Selezione e Giustificazione Architetturale `[Stato: CHECK]`
- [ ] 2.2.3 Enforcing del Paradigma Zero-Trust `[Stato: CHECK]`
### 2.3 Tassonomia delle Minacce e Vulnerabilità Logiche
- [ ] 2.3.1 Il Semantic Gap e l'Evoluzione del Panorama delle Minacce `[Stato: CHECK]`
- [ ] 2.3.2 Categorie di Fallimento Architetturale `[Stato: CHECK]`
- [ ] 2.3.3 Dal Modello Teorico alla Necessità di Valutazione Strutturata `[Stato: CHECK]`
### 2.4 L'Evoluzione del Testing di Sicurezza: dall'Analisi Cieca ai Contratti
- [ ] 2.4.1 Paradigmi Tradizionali e i Limiti del DAST/SAST `[Stato: CHECK]`
- [ ] 2.4.2 Asimmetria Informativa e il Box Gradient `[Stato: CHECK]`
- [ ] 2.4.3 Contract-Driven Security e Approcci Ibridi `[Stato: CHECK]`

---

## 3. Metodologia, Architettura e Principi di Design
### 3.1 Principi Fondamentali: il Perché delle Scelte Architetturali
- [X] 3.1.1 Agnosticismo Applicativo (D1.P1) `[Stato: OK]`
- [X] 3.1.2 La Specifica OpenAPI come Unico Oracolo Formale (D3.P2) `[Stato: OK]`
- [X] 3.1.3 Config-Driven Development (D3.P1) `[Stato: OK]`
- [X] 3.1.4 Riproducibilità Deterministica (D3.P4) `[Stato: OK]`
### 3.2 Architettura dell'Assessment Engine
- [X] 3.2.1 Flusso di Dipendenze Monodirezionale (D1.P2) `[Stato: OK]`
- [X] 3.2.2 Scheduling Basato su DAG e Orchestrazione Deterministica (D2.P2) `[Stato: OK]`
- [X] 3.2.3 Split State e Immutabilità (D1.P3) `[Stato: OK]`
- [X] 3.2.4 Gateway-Agnostic Adapter (D1.P6) `[Stato: OK]`
- [X] 3.2.5 Streaming Evidence Store (D4.P1) `[Stato: OK]`
- [X] 3.2.6 Assenza di Dipendenze di Stato Esterno (D3.P5) `[Stato: OK]`
### 3.3 Domini di Sicurezza e Box Gradient Applicato
- [X] 3.3.1 Tassonomia degli Otto Domini di Assurance `[Stato: OK]`
- [X] 3.3.2 Il Box Gradient come Mapping dalle Precondizioni al Privilegio (D3.P3) `[Stato: OK]`

---

## 4. Implementazione
### 4.1 La Pipeline di Esecuzione a Sette Fasi e il Core Engine
- [X] 4.1.1 Fail-Safe Error Isolation (D4.P3) `[Stato: OK]`
- [X] 4.1.2 Gerarchia delle Eccezioni con Phase Mapping (D4.P4) `[Stato: OK]`
- [X] 4.1.3 Costruzione dei Contesti di Esecuzione (D1.P3) `[Stato: OK]`
### 4.2 Discovery Dinamico e Risoluzione del Grafo
- [X] 4.2.1 Discovery Dinamico via pkgutil (D2.P1) `[Stato: OK]`
- [X] 4.2.2 Scheduling Topologico e DAGScheduler (D2.P2) `[Stato: OK]`
### 4.3 Architettura dei Test Nativi e Contratto BaseTest
- [X] 4.3.1 Gerarchia Duale BaseTest / ExternalToolTest (D1.P4) `[Stato: OK]`
- [X] 4.3.2 Invarianti di TestResult a Livello di Tipo (D4.P9) `[Stato: OK]`
- [X] 4.3.3 Auth Abstraction Layer e Idempotenza dei Token (D2.P5) `[Stato: OK]`
- [X] 4.3.4 Tracciabilità Normativa e Distinzione Finding/InfoNote (D5.P1, D5.P2) `[Stato: OK]`
- [X] 4.3.5 Oracle a Tre Esiti e Safe HTTP Probing Policy (D4.P7) `[Stato: OK]`
- [X] 4.3.6 Path Seed System (D2.P7) `[Stato: OK]`
- [X] 4.3.7 Catalogo dei Payload di Attacco (D2.P8) `[Stato: OK]`
- [X] 4.3.8 Teardown Best-Effort in Ordine LIFO (D4.P6) `[Stato: OK]`
### 4.4 Gerarchia dei Connettori e Integrazione Tool Esterni
- [X] 4.4.1 Gerarchia a Tre Livelli e Separazione Dati/Valutazione (D1.P5, D2.P3) `[Stato: OK]`
- [X] 4.4.2 Lifecycle dei Connector e Dependency Injection (D2.P4) `[Stato: OK]`
- [X] 4.4.3 Classificazione A/B dei Connector (D2.P6) `[Stato: OK]`
- [X] 4.4.4 Isolamento della Dipendenza AGPL (D7.P2) `[Stato: OK]`
### 4.5 Implementazione del Gateway Adapter
- [X] 4.5.1 KongGatewayAdapter: Accesso Read-Only all'Admin API `[Stato: OK]`
- [X] 4.5.2 Degradazione Controllata a Tre Livelli (D4.P5) `[Stato: OK]`
### 4.6 Evidence Store e Sanitizzazione delle Credenziali
- [X] 4.6.1 Ciclo di Vita dello Streaming Evidence Store (D4.P1) `[Stato: OK]`
- [X] 4.6.2 Sanitizzazione Centralizzata delle Credenziali (D4.P2) `[Stato: OK]`
- [X] 4.6.3 Dual Audit Trail e Report Domain-Centric (D5.P5) `[Stato: OK]`

---

## 5. Validazione Sperimentale e Risultati
### 5.1 Topologia del Testbed Sperimentale
- [ ] 5.1.1 Architettura del Testbed `[Stato: POST-CHECK]`
- [ ] 5.1.2 Configurazione Intenzionale per la Copertura dei Finding `[Stato: POST-CHECK]`
- [ ] 5.1.3 Struttura RBAC e Provisioning degli Utenti `[Stato: POST-CHECK]`
### 5.2 Release-Readiness e Integrità Architetturale
- [ ] 5.2.1 Analisi Statica del Codebase `[Stato: POST-CHECK]`
- [ ] 5.2.2 Dual-Layer Type Safety (D6.P3) `[Stato: POST-CHECK]`
- [ ] 5.2.3 Indicatori di Qualità dell'Ingegneria di Produzione `[Stato: POST-CHECK]`
### 5.3 Copertura Funzionale e Idempotenza dell'Assessment
- [ ] 5.3.1 Analisi dei Risultati per Dominio `[Stato: POST-CHECK]`
- [ ] 5.3.2 Idempotenza e Validazione del Teardown `[Stato: POST-CHECK]`
### 5.4 Footprint Computazionale e Benchmarking del DAG
- [ ] 5.4.1 Regime di Esecuzione: IO-Bound, non CPU-Bound `[Stato: POST-CHECK]`
- [ ] 5.4.2 Topologia del DAG e Implicazioni sull'Ordinamento dell'Esecuzione `[Stato: POST-CHECK]`
### Sintesi della Validazione
- [ ] `[Stato: POST-CHECK]`

---

## 6. Discussione e Sviluppi Futuri
### 6.1 Analisi Critica e Limiti del Paradigma Contract-Driven
- [ ] 6.1.1 Il Paradosso del Ground Truth (D3.P2) `[Stato: POST-CHECK]`
- [ ] 6.1.2 La Tensione dell'Astrazione (D1.P6) `[Stato: POST-CHECK]`
- [ ] 6.1.3 La Dipendenza dall'Admin API (D4.P5) `[Stato: POST-CHECK]`
### 6.2 Applicabilità Industriale e Integrazione DevSecOps
- [ ] 6.2.1 Semantic Exit Codes come Canale di Comunicazione con la Pipeline (D6.P1) `[Stato: POST-CHECK]`
- [ ] 6.2.2 Quality Gate a Due Velocità: Fail-Fast e Assessment Completo (D4.P8) `[Stato: POST-CHECK]`
- [ ] 6.2.3 Variabilità di Privilegio nei Deployment Industriali `[Stato: POST-CHECK]`
### 6.3 Sviluppi Futuri
- [ ] 6.3.1 Estensioni Operative `[Stato: POST-CHECK]`
- [ ] 6.3.2 Traiettorie di Ricerca Aperta `[Stato: POST-CHECK]`

---

## 7. Conclusioni
### 7.1 Sintesi del Lavoro e Risoluzione del Problema Iniziale
- [ ] `[Stato: CHECK]`
### 7.2 Contributi Scientifici e Ingegneristici
- [ ] `[Stato: CHECK]`
### 7.3 Considerazioni Finali sull'Assurance Continuo
- [ ] `[Stato: CHECK]`