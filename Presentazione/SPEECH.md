# Speech — Slide 01: Titolo

Buongiorno a tutti. Sono Enea Manzi e oggi vi presento il mio lavoro di tesi magistrale intitolato *"Progettazione e Implementazione di un Tool API-Agnostico per la Security Assurance di API REST"* svolto presso SesarLab sotto la supervisione del Prof Marco Anisetti e del Prof Claudio Agostino Ardagna.

# Speech — Slide 02: Contesto

Le architetture a **microservizi** cloud-native distribuiscono la complessità su un numero crescente di *servizi autonomi* che comunicano tramite **API REST**, portando a una *proliferazione di endpoint* spesso priva di una *vera governance*.
Per gestire questa complessità è nato il **gateway API**, un *punto unico* che *centralizza* le *policy di sicurezza* e la *gestione delle API* esposte.

Tuttavia, la maggior parte degli strumenti di testing odierni sono *sbilanciati*: verificano se un'API *funziona correttamente* (conformità funzionale), ma non la sua vera **sicurezza**. 
Si fermano alla pura *sintassi* delle richieste, trascurando la *semantica dei contratti*.
Questo lavoro si inserisce in questo *spazio poco esplorato*, proponendo una valutazione che copra sia il **gateway** che la **logica applicativa** sottostante.

# Speech — Slide 03: Gaps

**G1** è la **cecità semantica**. I tool di assessment attuali si fermano principalmente alla *sintassi* del contratto. 
Tuttavia, una richiesta *sintatticamente ineccepibile* può benissimo richiedere l'accesso a un *dato non autorizzato*, **violando le regole semantiche** del sistema.
A questi strumenti *manca la conoscenza del comportamento atteso*.

**G2** riguarda il compromesso tra **profondità e portabilità**: 
da un lato abbiamo strumenti **specifici** ma ancorati a una *singola piattaforma*; dall'altro, strumenti **generici** che funzionano ovunque, ma restano *inevitabilmente superficiali* per l'*assenza di conoscenze mirate*.

**G3** riguarda la **riproducibilità**: in un *ciclo di sviluppo continuativo*, dove il sistema cambia continuamente, solo verifiche *ripetibili con esattezza* consentono *automazione e confronti affidabili*

Infine, **G4** è il **problema dell'oracolo**. 
Mentre generare *automaticamente delle richieste* è un compito che la letteratura ha già affrontato con buoni risultati, stabilire se il *comportamento osservato violi* una *garanzia di sicurezza* è ancora una sfida. 
Questo richiede un criterio che la *specifica da sola non può fornire*, proprio perché dipende dalla **conoscenza del dominio del controllo specifico**.

# Speech — Slide 04: Obiettivi

Da queste quattro lacune nascono quattro obiettivi speculari, con il primo e il quarto che rappresentano i veri pilastri di questo lavoro.

Il primo obiettivo è progettare un tool che sia **contract-driven** e **totalmente agnostico**, capace cioè di *testare qualsiasi API REST*, esposta tramite *gateway o meno*, **senza dover scrivere codice specifico** per il target. 

Il secondo è riuscire a **restare generici senza perdere profondità**: vogliamo un'*astrazione* che mantenga le *verifiche rigorose* pur *adattandosi a sistemi diversi*.

Il terzo è garantire il **determinismo** dell'output a *parità di condizioni*, un requisito fondamentale se vogliamo che il tool sia *integrabile nei cicli di sviluppo continuativo*.

Infine, il quarto obiettivo: **superare l'interpretazione manuale**.
Vogliamo dimostrare che per ogni *verifica di sicurezza* è possibile ricavare un **criterio di valutazione** oggettivo dalla *conoscenza del dominio* di ogni controllo, *codificandolo* direttamente nella logica del test.

Vediamo ora come questi obiettivi prendono forma concreta.

# Speech — Slide 05: Agnosticismo applicativo e contract-driven

Il primo principio fondante è l'**agnosticismo applicativo**. 
Per ottenerlo, abbiamo *estratto tutta la conoscenza del target dal codice sorgente*, *confinandola a due sole risorse* lette a runtime: la **specifica OpenAPI** e un **file di configurazione**, che fornisce i *parametri* e i *dettagli di deployment* specifici per il target.
In questo modo non c'è *nulla di hardcoded* e il tool è quindi deployabile su *qualsiasi API REST documentata* senza modificare una singola riga.

A questo si unisce il paradigma **contract-driven**. 
La specifica OpenAPI non è solo un documento, ma diventa il *motore del nostro strumento* in tre modi:
Primo, guida la costruzione di **probe sintatticamente valide**, permettendoci di superare i banali errori di formato e spostare l'osservazione *dalla sintassi* alla vera *logica applicativa*.
Secondo, *delimita* chirurgicamente la **superficie di attacco** ai soli endpoint esposti.
Terzo, fornisce un primo **criterio di valutazione strutturale**, anche se la profondità *semantica* vera nasce solo combinandolo con la *conoscenza del dominio*.

# Speech — Slide 06: Specified oracles

In letteratura, mentre la *generazione delle richieste* è un ambito di ricerca maturo, *la valutazione* della **correttezza del comportamento osservato** resta un problema aperto, noto come **problema dell'oracolo**.
Come abbiamo visto, fermarsi alla sola *specifica OpenAPI* garantisce unicamente una *validità strutturale*. 
Per fare il salto di qualità e individuare le reali *violazioni di sicurezza*, abbiamo quindi affrontato questo ostacolo applicando il concetto di **specified oracles**.

Il tool definisce per ogni test un **criterio a priori** basato sulla *conoscenza del dominio* del controllo specifico, permettendogli di generare un **verdetto in autonomia**.
Poiché questo *metro di giudizio è fisso*, a *parità di condizioni il risultato sarà sempre identico*, fondando il principio di **riproducibilità** di cui parleremo a breve.

Le fonti sono eterogenee: a volte lo **schema della specifica**, per esempio il *tipo e i campi attesi* in una risposta; 
a volte **standard tecnici pubblicati**, come le linee guida **NIST** sul TLS; 
a volte un **confronto ad-hoc** per quel controllo, come osservare le risposte ottenute con *credenziali di ruolo diverso*.

# Speech — Slide 07: Tassonomia e box gradient

Costruire i test ha richiesto uno *studio approfondito* dell'*intera categoria* delle **API REST esposte tramite gateway**, che ha condotto alla realizzazione di una **tassonomia di otto domini** di sicurezza.

I primi tre seguono una precisa **catena di precondizioni logiche**: non ha senso verificare l'*autorizzazione* (un utente può svolgere un'azione) (**D2**) se l'*autenticazione* (**D1**) non funziona, ed è *impossibile testare l'autenticazione* senza conoscere prima quali endpoint esistono, la *superficie di attacco* (**D0**).
I restanti cinque domini completano lo *spettro di sicurezza*, spaziando dall'*integrità dei dati* (D3), alla *disponibilità* (D4) fino alla falle di *logica applicativa* (D7) più complesse come SSRF
Ad oggi, su questi otto domini contiamo **18 test già implementati** e *14 pianificati.*

Infine, per ogni test abbiamo definito il **box gradient**, ovvero il *livello di accesso necessario*: dal **Black Box** per i controlli *perimetrali*, al **Grey Box** con *token e credenziali valide*, fino al **White Box** con accesso diretto all'*Admin API* del gateway. 
Non è una scelta arbitraria, ma riflette esattamente le *precondizioni* che ogni specifica *garanzia richiede per essere verificata*.

# Speech — Slide 08: Pipeline di esecuzione e riproducibilità

Le prime **quattro** fasi, in rosso, sono **bloccanti**: un errore qui ferma tutto prima di lanciare qualsiasi test.
Si parte dalla *lettura* del file di **configurazione**,
per poi passare allo *scaricamento e validazione* della specifica **OpenAPI**.
Nella fase 3 si costruiscono i due **contesti** necessari all'esecuzione (uno *fisso* con la conoscenza del target, e uno *mutabile* per la consocenza a runtime).
Infine, la **Fase** 4 **scopre i test dinamicamente** e costruisce il **grafo delle dipendenze**: l'*ordine topologico* garantisce che ogni test attenda i suoi *prerequisiti*; per i test senza dipendenze reciproche vengono poi *ordinati lessicograficamente* sul nome, producendo un *ordine totale* che garantisce *determinismo*

Le ultime **tre fasi**, in verde, sono invece **non bloccanti**: un errore viene *isolato* per far *proseguire comunque la pipeline*.
Si **eseguono i test** nell'ordine stabilito dal grafo, si fa il **teardown** delle risorse create in *ordine inverso*, e si genera il **report** finale. 

Tutto questo si traduce in quattro **exit code semantici**, che distinguono il *fallimento del target* (1), da un *malfunzionamento imprevisto del tool* (2), o da *errori infrastrutturali*, come la mancanza dell'OpenAPI spec (10). 
Questo permette a una **pipeline CI/CD** di *reagire automaticamente*

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta contro *Forgejo*, esposto tramite *Kong* DB-less.
Abbiamo scelto il target *applicativo di test* per le sue **proprietà strutturali** in quanto offre una *specifica OpenAPI nativa* e gestisce veri *livelli di privilegio*.
Poiché nel codice del tool *non c'è alcun riferimento esplicito a Forgejo*, si dimostra empiricamente l'**agnosticismo applicativo**.

Il **determinismo** è stato confermato eseguendo *run indipendenti* che hanno restituito risultati **byte-identici**.
Il **testbed** è stato *configurato deliberatamente* per presentare sia *successi* che *vulnerabilità attese*, e il tool li ha *distinti correttamente* producendo **9 PASS e 7 FAIL**.

C'è poi un dato ancora più significativo: Forgejo dichiara nella sua specifica un'*autenticazione globale*, ma alcuni endpoint sono *genuinamente pubblici per progettazione* e rispondono correttamente anche *senza credenziali*.
È esattamente la classe di anomalia che il **contract-driven testing** è pensato per individuare, un *disallineamento* tra quello che il **contratto promette** e quello che il **sistema fa** davvero.

# Speech — Slide 10: Conclusioni e Sviluppi Futuri

In sintesi, questo lavoro ha costruito una **tassonomia per la security assurance**, definito gli **specified oracles** come *criterio di valutazione*, e *orchestrato* tutto con un **motore deterministico**;
si ottiene quindi un tool **agnostico** (O1), **portabile** (O2) e **riproducibile** (O3) con **oracoli fissi** (O4). 

Restano quindi alcuni sviluppi futuri: 
il completamento dei **domini parziali**, con nuovi *test e connector*, e *adapter* per i *gateway cloud managed*; 
e due **direzioni di ricerca** più ampie, l'estensione a piattaforma modulare per *protocolli eterogenei* come gRPC e GraphQL (dove cambia il contratto formale),
e soprattutto continuare la **formalizzazione degli oracoli di sicurezza**, un problema di *ricerca ancora aperto* a cui questo lavoro fornisce un *contributo*

# Speech — Slide 11: Ringraziamenti

Vi *ringrazio per l'attenzione* e rimango a vostra disposizione per eventuali domande e chiarimenti.