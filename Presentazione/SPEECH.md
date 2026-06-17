# Speech — Slide 01: Contesto

Le architetture a microservizi hanno ridistribuito la complessità applicativa su molti servizi autonomi che comunicano tramite API REST. La conseguenza per la sicurezza non è lineare: la superficie di attacco non cresce con il numero di servizi, cresce con il numero di interazioni tra servizi, ciascuna mediata da un'interfaccia programmabile che può essere scoperta, interrogata e abusata indipendentemente dal contesto applicativo.

In questo scenario, il gateway API è emerso come punto di enforcement centralizzato: concentra le politiche di autenticazione, autorizzazione e rate limiting, e costituisce il confine tra i client esterni e i servizi interni.

Il problema è che le vulnerabilità più rilevanti in questo spazio non sono sintattiche, sono semantiche. Non emergono dall'analisi del formato di una richiesta HTTP, ma richiedono la conoscenza del comportamento atteso del sistema per essere rilevate. Quattro delle prime cinque categorie di rischio nell'OWASP API Security Top 10 del 2023 appartengono a questa classe. E gli strumenti attuali, come vedremo, non le raggiungono.

# Speech — Slide 02: Stato dell'arte e gap

Gli strumenti di security testing esistenti operano sulla sintassi delle richieste HTTP: inviano payload malformati e osservano i codici di risposta. Come mostra il confronto a destra, la logica applicativa resta invisibile, protetta da una barriera sintattica che un fuzzer non attraversa mai. Questo è G1, la cecità semantica: le vulnerabilità che richiedono la conoscenza del comportamento atteso del sistema non vengono rilevate.

A questo si affiancano tre frizioni ulteriori. I pochi strumenti specializzati sono scritti per un target specifico: portabilità e profondità semantica non coesistono, G2. I risultati variano tra esecuzioni successive: senza determinismo non si integra il testing in una pipeline CI/CD, G3. E infine il problema strutturalmente meno affrontato: come stabilire automaticamente se una risposta osservata è una violazione? Chi costruisce il criterio? Questo è il problema dell'oracolo, G4.

Quattro frizioni distinte, tutte aperte prima di questo lavoro.

# Speech — Slide 03: Obiettivi

L'obiettivo è progettare e implementare un tool contract-driven per la security assurance di qualsiasi API REST documentata, senza modifiche al codice per ogni target diverso.

Quattro obiettivi specifici guidano le slide successive. O1: agnosticismo applicativo, reso possibile dal fatto che tutta la conoscenza del target deriva dalla specifica OpenAPI e da un file di configurazione, senza nulla hardcoded. O2: superare il compromesso tra portabilità e profondità semantica tramite il paradigma contract-driven. O3: riproducibilità deterministica dell'output, prerequisito per l'integrazione in pipeline CI/CD. O4: specified oracles, ovvero criteri di valutazione automatici derivati dalla conoscenza del dominio di ogni controllo, che risolvono il problema dell'oracolo.

Vediamo ora come questi obiettivi si traducono in scelte architetturali concrete.

# Speech — Slide 04: Design contract-driven

Il fondamento dell'approccio è il paradigma contract-driven. La specifica OpenAPI del target descrive formalmente gli endpoint, i parametri e i codici di risposta attesi. L'engine usa questa specifica per costruire probe semanticamente valide: richieste che superano i controlli sintattici e raggiungono la logica applicativa. Non payload malformati generici, ma richieste che il sistema dichiara di accettare. È esattamente lì che vivono le vulnerabilità semantiche.

Da questa scelta discende direttamente l'agnosticismo applicativo. Come si vede a destra, le due sole sorgenti di conoscenza del target a runtime sono la specifica OpenAPI e un file di configurazione con le credenziali e l'URL di base. Non c'è nulla nel codice che faccia riferimento a Forgejo, Kong, o qualsiasi altro target specifico. Il tool è deployabile su qualsiasi API REST documentata senza modificare una singola riga.

# Speech — Slide 05: Tassonomia

Le verifiche sono organizzate in una tassonomia di otto domini che coprono le principali categorie di vulnerabilità delle API REST. D0 verifica l'inventario degli endpoint esposti, incluse le shadow API non documentate. D1 e D2 coprono autenticazione e autorizzazione: qui ricadono i difetti di segregazione orizzontale e verticale come BOLA, che rappresentano quattro delle prime cinque categorie OWASP citate all'inizio. D3 verifica la coerenza strutturale dei payload e le firme crittografiche. D4 copre le difese contro l'esaurimento delle risorse. D6 verifica la configurazione del gateway e gli header HTTP. D7 affronta le falle semantiche più complesse: SSRF, race condition su operazioni critiche.

D5, l'osservabilità, è architetturalmente preparato ma non ha test attivi in questa versione.

In totale: 18 test attivi su 7 domini.

# Speech — Slide 06: Box gradient

Il box gradient nasce da una domanda semplice: quante credenziali ha a disposizione il tester? La risposta determina quali verifiche sono eseguibili.

In modalità Black Box non ci sono credenziali. Si simula un attaccante esterno e si verificano solo i controlli perimetrali che il gateway applica a qualsiasi interlocutore: autenticazione obbligatoria, rifiuto di metodi non autorizzati, header di sicurezza.

In modalità Grey Box si dispone di token validi per almeno due ruoli distinti. Questo rende accessibili le garanzie che presuppongono stato autenticato: difetti di segregazione orizzontale come BOLA, violazioni RBAC, escalation di privilegi.

In modalità White Box si ha accesso all'Admin API del gateway e si può ispezionare direttamente la configurazione e le policy di routing.

Il gradiente non è una classificazione teorica applicata retroattivamente: è la conseguenza diretta di cosa il tester porta con sé nel momento dell'assessment.

# Speech — Slide 07: Specified oracles

Come si stabilisce automaticamente se quello che si osserva è una violazione? Questo è il problema dell'oracolo, formalizzato da Barr et al. nel 2015: la generazione automatizzata di input verso il sistema è un problema in larga parte risolto; stabilire se il comportamento osservato è corretto rimane il collo di bottiglia strutturale dell'automazione del testing.

APIGuard adotta specified oracles: per ogni test, il criterio di valutazione è codificato a priori nella logica del test, ricavato dalla conoscenza del dominio di sicurezza del controllo specifico. Le sorgenti variano per dominio. Per la conformità strutturale dei payload, l'oracolo viene dallo schema OAS. Per la configurazione TLS e gli header, dagli standard tecnici come NIST SP 800-52 e ASVS. Per le policy di routing, dalla configurazione del gateway. Per i difetti RBAC e BOLA, dal confronto sistematico tra ruoli con privilegi diversi.

Il risultato, come mostra il diagramma, è che ogni test produce un verdetto autonomamente: PASS, FAIL o SKIP, senza che nessun operatore debba interpretare il comportamento osservato caso per caso.

# Speech — Slide 08: Pipeline e connector

L'implementazione si articola in una pipeline a sette fasi sequenziali, visibile a destra. Le prime quattro, dalla lettura della configurazione alla costruzione del grafo di dipendenze, sono bloccanti: un errore in questa zona interrompe l'avvio prima che qualsiasi test venga eseguito. Le ultime tre, esecuzione teardown e generazione del report, sono non bloccanti: un test che fallisce con un'eccezione interna viene isolato e la pipeline prosegue sugli altri.

I tool esterni sono integrati tramite connector gerarchici a tre livelli. Il livello base definisce il contratto universale: verifica disponibilità, versione, esecuzione. I livelli intermedi si biforcano a seconda della natura del tool, subprocess o libreria Python. I connector specifici stanno al terzo livello. Questa struttura fa sì che lo stesso connector funzioni senza modifiche in sviluppo locale, in CI/CD e in ambienti containerizzati.

Il discovery dinamico completa il quadro: nuove verifiche vengono registrate automaticamente dal registry senza toccare il core dell'engine.

# Speech — Slide 09: DAG e CI/CD

Il DAG scheduler garantisce la correttezza semantica dell'ordinamento di esecuzione. Alcuni test presuppongono che certi altri abbiano già prodotto risorse sul target: i test di autorizzazione RBAC, per esempio, richiedono che il test di autenticazione abbia già ottenuto i token validi. Queste dipendenze vengono dichiarate esplicitamente da ogni test e risolte topologicamente dallo scheduler. Senza questa garanzia, l'esecuzione in ordine arbitrario produrrebbe errori non deterministici invece di fallimenti puliti, rendendo l'output inaffidabile.

L'integrazione CI/CD è resa possibile da quattro exit codes semantici. Exit code 0 significa che tutti i test sono PASS o SKIP: la pipeline può procedere con merge o deploy. Exit code 1 indica almeno un FAIL: il merge viene bloccato e il report allegato come artefatto. Exit code 2 segnala un malfunzionamento interno senza FAIL: richiede revisione manuale. Exit code 10 indica un errore infrastrutturale come la specifica OAS non raggiungibile.

Questa semantica permette di consumare i risultati direttamente in una pipeline GitHub Actions o GitLab CI senza dover fare parsing dell'output.

# Speech — Slide 10: Validazione sperimentale

La validazione è stata condotta su Forgejo 14.0.3, una piattaforma Git self-hosted, esposta tramite Kong 3.9 in modalità DB-less in ambiente Docker locale. Forgejo è stato scelto perché fornisce una specifica OpenAPI generata nativamente, autenticazione reale con ruoli distinti — amministratore e utenti standard — e endpoint con gradi diversi di protezione. L'assenza di qualsiasi riferimento a Forgejo nel codice del tool ha confermato in modo pratico l'agnosticismo applicativo.

I 18 test attivi su 7 domini hanno prodotto 9 PASS, 7 FAIL, 2 SKIP e 0 ERROR, per un totale di 98 finding. I 7 FAIL non sono errori del tool: sono configurazioni deliberatamente non conformi nel testbed, progettate per produrre esiti negativi attesi. Il tool ha distinto correttamente tutti i casi.

Il risultato più interessante è la discrepanza evidenziata nel blocco blu: Forgejo dichiara globalmente il requisito di autenticazione nella sua specifica, ma alcuni endpoint genuinamente pubblici rispondono correttamente anche senza credenziali. Il tool ha rilevato questo disallineamento tra contratto e implementazione, che è esattamente la classe di anomalia che il paradigma contract-driven è progettato per individuare.

Due run indipendenti sullo stesso target hanno prodotto risultati byte-identici, con un delta sul wall-clock inferiore allo 0.3%, validando empiricamente il determinismo dichiarato.

# Speech — Slide 11: Conclusioni

I quattro gap identificati all'inizio trovano risposta nelle scelte architetturali. G1: le probe costruite dalla specifica OAS raggiungono la logica applicativa, superando la barriera sintattica che blocca i fuzzer tradizionali. G2: la profondità di assessment si mantiene su qualsiasi API REST documentata senza riscrivere una riga di codice. G3: l'output è byte-identico tra run successive, consumabile direttamente via exit code in una pipeline CI/CD. G4: ogni test porta il proprio criterio di valutazione, ricavato dalla conoscenza del dominio; nessun operatore deve interpretare il comportamento osservato.

Il risultato complessivo è che la security assurance non è più un'osservazione puntuale prodotta da un operatore in un momento specifico. Diventa un processo continuo e misurabile, integrabile nel ciclo di sviluppo con la stessa naturalezza di una test suite funzionale.

Sul piano dei contributi: una tassonomia a 8 domini applicabile indipendentemente dall'implementazione, un approccio sistematico agli specified oracles nel security testing REST, e un assessment engine deterministico a DAG verificato empiricamente.

# Speech — Slide 12: Sviluppi futuri

Sul fronte operativo, la priorità principale sono gli adapter per i gateway cloud managed come AWS API Gateway e Azure APIM. Questi ambienti non espongono un piano di controllo accessibile, il che riduce la copertura alle sole verifiche black-box e grey-box. Un adapter dedicato permetterebbe di recuperare le informazioni di configurazione tramite le API proprietarie del vendor. A questo si aggiunge il completamento del dominio Observability e la parallelizzazione intra-batch per ridurre i tempi di esecuzione.

Sul fronte della ricerca, l'obiettivo più ambizioso è trasformare il tool in una piattaforma modulare che supporti protocolli eterogenei come gRPC e GraphQL, dove il contratto formale non è più OAS ma Protobuf o lo schema GraphQL. Affianca a questo la formalizzazione degli oracoli di sicurezza, che permetterebbe di verificarne la correttezza in modo rigoroso, e la coverage augmentation progressiva, ovvero la capacità di guidare le esecuzioni successive verso le aree meno coperte in base ai risultati precedenti.