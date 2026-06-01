# Schede Bibliografiche — Lettura Integrale dei 12 Paper

*Documento prodotto da lettura riga per riga dei file `.pdf` (archivi ZIP contenenti testo estratto e immagini). Ogni affermazione è ricavabile dal testo letto. Dove il testo non forniva dati sufficienti, lo si dichiara esplicitamente.*

---

## 1. RESTler: Stateful REST API Fuzzing
**Autori:** Vaggelis Atlidakis, Patrice Godefroid, Marina Polishchuk  
**Sede:** ICSE 2019, DOI 10.1109/ICSE.2019.00083

### Contenuto

RESTler è il primo fuzzer stateful per API REST. Il paper parte da un'osservazione sperimentale precisa: i fuzzer stateless generano in massima parte risposte HTTP 4xx perché inviano richieste prive delle precondizioni necessarie. Il contributo centrale è un algoritmo che analizza la specifica Swagger/OpenAPI e inferisce automaticamente le dipendenze produttore-consumatore tra le operazioni: se un endpoint `POST /posts` produce un campo `id` nella risposta, e un endpoint `DELETE /posts/{id}` consuma quel campo nel path, RESTler genera la sequenza nell'ordine corretto senza intervento manuale.

L'algoritmo opera in due funzioni iterative: `EXTEND` aggiunge a ogni sequenza valida nuove operazioni con dipendenze soddisfatte, mentre `RENDER` concretizza le operazioni con valori estratti da dizionari configurabili e le esegue, scartando le sequenze che producono risposte fuori dalla fascia 2xx. Sono presentate tre strategie di ricerca (BFS, BFS-Fast, RandomWalk) confrontate sperimentalmente su GitLab, che conta oltre 376.000 righe di codice Ruby. BFS garantisce copertura grammaticale completa ma non scala con il numero di operazioni; RandomWalk raggiunge profondità maggiori esplorando sequenze di lunghezza fino a 33 nel tempo budget di 5 ore, trovando 21 bug su 22 unici. La valutazione su 6 gruppi di API GitLab mostra che l'aumento della copertura codice è correlato all'allungamento delle sequenze: la funzionalità di cherry-pick di un commit richiede almeno 3 operazioni in sequenza per essere raggiunta.

Gli autori dichiarano esplicitamente il limite dell'oracolo: RESTler definisce un bug come un codice HTTP 500 ("500 Internal Server Error"), e "cannot detect vulnerabilities that are not visible though HTTP status codes". Questa restrizione è affermata nel testo come limitazione corrente, non come scelta di design consolidata. In totale, 28 bug sono stati trovati in GitLab e un numero non specificato in quattro servizi Azure e Office365, tutti confermati e corretti dai team responsabili.

### Perché è adatto dove viene collocato

Il paper è la referenza canonica per il concetto di "combinatorial wall" nel fuzzing delle API REST, ovvero l'esplosione combinatoria delle sequenze di richieste che rende inefficace il testing stateless. La sua limitazione esplicita dell'oracolo (HTTP 500 come unico indicatore di difetto) è precisamente il gap che le estensioni successive, incluso l'approccio contract-driven di APIGuard, si propongono di colmare. Nel Capitolo 2, la citazione a RESTler fonda l'argomento che la conoscenza delle dipendenze tra operazioni è necessaria ma non sufficiente: occorre anche un oracolo formale derivato dal contratto.

---

## 2. Checking Security Properties of Cloud Service REST APIs
**Autori:** Vaggelis Atlidakis, Patrice Godefroid, Marina Polishchuk  
**Sede:** ICST 2020, DOI 10.1109/ICST46399.2020.00046

### Contenuto

Il paper estende RESTler con quattro *active property checkers* che verificano garanzie di sicurezza formali sulle API REST. Le quattro regole sono: (1) **use-after-free** — una risorsa cancellata non deve rimanere accessibile; (2) **resource-leak** — una risorsa creata con errore non deve lasciare effetti collaterali nel backend; (3) **resource-hierarchy** — una risorsa figlia non deve essere accessibile tramite un parent diverso da quello in cui è stata creata; (4) **user-namespace** — una risorsa creata nell'ambito di un utente non deve essere accessibile dall'ambito di un altro utente. Gli autori precisano che tutte e quattro le regole sono state ispirate da bug reali trovati in produzione tramite penetration testing manuale su Azure e Office365.

La distinzione tra *active checker* e monitoraggio passivo è esplicitata nel testo: un checker passivo osserva le sequenze generate dal driver principale senza aggiungere richieste; un active checker genera attivamente nuovi casi di test mirati a innescare la violazione della regola. Questa distinzione è strutturale: la use-after-free violation emerge solo se si tenta di rileggere la risorsa appena cancellata, e tale tentativo non avviene mai nel testing baseline. Viene introdotta una nuova strategia di ricerca, BFS-Cheap, che offre un compromesso tra BFS (copertura grammaticale completa ma bassa profondità) e BFS-Fast (alta profondità, copertura ridotta), necessario perché i checker attivano un numero di test aggiuntivi proporzionale alle opportunità del driver principale. In totale, su una decina di servizi Azure e Office365 testati, circa due terzi dei bug sono stati rilevati come HTTP 500 e un terzo come violazioni di regola, tutti confermati e corretti dai team.

Il paper include un esempio concreto di violazione della resource-hierarchy in un servizio Office365 di messaggistica: una risposta `204 Allowed` viene restituita quando un utente tenta di modificare una risposta a un messaggio altrui usando il proprio `message-id`, anziché il `404 Not Found` atteso. Il bug emerge perché il controllo dei permessi sul `reply_id` non verifica l'intera gerarchia parent-child.

### Perché è adatto dove viene collocato

Questo è il precedente accademico diretto di APIGuard nella letteratura: il primo lavoro che introduce property checkers formali per API REST e li valida su servizi cloud in produzione. La sua collocazione a supporto del §3.3 (oracolo formale) e del §2.4 (evoluzione del fuzzing verso il security assessment formale) è necessaria: senza questo riferimento, l'affermazione che APIGuard introduce un paradigma "a oracolo formale" apparirebbe come contributo senza radici nella letteratura. Contemporaneamente, il confronto con APIGuard è produttivo: RESTler/Checkers richiede il codice sorgente dei servizi cloud per la copertura, opera su sequenze generate dinamicamente, e non supporta una struttura multi-dominio; APIGuard verifica garanzie su API gateway mediante specifica OpenAPI come SSoT, senza accesso al codice del backend.

---

## 3. Pythia: Grammar-Based Fuzzing of REST APIs with Coverage-guided Feedback and Learning-based Mutations
**Autori:** Vaggelis Atlidakis, Roxana Geambasu, Patrice Godefroid, Marina Polishchuk, Baishakhi Ray  
**Sede:** arXiv preprint 2005.11498 (2020)

### Contenuto

Pythia affronta le due limitazioni residue di RESTler dopo la generazione stateful delle sequenze: il dizionario dei valori primitivi è statico e non si adatta al target, e non esiste feedback di copertura per prioritizzare le sequenze più promettenti. Il contributo principale è un motore di mutazione basato su un autoencoder seq2seq (encoder + decoder GRU a 256 unità, addestrato in meno di due ore su CPU) che apprende i pattern di utilizzo comuni delle API dai seed generati da RESTler, e li muta minimalmente mantenendo la validità sintattica.

Il ciclo operativo si articola in tre fasi: parsing (produzione di alberi di sintassi astratti dalla grammatica regolare delle sequenze), mutazione basata sull'apprendimento (perturbazione dell'embedding latente del seed, confronto tra la predizione del decoder e l'originale per decidere la strategia di mutazione), ed esecuzione con monitoraggio della copertura (raccolta dei basic block attivati tramite TracePoint in Ruby per GitLab). La distinzione tra Case 1 e Case 2 delle mutazioni è strutturale: nelle posizioni in cui decoder e originale coincidono, il modello non ha visto varianza sufficiente e si applicano regole grammaticali non presenti nel seed (potenzialmente più distruttive); nelle posizioni in cui divergono, il modello suggerisce valori alternativi plausibili.

La valutazione su 9 API di GitLab, Mastodon e Spree mostra che RESTler raggiunge un plateau dopo 24-32 ore (a seconda dell'API), mentre Pythia continua ad aumentare la copertura nel budget successivo di 24 ore. L'analisi della union e dell'intersection tra le righe coperte da RESTler e da Pythia mostra che l'intersezione rimane costante mentre la union cresce: i due strumenti esplorano sottospazi disgiunti del codice. In totale, Pythia trova 29 bug nuovi (confermati), di cui RESTler ne trovava 2 nelle stesse condizioni.

### Perché è adatto dove viene collocato

Pythia completa la traiettoria evolutiva del fuzzing per API REST nel §2.4: RESTler risolve le dipendenze tra operazioni, Pythia introduce il coverage-guided e le mutazioni apprese, portando il paradigma fuzzing al suo limite attuale. Citarlo consente di mostrare perché anche i fuzzer più avanzati rimangano orientati alla scoperta di crash e non alla verifica di garanzie semantiche: il meccanismo di reward (copertura di codice) non distingue tra un bug di robustezza e una violazione di policy di autorizzazione.

---

## 4. Automated Black-box Testing of Mass Assignment Vulnerabilities in RESTful APIs
**Autori:** Davide Corradini, Michele Pasqua, Mariano Ceccato  
**Sede:** ICSE 2023, DOI 10.1109/ICSE48619.2023.00213

### Contenuto

Il paper propone il primo approccio completamente automatizzato in black-box per il rilevamento del Mass Assignment nelle API REST. La vulnerabilità è definita come la possibilità di sovrascrivere attributi interni del modello di dominio (es. colonne di database) attraverso il meccanismo di auto-binding dei framework web (Spring, Flask, Express, Laravel), che per default mappa tutti i campi JSON in ingresso alle proprietà corrispondenti dell'oggetto. Un attributo è "read-only" se compare nello schema di risposta di un'operazione GET ma non nello schema di input di alcuna operazione POST/PUT/PATCH sullo stesso tipo di risorsa.

L'approccio si articola in tre passi. Il primo identifica gli attributi read-only tramite clustering EM (Expectation-Maximization) sugli operandi in formato booleano (presenza/assenza di ciascun campo nell'input o output dell'operazione), normalizzati con lo stemming di Porter, per raggruppare le operazioni che agiscono sullo stesso tipo di risorsa. Il secondo passo genera sequenze di test concrete da due template astratti: *Update-injection* (`Create, Read, UpdateWithInjection, Read`) e *Create-injection* (`CreateWithInjection, Read`), dove l'operazione di iniezione aggiunge il campo read-only come campo extra non documentato nella richiesta. Il terzo passo è un oracolo di sicurezza che confronta il valore del campo read-only prima e dopo l'iniezione: se i due valori coincidono con quello iniettato, la vulnerabilità è stata sfruttata con successo.

La valutazione su 5 API (VAmPI, OWASP, Toggle, Bookstore, CRUD) scritte in Java, Python, ASP.NET e Node.js mostra precisione del 100% e recall del 100% su quasi tutti i casi di studio (eccezione: 1 esecuzione su 10 su OWASP, dovuta a fallimento nell'istanziazione della sequenza). Come effetto collaterale, i test rilevano anche crash (5xx) e accettazione di richieste non conformi alla specifica, producendo 5 bug aggiuntivi da 5 difetti distinti.

### Perché è adatto dove viene collocato

Il paper dimostra empiricamente che il Mass Assignment è rilevabile automaticamente dall'analisi strutturale della specifica OpenAPI, senza accesso al codice sorgente. Questo supporta l'argomento del §2.3.2 che i WAF perimetrali non possono intercettare questa vulnerabilità (il payload JSON che la veicola è sintatticamente valido e indistinguibile da una richiesta legittima), e che solo un approccio basato sul contratto consente di identificare i campi a rischio. È la referenza principale per il Mass Assignment a causa della venue (ICSE, tier-1) e del rigore metodologico, da affiancare al più recente Mazidi 2024 per la prospettiva di mining preventivo della specifica.

---

## 5. NAUTILUS: Automated RESTful API Vulnerability Detection
**Autori:** Gelei Deng, Zhiyi Zhang, Yuekang Li, Yi Liu, Tianwei Zhang, Yang Liu, Guo Yu, Dongjin Wang  
**Sede:** USENIX Security 2023, pp. 5593–5609

### Contenuto

NAUTILUS affronta due limiti strutturali degli scanner di vulnerabilità esistenti applicati alle API REST: l'incapacità di ottenere le relazioni tra operazioni e la mancanza di consapevolezza dell'ordine corretto di esecuzione. Il contributo centrale è una strategia di annotazione della specifica OpenAPI con due tipi di primitive: *operation annotations* (campi `dep-operation`, `term-operation`, `alias` aggiunti come estensioni `x-operation-annotation`) e *parameter annotations* (strategia di generazione valori: `example`, `dynamic`, `success`, `mutation`). Le annotazioni sono leggibili da macchine e da umani, compatibili con lo standard OpenAPI 3.0, e vengono aggiornate dinamicamente durante il testing.

NAUTILUS opera in due stadi: *exploration* (maximizza la copertura delle operazioni generando sequenze corrette basate sulle annotazioni, aggiornando le annotazioni via feedback di esecuzione) e *exploitation* (inietta payload di attacco da FUZZDB nelle posizioni identificate, verificando la risposta con tre tipi di oracolo: status code, struttura del body, relazione semantica tra payload e risposta). La valutazione su 6 servizi benchmark (NodeGoat, JuiceShop, VAmPI, SeoPanel, Navigate CMS, Gila CMS) mostra un incremento medio del 141% nel numero di vulnerabilità rilevate e del 104% nella copertura delle operazioni rispetto ai baseline ZAP, w3af, RESTler e MOREST, con un false positive rate del 24.74%.

Applicato a 9 servizi reali, NAUTILUS trova 23 vulnerabilità zero-day, di cui 12 con CVE assegnato: inclusa una OGNL injection (Remote Code Execution) in Atlassian Confluence (CVE not specified, "Internally Issued") e tre privilege escalation in Microsoft Azure. La valutazione ablation mostra che le annotation contribuiscono in modo diversificato: le operation annotation sono più rilevanti per servizi con logica di sequenza complessa (es. JuiceShop), le parameter annotation per servizi con formato dei parametri stretto (es. SeoPanel).

Il paper dichiara esplicitamente che le annotazioni manuali sono necessarie per una parte delle vulnerabilità più complesse: "7 of 23 0-day vulnerabilities require manual annotations to be detected".

### Perché è adatto dove viene collocato

NAUTILUS è il precedente nella letteratura strutturalmente più simile a APIGuard come obiettivo (vulnerability detection automatizzata su API REST reali) e come venue (USENIX Security, top-tier). La distinzione architetturale fondamentale è che NAUTILUS richiede annotazioni manuali aggiuntive sulla specifica per risolvere le relazioni tra operazioni e i formati dei parametri; APIGuard deriva queste informazioni interamente dalla specifica OpenAPI come Single Source of Truth, senza richiedere annotazioni aggiuntive. Questa distinzione è il contributo differenziante più diretto da articolare nel §3.2 o §3.3.

---

## 6. Testing RESTful APIs: A Survey
**Autori:** Amid Golmohammadi, Man Zhang, Andrea Arcuri  
**Sede:** ACM Transactions on Software Engineering and Methodology, vol. 33, n. 1, art. 27 (2023), DOI 10.1145/3617175

### Contenuto

Il paper conduce una revisione sistematica della letteratura su 92 articoli scientifici pubblicati tra il 2009 e il 2022 sul testing delle API REST, con 12 research question organizzate in quattro prospettive: status delle pubblicazioni, approcci al testing, strumenti disponibili, sfide aperte e risolte. La metodologia include ricerca in 7 database (IEEE, ACM, ScienceDirect, Wiley, Web of Science, MIT Libraries, Springer) più forward e backward snowballing.

I risultati principali documentano una crescita esponenziale delle pubblicazioni dal 2017 in poi (da 0–2 paper/anno prima del 2017 a 24 nel 2021). Il 66% dei paper propone un nuovo approccio automatizzato, il 73% degli approcci è black-box. Le metriche più usate per la valutazione sono quelle di fault detection (status code 5xx, violazioni dello schema, violazione di regole), con la copertura basata sullo schema come seconda categoria più frequente. Il problema delle dipendenze tra risorse è la sfida più affrontata (8 paper), seguita dall'inferenza delle dipendenze tra parametri (6 paper) e dall'oracle problem (5 paper).

Lo strumento più referenziato è EvoMaster (19 paper), seguito da RESTest e RESTler (8 paper ciascuno). Tra le sfide aperte, il security testing è la categoria più citata come future work (10 paper), a testimonianza del gap tra il testing funzionale e quello orientato alla sicurezza. Il survey identifica 20 strumenti non accademici e classifica le caratteristiche supportate dai 16 prototipi open source secondo 5 categorie di feature (input, output, authentication support, database reset, automated code instrumentation). Solo EvoMaster supporta il reset del database e la strumentazione automatica del codice.

### Perché è adatto dove viene collocato

Il survey è la referenza di inquadramento per l'intero §2.4 (panoramica degli strumenti di testing REST API): citarlo permette di posizionare APIGuard rispetto all'intero campo con una sola fonte autorevole invece di elencare ogni strumento individualmente. In particolare, il fatto che 10 paper su 92 identifichino il security testing come future work aperto supporta la motivazione della tesi: APIGuard si colloca precisamente nel gap rilevato da questo survey.

---

## 7. Mining REST APIs for Potential Mass Assignment Vulnerabilities
**Autori:** Arash Mazidi, Davide Corradini, Mohammad Ghafari  
**Sede:** EASE 2024, ACM, DOI 10.1145/3661167.3661204

### Contenuto

Il paper introduce LightMass, uno strumento leggero per identificare operazioni e attributi potenzialmente vulnerabili al Mass Assignment analizzando esclusivamente la specifica OpenAPI, senza interagire con il sistema in esecuzione. A differenza di RestTestGen (che richiede una API attiva per il testing black-box) e di Akto (che è semi-automatico e richiede di indicare manualmente le operazioni sospette), LightMass opera in fase di specifica, abilitando la rilevazione preventiva già prima del deployment.

L'algoritmo si compone di tre passi: parsing della specifica e risoluzione dei `$ref`, identificazione di coppie simili di operazioni GET e POST/PUT/PATCH basata sul coefficiente di Jaccard tra gli attributi (con stemming di Porter per normalizzare i nomi), identificazione degli attributi read-only come quelli presenti nella risposta GET ma assenti nella richiesta dell'operazione confrontata. Il report viene generato quando la similarità supera il 50% e il numero di attributi nel GET eccede quello nel POST/PUT/PATCH.

La valutazione su 100 API selezionate da dataset precedenti, GitHub e Google APIs identifica 25 API potenzialmente vulnerabili (115 endpoint, 133 operazioni, 495 attributi candidati). Il confronto dinamico su 6 API open source eseguibili localmente (VAmPI, OWASP, Toggle, CRUD, Bookstore, StudentAPI) mostra risultati identici a RestTestGen su 5 API su 6; su VAmPI, LightMass segnala un falso positivo (campo `owner` marcato come candidato ma protetto da un whitelist server-side). Gli autori riconoscono che LightMass non può distinguere tra un attributo realmente vulnerabile e uno protetto da meccanismi non visibili nella specifica.

### Perché è adatto dove viene collocato

LightMass è complementare al paper di Corradini 2023 sulla stessa vulnerabilità: dove Corradini propone un approccio di testing attivo che esegue sequenze di richieste per confermare la vulnerabilità, LightMass opera staticamente sulla specifica con costo computazionale minimo (meno di 1 secondo per API), abilitando un'analisi su larga scala. La coppia va citata insieme nel §2.3.2 per mostrare il continuum tra rilevazione preventiva (LightMass, specifica) e conferma empirica (Corradini, testing attivo). Entrambi dimostrano che la vulnerabilità è strutturale nella specifica OpenAPI stessa, non nel traffico.

---

## 8. WENDIGO: Deep Reinforcement Learning for Denial-of-Service Query Discovery in GraphQL
**Autori:** Shae McFadden, Marcello Maugeri, Chris Hicks, Vasilios Mavroudis, Fabio Pierazzi  
**Sede:** IEEE S&P Workshops (Deep Learning Security and Privacy, co-located IEEE S&P 2024), pp. 68–75, DOI 10.1109/SPW63631.2024.00012

### Contenuto

WENDIGO è il primo approccio basato su Deep Reinforcement Learning per la scoperta automatizzata di query GraphQL sfruttabili per attacchi Denial-of-Service. Il punto di partenza è l'osservazione che GraphQL consente query semanticamente complesse attraverso un singolo endpoint HTTP, e che i vettori di attacco (oggetti circolari, duplicazione di campi, alias overloading, object limit overriding, array-based query batching) permettono di saturare le risorse del server con un numero minimo di richieste. Un survey del 2022 citato nel paper riporta che solo il 21.7% dei GraphQL deployment usa timeout, il 23.1% rate limiting e il 26.7% depth limiting.

L'ambiente DRL è progettato secondo le specifiche di Gymnasium: lo stato rappresenta la query corrente come vettore con valori di duplicazione e alias per ogni campo/oggetto; le azioni sono operazioni `add`/`remove` su ciascuna componente dello stato; il reward è il tempo di risposta in secondi. L'agente usa PPO (Proximal Policy Optimization), un metodo actor-critic, confrontato con Random, Random-Greedy e EvoMaster (black-box).

La valutazione su DVGA (Damn Vulnerable GraphQL Application) in Docker mostra risultati significativi. Nel setting UNPROTECTED (max depth 10, max height 100), l'agente PPO raggiunge un tempo di risposta di 1,649.57 secondi, causa la terminazione del container Docker per esaurimento di memoria, e produce un attacco DoS con 99.998% denial usando solo 2 query per ora. EvoMaster raggiunge al massimo 23.96 secondi nello stesso setting: WENDIGO supera EvoMaster di 68.85 volte. Nel setting PROTECTED (con depth limiting a 5 e height a 5), PPO raggiunge 208 secondi, con 99.852% denial usando 178 query, contro le 1,434 di EvoMaster.

### Perché è adatto dove viene collocato

WENDIGO è la referenza diretta per la sezione sulle vulnerabilità GraphQL (§2.8 nella struttura prevista) e per l'argomento che il rate limiting volumetrico (misura di richieste per secondo) non costituisce una difesa sufficiente contro il DoS semantico. Il paper dimostra sperimentalmente che 2 richieste per ora possono provocare un DoS completo, il che invalida la premessa di qualsiasi difesa basata sul conteggio delle richieste senza considerare la complessità computazionale della singola query.

---

## 9. Enhancing REST API Fuzzing with Access Policy Violation Checks and Injection Attacks
**Autori:** Omur Sahin, Man Zhang, Andrea Arcuri  
**Sede:** arXiv preprint 2604.00702 (2026)

### Contenuto

Il paper propone nove oracoli automatizzati per il rilevamento di fault legati all'accesso e all'autorizzazione nelle API REST, integrabili come fase di post-processing in qualsiasi fuzzer che supporti autenticazione multi-utente. I nove oracoli, identificati con codici F2xx/F9xx, sono: F205 Not Recognized Authentication (un utente autenticato riceve 401 su un endpoint dove le sue credenziali sono valide), F204 Existence Leakage (lo stesso endpoint restituisce 403 per un ID esistente e 404 per un ID inesistente, rivelando l'esistenza di risorse protette), F206 Missed Authorization Checks (un utente è bloccato su DELETE ma non su PUT/PATCH della stessa risorsa), F901 Anonymous Modifications (operazioni DELETE/PUT/PATCH hanno successo senza credenziali), F900 Ignore Anonymous (un endpoint richiede autenticazione ma la ignora se non fornita), F902 Leaked Stack Trace (la risposta HTTP 500 include lo stack trace dell'applicazione), F903 Hidden Accessible (endpoint non dichiarati nella specifica OpenAPI rispondono con status diverso da 403/405/501), F200 SQL Injection (sleep-based detection), F201 XSS (reflected e stored).

I requisiti dell'approccio sono esclusivamente: una specifica OpenAPI e informazioni di autenticazione per almeno due utenti con ruoli diversi. Non sono richieste annotazioni aggiuntive né accesso al codice sorgente. L'integrazione con EvoMaster genera test case eseguibili in Java, Kotlin, Python o JavaScript per ogni fault trovato. La valutazione copre 52 API distinte: 9 artificiali con fault iniettati, 8 API vulnerabili-by-design (capital, crapi, dvapi, dvws-node, vampi, ecc.), 36 API dal corpus WFD in white-box. Su 36 API WFD, sono rilevati più di 300 fault distinti; il tempo di esecuzione della fase di security è mediana di 13.6 secondi con overhead massimo di 38 minuti su proxyprint.

Un caso notevole è individuato in familie-ba-sak (API del governo norvegese per il child benefit processing): un endpoint restituisce HTTP 200 con body `FEILET` (errore in norvegese) anche per richieste non autenticate, mentre lo stesso endpoint restituisce 403 per l'utente Forvalter. Gli autori discutono esplicitamente se questo sia una vulnerabilità di sicurezza o un uso scorretto della semantica HTTP, concludendo che entrambe le interpretazioni identificano un fault grave.

### Perché è adatto dove viene collocato

Il paper è la referenza più diretta per l'argomento del §2.3.2 che i fuzzer tradizionali non rilevano BOLA e BFLA perché non dispongono di oracoli per vulnerabilità logiche. EvoMaster con questi oracoli estesi è il confronto metodologicamente più vicino ad APIGuard nell'intera letteratura: entrambi richiedono credenziali per più utenti e verificano garanzie semantiche di accesso. La distinzione rilevante per la tesi è che EvoMaster/Sahin parte da un fuzzer che genera traffico e aggiunge oracoli come post-processing, mentre APIGuard parte dall'oracolo (le garanzie dichiarate nella configurazione del gateway) come principio fondante e costruisce intorno a esso le sequenze di verifica.

---

## 10. HDiff: A Semi-automatic Framework for Discovering Semantic Gap Attack in HTTP Implementations
**Autori:** Kaiwen Shen, Jianyu Lu, Yaru Yang, Jianjun Chen, Mingming Zhang, Haixin Duan, Jia Zhang, Xiaofeng Zheng  
**Sede:** DSN 2022 (Best Paper Award), DOI 10.1109/DSN53405.2022.00014

### Contenuto

HDiff propone una definizione formale operativa di *semantic gap attack* nel contesto HTTP e un framework semi-automatico per la loro scoperta sistematica. La definizione è: l'attacco sfrutta interpretazioni semantiche inconsistenti dello stesso messaggio HTTP da parte di componenti diversi nella catena di elaborazione (proxy, WAF, CDN, server applicativo), producendo un comportamento che nessuno dei componenti classificherebbe come errore isolatamente ma che nella composizione diventa vulnerabilità. Il paper analizza tre classi di attacco: HTTP Request Smuggling (HRS), Host of Troubles (HoT) e Cache-Poisoned DoS (CPDoS).

Il framework si articola in due moduli principali. Il Documentation Analyzer estrae automaticamente due tipi di regole dalla specifica HTTP RFC 7230–7235 (172.088 parole, 5.995 frasi): le Specification Requirements (SRs), frasi con alta intensità semantica di vincolo (identificate tramite un classificatore di sentiment basato su Stanza), convertite in espressioni formali tramite dependency parsing e textual entailment (AllenNLP); e le regole ABNF, estratte tramite pattern matching e normalizzate per eliminare duplicazioni e riferimenti incrociati tra RFC. Il modulo di Differential Testing manda gli stessi input generati a 10 implementazioni HTTP (IIS, Tomcat, Weblogic, Lighttpd, Apache, Nginx, Varnish, Squid, Haproxy, ATS) e confronta i comportamenti tramite il vettore HMetrics (status code, host interpretato, dati inoltrati).

In totale, HDiff genera 8.427 test case dall'SR translator e 92.658 dall'ABNF generator. Vengono trovate 14 vulnerabilità che coprono tutte e tre le classi di attacco, con 7 nuovi CVE assegnati (Tomcat CVE-2019-17569 e CVE-2020-1935, IIS CVE-2020-0645, Weblogic tre CVE, ATS CVE-2020-1944). Tre nuovi vettori di attacco sono identificati per la prima volta: l'HTTP-version invalido come vettore HRS e CPDoS, l'Expect header in richieste GET come vettore HRS/CPDoS, e il blind forwarding di HTTP/0.9 come vettore CPDoS.

### Perché è adatto dove viene collocato

HDiff fornisce la radice bibliografica accademica del concetto di "semantic gap" nel §2.3.1 della tesi. Il paper dimostra che le inconsistenze di parsing tra componenti della catena HTTP non sono casi isolati ma una classe strutturale di vulnerabilità, e lo fa con rigore metodologico e una valutazione empirica su 10 implementazioni reali. Il collegamento con il §2.3.1 della tesi va contestualizzato: HDiff formalizza il semantic gap a livello di parsing protocollare HTTP (Content-Length/Transfer-Encoding, Host header), mentre la tesi usa il termine in un senso più ampio che include la cecità dei WAF rispetto alla logica applicativa. Un raccordo esplicito ("HDiff formalizza il termine al livello del parsing del protocollo; la presente trattazione ne estende la portata al livello del contratto applicativo") è necessario per evitare ambiguità nell'uso del termine.

---

## 11. An Analysis of How Many Undiscovered Vulnerabilities Remain in Information Systems
**Autore:** Jonathan Spring  
**Sede:** Computers & Security, vol. 131, art. 103191, Elsevier (2023), DOI 10.1016/j.cose.2023.103191

### Contenuto

Il paper argomenta formalmente, attraverso concetti della teoria della computabilità, che il numero di vulnerabilità non scoperte in qualsiasi sistema software moderno in esercizio è praticamente illimitato. La struttura dell'argomento procede per passi distinti. Innanzitutto, la domanda "quante vulnerabilità non scoperte esistono?" viene riformulata come la ricerca di una funzione `v(m, n, i)` che classifichi ogni stato `i` di una macchina di Turing `m` con input `n` come sicuro o vulnerabile. L'autore dimostra che se tale funzione esistesse, permetterebbe di costruire una funzione di halting computabile, contraddicendo il teorema di indecidibilità di Turing: quindi `v` non è computabile in generale.

Il secondo passo invoca il teorema di Rice: tutte le proprietà semantiche non banali dei linguaggi di programmazione sono indecidibili. Ne consegue che nessun metodo di verifica generale può enumerare tutte le vulnerabilità di un programma Turing-completo. L'autore poi argomenta che i sistemi moderni, pur essendo finiti nell'hardware, sono da modellare come macchine di Turing a nastro infinito perché dispongono di interfacce di rete che forniscono un flusso di input potenzialmente illimitato. Un sistema con 4 GB di RAM ha 2^(8 × 3,5 × 10^9) stati possibili, un spazio di ricerca crittograficamente sicuro che nessun strumento di verifica può esplorare esaustivamente. L'autore qualifica esplicitamente la conclusione: "vulnerabilities appear to be dense, not in the proper mathematical sense but in the sense that there will always be more vulnerabilities in a given piece of software." La raccomandazione pratica è di orientare le strategie di vulnerability management verso la resilienza e la rapid patch dissemination piuttosto che verso la ricerca esaustiva di vulnerabilità pre-rilascio.

### Perché è adatto dove viene collocato

Il paper fornisce la giustificazione teorica per un'affermazione che nella tesi va usata con cautela: non che il black-box testing sia fallimentare in quanto tale, ma che nessun approccio di testing può garantire l'assenza di vulnerabilità in un sistema Turing-completo. La citazione corretta, come nota lo stesso report bibliografico, deve essere circoscritta: "la persistenza strutturale di vulnerabilità non scoperte nei sistemi software moderni è stata formalizzata su basi computazionali". Non va attribuito al paper un confronto tra paradigmi di testing (black-box vs. white-box vs. contract-driven) che il testo non contiene.

---

## 12. Rethinking Broken Object Level Authorization Attacks Under Zero Trust Principle
**Autori:** Anbin Wu, Zhiyong Feng, Ruitao Feng, Zhenchang Xing, Yang Liu  
**Sede:** arXiv preprint 2507.02309 (2025), sottomissione futura

### Contenuto

BoLAZ è un framework difensivo contro BOLA fondato sul principio Zero Trust e sulla Micro-Segmentation (MSG). Il paper ridefinisce il problema della difesa contro BOLA come un problema di minimizzazione dell'intervallo di autorizzazione: ogni parametro che il client può controllare (injection point di un C-API) deve essere vincolato al sottoinsieme minimo di resource ID che l'utente ha legittimamente il diritto di usare in quel contesto specifico, determinato dalla catena di chiamate a API produttrici che precede quella consumatrice nella logica dell'applicazione.

La classificazione delle API è il punto di partenza: P-API produce resource ID (li include nella risposta), C-API li consuma (li riceve come parametri), PC-API fa entrambe le cose (un'API di commenti che riceve il blog ID e produce il comment ID), FP-API ritorna lo stesso resource ID che riceve (non crea nuovi oggetti), NPC-API non interagisce con resource ID. Il tracciamento della propagazione avviene con CodeQL come motore di taint analysis: per le P-API, si tracciano le istruzioni SELECT che restituiscono primary key o foreign key e le condizioni WHERE associate (che definiscono l'intervallo MSG); per le C-API, si tracciano i parametri delle API fino alle istruzioni SQL per identificare gli injection point. L'associazione tra P-API e C-API avviene attraverso sei pattern di data flow nel codice frontend JavaScript/HTML.

La valutazione su 10 progetti GitHub in SpringBoot (261.916 LLOC totali, 526 API) mostra un recall del 97% per la classificazione delle API e dell'87% per l'associazione P-API/C-API. Vengono rilevati 35 vulnerabilità BOLA nuove confermate in 10 progetti (più 1 falso positivo causato da modifica del resource ID nel data flow del frontend). Il confronto con BOLARAY (CCS 2024, stato dell'arte) mostra che BoLAZ rileva 8 vulnerabilità aggiuntive (quelle nelle istruzioni SELECT, non supportate da BOLARAY), con 2 falsi positivi in meno. I due falsi positivi di BOLARAY emergono dall'uso di modelli di autorizzazione statici pre-definiti dall'utente che non si adattano alla logica specifica dell'applicazione (es. un endpoint di like sui commenti che può essere invocato da qualsiasi utente, ma che BOLARAY classifica erroneamente come soggetto al modello "ownership").

### Perché è adatto dove viene collocato

BoLAZ è la referenza per l'argomento del §2.3.2 che BOLA non è rilevabile da strumenti che non tracciano la propagazione degli ID nella logica applicativa: dimostra formalmente che l'unico modo per determinare se un ID è "autorizzato" è ricostruire il contesto di produzione di quell'ID dall'upstream del data flow. Il paper è un preprint (non peer-reviewed), ma l'argomento metodologico e la validazione empirica sono solidi. Va citato con la qualifica "arXiv preprint" e come complemento alla referenza di Atlidakis 2020 (Checking Security Properties), che affronta la stessa vulnerabilità dall'angolo del testing dinamico.

---

*Fine documento. 12 paper su 12 elaborati.*