# Speech — Slide 01: Titolo

Buongiorno a tutti. Sono Enea Manzi e oggi vi presento il mio lavoro di tesi magistrale intitolato *"Progettazione e Implementazione di un Tool API-Agnostico per la Security Assurance di API REST"* svolto presso SesarLab sotto la supervisione del Prof Marco Anisetti e del Prof Claudio Agostino Ardagna.

# Speech — Slide 02: Contesto

Le architetture a **microservizi** cloud-native distribuiscono la complessità su un numero crescente di servizi autonomi che comunicano tramite **API REST**, con una *proliferazione di endpoint* spesso priva di una vera governance.
Per gestirla è nato il **gateway API**, *punto unico* che centralizza le regole di accesso invece di verificarle singolarmente su ogni servizio.

La maggior parte degli strumenti di testing esistenti verifica se un'API *funziona correttamente*, non se è *sicura*: un problema di *sintassi* più che di *semantica dei contratti*.
Questo lavoro nasce in questo spazio poco esplorato, con una valutazione che guarda sia al **gateway** che alla **logica applicativa** dietro di esso.

# Speech — Slide 03: Gaps

Gli scanner **DAST** e i **fuzzer** generici osservano la *sintassi* delle richieste, non la *semantica*: una richiesta sintatticamente perfetta può comunque violare le *regole di accesso del sistema*, per esempio restituendo una risorsa a un ruolo che non dovrebbe vederla.
Senza conoscere il *comportamento atteso* dietro ogni interazione, uno scanner non costruisce richieste che arrivino davvero a toccare questa logica.
Questo è **G1**, è uno dei due gap su cui questo lavoro si concentra maggiormente.

**G2** riguarda il compromesso tra profondità e portabilità: gli strumenti pensati per un gateway o una piattaforma particolare vanno in profondità solo in quel contesto, quelli generici restano superficiali perché richiedono conoscenze mirate che un approccio generico non porta con sé.

**G3** riguarda la **riproducibilità**: in un *ciclo di sviluppo continuativo*, senza un modo per rendere le verifiche *ripetibili con esattezza*, diventa impossibile distinguere una vera regressione di sicurezza da una semplice differenza nel modo in cui è stata condotta la verifica.

**G4** è il **problema dell'oracolo**: generare *automaticamente delle richieste* verso un sistema è un compito che la letteratura ha già affrontato con buoni risultati, mentre stabilire se quello che si osserva viola una *garanzia di sicurezza* richiede un criterio che la specifica da sola non può fornire, perché dipende dalla *conoscenza del dominio* del controllo specifico.

# Speech — Slide 04: Obiettivi

Da queste quattro lacune nascono quattro obiettivi, tutti orientati allo stesso scopo complessivo, anche se il primo e il quarto pesano più degli altri nell'impianto di questo lavoro.

Il primo obiettivo è progettare un tool **contract-driven** e **agnostico**.
La specifica **OpenAPI** fornisce il fondamento contrattuale per costruire *probe sintatticamente valide*, mentre il file di **configurazione** porta la *conoscenza* concreta del *deployment*, come le credenziali dei ruoli e i *parametri/configurazioni dei test*.

O2 è restare generici senza perdere profondità: con un'adeguata *astrazione* è possibile mantenere verifiche approfondite pur restando applicabili a qualsiasi sistema.

O3 è il **determinismo**: la *stessa configurazione*, applicata allo *stesso target*, deve produrre sempre lo *stesso output*, condizione necessaria per integrare il tool in un **ciclo di sviluppo continuativo**.

Il quarto obiettivo è, insieme al primo, quello su cui questo lavoro investe maggiormente: dimostrare che per ogni *verifica di sicurezza* è possibile ricavare un **criterio di valutazione** dalla *conoscenza del dominio* del controllo specifico, e *codificarlo* direttamente nella logica del singolo test.

Vediamo ora come questi obiettivi prendono forma concreta.

# Speech — Slide 05: Agnosticismo applicativo e contract-driven

Il primo principio è l'**agnosticismo applicativo**: le uniche due sorgenti di conoscenza del target a runtime sono la specifica **OpenAPI** e un file di **configurazione**, e proprio per questo nel codice non c'è nulla di *hardcoded* e il tool è deployabile su *qualsiasi API REST documentata* senza modificare una riga.

Questo rende possibile il paradigma **contract-driven**, che la specifica OpenAPI realizza in **tre modi**: guida la costruzione di probe *sintatticamente valide* invece di payload che si fermano a un errore di formato, spostando l'osservazione dalla *sintassi* alla *logica applicativa*; delimita la **superficie di attacco** al perimetro degli endpoint documentati; e fornisce un primo **criterio di valutazione** strutturale, anche se la profondità *semantica* vera nasce solo combinandolo con la *conoscenza del dominio*.

# Speech — Slide 06: Specified oracles

Abbiamo visto che la OAS da sola garantisce solo una validità *strutturale*.
Per giudicare se un *comportamento osservato* viola davvero una *garanzia di sicurezza* serve qualcosa in più: è il cosiddetto **problema dell'oracolo**.
Generare richieste verso un sistema è un problema maturo in letteratura, ma giudicarne la correttezza resta molto più aperto, ed è esattamente lo spazio in cui entrano gli **specified oracles**.

Il tool codifica per ogni test un **criterio definito a priori**, ricavato dalla *conoscenza del dominio* del controllo specifico.
Le fonti sono eterogenee: a volte lo **schema della specifica**, per esempio il tipo e i campi attesi in una risposta; a volte **standard tecnici pubblicati**, come le linee guida **NIST** sul TLS; a volte un **confronto ad-hoc** per quel controllo, come osservare le risposte ottenute con credenziali di ruolo diverso.

Il risultato è che ogni test produce un **verdetto in autonomia**, senza interpretazione manuale, perché il criterio con cui giudica è fisso: lo stesso sistema, interrogato nella stessa configurazione, produce quindi sempre lo stesso verdetto, ed è questa proprietà a fondare la **riproducibilità** di cui parleremo più avanti.

# Speech — Slide 07: Tassonomia e box gradient

Per costruire i test è stato necessario *studiare* a fondo il *tipo di scenario operativo*: l'*intera categoria* delle **API REST esposte tramite gateway**.
Da questo studio è nata una **tassonomia di otto domini** di sicurezza.

I primi tre domini seguono una **catena di precondizioni logiche**: non ha senso verificare se un utente può accedere a una risorsa, l'*autorizzazione* (D2), se non si sa già che l'*autenticazione* (D1) funziona, né verificare l'autenticazione senza conoscere prima quali endpoint esistono, la *superficie di attacco* (D0).
Gli altri domini coprono l'integrità dei dati (D3), la disponibilità (D4), l'osservabilità (D5, predisposta architetturalmente ma senza test attivi in questa versione), la configurazione del gateway (D6), e le falle di *logica applicativa* più complesse come SSRF e race condition (D7).
In totale, **18 test** sono già **implementati** e altri **14** pianificati come sviluppi futuri.

Ogni test dichiara anche il proprio *livello di accesso necessario*: il **box gradient**, dal **Black Box** senza credenziali per i controlli perimetrali, al **Grey Box** con token validi per almeno due ruoli per le verifiche di autorizzazione come **RBAC** e **BOLA**, fino al **White Box** con accesso diretto all'**Admin API** del gateway.
Non è una scelta arbitraria, ma la conseguenza diretta di cosa serve per verificare ogni garanzia: alcune restano semplicemente fuori portata senza il privilegio giusto.

# Speech — Slide 08: Pipeline di esecuzione e riproducibilità

Le prime **quattro** fasi, in rosso, sono **bloccanti**: un errore in una di queste interrompe l'avvio prima che un solo test venga eseguito.
Si legge il file di **configurazione**, si scarica e si valida la specifica **OpenAPI** costruendo la superficie di assessment, si costruiscono due **contesti distinti** (uno *fisso*, con la conoscenza del target, e uno *mutabile*, che accumula lo stato durante l'esecuzione), e infine si scoprono dinamicamente tutti i test disponibili grazie a un *discovery dinamico* che permette di aggiungerne uno nuovo con un solo file, costruendo il **grafo delle dipendenze**.

Le ultime **tre**, in verde, sono invece **non bloccanti**: un errore qui viene isolato, e la pipeline prosegue comunque.
Si eseguono i test nell'ordine stabilito dal grafo, si fa il **teardown** delle risorse create durante i test nell'ordine esattamente *opposto* a come sono state create, e si genera il **report** finale.

Tutto questo funziona in modo riproducibile grazie a meccanismi che abbiamo già incontrato: gli **specified oracles**, con un *criterio di valutazione fisso* che garantisce sempre lo stesso verdetto, e il **file di configurazione**, *unica fonte di verità* per i parametri del tool.
A questi si aggiunge il **DAG** appena visto in Fase 4: il suo *ordine topologico* assicura che ogni test venga eseguito solo dopo i suoi prerequisiti, e per i test allo stesso livello, senza dipendenze reciproche, un **ordinamento lessicografico** sul nome stabilisce un *ordine totale*, sa sempre dire chi viene prima.

Questo determinismo si traduce operativamente nei quattro **exit code**: distinguono il fallimento del target (**1**) da un malfunzionamento del tool (**2**) o da un errore infrastrutturale (**10**), permettendo a un sistema come **GitHub Actions** o **GitLab CI** di reagire automaticamente, senza dover analizzare i log.

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta su **Forgejo 14.0.3**, esposto tramite **Kong 3.9** in modalità **DB-less**, in un ambiente Docker locale.
È stato scelto per le sue *proprietà strutturali*: una *specifica OpenAPI* nativa e un'*autenticazione* reale con più livelli di privilegio, senza che il codice del tool contenga alcun riferimento a Forgejo, conferma pratica dell'**agnosticismo applicativo** di cui abbiamo parlato.

Due run indipendenti hanno prodotto risultati **byte-identici**, verificando direttamente il determinismo e producendo **9 PASS**, **7 FAIL**, **2 SKIP** e **0 ERROR** su **18 test** attivi nei **7 domini**, per un totale di **98 finding**: i FAIL sono configurazioni *deliberatamente non conformi* nel testbed, distinte correttamente dal tool in ogni run.

Il risultato più significativo è la **discrepanza** che si vede nel box: Forgejo dichiara nella sua specifica un'*autenticazione globale*, ma alcuni endpoint sono *genuinamente pubblici per progettazione*, e rispondono correttamente anche *senza credenziali*, esattamente la classe di anomalia che il **contract-driven testing** è pensato per individuare: un *disallineamento* tra quello che il **contratto promette** e quello che il **sistema fa** davvero.

# Speech — Slide 10: Conclusioni

Questo lavoro non risolve il testing della sicurezza delle API REST: è un settore ancora *troppo giovane* per parlare di *soluzioni definitive*.
Quello che presento sono **contributi concreti**, *verificati empiricamente su un caso reale*.

Sul piano **metodologico** c'è la **tassonomia a otto domini**, *applicabile indipendentemente dagli strumenti*, e la *metodologia sistematica* per gli **specified oracles**; sul piano **ingegneristico**, l'**assessment engine basato sul DAG**, che garantisce un *ordinamento assoluto* dei test.

Un **penetration testing tradizionale** produce un'**osservazione puntuale**, legata a un *operatore e a un momento specifico*.
Questo lavoro produce invece risultati **deterministicamente identici** a ogni riesecuzione, *verificabili da chiunque*.
**Da osservazione puntuale a garanzia misurabile.**

# Speech — Slide 11: Sviluppi futuri

Ogni approccio *contract-driven* ha un **limite intrinseco**: dipende dalla *qualità della specifica OpenAPI* del target, e un contratto *incompleto o disallineato* produce un assessment parziale senza che il sistema possa accorgersene.

Restano due fronti aperti. Il primo è un'**estensione operativa**: completare i domini *parzialmente coperti* e i relativi connector, ed estendere il supporto ai **gateway cloud managed** come *AWS o Azure*, che esponendo solo *API proprietarie* limitano oggi la copertura a Black Box e Grey Box.

Gli altri due sono **direzioni di ricerca**: una **piattaforma modulare** per *protocolli eterogenei* come *gRPC e GraphQL*, dove il *contratto formale non sarebbe più la specifica OpenAPI* ma uno schema diverso, e la **formalizzazione** degli oracoli di sicurezza, un problema di ricerca *ancora agli inizi e poco affrontato in letteratura*, di cui questo lavoro offre solo un *contributo iniziale*.

# Speech — Slide 12: Ringraziamenti

Vi ringrazio per l'attenzione e sono a disposizione per eventuali domande e approfondimenti.