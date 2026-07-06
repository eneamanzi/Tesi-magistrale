# Speech — Slide 01: Titolo

Buongiorno a tutti. Sono Enea Manzi e oggi vi presento il mio lavoro di tesi magistrale intitolato *"Progettazione e Implementazione di un Tool API-Agnostico per la Security Assurance di API REST"* svolto presso SesarLab sotto la supervisione del Prof Marco Anisetti e del Prof Claudio Agostino Ardagna.

# Speech — Slide 02: Contesto

Le architetture a **microservizi** cloud-native distribuiscono la loro complessità su un numero crescente di *servizi autonomi* comunicanti tra loro tramite **API REST**, favorendo la *proliferazione incontrollata di endpoint* spesso accompagnata dall'assenza di una *vera governance*.
Per gestire questa complessità è nato il **gateway API**, un *punto unico* che **centralizza** la *gestione degli endpoint* esposti e l'enforcement delle *policy di sicurezza*.

Tuttavia, gli attuali strumenti di testing per queste architetture risultano spesso **limitati** alla sola verifica della *conformità funzionale* e della *sintassi delle richieste*, trascurando quindi la *semantica dei contratti* e la vera *sicurezza dell'API*;
il mio lavoro si pone/si inserisce in questo *spazio poco esplorato*, proponendo una **valutazione di sicurezza** che copra sia il *gateway* che la *logica applicativa*.

# Speech — Slide 03: Gaps

**G1** formalizza quanto accennato nella **cecità semantica**. 
I tool di assessment attuali si concentrano su una valutazione *sintattica*, trascurando la *sicurezza* dei sistemi: una *richiesta sintatticamente ineccepibile* può comunque tentare l'accesso a un *dato non autorizzato* non venendo rilevata, minando quindi **la sicurezza del sistema** o non rispettando la **semantica dei contratti**.

**G2** riguarda il compromesso tra **profondità e portabilità**: 
da un lato strumenti **verticali**, che risultano **specifici** ma ancorati a una *singola piattaforma*; 
dall'altro strumenti **orizzontali**, ossia soluzioni **generiche** applicabili in qualsiasi contesto, che tuttavia offrono *meno profondità* data l'*assenza di conoscenze mirate*.

**G3** riguarda la **riproducibilità**: 
in un **ciclo di sviluppo continuativo**, dove il sistema *cambia continuamente*, solo verifiche *riproducbili con esattezza* consentono *valutazioni affidabili* e integrabili in pipeline

Infine, **G4** è il **problema dell'oracolo**. 
Mentre generare *automaticamente delle richieste* è un compito che la letteratura ha già affrontato con buoni risultati, stabilire se il *comportamento osservato violi* una *garanzia di sicurezza* è ancora una sfida aperta

# Speech — Slide 04: Obiettivi

Da queste quattro lacune nascono quattro obiettivi, con il primo e il quarto che rappresentano i pilastri di questo lavoro.

Il primo obiettivo è progettare un tool che sia **contract-driven** e **totalmente agnostico**, capace cioè di *testare qualsiasi API REST*, esposta tramite *gateway o meno*, **senza dover scrivere codice specifico** per il target. 

O2 si occupa di gestire il **compromesso tra portabilità e profondità** e lo fa attraverso un'*astrazione* che *generalizzi i vari sistemi* permettendo *verifiche rigorose*

Il terzo è garantire la **riproducibilità deterministica** dell'output a *parità di condizioni*, un requisito fondamentale per l'*integrazione* del tool nei *cicli di sviluppo continuativo*.

Infine, il quarto obiettivo: **superare l'interpretazione manuale**.
Vogliamo dimostrare che per ogni *verifica di sicurezza* è possibile ricavare un **criterio di valutazione** oggettivo dalla *conoscenza del dominio* di ogni controllo, *codificandolo* direttamente nella logica del test.

# Speech — Slide 05: Agnosticismo applicativo e contract-driven

Il primo principio fondante è l'**agnosticismo**. 
Per ottenerlo, abbiamo *estratto tutta la conoscenza del target e del gateway dal codice sorgente*, confinandola a 2 sole *risorse lette a runtime*: la **specifica OpenAPI** e un **file di configurazione**, che fornisce i *parametri* e le varie *impostazioni*.
In questo modo non c'è *nulla di hardcoded* e il tool è quindi deployabile su *qualsiasi API REST documentata* senza modificare una singola riga.

A questo si unisce il paradigma **contract-driven** che utilizza la *specifica OpenAPI* in tre modi distinti:
Primo, guida la costruzione di **probe sintatticamente valide**, permettendoci di superare i banali errori di formato e spostando l'osservazione *dalla sintassi* alla *logica applicativa* o *semantica*.
Secondo, *delimita* chirurgicamente la **superficie di attacco** ai soli endpoint dichiarati.
Terzo, fornisce un primo **criterio di valutazione strutturale**, anche se la profondità *semantica* nasce solo con la *conoscenza del dominio*.

# Speech — Slide 06: Specified oracles

In letteratura, mentre la *generazione delle richieste* è un ambito di ricerca maturo, *la valutazione* della **correttezza del comportamento osservato** resta un problema aperto, noto come **problema dell'oracolo**.
L'utilizzo della *specifica OpenAPI* garantisce una *validità strutturale e sintattica* ma per fare il salto di qualità e individuare le reali *violazioni di sicurezza e semantiche* è necessario introdurre gli **specified oracles**.

Per ogni test viene definito un **criterio fissato a priori** basato sulla *conoscenza del dominio*, per generare un *verdetto in autonomia*; 
essendo il criterio fisso, a *parità di condizioni* il risultato è sempre *identico*, garantendo la **riproducibilità** e il **determinismo**.

Le fonti di consocenza sono eterogenee: a volte lo **schema della specifica**, per esempio il *tipo e i campi attesi* in una risposta; 
a volte **standard tecnici pubblicati**, come le linee guida **NIST** sul TLS; 
a volte un **confronto ad-hoc** per quel controllo, come osservare le risposte ottenute con *credenziali di ruolo diverso*.

# Speech — Slide 07: Tassonomia e box gradient

Costruire i test ha richiesto uno *studio approfondito* dell'*intera categoria* delle **API REST esposte tramite gateway**, che ha condotto alla realizzazione di una **tassonomia di otto domini** di sicurezza.

I primi tre seguono una precisa **catena di precondizioni logiche**: non ha senso verificare l'*autorizzazione* (un utente può svolgere un'azione) (**D2**) se l'*autenticazione* (**D1**) non funziona, ed è *impossibile testare l'autenticazione* (verificare identità di un utente) senza conoscere prima quali endpoint esistono, la *superficie di attacco* (**D0**).
I restanti cinque domini completano lo *spettro di sicurezza*, spaziando dall'*integrità dei dati* (D3), alla *disponibilità* (D4) fino alla falle di *logica applicativa* (D7) più complesse come SSRF
Ad oggi, su questi otto domini contiamo **18 test già implementati** e *14 pianificati.*

Infine, per ogni test abbiamo definito il **box gradient**, ovvero il *livello di accesso necessario*: dal **Black Box** per i controlli *perimetrali*, al **Grey Box** con *token e credenziali valide*, fino al **White Box** con accesso diretto all'*Admin API* del gateway. 
Queste distinzioni riflette esattamente le *precondizioni* che ogni *garanzia richiede per essere verificata*.

# Speech — Slide 08: Pipeline di esecuzione e riproducibilità

Le prime **quattro** fasi, in rosso, sono **bloccanti**: un errore qui ferma tutto prima che alcun test venga eseguito.
Si parte dalla *lettura* del file di **configurazione**,
per poi passare allo *scaricamento e validazione* della specifica **OpenAPI**.
Nella fase 3 si costruiscono i due **contesti** necessari all'esecuzione (uno *fisso* con la conoscenza del target, e uno *mutabile* per la consocenza a runtime).
Infine, la **Fase** 4 **scopre i test dinamicamente** e tramite un **DAG** costruisce il **grafo delle dipendenze**: l'*ordine topologico* garantisce che ogni test attenda i suoi *prerequisiti*; mentre per i test senza dipendenze reciproche vengono poi *ordinati lessicograficamente* sul nome, producendo un *ordine totale* che garantisce *determinismo*

Le ultime **tre fasi**, in verde, sono invece **non bloccanti**: un errore viene *isolato* e la *pipeline procede* comunque.
Si **eseguono i test** nell'ordine stabilito dal grafo, si fa il **teardown** delle risorse create in *ordine inverso*, e si genera il **report** finale. 

Tutto questo si traduce in quattro **exit code semantici** che permettono a una **pipeline CI/CD** di *reagire automaticamente*, distinguendo il *succeso (0) e fallimento del target* (1), da un *malfunzionamento imprevisto del tool* (2) e da *errori infrastrutturali*, come la mancanza dell'OpenAPI spec (10).

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta contro *Forgejo*, esposto tramite *Kong* DB-less.
Abbiamo scelto il target *applicativo di test* per le sue **proprietà strutturali** in quanto offre una *specifica OpenAPI generata nativamente* e gestisce vari *livelli di autenticazione*.
Poiché nel codice del tool *non c'è alcun riferimento esplicito a Forgejo*, si dimostra empiricamente l'**agnosticismo applicativo** dichiarato.

Il **determinismo** è stato confermato eseguendo 2 *run indipendenti* contro lo stesso test bed, che hanno restituito risultati **byte-identici**; 
il *testbed* è stato *configurato appositamente* per presentare sia *successi* che *vulnerabilità attese*, in cui il tool li ha *correttamente distinti* producendo **9 PASS e 7 FAIL.**

è stata anche individuata una **discrepanza reale**: Forgejo dichiara nella sua specifica un'*autenticazione globale*, ma alcuni endpoint sono *genuinamente pubblici per progettazione* e rispondono correttamente anche *senza credenziali*.
È esattamente la classe di anomalia che il **contract-driven testing** è pensato per individuare, un *disallineamento* tra quello che il **contratto promette** e quello che il **sistema fa** davvero.

# Speech — Slide 10: Conclusioni e Sviluppi Futuri

In sintesi, questo lavoro ha costruito una **tassonomia per la security assurance**, definito degli **specified oracles** come *criterio di valutazione* di quanto osservato, e *orchestrato* tutto con un **engine deterministico** basato su DAG;
Andando a riprendere gli obbiettivi dichiarati all'inizio, possiamo affermare che vengono soddisfatti ottenendo un tool **agnostico** (O1), **portabile** (O2), **riproducibile deterministicamente** (O3) e con **oracoli fissi** (O4). 

Per quanto riguarda gli sviluppi futuri, invece, rimane il completamento dei **domini parziali**, con nuovi *test e connector*; 
e due **direzioni di ricerca** più ampie:
l'estensione a *piattaforma modulare* per *protocolli eterogenei* come gRPC e GraphQL (dove cambia il contratto formale),
e soprattutto continuare la **formalizzazione degli oracoli di sicurezza**, un problema di *ricerca ancora aperto* a cui questo lavoro fornisce un *contributo*

# Speech — Slide 11: Ringraziamenti

Vi *ringrazio per l'attenzione* e rimango a vostra disposizione per eventuali domande e chiarimenti.