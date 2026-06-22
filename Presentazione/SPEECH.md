# Speech — Slide 01: Contesto

Le architetture a microservizi cloud-native hanno distribuito la complessità su un numero crescente di servizi autonomi, comunicanti tramite API REST. La conseguenza è la moltiplicazione della superficie esposta: ogni servizio aggiunge endpoint al perimetro, spesso senza un inventario centralizzato né una governance del loro ciclo di vita.

Il gateway API è emerso come punto di enforcement centralizzato: concentra autenticazione, autorizzazione e rate limiting in un unico piano di configurazione, e costituisce il confine tra client esterni e servizi interni.

Il problema è che le vulnerabilità più significative non sono sintattiche, sono semantiche: richiedono la conoscenza del comportamento atteso del sistema per essere rilevate. Quattro delle prime cinque categorie OWASP API Security Top 10 2023 appartengono a questa classe, e gli strumenti attuali non le raggiungono.

# Speech — Slide 02: Stato dell'arte e gap

Gli strumenti esistenti operano sulla sintassi delle richieste HTTP: payload malformati, codici di risposta. La logica applicativa resta invisibile, protetta da una barriera che un fuzzer non attraversa. Questo è G1, la cecità semantica.

G2: i pochi strumenti specializzati che vanno in profondità sono legati a un target specifico; quelli generici restano in superficie. Portabilità e profondità non coesistono.

G3, la riproducibilità: se i risultati variano tra esecuzioni senza un motivo dichiarato, il testing non si integra in un ciclo continuativo, perché nessuno si fida di un segnale che cambia da solo. L'obiettivo finale è che il processo funzioni senza un operatore che interpreti ogni volta il risultato.

G4, il problema dell'oracolo, forse il meno affrontato in letteratura: come si stabilisce automaticamente se un comportamento viola una garanzia di sicurezza? Anche qui, senza un meccanismo sistematico quella valutazione richiede quasi sempre un intervento umano.

Quattro frizioni distinte, tutte aperte prima di questo lavoro.

# Speech — Slide 03: Obiettivi

L'obiettivo è progettare un tool contract-driven per la security assurance di qualsiasi API REST documentata, senza modifiche al codice per ogni target.

Quattro obiettivi rispondono direttamente ai quattro gap. O1, l'agnosticismo applicativo, è il presupposto di tutto il resto: la conoscenza del target deriva solo dalla specifica OpenAPI e da un file di configurazione, niente hardcoded.

O2 risponde a G2: il box gradient scala la profondità dell'assessment ai privilegi disponibili nel test, risolvendo il compromesso tra portabilità e profondità senza dover scegliere.

O3 risponde a G3: riproducibilità deterministica dell'output, condizione necessaria perché il processo funzioni senza che un operatore interpreti ogni volta il risultato.

O4, insieme a O1, risponde a G1 e in modo specifico a G4: gli specified oracles sono criteri affidabili derivati dalla conoscenza del dominio, applicati deterministicamente, di nuovo senza bisogno di un intervento umano per giudicare l'esito.

Vediamo ora come si traducono in scelte architetturali concrete.

# Speech — Slide 04: Agnosticismo applicativo e contract-driven

Il primo principio è l'agnosticismo applicativo: le uniche due sorgenti di conoscenza del target a runtime sono la specifica OpenAPI e un file di configurazione. Niente nel codice fa riferimento a un target specifico: il tool è deployabile su qualsiasi API REST documentata senza modificare una riga.

Questo rende possibile il paradigma contract-driven: la specifica OpenAPI guida la costruzione di probe sintatticamente valide, richieste che superano i controlli di formato e raggiungono la logica applicativa, invece di fermarsi al primo errore di sintassi.

Una precisazione: la OAS da sola garantisce solo la validità sintattica. Alcune informazioni semantiche si deducono direttamente da essa, ma la profondità semantica vera nasce dalla combinazione col dominio di sicurezza, che vedremo con gli specified oracles.

# Speech — Slide 04 ALT: Agnosticismo e contract-driven (con immagine)

Questa è l'architettura completa, e ci torneremo pezzo per pezzo. Per ora guardate solo la parte a sinistra: le due uniche sorgenti di conoscenza del target sono openapi.yaml e config.yaml, che alimentano l'Assessment Engine. Niente nel codice fa riferimento a Forgejo o a un altro target specifico: l'engine è deployabile su qualsiasi API REST documentata senza modificare una riga.

Da lì, l'engine costruisce probe HTTP sintatticamente valide e le invia al gateway, che le instrada verso il target reale. È importante essere precisi: la specifica OpenAPI da sola garantisce solo questa validità sintattica. La profondità semantica vera nasce più avanti, quando combiniamo questo contratto con la conoscenza del dominio negli specified oracles.

Il resto del diagramma, DAG Scheduler ed EvidenceStore, lo riprenderemo nelle prossime slide.

# Speech — Slide 05: Tassonomia e box gradient

Prima di costruire qualsiasi test, ho dovuto studiare il target su cui il tool avrebbe operato: non un'applicazione specifica, ma la categoria intera di API REST esposte tramite gateway. Da questo studio è nata una tassonomia di otto domini, allineata anche ai controlli runtime descritti nello standard NIST SP 800-228. D0, D1 e D2 seguono una catena di precondizioni logiche: non ha senso verificare l'autorizzazione senza sapere che l'autenticazione funziona. D3 verifica l'integrità dei dati, D4 la disponibilità, D6 la configurazione del gateway, D7 le falle di logica applicativa più complesse. D5, l'osservabilità, è predisposto architetturalmente ma i suoi test sono ancora pianificati. In totale: 18 test implementati, 14 pianificati, 32 garanzie distinte. La parte più impegnativa non è stata scrivere i singoli test, è stata individuare sistematicamente quali avesse senso fare.

Ogni singolo test, indipendentemente dal dominio a cui appartiene, dichiara anche il proprio livello di accesso necessario: il box gradient. In Black Box non servono credenziali, si simula un attaccante esterno e si verificano solo i controlli perimetrali del gateway. In Grey Box bastano token per almeno due ruoli distinti, e si sbloccano le verifiche di autorizzazione come RBAC e BOLA. In White Box serve l'accesso diretto all'Admin API del gateway, per ispezionare la configurazione. Non è una classificazione imposta dall'esterno: è la conseguenza diretta di cosa il tester ha a disposizione nel momento dell'assessment.

# Speech — Slide 06: Specified oracles

Come si stabilisce automaticamente se un comportamento osservato viola una garanzia di sicurezza? Generare input è un problema in gran parte risolto nella letteratura sul testing; giudicare se la risposta è corretta resta il collo di bottiglia, il cosiddetto problema dell'oracolo.

APIGuard adotta specified oracles: per ogni test, il criterio è codificato a priori, ricavato dalla conoscenza del dominio del controllo specifico. Una precisazione: nella letteratura classica gli oracoli "specified" derivano solo da specifiche formali; qui il termine è più ampio, perché le fonti concrete sono tre. Lo schema OpenAPI per la conformità strutturale. Gli standard tecnici pubblicati, come le linee guida NIST sul TLS, per i requisiti protocollari. E una costruzione ad-hoc sul controllo specifico: confronto tra ruoli per l'autorizzazione, ispezione del gateway per le garanzie infrastrutturali.

Il risultato è che ogni test produce un verdetto da solo, PASS, FAIL o SKIP, senza interpretazione manuale. E poiché il criterio è fisso, lo stesso sistema nella stessa configurazione produce sempre lo stesso verdetto: è questa proprietà a fondare la riproducibilità che vedremo più avanti.

# Speech — Slide 07: Pipeline di esecuzione

L'esecuzione si articola in sette fasi, divise in due gruppi con comportamento d'errore diverso.

Le prime quattro sono bloccanti: un errore qui interrompe l'avvio. Fase 1, lettura di config.yaml. Fase 2, discovery della specifica OpenAPI e costruzione della superficie di assessment. Fase 3, costruzione dei due contesti, target e test. Fase 4, discovery dei test e costruzione del grafo delle dipendenze.

Le ultime tre sono non bloccanti: un errore qui viene isolato e la pipeline prosegue. Fase 5, esecuzione dei test nell'ordine stabilito dal DAG. Fase 6, teardown delle risorse in ordine LIFO, opposto alla creazione. Fase 7, report finale.

Questa struttura rende il sistema estensibile in due modi: i tool esterni si integrano tramite connector gerarchici a tre livelli, e lo stesso connector funziona in locale, CI/CD e containerizzato; il discovery dinamico della Fase 4 significa che aggiungere un test richiede solo un file nella directory giusta, senza toccare il resto del codice.

# Speech — Slide 07 ALT: Pipeline di esecuzione (con immagine)

Sette fasi, due gruppi. Le prime quattro, in alto, sono bloccanti: leggono la configurazione, scaricano la specifica OpenAPI, costruiscono i contesti, e infine scoprono i test e costruiscono il grafo delle dipendenze. Se una di queste fallisce, come vedete a destra, l'avvio si interrompe subito, prima che un solo test venga eseguito.

Le ultime tre, in verde, sono diverse per natura: eseguono i test, fanno il teardown delle risorse in ordine inverso a come sono state create, e generano il report. Qui un errore non blocca più tutto: viene isolato, come vedete con le frecce arancioni, e la pipeline prosegue.

Il risultato finale è uno dei quattro exit code in basso, che è quello che permette a un sistema di CI/CD di reagire automaticamente senza interpretare nulla.

# Speech — Slide 08: Riproducibilità e integrazione CI/CD

Tre meccanismi rendono l'assessment riproducibile, e per questo integrabile in un ciclo di sviluppo continuativo.

Il DAG scheduler: alcuni test presuppongono risorse prodotte da altri, ad esempio i test RBAC richiedono che l'autenticazione abbia già ottenuto i token. Ordine topologico significa che ogni test viene eseguito solo dopo i suoi prerequisiti, mai prima; altrimenti l'ordine arbitrario produrrebbe errori non deterministici.

Il config-driven development: tutti i parametri operativi, non solo la conoscenza del target, risiedono in un unico file. Stessa configurazione, stesso output.

Gli exit code semantici: zero significa tutti PASS o SKIP, la pipeline procede. Uno indica almeno un FAIL, blocca merge o deploy. Due segnala un malfunzionamento interno da rivedere manualmente. Dieci un errore infrastrutturale, come la specifica non raggiungibile. Questa distinzione tra fallimento del target e fallimento del tool è ciò che permette a GitHub Actions o GitLab CI di consumare il risultato senza fare parsing dei log.

# Speech — Slide 08 ALT: Riproducibilità e integrazione CI/CD (con immagine)

Questo è il grafo delle dipendenze costruito alla Fase 4. La Phase A in arancione, sedici test, non ha dipendenze e parte subito. Il test 1.1, l'autenticazione, sblocca però la Phase B in blu: i test 1.4 e 2.1, di autorizzazione, dichiarano esplicitamente di dipendere da 1.1 e aspettano che produca i token validi prima di partire. Senza questa garanzia, eseguirli in ordine arbitrario produrrebbe errori non deterministici invece di fallimenti puliti. La Phase C, in grigio, è già predisposta per dipendenze future.

Gli altri due meccanismi che rendono tutto questo riproducibile non sono in figura, ma sono altrettanto importanti. Il config-driven development: tutti i parametri operativi, non solo la conoscenza del target, risiedono in un unico file, quindi stessa configurazione, stesso output. E gli exit code semantici, da zero a dieci, che distinguono un fallimento del target da un malfunzionamento del tool, permettendo a GitHub Actions o GitLab CI di reagire senza fare parsing dei log.

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta su Forgejo 14.0.3, esposto tramite Kong 3.9 in modalità DB-less, in Docker locale. Forgejo è stato scelto perché offre una specifica OpenAPI nativa, autenticazione reale con ruoli distinti (amministratore e utenti standard), ed endpoint con gradi diversi di protezione. L'assenza di riferimenti a Forgejo nel codice ha confermato in pratica l'agnosticismo applicativo.

I 18 test attivi su 7 domini hanno prodotto 9 PASS, 7 FAIL, 2 SKIP, 0 ERROR, per 98 finding totali. I FAIL non sono errori del tool: sono configurazioni deliberatamente non conformi nel testbed, per produrre esiti negativi attesi, e il tool li ha distinti correttamente.

Il risultato più interessante è la discrepanza nel box sotto i numeri: Forgejo dichiara autenticazione globale, ma alcuni endpoint pubblici rispondono correttamente senza credenziali. Il tool ha rilevato questo disallineamento tra contratto e implementazione, esattamente la classe di anomalia che il paradigma contract-driven è progettato per individuare. È il finding più significativo dei 98 raccolti.

Due run indipendenti hanno prodotto risultati byte-identici, con un delta sul wall-clock inferiore allo 0.3%.

# Speech — Slide 10: Conclusioni

Prima di chiudere, una precisazione: questo lavoro non risolve il testing della sicurezza delle API REST, il settore è troppo giovane per soluzioni definitive. Quello che presento sono contributi concreti, verificati empiricamente.

Si collocano su due piani. Sul piano metodologico: una tassonomia a otto domini applicabile indipendentemente dagli strumenti impiegati, e una metodologia sistematica per definire specified oracles. Sul piano ingegneristico: un assessment engine deterministico basato su DAG, che garantisce la correttezza dell'ordine di esecuzione anche con dipendenze tra test.

La validazione non è su uno scenario sintetico costruito per il tool, ma su Forgejo dietro Kong, scelto per le sue proprietà strutturali, non per affinità con lo strumento.

La differenza che voglio lasciarvi non è di scala, è di natura. Un penetration testing tradizionale produce un'osservazione puntuale, condotta da un operatore in un momento specifico: rieseguirlo produce risultati comparabili solo per convenzione. Questo lavoro produce risultati deterministicamente identici a ogni riesecuzione, verificabili da chiunque senza ricostruire il processo di chi li ha generati. Da osservazione puntuale a garanzia misurabile.

# Speech — Slide 11: Sviluppi futuri

Va detto onestamente il limite strutturale principale: il tool dipende dalla qualità della specifica OpenAPI del target. Un contratto incompleto o disallineato produce un assessment parziale, senza che il sistema se ne accorga da solo. È un limite intrinseco a qualsiasi approccio contract-driven, non qualcosa che si risolve con un'estensione.

Da qui nascono le priorità operative: adapter per i gateway cloud come AWS API Gateway e Azure APIM, che recupererebbero le informazioni di configurazione tramite le API del vendor; e il completamento del dominio Observability, già predisposto architetturalmente ma senza test attivi.

Sul fronte della ricerca, quattro direzioni: una piattaforma modulare per protocolli eterogenei come gRPC e GraphQL; la formalizzazione degli oracoli di sicurezza, per verificarne la correttezza in modo rigoroso; la coverage augmentation progressiva verso le aree meno coperte; e la parallelizzazione intra-batch, mantenendo la correttezza dell'ordinamento garantita dal DAG.