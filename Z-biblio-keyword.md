### Capitolo 1 e 2: Background, Stato dell'Arte e Tassonomia delle Minacce

In questa fase la ricerca deve concentrarsi sulla giustificazione del problema. È fondamentale dimostrare perché i WAF e i fuzzer tradizionali falliscono e perché la complessità delle API moderne richiede un cambio di paradigma.

**Concetti Chiave da Ricercare:**

* **Semantic Gap:** L'incapacità dei layer di ispezione sintattica di comprendere la logica di business.
* **Combinatorial Wall:** L'esplosione dello spazio degli stati nel fuzzing cieco.
* **API Sprawl:** Proliferazione di Shadow, Zombie e Deprecated API.
* **Stateful vs Stateless Protocol Limits:** I limiti di ispezione su traffico WebSocket, SSE, o serializzazione binaria (gRPC/Protobuf).
* **Vulnerabilità Semantiche:** BOLA/IDOR, BFLA, Mass Assignment, Excessive Data Exposure.

**Query per la Ricerca Accademica:**

* `"semantic gap" AND "Web Application Firewall" AND "business logic vulnerabilities" REST API`
* `"combinatorial explosion" OR "combinatorial wall" AND "API fuzzing" OR "black-box testing"`
* `"Shadow API" OR "Zombie API" automated discovery perimeter security microservices`
* `"Broken Object Level Authorization" OR BOLA OR IDOR automated detection REST API`
* `"Mass Assignment" vulnerability automated discovery web API`
* `"GraphQL" query complexity validation security bypassing WAF`
* `"gRPC" HTTP/2 binary serialization WAF inspection bypass`
* `"Information asymmetry" in software security testing Black Grey White box`

---

### Capitolo 3: Metodologia e Principi Architetturali

Qui la ricerca si sposta sull'Ingegneria del Software. Le decisioni prese per il framework (determinismo, agnosticisimo, DAG) sono concetti con una solida letteratura alle spalle.

**Concetti Chiave da Ricercare:**

* **Contract-Driven Testing:** L'uso della specifica OpenAPI come Single Source of Truth (SSoT) e oracolo formale.
* **DAG Scheduling:** Risoluzione topologica delle dipendenze per l'esecuzione ordinata dei test.
* **Split State Pattern:** Separazione rigorosa tra contesto immutabile (target) e stato mutabile (esecuzione) per prevenire inquinamento dei dati.
* **Box Gradient:** Tassonomia dinamica dei privilegi (es. test fattibili solo con token vs test senza credenziali).
* **Unidirectional Architecture:** Flusso delle dipendenze monodirezionale per isolare il core logic.

**Query per la Ricerca Accademica:**

* `"contract-driven testing" OR "schema-based fuzzing" AND "OpenAPI" OR "Swagger"`
* `using "OpenAPI specification" as test oracle automated security assessment`
* `"Directed Acyclic Graph" test scheduling topological sorting parallel execution CI/CD`
* `"Immutable state" OR "Split state pattern" parallel test execution contexts`
* `"Unidirectional architecture" OR "Unidirectional dependency flow" testing frameworks`
* `"Box gradient" OR privilege-based security assessment API`
* `"Adapter pattern" OR "hardware abstraction layer" applied to API Gateway configuration security`
* `deterministic test execution OR reproducibility in "automated security testing"`

---

### Capitolo 4: Implementazione

Il capitolo più tecnico richiede paper che validino i design pattern applicati allo sviluppo di strumenti di sicurezza, alla gestione dei dati sensibili e alla validazione dell'input.

**Concetti Chiave da Ricercare:**

* **Three-State Oracle:** Il framework decisionale (Enforced, Bypassed, Inconclusive) per minimizzare i falsi positivi nel probing HTTP.
* **Dual-layer Type Safety:** L'uso congiunto di analisi statica (Type Hints/mypy) e validazione a runtime ai confini del sistema (Pydantic).
* **Data Redaction/Sanitization:** Oscuramento automatico di JWT e credenziali prima della scrittura su disco.
* **Streaming Evidence Store:** Uso del formato JSONL per mantenere basso il footprint di memoria nell'aggregazione dei log.
* **LIFO Teardown:** Gestione della pulizia delle risorse di test dipendenti.

**Query per la Ricerca Accademica:**

* `"Three-state oracle" OR "Inconclusive test results" automated API security assessment`
* `"Test data generation" OR "Path parameter instantiation" OpenAPI specification fuzzing`
* `"Automated secret redaction" OR "credential sanitization" in security audit trails JSONL`
* `"Runtime type validation" vs "Static type checking" robust security tools Python`
* `"Test resource cleanup" OR "Teardown phase" LIFO dependency graph stateful testing`
* `"Plugin architecture" OR "Connector pattern" security testing tools integration`
* `Lazy loading in large-scale security reporting interfaces`

---

### Capitolo 5: Validazione Sperimentale

La validazione scientifica richiede metriche. Qui i paper serviranno a contestualizzare come si misurano le performance e l'affidabilità di uno scanner DAST/Security Tool.

**Concetti Chiave da Ricercare:**

* **Network I/O Bound Profiling:** Dimostrare che il collo di bottiglia è l'attesa HTTP e non il calcolo CPU.
* **Idempotenza:** La stabilità statistica e funzionale di un test di sicurezza eseguito ripetutamente.
* **Reproducible Builds:** La sicurezza della supply chain del tool stesso.
* **Proof of Coverage:** La dimostrazione forense che la superficie dichiarata è stata testata.

**Query per la Ricerca Accademica:**

* `"Network-bound" OR "I/O bound" performance profiling automated DAST scanners`
* `"Idempotence" in stateful API security testing automated verification`
* `"Reproducible builds" OR "Supply chain security" python security assessment tools`
* `"Static analysis" integration in security testing tool development lifecycle`
* `Statistical stability and "Proof of coverage" in automated security assessments`

---

### Capitolo 6 e 7: Discussione, DevSecOps e Sviluppi Futuri

In chiusura, la tesi guarda al mondo industriale e alle sfide aperte. Serve letteratura sul DevSecOps e sui limiti noti del testing formale.

**Concetti Chiave da Ricercare:**

* **Specification Drift / Ground Truth Paradox:** Quando la documentazione OpenAPI diverge dall'implementazione reale (il vero limite del contract-driven).
* **Semantic Exit Codes & Fail-Fast:** Strategie di orchestrazione automatica nei Quality Gates delle pipeline CI/CD.
* **Out-of-band Vulnerability Detection:** Rilevamento di Blind SSRF tramite callback esterni (Interactsh).
* **Compensating Controls Assessment:** Valutare controlli passivi (es. healthchecks) in assenza di controlli attivi (es. circuit breakers).
* **Progressive Coverage Augmentation:** Arricchimento dinamico della superficie di attacco basato sui risultati intermedi dei test.

**Query per la Ricerca Accademica:**

* `"Specification drift" OR "documentation mismatch" API security contract-driven`
* `"Oracle problem" in automated security testing API ground truth`
* `"Continuous Security Assurance" microservices pipeline integration DevSecOps`
* `"Semantic exit codes" automated CI/CD pipeline orchestration security gates`
* `"Fail-fast" execution strategy continuous security validation DevSecOps`
* `"Blind SSRF" OR "Server-Side Request Forgery" out-of-band detection API`
* `"Dynamic attack surface discovery" OR "Progressive coverage augmentation" API security scanning`
* `"Modular architecture" multi-protocol security assessment REST GraphQL gRPC`