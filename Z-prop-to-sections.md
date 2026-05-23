### ✅ Proprietà TRATTATE nei Capitoli 3 e 4

**D1: Architettura & Design**

* **D1.P1** (Agnosticismo Applicativo) ➔ Trattata in Cap. 3, `\subsection{Agnosticismo Applicativo (D1.P1)}` (`\label{subsec:agnosticismo}`)
* **D1.P2** (Flusso di Dipendenze Monodirezionale) ➔ Trattata in Cap. 3, `\subsection{Flusso di Dipendenze Monodirezionale (D1.P2)}` (`\label{subsec:dep-flow}`)
* **D1.P3** (Split State e Immutabilità) ➔ Trattata in Cap. 3, `\subsection{Split State e Immutabilità (D1.P3)}` (`\label{subsec:split-state}`)
* **D1.P4** (Gerarchia Duale) ➔ Trattata in Cap. 4, `\subsection{Gerarchia Duale \texttt{BaseTest} / \texttt{ExternalToolTest} (D1.P4)}` (`\label{subsec:dual-hierarchy}`)
* **D1.P5** (Gerarchia a Tre Livelli) ➔ Trattata in Cap. 4, `\subsection{Gerarchia a Tre Livelli e Separazione Dati/Valutazione (D1.P5, D2.P3)}` (`\label{subsec:connector-hierarchy}`)
* **D1.P6** (Gateway-Agnostic Adapter) ➔ Trattata in Cap. 3, `\subsection{Gateway-Agnostic Adapter (D1.P6)}` (`\label{subsec:gateway-adapter}`)

**D2: Estensibilità & Manutenibilità**

* **D2.P1** (Discovery Dinamico) ➔ Trattata in Cap. 4, `\subsection{Discovery Dinamico via \texttt{pkgutil} (D2.P1)}` (`\label{subsec:discovery-impl}`)
* **D2.P2** (Scheduling Topologico e DAG) ➔ Trattata in Cap. 3, `\subsection{Scheduling Basato su \glsentrytext{DAG}...}` (`\label{subsec:dag}`) e in Cap 4, `\subsection{Scheduling Topologico...}` (`\label{subsec:dag-impl}`)
* **D2.P3** (Separazione Dati/Valutazione) ➔ Trattata in Cap. 4, `\subsection{Gerarchia a Tre Livelli... (D1.P5, D2.P3)}` (`\label{subsec:connector-hierarchy}`)
* **D2.P4** (Lifecycle e Dependency Injection) ➔ Trattata in Cap. 4, `\subsection{Lifecycle dei Connector e Dependency Injection (D2.P4)}` (`\label{subsec:connector-injection}`)
* **D2.P5** (Auth Abstraction Layer) ➔ Trattata in Cap. 4, `\subsection{Auth Abstraction Layer e Idempotenza dei Token (D2.P5)}` (`\label{subsec:auth-layer}`)
* **D2.P6, D2.P7, D2.P8** (Classificazione A/B, Path Seed, Catalogo Payload) ➔ Trattate assieme in Cap. 4, `\subsection{Classificazione A/B, Path Seed e Catalogo dei Payload (D2.P6, D2.P7, D2.P8)}` (`\label{subsec:connector-classification}`)

**D3: Config & Riproducibilità**

* **D3.P1** (Config-Driven Development) ➔ Trattata in Cap. 3, `\subsection{Config-Driven Development (D3.P1)}` (`\label{subsec:config-driven}`)
* **D3.P2** (Specifica OpenAPI) ➔ Trattata in Cap. 3, `\subsection{La Specifica OpenAPI come Unico Oracolo Formale (D3.P2)}` (`\label{subsec:openapi-sot}`)
* **D3.P3** (Box Gradient) ➔ Trattata in Cap. 3, `\subsection{Il Box Gradient come Mapping... (D3.P3)}` (`\label{subsec:box-gradient}`)
* **D3.P4** (Riproducibilità Deterministica) ➔ Trattata in Cap. 3, `\subsection{Riproducibilità Deterministica (D3.P4)}` (`\label{subsec:reproducibility}`)
* **D3.P5** (Assenza Dipendenze Esterne) ➔ Trattata in Cap. 3, `\subsection{Assenza di Dipendenze di Stato Esterno (D3.P5)}` (`\label{subsec:zero-state}`)

**D4: Robustezza & Sicurezza**

* **D4.P1** (Streaming Evidence Store) ➔ Trattata in Cap. 3, `\subsection{Streaming Evidence Store (D4.P1)}` (`\label{subsec:evidence-store}`) e implementata in Cap 4 (`\label{subsec:evidence-lifecycle}`)
* **D4.P2** (Sanitizzazione Centralizzata) ➔ Trattata in Cap. 4, `\subsection{Sanitizzazione Centralizzata delle Credenziali (D4.P2)}` (`\label{subsec:sanitization}`)
* **D4.P3** (Fail-Safe Error Isolation) ➔ Trattata in Cap. 4, `\subsection{Fail-Safe Error Isolation (D4.P3)}` (`\label{subsec:fail-safe}`)
* **D4.P4** (Gerarchia Eccezioni) ➔ Trattata in Cap. 4, `\subsection{Gerarchia delle Eccezioni con Phase Mapping (D4.P4)}` (`\label{subsec:exception-hierarchy}`)
* **D4.P5** (Degradazione Controllata) ➔ Trattata in Cap. 4, `\subsection{Degradazione Controllata a Tre Livelli (D4.P5)}` (`\label{subsec:graceful-degradation}`)
* **D4.P6** (Teardown LIFO) ➔ Trattata in Cap. 4, `\subsection{Teardown Best-Effort in Ordine LIFO (D4.P6)}` (`\label{subsec:teardown}`)
* **D4.P7** (Safe HTTP Probing Policy) ➔ Trattata in Cap. 4, `\subsection{Safe HTTP Probing Policy e Oracle a Tre Esiti (D4.P7)}` (`\label{subsec:probing-policy}`)
* **D4.P9** (Invarianti TestResult) ➔ Trattata in Cap. 4, `\subsection{Invarianti di \texttt{TestResult} a Livello di Tipo (D4.P9)}` (`\label{subsec:testresult-invariants}`)

**D5: Qualità & Osservabilità**

* **D5.P1, D5.P2** (Tracciabilità Normativa e Finding/InfoNote) ➔ Trattate in Cap. 4, `\subsection{Tracciabilità Normativa e Distinzione Finding/InfoNote (D5.P1, D5.P2)}` (`\label{subsec:traceability}`)
* **D5.P5** (Dual Audit Trail) ➔ Trattata in Cap. 4, `\subsection{Dual Audit Trail e Report Domain-Centric (D5.P5)}` (`\label{subsec:dual-audit-trail}`)

**D7: Packaging & Deployment**

* **D7.P2** (Isolamento Dipendenza AGPL) ➔ Trattata in Cap. 4, `\subsection{Isolamento della Dipendenza AGPL (D7.P2)}` (`\label{subsec:agpl-isolation}`)
* **D7.P3** (Astrazione URL Deployment) ➔ Trattata in Cap. 4, `\subsection{Astrazione Trasparente dell'URL di Deployment (D7.P3)}` (`\label{subsec:url-abstraction}`)

---

### ❌ Proprietà NON TRATTATE (o solo citate senza sezione dedicata)

Queste proprietà appaiono nella tabella iniziale o sono citate nel testo, ma **mancano di una sottosezione o di una vera e propria spiegazione formale** nei Capitoli 3 e 4. Molte di queste andranno probabilmente a popolare i Capitoli 5 e 6.

* **D4.P8 (Fail-Fast):** Ne accenni velocemente nel Capitolo 3 ("la pipeline può essere interrotta esplicitamente tramite configurazione"), ma non c'è una `\subsection{Fail-Fast (D4.P8)}` che ne spieghi il meccanismo implementativo come per le altre.
* **D5.P3 e D5.P4:** Nella tabella del Capitolo 3 appaiono ancora con il placeholder `\hyperref[prop:change-me]{...}` e non sono mai menzionate nel testo.
* **D6.P1 (Semantic Exit Codes):** Viene citata di sfuggita in 3.2.6 ("rendono affidabile D6.P1: i semantic exit codes discussi nella Sezione \ref{sec:devsecops}"). Probabilmente la tratterai nel Capitolo 6.
* **D6.P2:** Appare nella tabella con `\hyperref[prop:change-me]{...}` e non se ne parla nel testo.
* **D6.P3 (Dual-Layer Type Safety):** In tabella ha un label `\label{subsec:dual-layer-type-safety}`, ma questa sezione non esiste nei file 3 e 4. Credo che andrà nel Capitolo 5 (5.2 Release-Readiness).
* **D7.P1 (Binario e Cascata di ricerca):** Viene menzionata al volo nel Capitolo 4 ("La ricerca del binario avviene tramite una cascata a tre canali, documentata come D7.P1"), ma non ha un suo paragrafo formale dedicato.

**Cosa fare con queste ultime?** Per `D4.P8` e `D7.P1`, visto che sono citate nel testo, ti converrà decidere se bastano le citazioni rapide o se vuoi aggiungere un micro-paragrafo in Cap 4. Per il blocco `D6` andrà sicuramente a finire nei capitoli 5 e 6 (la checklist che avevamo fatto conferma questo punto). Per `D5.P3` e `D5.P4` bisogna controllare a cosa ti riferivi originariamente nel piano della tesi.