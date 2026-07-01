# Speech — Slide 01: Titolo

Buongiorno a tutti. Sono Enea Manzi e oggi vi presento il mio lavoro di tesi magistrale intitolato *"Progettazione e Implementazione di un Tool API-Agnostico per la Security Assurance di API REST"* svolto presso SesarLab sotto la supervisione del Prof Marco Anisetti e del Prof Claudio Agostino Ardagna.

# Speech — Slide 02: Contesto

Le architetture a **microservizi** cloud-native distribuiscono la complessità su un numero crescente di *servizi autonomi* che comunicano tramite **API REST**, con una *proliferazione di endpoint* spesso priva di una vera governance.
Per gestirla è nato il **gateway API**, *punto unico* che centralizza le *policy di sicurezza* invece di verificarle singolarmente su ogni servizio.

La maggior parte degli strumenti di testing esistenti verifica se un'API *funziona correttamente* (conformità funzionale), non se è *sicura*: un problema di *sintassi* più che di *semantica dei contratti*.
Questo lavoro nasce in questo *spazio poco esplorato*, con una valutazione che guarda sia al **gateway** che alla **logica applicativa** dietro di esso.

# Speech — Slide 03: Gaps

**G1** è la **cecità semantica**: i tool di assessment generici osservano la *sintassi* delle richieste, non la *semantica*, e una richiesta sintatticamente perfetta, per esempio chiedendo una risorsa con un ruolo che non dovrebbe vederla, può violare le *regole di accesso del sistema*.
Manca la *conoscenza del comportamento atteso* dietro ogni interazione, la stessa che servirà più avanti per costruire gli **specified oracles**.

**G2** riguarda il compromesso tra **profondità e portabilità**: gli strumenti **specifici** per un gateway o una piattaforma vanno in *profondità solo in quel contesto*, quelli **generici** restano *superficiali per l'assenza di conoscenze mirate*.

**G3** riguarda la **riproducibilità**: in un *ciclo di sviluppo continuativo*, dove il sistema cambia continuamente, solo verifiche *ripetibili con esattezza* permettono al tool di restare al passo con i cambiamenti senza perdere il controllo sul risultato.

**G4** è il **problema dell'oracolo**: generare *automaticamente delle richieste* verso un sistema è un compito che la letteratura ha già affrontato con buoni risultati, mentre stabilire se quello che si osserva viola una *garanzia di sicurezza* richiede un criterio che la specifica da sola non può fornire, perché dipende dalla *conoscenza del dominio* del controllo specifico.

# Speech — Slide 04: Obiettivi

Da queste quattro lacune nascono quattro obiettivi speculari, anche se il primo e il quarto pesano più degli altri nell'impianto di questo lavoro.

Il primo obiettivo è progettare un tool **contract-driven** e **agnostico**: la specifica **OpenAPI** fornisce il fondamento contrattuale per costruire *probe sintatticamente valide*, mentre il file di **configurazione** porta la *conoscenza* concreta del *deployment*, come i *parametri e le configurazioni dei test*.

O2 è restare **generici senza perdere profondità**: con un'adeguata *astrazione* è possibile mantenere verifiche approfondite pur restando *applicabili a qualsiasi sistema.*

O3 è il **determinismo** dell'output a *parità di configurazione e target*, condizione necessaria per l'integrazione nei *cicli di sviluppo continuativo*.

Il quarto obiettivo è, insieme al primo, quello su cui questo lavoro investe maggiormente: dimostrare che per ogni *verifica di sicurezza* è possibile ricavare un **criterio di valutazione** dalla *conoscenza del dominio* del controllo specifico, e *codificarlo* nella logica del test.

Vediamo ora come questi obiettivi prendono forma concreta.

# Speech — Slide 05: Agnosticismo applicativo e contract-driven

Il primo principio è l'**agnosticismo applicativo**: le uniche due sorgenti di conoscenza del target a runtime sono la specifica **OpenAPI** e un file di **configurazione**, e proprio per questo nel codice non c'è nulla di *hardcoded* e il tool è deployabile su *qualsiasi API REST documentata* senza modificare una riga.

A questo si affianca il paradigma **contract-driven**, che la specifica OpenAPI realizza in **tre modi**: guida la costruzione di probe *sintatticamente valide* invece di payload che si fermano a un errore di formato, spostando l'osservazione dalla *sintassi* alla *logica applicativa*; delimita la **superficie di attacco** al perimetro degli endpoint documentati; e fornisce un primo **criterio di valutazione** strutturale, anche se la profondità *semantica* vera nasce solo combinandolo con la *conoscenza del dominio*.

# Speech — Slide 06: Specified oracles

Abbiamo visto che la OAS da sola garantisce solo una validità *strutturale*.
Per giudicare se un *comportamento osservato* viola davvero una *garanzia di sicurezza* serve qualcosa in più: è il **problema dell'oracolo**.
Generare richieste verso un sistema è un problema maturo in letteratura, ma *giudicarne la correttezza* resta molto più aperto, ed è esattamente lo spazio in cui entrano gli **specified oracles**.

Il tool codifica per ogni test un **criterio definito a priori**, ricavato dalla *conoscenza del dominio* del controllo specifico.
Le fonti sono eterogenee: a volte lo **schema della specifica**, per esempio il tipo e i campi attesi in una risposta; a volte **standard tecnici pubblicati**, come le linee guida **NIST** sul TLS; a volte un **confronto ad-hoc** per quel controllo, come osservare le risposte ottenute con credenziali di ruolo diverso.

Il risultato è che ogni test produce un **verdetto in autonomia**, senza interpretazione manuale, perché il *criterio con cui giudica è fisso*: lo *stesso sistema*, interrogato nella *stessa configurazione*, produce quindi sempre lo *stesso verdetto*, ed è questa proprietà a fondare la **riproducibilità** di cui parleremo più avanti.

# Speech — Slide 07: Tassonomia e box gradient

Costruire i test ha richiesto uno studio a fondo dell'*intera categoria* delle **API REST esposte tramite gateway**, che ha condotto alla realizzazione di una **tassonomia di otto domini** di sicurezza.

I primi tre domini seguono una **catena di precondizioni logiche**: non ha senso verificare se un utente può accedere a una risorsa, l'*autorizzazione* (D2), se non si sa già che l'*autenticazione* (D1) funziona, né verificare l'autenticazione senza conoscere prima quali endpoint esistono, la *superficie di attacco* (D0).
Gli altri domini coprono l'*integrità dei dati* (D3), la *disponibilità* (D4), l'*osservabilità* (D5), la *configurazione del gateway* (D6), e le falle di *logica applicativa* più complesse come SSRF e race condition (D7).
In totale, **18 test** sono già **implementati** e altri **14** pianificati come sviluppi futuri.

Ogni test dichiara anche il proprio *livello di accesso necessario*: il **box gradient**; dal **Black Box** senza credenziali per i *controlli perimetrali*, al **Grey Box** con token validi per almeno *due ruoli* per le verifiche di *autorizzazione* (RBAC e BOLA), fino al **White Box** con accesso diretto all'**Admin API** del gateway.
Non è una scelta arbitraria: *riflette ciò che ogni garanzia richiede per essere verificata*.

# Speech — Slide 08: Pipeline di esecuzione e riproducibilità

Le prime **quattro** fasi, in rosso, sono **bloccanti**: un errore interrompe l'avvio prima che un solo test venga eseguito.
Si parte dalla lettura del file di **configurazione**, si passa poi allo scaricamento e validazione della specifica **OpenAPI**, si costruiscono i due **contesti** necessari all'esecuzione (uno *fisso*, con la conoscenza del target, e uno *mutabile*, che accumula lo stato durante l'esecuzione), e infine, in **Fase 4**, il *discovery dinamico* dei test scopre tutti quelli disponibili e il **DAG** costruisce il **grafo delle dipendenze**: il suo *ordine topologico* assicura che ogni test venga eseguito solo *dopo i suoi prerequisiti*, e per i test allo stesso livello, senza dipendenze reciproche, è un **ordinamento lessicografico** sul nome a stabilire l'*ordine totale*.

(sono questi due elementi, insieme agli *specified oracles fissi* e al *file di configurazione*, a garantire **riproducibilità e determinismo**).

Le ultime **tre**, in verde, sono invece **non bloccanti**: un errore qui viene isolato, e la *pipeline prosegue comunque.*
Si **eseguono i test** nell'ordine stabilito dal grafo, si fa il **teardown** delle risorse create durante i test nell'ordine esattamente *opposto* a come sono state create, e infine si genera il **report** finale.

Il risultato si traduce in quattro **exit code**, che distinguono il *fallimento del target* (**1**) da un *malfunzionamento del tool* (**2**) o da un *errore infrastrutturale* (**10**), permettendo a una pipeline **CI/CD** di reagire automaticamente senza analizzare i log.

-> malfunzionamento del tool -> errori imrpevisit ma gestiti
-> infrastrutturale tipo mancanza OAS o parametri test

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta su **Forgejo 14.0.3**, esposto tramite **Kong 3.9** in modalità **DB-less**, in un ambiente *Docker* in cloud.
È stato scelto per le sue *proprietà strutturali*: una *specifica OpenAPI* nativa e un'*autenticazione* reale con più livelli di privilegio, *senza* che il codice del tool *contenga alcun riferimento a Forgejo*, conferma pratica dell'**agnosticismo applicativo** dichiarato.

Due run *indipendenti* hanno prodotto risultati **byte-identici**, confermando empiricamente il **determinismo**.
Il **testbed** è stato costruito *deliberatamente* con configurazioni pensate per generare sia *esiti positivi che negativi attesi*, producendo **9 PASS** e **7 FAIL** distinti correttamente dal tool.

C'è poi un dato ancora più significativo: Forgejo dichiara nella sua specifica un'*autenticazione globale*, ma alcuni endpoint sono *genuinamente pubblici per progettazione* e rispondono correttamente anche *senza credenziali*.
È esattamente la classe di anomalia che il **contract-driven testing** è pensato per individuare, un *disallineamento* tra quello che il **contratto promette** e quello che il **sistema fa** davvero.

# Speech — Slide 10: Conclusioni

Questo lavoro *non risolve il testing della sicurezza delle API REST*: è un settore ancora *troppo giovane* per parlare di *soluzioni definitive*.
Quello che presento sono **contributi concreti**, *verificati empiricamente su un caso reale*.

Sul piano **metodologico** c'è la **tassonomia a otto domini**, *applicabile indipendentemente dagli strumenti*, e la *metodologia sistematica* per gli **specified oracles**; 
sul piano **ingegneristico**, l'**assessment engine basato sul DAG**, che garantisce un *ordinamento assoluto* dei test (determinismo).

Un **penetration testing tradizionale** produce un'**osservazione puntuale**, legata a un *operatore e a un momento specifico*.
Questo lavoro produce invece risultati **deterministicamente identici** a ogni riesecuzione, *verificabili da chiunque*.
**Da osservazione puntuale a garanzia misurabile.**

# Speech — Slide 11: Sviluppi futuri

Ogni approccio *contract-driven* ha un **limite intrinseco**: dipende dalla *qualità della specifica OpenAPI* del target, e un contratto *incompleto o disallineato* produce un assessment parziale senza che il sistema possa accorgersene.

Restano due fronti aperti. 
Il primo è un'**estensione operativa**: completare i domini *parzialmente coperti* e i relativi connector, ed estendere il supporto ai **gateway cloud managed** come *AWS o Azure*, che esponendo solo *API proprietarie* limitano oggi la copertura a Black Box e Grey Box.
(kong è un gateway api dedicato invece)

Gli altri due sono **direzioni di ricerca**: una **piattaforma modulare** per *protocolli eterogenei* come *gRPC e GraphQL*, dove il *contratto formale non sarebbe più la specifica OpenAPI* ma uno schema diverso, 
e la **formalizzazione degli oracoli di sicurezza**, un problema di ricerca *ancora aperto* a cui questo lavoro fornisce un *contributo*.

# Speech — Slide 12: Ringraziamenti

Vi *ringrazio per l'attenzione* e rimango a vostra disposizione per eventuali domande e chiarimenti.