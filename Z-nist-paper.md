Ho riletto il NIST upd1 completo e ho la struttura della tesi davanti. Procedo con l'analisi sezione per sezione, con proposta di collocazione per ogni pezzo rilevante.

---

## NIST SP 800-228-upd1 — Analisi per la Tesi

---

### §1 Introduction — API gateway, zero trust, ciclo di vita

**Cosa dice**: Il documento inquadra l'API gateway come il componente che riceve le richieste, applica le policy dichiarate (autenticazione, rate limiting) e le instrada al servizio target. Introduce zero trust come principio fondante: non esiste distinzione significativa tra chiamante interno ed esterno, perché il perimetro è l'istanza di servizio stessa. Definisce il ciclo di vita dell'API in due fasi: pre-runtime (pianificazione, sviluppo, build, test, release) e runtime (deploy, operate, monitor, feedback) — che corrisponde al paradigma DevSecOps.

**Utilità per la tesi**: Alta in due punti.

- **§2.2 `\subsec{zero-trust}`** — la definizione normativa di zero trust riferita specificamente alle API cloud-native supporta il tuo paragrafo sul paradigma zero-trust. NIST lo usa esattamente nel contesto che descrivi: non perimetro esterno ma policy enforcement al livello dell'istanza, con gateway come punto di enforcement canonico.
- **§6.2** (applicabilità industriale e DevSecOps) — la classificazione pre-runtime/runtime di NIST mappa direttamente sulla discussione di come APIGuard si integra nel ciclo CI/CD: i test di APIGuard sono un'attività pre-deployment che verifica le garanzie runtime.

---

### §2 API Risks — Tassonomia dei rischi

Questa è la sezione più densa e potenzialmente più utile. Descrivo ogni sottosezione.

**§2.1 Lack of visibility** — Shadow API (definite per uso interno senza revisione di sicurezza), Zombie API (sostituite ma non rimosse), API orfane (team responsabili non più esistenti). Il rischio è che API non inventariate non possano essere protette.

→ **Utilità**: diretta. Questo è esattamente il dominio D0 di APIGuard (Shadow API detection). NIST fornisce la categorizzazione normativa delle ragioni per cui esistono Shadow API — non è solo un problema tecnico ma organizzativo (silos, velocità Agile, M&A). Collocazione: **§2.3 `\subsec{api-sprawl}`** dove già parli di questo fenomeno, e/o **§3.3 `\subsec{domini-tassonomia}`** per ancorare D0 a una classificazione normativa riconosciuta.

**§2.2 Missing/Incorrect/Insufficient Authorization** — tre tipi distinti: (1) autorizzazione assente; (2) autorizzazione eseguita ma su identità, permesso o risorsa sbagliati; (3) autorizzazione a livello di risorsa corretta ma il campo contiene informazioni privilegiate non visibili al livello di accesso. NIST nota che 3 delle 10 voci dell'OWASP API Top 10 riguardano l'autorizzazione.

→ **Utilità**: alta. Il dominio D2 di APIGuard copre l'autorizzazione RBAC (corrispondente al tipo 2 di NIST). Il tipo 1 (assenza) è coperto in parte da D1. Il tipo 3 (information leakage via campo) è fuori scope ma potrebbe essere menzionato come futuro sviluppo in §6.3. Collocazione: **§3.3 `\subsec{domini-tassonomia}`** per ancorare D2 alla tassonomia NIST.

**§2.3 Broken Authentication** — credential stuffing, brute force, token deboli, alg:none nei JWT, mancata validazione di scadenza/firma, credenziali hardcoded. NIST distingue tra robustezza del sistema di autenticazione e corretto utilizzo delle identità autenticate nell'applicazione.

→ **Utilità**: alta per D1. La distinzione NIST tra "sistema di autenticazione robusto" e "utilizzo corretto delle credenziali" è precisa e copre due aspetti che APIGuard testa separatamente: la presenza del controllo di autenticazione (test 1.1) e la robustezza del trasporto (test 1.5/TLS). Collocazione: **§3.3 `\subsec{domini-tassonomia}`**.

**§2.4 Unrestricted Resource Consumption** — DoS via bandwidth saturation, resource starvation, cost amplification (piccolo input → grande consumo). Include sia il compute (CPU, memoria) sia il consumo fisico (SMS per MFA fatigue, API AI costose). NIST specifica: rate limiting, timeouts, circuit breaking, bot detection come mitigazioni.

→ **Utilità**: alta per D4. L'elenco NIST delle mitigazioni (rate limiting, timeout, circuit breaker) corrisponde ai test 4.1, 4.2, 4.3 di APIGuard. NIST conferma che queste tre categorie sono le mitigazioni standard e distingue tra rate limit (protezione da overuse) e quota (billing) — distinzione che APIGuard adotta implicitamente nel suo modello. Collocazione: **§3.3 `\subsec{domini-tassonomia}`** per D4.

**§2.5 Leaking Sensitive Information** — due vettori principali: (1) enumerazione di risorse via differenza tra 403 Forbidden e 404 Not Found — l'attaccante distingue "risorsa esiste ma non hai accesso" da "risorsa non esiste"; (2) leak di informazioni sull'infrastruttura via messaggi di errore (versioni software, nomi interni, path di sistema).

→ **Utilità**: alta. Il punto (2) è già in D6 (information disclosure via stack trace). Il punto (1) — la distinzione 403/404 come canale di information leakage — è un controllo che APIGuard non esplora esplicitamente ma che NIST identifica come rischio. Potrebbe essere citato in **§2.3 `\subsec{categorie-fallimento}`** (manifestazioni concrete del semantic gap) come esempio di violazione semantica invisibile ai WAF, e in **§6.3** come potenziale estensione futura.

**§2.6 Insufficient Input Validation** — due livelli: (1) validazione sintattica (il campo `name` deve essere stringa, non-empty, sotto 100 caratteri); (2) validazione semantica/malicious (input sintatticamente valido ma contenente SQLi, SSRF, zip bomb, billion laughs). NIST distingue esplicitamente "syntactic correct" da "non-malicious".

→ **Utilità**: media-alta per D3. Il dominio D3 di APIGuard copre la validazione dell'input rispetto allo schema OAS (livello 1 di NIST). Il livello 2 (payload malevolo) è coperto parzialmente da D7 (SSRF) e potenzialmente dai connector Schemathesis. Collocazione: **§3.3 `\subsec{domini-tassonomia}`** per D3.

**§2.7 Credential Canonicalization** — i gateway straddle boundaries: ricevono credenziali in formati diversi (JWT, API key, mTLS, Kerberos) e devono tradurle in un formato canonico atteso dall'infrastruttura interna. NIST descrive lo scenario in cui il gateway è l'unico punto che conosce entrambi i formati e può fare la traduzione. Introduce anche il Confused Deputy attack.

→ **Utilità**: bassa per la tesi. Interessante architetturalmente ma fuori scope da APIGuard. APIGuard assume che le credenziali già esistano (le riceve in config.yaml) e non testa il processo di canonicalizzazione. Da non includere.

---

### §3 Recommended Controls — 26 controlli

**Pre-runtime basic (REC-API-1 a REC-API-4)**: tutte le API devono avere una specifica con IDL (OpenAPI per REST, gRPC per protobuf), schema di request/response, governance centralizzata con inventario.

→ **Utilità**: alta. REC-API-1 e REC-API-2 sono il fondamento normativo che giustifica l'approccio OAS-centric di APIGuard. "All APIs must have a specification" è esattamente la precondizione che APIGuard richiede. REC-API-4.2 (inventario delle API incluse shadow e zombie) corrisponde al dominio D0. Collocazione: **§3.1.2 `\subsec{openapi-sot}`** dove OAS viene presentata come fondamento contrattuale — NIST dà la motivazione normativa per questa scelta.

**Pre-runtime advanced (REC-API-5 a REC-API-8)**: annotazione campo per campo (public/private, semantic type PII/PHI/PCI), validazione a livello di campo, inventario runtime con informazioni sulle istanze.

→ **Utilità**: bassa per la tesi corrente. Questi controlli sono al di là di ciò che APIGuard verifica. Potrebbero essere citati in §6.3 come direzione futura ("NIST identifica la field-level authorization come advanced runtime control; APIGuard attualmente opera a livello di endpoint").

**Runtime basic (REC-API-9 a REC-API-18)**: cifratura in transito (TLS), validazione generica (WAF, bot, DoS), autenticazione robusta, autorizzazione, validazione schema request/response, rate limiting, monitoring.

→ **Utilità**: molto alta. Questi controlli sono esattamente quello che APIGuard verifica:
- REC-API-9 (TLS) → test 1.5
- REC-API-11 (autenticazione) → test 1.1, 1.4
- REC-API-12 (autorizzazione) → test 2.1
- REC-API-13 (validazione schema) → test 3.3
- REC-API-15-16 (rate limiting) → test 4.1, 4.2, 4.3
- REC-API-18 (monitoring/logging) → dominio D5

Collocazione principale: **§3.3 `\subsec{domini-tassonomia}`** — i domini di APIGuard corrispondono ai controlli basic runtime che NIST prescrive per qualsiasi API cloud-native.

**Runtime advanced (REC-API-19 a REC-API-26)**: field-level validation, authorization per campo, semantic data discovery, non-signature payload scanning (AI API), resource enumeration prevention.

→ **Utilità**: bassa per la tesi corrente, utile per §6.3 future work. NIST identifica questi come "advanced" che richiedono maturità organizzativa superiore; APIGuard si posiziona nel basic tier che NIST dice deve essere adottato immediatamente da tutte le organizzazioni.

---

### §4 Implementation Patterns — Gateway Models

**§4.1 Centralized gateway**: singolo componente di enforcement. Vantaggi: singolo punto di controllo, facile auditing. Svantaggi: shared fate outage, noisy neighbors, long change lead times, bypassabile via pivot interno.

**§4.2 Hybrid gateway**: policy cross-cutting (autenticazione, rate limiting) nel gateway centralizzato; policy application-specific (autorizzazione, validazione) nell'applicazione o gateway dedicato per app.

**§4.3 Distributed gateway**: gateway per-applicazione, spesso come sidecar nel service mesh. No shared fate; enforcement al livello dell'istanza. Più complesso per auditing distribuito.

**§4.4.1 WAF limitation**: "WAFs generally do not work at the API level." Signature-based, fundamentally reactive, enforce only at perimeter. Excellent first step, not a complete solution.

→ **Utilità dei pattern (§4.1-4.3)**: molto alta per **§2.2 `\subsec{modelli-esposizione}`**. La tesi già descrive i modelli di esposizione (gateway API dedicato, Kubernetes Ingress, service mesh, managed cloud). NIST fornisce la classificazione normativa esatta di questi pattern con un'analisi dei trade-off che supporta la sezione. Questa è la collocazione più naturale e forte.

→ **Utilità per §3.1.1 `\subsec{agnosticismo}`**: il fatto che esistano tre pattern diversi giustifica la scelta di agnosticismo — APIGuard deve funzionare indipendentemente da quale pattern è adottato.

→ **Utilità WAF (§4.4.1)**: per **§2.4.1 `\subsec{dast-sast}`** (già discussa — supporta la frase sulla limitazione del WAF nel contesto delle API).

---

### Appendici

**Appendix A**: tassonomia delle API (public/private/partner; request-response vs event-driven; REST/gRPC/GraphQL/SOAP/WebSocket).

→ **Utilità**: media per **§2.1 `\subsec{tassonomia-stili}`** che già descrive questi stili. NIST potrebbe essere citato come riferimento normativo per la classificazione, ma la tesi ha già le proprie fonti qui.

**Appendix B**: DevSecOps phases e controlli associati.

→ **Utilità**: alta per **§6.2** (applicabilità industriale). La tabella mostra che la fase "Test" include "Ensure that validation routines perform as intended in various runs of API requests and responses" — che è esattamente cosa fa APIGuard. Cita in §6.2 come quadro normativo nel quale APIGuard si colloca nella fase Test/Deploy del ciclo DevSecOps.

**Appendix C**: tipi di rate limit (rate limits, quotas, concurrent connection limits, payload size limits, response time limits, IP-based limits, role-based limits).

→ **Utilità**: bassa. Già coperta dalla letteratura esistente, nessun valore aggiunto.

**Appendix D e E**: tabelle riassuntive di §2 e §3. Aggiunte nell'upd1. Utili per orientamento ma non citabili come contenuto aggiuntivo.

---

## Mappa delle collocazioni consigliate

| NIST | Sezione tesi | Motivazione |
|---|---|---|
| §1.1 Zero trust | §2.2 `\subsec{zero-trust}` | Fondamento normativo del paradigma gateway come enforcement point |
| §2.1 Visibility / Shadow API | §2.3 `\subsec{api-sprawl}` e/o §3.3 `\subsec{domini-tassonomia}` D0 | Definizione normativa del perché le shadow API esistono |
| §2.2–2.6 Risk taxonomy | §3.3 `\subsec{domini-tassonomia}` | I domini D0-D7 coprono esattamente i rischi NIST §2 |
| §3 REC-API-1/2 (spec obbligatoria) | §3.1.2 `\subsec{openapi-sot}` | Giustificazione normativa per OAS come fondamento |
| §3 REC-API-9,11,12,13,15-16,18 | §3.3 `\subsec{domini-tassonomia}` | I basic runtime controls corrispondono 1:1 ai domini di APIGuard |
| §4.1–4.3 Gateway patterns | §2.2 `\subsec{modelli-esposizione}` | Classificazione normativa dei tre pattern con trade-off |
| §4.1–4.3 Gateway patterns | §3.1.1 `\subsec{agnosticismo}` | Giustifica l'agnosticismo: pattern diversi richiedono un tool indipendente dal pattern |
| §4.4.1 WAF limitation | §2.4.1 `\subsec{dast-sast}` | Supporto normativo per la limitazione del WAF nel contesto API |
| Appendix B DevSecOps | §6.2 applicabilità industriale | APIGuard nella fase Test/Deploy del ciclo NIST |
| §3.2.2 Advanced controls | §6.3 `\subsec{ricerca-aperta}` | Direzioni future che NIST già identifica come advanced tier |

**Le due collocazioni più forti e prioritarie sono:**
1. **§2.2 `\subsec{modelli-esposizione}`** — §4 NIST sui pattern gateway, con analisi dei trade-off
2. **§3.3 `\subsec{domini-tassonomia}`** — §2+§3 NIST come fondamento normativo dei domini di assessment