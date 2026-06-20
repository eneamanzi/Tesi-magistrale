# Speech — Slide 01: Contesto

Le architetture a microservizi cloud-native hanno ridistribuito la complessità applicativa su un numero crescente di servizi autonomi, ciascuno responsabile di un sottodominio del sistema e comunicante con gli altri tramite API REST. La conseguenza diretta è la moltiplicazione della superficie esposta: ogni servizio aggiunge endpoint al perimetro, spesso in assenza di un inventario centralizzato e di una governance sistematica del loro ciclo di vita.

In questo scenario, il gateway API è emerso come punto di enforcement centralizzato: concentra in un unico piano di configurazione ispezionabile le politiche di autenticazione, autorizzazione e rate limiting, e costituisce il confine tra i client esterni e i servizi interni.

Il problema è che le vulnerabilità più significative in questo spazio non sono sintattiche, sono semantiche. Non emergono dall'analisi del formato di una richiesta HTTP, ma richiedono la conoscenza del comportamento atteso del sistema per essere rilevate. Quattro delle prime cinque categorie di rischio nell'OWASP API Security Top 10 del 2023 appartengono a questa classe. E gli strumenti attuali, come vedremo, non le raggiungono.

# Speech — Slide 02: Stato dell'arte e gap

Gli strumenti di security testing esistenti operano sulla sintassi delle richieste HTTP: inviano payload malformati e osservano i codici di risposta. La logica applicativa resta invisibile, protetta da una barriera sintattica che un fuzzer non attraversa mai. Questo è G1, la cecità semantica: le vulnerabilità che richiedono la conoscenza del comportamento atteso del sistema non vengono rilevate.

A questo si affianca G2: i pochi strumenti specializzati che raggiungono una certa profondità sono scritti per un target specifico e non si generalizzano; gli strumenti generici, al contrario, restano in superficie. Portabilità e profondità non coesistono.

G3 riguarda la riproducibilità: se i risultati variano tra esecuzioni successive senza un motivo dichiarato, il testing non si può integrare in un ciclo di sviluppo continuativo, perché nessuno può fidarsi di un segnale che cambia da solo. E qui c'è un punto che vale la pena sottolineare a voce: l'obiettivo finale è che l'intero processo funzioni senza un operatore che debba interpretare ogni volta il risultato.

Lo stesso vale per G4, il problema dell'oracolo, probabilmente il meno affrontato in letteratura: come si stabilisce automaticamente se un comportamento osservato viola una garanzia di sicurezza? Chi costruisce quel criterio? Anche qui, l'assenza di un meccanismo sistematico significa che oggi quella valutazione richiede quasi sempre un intervento umano per essere considerata affidabile.

Quattro frizioni distinte, tutte aperte prima di questo lavoro.

# Speech — Slide 03: Obiettivi

L'obiettivo è progettare e implementare un tool contract-driven per la security assurance di qualsiasi API REST documentata, senza modifiche al codice per ogni target diverso.

Quattro obiettivi specifici guidano le slide successive, e rispondono direttamente ai quattro gap appena visti. O1, l'agnosticismo applicativo, è il presupposto su cui si fonda tutto il resto: tutta la conoscenza del target deriva dalla specifica OpenAPI e da un file di configurazione, senza nulla hardcoded nel codice. È la base di partenza da cui costruiamo le altre proprietà.

O2 risponde a G2: il box gradient, che vedremo più avanti, scala la profondità dell'assessment in base ai privilegi effettivamente disponibili nel momento del test, risolvendo il compromesso tra portabilità e profondità senza dover scegliere l'una o l'altra.

O3 risponde a G3: riproducibilità deterministica dell'output, prerequisito per l'integrazione nei cicli di sviluppo continuativo, e — come accennavo — condizione necessaria perché il processo funzioni senza che un operatore debba interpretare ogni volta il risultato.

O4, insieme a O1, risponde a G1 e in modo specifico a G4: gli specified oracles sono criteri di valutazione affidabili, derivati dalla conoscenza del dominio di ogni singolo controllo, applicati deterministicamente. È qui che il problema dell'oracolo trova una risposta sistematica, di nuovo senza bisogno di un intervento umano per giudicare l'esito.

Vediamo ora come questi obiettivi si traducono in scelte architetturali concrete.

# Speech — Slide 04: Agnosticismo applicativo e contract-driven

Il primo principio è l'agnosticismo applicativo. Le uniche due sorgenti di conoscenza del target a runtime sono la specifica OpenAPI e un file di configurazione, con le credenziali e l'URL di base. Non c'è nulla nel codice che faccia riferimento a un target specifico: il tool è deployabile su qualsiasi API REST documentata senza modificare una singola riga.

Questo presupposto rende possibile il paradigma contract-driven. La specifica OpenAPI guida la costruzione di probe sintatticamente valide: richieste che superano i controlli di formato e raggiungono la logica applicativa, invece di payload malformati generici che si fermano al primo errore di sintassi.

È importante essere precisi su un punto: la specifica OAS da sola garantisce solo la validità sintattica delle probe. Alcune informazioni semantiche si possono dedurre direttamente da essa, come quali endpoint richiedono autenticazione, ma la profondità semantica vera e propria del controllo nasce dalla combinazione di questo contratto con la conoscenza del dominio di sicurezza, che vedremo più avanti con gli specified oracles.

# Speech — Slide 05: Tassonomia

Prima di costruire qualsiasi test, è stato necessario studiare il target su cui il tool avrebbe operato: non un'applicazione specifica, ma la categoria intera di API REST esposte tramite gateway. Da questo studio è nata una tassonomia di otto domini, ciascuno corrispondente a una famiglia di rischio distinta, allineata anche ai controlli runtime descritti nello standard NIST SP 800-228.

D0, D1 e D2 seguono una catena di precondizioni logiche: non ha senso verificare l'autorizzazione senza prima sapere che l'autenticazione funziona, né l'autenticazione senza conoscere la superficie di attacco. D3 verifica l'integrità dei dati, D4 la disponibilità, D6 la configurazione del gateway, D7 le falle di logica applicativa più complesse come SSRF e race condition. D5, l'osservabilità, è architetturalmente predisposto ma i suoi test sono pianificati come sviluppo futuro, non ancora implementati in questa versione.

I numeri in fondo raccontano due cose diverse: quanti test sono già implementati e quanti sono stati individuati durante questo lavoro di ricerca ma restano pianificati per il futuro. In totale, 18 test attivi e 14 pianificati, 32 garanzie distinte mappate su 8 domini: la parte più impegnativa di questo lavoro non è stata scrivere i singoli test, è stata individuare in modo sistematico quali controlli avessero senso fare.

# Speech — Slide 06: Box gradient

Il box gradient nasce da una domanda semplice: quante credenziali ha a disposizione il tester? La risposta determina quali verifiche sono eseguibili.

In modalità Black Box non ci sono credenziali. Si simula un attaccante esterno e si verificano solo i controlli perimetrali che il gateway applica a qualsiasi interlocutore: autenticazione obbligatoria, rifiuto di metodi non autorizzati, header di sicurezza.

In modalità Grey Box si dispone di token validi per almeno due ruoli distinti. Questo rende accessibili le garanzie che presuppongono stato autenticato: difetti di segregazione orizzontale come BOLA, violazioni RBAC, escalation di privilegi.

In modalità White Box si ha accesso all'Admin API del gateway e si può ispezionare direttamente la configurazione e le policy di routing.

Il gradiente non è una classificazione teorica applicata retroattivamente: è la conseguenza diretta di cosa il tester porta con sé nel momento dell'assessment.

# Speech — Slide 07: Specified oracles

Come si stabilisce automaticamente se quello che si osserva viola una garanzia di sicurezza? Nella letteratura sul testing del software, generare automaticamente input verso il sistema è un problema in larga parte risolto; stabilire se il comportamento osservato è corretto resta invece il collo di bottiglia strutturale. È il cosiddetto problema dell'oracolo, e nel testing delle API REST la verifica esplicita delle garanzie di sicurezza è l'ambito ancora meno sviluppato.

APIGuard adotta specified oracles: per ogni test, il criterio di valutazione è codificato a priori nella logica della classe, ricavato dalla conoscenza del dominio del controllo specifico. È importante essere precisi qui: nella letteratura classica gli oracoli "specified" derivano solo da specifiche formali. In questo lavoro il termine è usato in senso più ampio, perché le tre fonti concrete da cui derivano i criteri sono diverse tra loro. La prima è lo schema contrattuale della specifica OpenAPI, usato per verificare la conformità strutturale delle risposte. La seconda sono gli standard tecnici pubblicati, come le linee guida NIST sul TLS, usati per i requisiti protocollari. La terza è una costruzione ad-hoc basata sul controllo specifico da eseguire: il confronto tra risposte ottenute con credenziali di ruolo diverso per verificare un'autorizzazione, oppure l'ispezione diretta della configurazione del gateway per le garanzie infrastrutturali.

Il risultato è che ogni test produce un verdetto autonomamente: PASS, FAIL o SKIP, senza che nessun operatore debba interpretare il comportamento osservato caso per caso. E poiché il criterio è fisso, lo stesso sistema interrogato nella stessa configurazione produce sempre lo stesso verdetto: è questa proprietà a fondare empiricamente la riproducibilità che vedremo più avanti.

# Speech — Slide 08: Pipeline di esecuzione

L'esecuzione si articola in sette fasi sequenziali, divise in due gruppi con un comportamento d'errore diverso.

Le prime quattro sono bloccanti: se falliscono, l'avvio si interrompe prima che qualsiasi test venga eseguito. La Fase 1 legge ed interpreta config.yaml. La Fase 2 scarica e interpreta la specifica OpenAPI del target, costruendo la superficie di assessment. La Fase 3 costruisce i due contesti che abbiamo visto, quello del target e quello mutabile dei test. La Fase 4 scopre dinamicamente tutti i test disponibili e costruisce il grafo delle dipendenze, ordinandoli topologicamente.

Le ultime tre sono non bloccanti: un errore qui viene isolato e la pipeline prosegue sugli altri test. La Fase 5 esegue effettivamente i test, uno per uno, secondo l'ordine stabilito dal DAG. La Fase 6 esegue il teardown delle risorse create durante i test, in ordine LIFO, l'opposto dell'ordine di creazione. La Fase 7 genera il report finale con tutti i risultati e l'evidenza raccolta.

Questa architettura a pipeline è anche ciò che rende il sistema facilmente estensibile in due direzioni concrete. I tool esterni si integrano tramite connector gerarchici a tre livelli: un contratto universale alla base, una biforcazione per natura del tool (subprocess o libreria Python), e il connector specifico in cima. Lo stesso connector funziona senza modifiche in locale, in CI/CD e in ambienti containerizzati. E il discovery dinamico della Fase 4 significa che aggiungere un nuovo test è semplice: basta creare il file nella directory di dominio corretta, senza toccare nessun altro punto del codice.

# Speech — Slide 09: Riproducibilità e integrazione CI/CD

Questa slide raccoglie i tre meccanismi che insieme rendono l'assessment riproducibile, e che per questo permettono di integrarlo in una pipeline di sviluppo continuativo.

Il primo è il DAG scheduler. Alcuni test presuppongono che altri abbiano già prodotto risorse sul target: i test di autorizzazione RBAC, per esempio, richiedono che il test di autenticazione abbia già ottenuto i token validi. Ordine topologico significa esattamente questo: ogni test viene eseguito solo dopo tutti i suoi prerequisiti dichiarati, mai prima. Senza questa garanzia, l'esecuzione in ordine arbitrario produrrebbe errori non deterministici invece di fallimenti puliti.

Il secondo è il config-driven development. Tutti i parametri operativi del tool, non solo la conoscenza del target, risiedono in un unico file: soglie, timeout, filtri sui test, configurazione dei tool esterni. Questo significa che la stessa configurazione produce sempre lo stesso comportamento: se la configurazione è fissa, l'output è fisso.

Il terzo sono gli exit code semantici. Zero significa che tutti i test sono PASS o SKIP, e la pipeline può procedere. Uno indica almeno un FAIL, e blocca il merge o il deploy. Due segnala un malfunzionamento interno del tool, da rivedere manualmente. Dieci indica un errore infrastrutturale, come la specifica OpenAPI non raggiungibile. Questa distinzione tra fallimento del target e fallimento del tool è ciò che permette a un sistema come GitHub Actions o GitLab CI di consumare il risultato senza fare parsing dei log: il segnale è già nell'exit code.

# Speech — Slide 10: Validazione sperimentale

La validazione è stata condotta su Forgejo 14.0.3, una piattaforma Git self-hosted, esposta tramite Kong 3.9 in modalità DB-less in ambiente Docker locale. Forgejo è stato scelto perché fornisce una specifica OpenAPI generata nativamente, autenticazione reale con ruoli distinti — amministratore e utenti standard — e endpoint con gradi diversi di protezione. L'assenza di qualsiasi riferimento a Forgejo nel codice del tool ha confermato in modo pratico l'agnosticismo applicativo.

I 18 test attivi su 7 domini hanno prodotto 9 PASS, 7 FAIL, 2 SKIP e 0 ERROR, per un totale di 98 finding. I 7 FAIL non sono errori del tool: sono configurazioni deliberatamente non conformi nel testbed, progettate per produrre esiti negativi attesi. Il tool ha distinto correttamente tutti i casi.

Il risultato più interessante è la discrepanza evidenziata nel box sotto i numeri: Forgejo dichiara globalmente il requisito di autenticazione nella sua specifica, ma alcuni endpoint genuinamente pubblici rispondono correttamente anche senza credenziali. Il tool ha rilevato questo disallineamento tra contratto e implementazione, che è esattamente la classe di anomalia che il paradigma contract-driven è progettato per individuare. È un risultato a tutti gli effetti, non un'eccezione ai numeri sopra: è il finding più significativo dei 98 raccolti.

Due run indipendenti sullo stesso target hanno prodotto risultati byte-identici, con un delta sul wall-clock inferiore allo 0.3%, validando empiricamente il determinismo dichiarato.

# Speech — Slide 11: Conclusioni

Voglio essere preciso su un punto prima di chiudere: questo lavoro non risolve il testing della sicurezza delle API REST, è un settore ancora troppo giovane perché abbia senso parlare di soluzioni definitive. Quello che presento sono contributi concreti, verificati empiricamente, su quattro frizioni che all'inizio ho chiamato gap.

I quattro obiettivi che vi ho mostrato — agnosticismo, profondità graduata, riproducibilità, specified oracles — hanno trovato risposta nelle scelte architetturali che abbiamo visto: design contract-driven, box gradient, DAG scheduler, e i criteri di valutazione codificati a priori in ogni test.

I contributi si collocano su due piani distinti. Sul piano metodologico: una tassonomia a otto domini che organizza la superficie di sicurezza di un'API esposta tramite gateway in categorie distinte, applicabile a qualsiasi assessment indipendentemente dagli strumenti impiegati; e una metodologia sistematica per definire specified oracles, distinguendo le sorgenti del criterio in funzione del controllo specifico. Sul piano ingegneristico: un assessment engine deterministico basato su DAG, che garantisce la correttezza semantica dell'ordine di esecuzione anche in presenza di dipendenze tra test.

E poi c'è la validazione: non su uno scenario sintetico costruito apposta per il tool, ma su Forgejo dietro Kong, un target con specifica OpenAPI nativa e autenticazione reale, scelto per le sue proprietà strutturali, non per affinità con lo strumento.

La differenza che voglio lasciarvi non è di scala, è di natura. Un penetration testing tradizionale produce un'osservazione puntuale, condotta da un operatore in un momento specifico: rieseguirlo in condizioni nominalmente identiche produce risultati comparabili solo per convenzione. Questo lavoro produce invece risultati deterministicamente identici a ogni riesecuzione, verificabili da chiunque senza dover ricostruire il processo di chi li ha generati. Da osservazione puntuale a garanzia misurabile.

# Speech — Slide 12: Sviluppi futuri

Prima di chiudere, va detto onestamente qual è il limite strutturale principale di questo lavoro: il tool dipende dalla qualità della specifica OpenAPI del target. Un contratto incompleto o disallineato con l'implementazione reale produce un assessment parziale, senza che il sistema possa accorgersene da solo. È un limite intrinseco a qualsiasi approccio contract-driven, non qualcosa che si risolve con un'estensione.

Da questo limite, e da quello già visto sui deployment cloud managed, nascono le priorità operative. Gli adapter per i gateway cloud come AWS API Gateway e Azure APIM recupererebbero le informazioni di configurazione tramite le API proprietarie del vendor, anche dove non c'è un piano di controllo ispezionabile direttamente. A questo si aggiunge il completamento del dominio Observability, oggi predisposto architetturalmente ma senza test attivi.

Sul fronte della ricerca, quattro direzioni. La trasformazione in piattaforma modulare per protocolli eterogenei come gRPC e GraphQL, dove il contratto formale non è più OAS ma Protobuf o lo schema GraphQL. La formalizzazione degli oracoli di sicurezza, per verificarne la correttezza in modo rigoroso e non solo empirico. La coverage augmentation progressiva, che guiderebbe le esecuzioni successive verso le aree meno coperte in base ai risultati precedenti. E la parallelizzazione intra-batch, per ridurre i tempi di esecuzione mantenendo la correttezza dell'ordinamento garantita dal DAG.