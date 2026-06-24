# Speech — Slide 00: Titolo
Buongiorno a tutti. Sono Enea Manzi e oggi vi presento il mio lavoro di tesi magistrale intitolato "Progettazione e Implementazione di un Tool API-Agnostico per la Security Assurance di API REST" svolto presso SesarLab sotto la supervisione del Prof Marco Anisetti e del Prof Claudio Agostino Ardagna.

# Speech — Slide 01: Contesto

Le architetture a **microservizi** cloud-native distribuiscono la complessità su un numero crescente di servizi autonomi, che comunicano tra loro tramite **API REST**. La conseguenza è una *proliferazione di endpoint* che spesso cresce senza un inventario centralizzato e senza una vera governance del loro ciclo di vita.

Per governare questa complessità è nato il **gateway API**: un punto unico, posto davanti a tutti i servizi, dove si concentrano e si controllano le regole di accesso, invece di doverle ripetere e verificare singolarmente su ognuno di essi.

Detto questo, la maggior parte degli strumenti di testing esistenti verifica se un'API *funziona correttamente*, non se è *sicura*. Una revisione sistematica di **92 contributi** pubblicati tra il 2009 e il 2022 mostra che circa l'**80% (72 contributi)** si concentra su questo tipo di verifica funzionale, e meno del **10% (8 contributi)** affronta esplicitamente la sicurezza in modo specifico. Questo lavoro nasce proprio in questo spazio ancora poco esplorato: una valutazione di sicurezza che guardi sia al **gateway** che alla **logica applicativa** delle API che vi sono dietro.

Vediamo allora più precisamente quali sono i limiti specifici degli approcci esistenti, da cui partiamo.

# Speech — Slide 02: Gaps

Gli scanner **DAST** e i **fuzzer** generici lavorano osservando la *sintassi* delle richieste e delle risposte HTTP: generano payload, guardano i codici di errore, cercano anomalie nella forma di quello che inviano o ricevono. Ma molte vulnerabilità delle API REST non sono di forma, sono di sostanza: una richiesta può essere sintatticamente perfetta e violare comunque le regole di accesso del sistema, per esempio chiedendo una risorsa con un ruolo che non dovrebbe poterla vedere. Per accorgersene serve conoscere il *contratto*/*comportamento atteso* dietro ogni interazione: chi può accedere a cosa, quanto dura un token, quali sequenze di operazioni hanno senso. Senza questa conoscenza, uno scanner non può costruire in modo sistematico le richieste che arrivano davvero a toccare questa logica. Questo è **G1, la cecità semantica**, ed è uno dei due gap su cui questo lavoro si concentra maggiormente.

**G2** riguarda invece un compromesso che si ripete in letteratura. Gli strumenti pensati per un gateway o una piattaforma specifica riescono ad andare in *profondità*, ma solo in quel contesto. Quelli generici, che funzionano su qualsiasi target, restano invece più *superficiali*: non solo perché usano la specifica solo per costruire richieste valide e non per giudicarne la sicurezza, ma anche perché le verifiche di sicurezza più approfondite richiedono conoscenze specifiche che un approccio generico, per sua natura, non porta con sé. (concetto del G4) *Profondità* e *portabilità* finiscono quindi per essere due obiettivi che oggi si ottengono separatamente, non insieme.

**G3** riguarda la **riproducibilità**. In un ciclo di sviluppo continuativo, dove il sistema *cambia di continuo*, un operatore non riesce a tenere il passo con la frequenza delle modifiche, e ogni sua *scelta metodologica* introduce una variabile in più nel risultato. Senza un modo per rendere queste verifiche *ripetibili con esattezza*, diventa impossibile distinguere una vera regressione di sicurezza da una semplice differenza nel modo in cui è stata condotta la verifica.

**G4** è il **problema dell'oracolo**. Generare automaticamente delle richieste verso un sistema è un compito che la letteratura ha già affrontato con buoni risultati; stabilire *automaticamente* se quello che si osserva costituisce una *violazione di sicurezza*, invece, richiede un criterio che la specifica da sola non può fornire, perché dipende dalla *conoscenza del dominio* del controllo specifico. 
La *costruzione di criteri sistematici* è un problema che la letteratura sul testing automatico ha affrontato solo in parte, ed è il secondo gap su cui questo lavoro si concentra con particolare attenzione.

# Speech — Slide 03: Obiettivi

Da queste quattro lacune nascono quattro obiettivi, tutti orientati allo stesso scopo complessivo, anche se il primo e il quarto pesano più degli altri nell'impianto di questo lavoro.

Il primo obiettivo è progettare un tool **contract-driven** e **agnostico**. La specifica **OpenAPI** fornisce il fondamento contrattuale per costruire probe sintatticamente valide, mentre il file di **configurazione** porta la conoscenza concreta del deployment, come le credenziali dei ruoli e i parametri/configurazioni dei test. 
Insieme, le due cose eliminano qualsiasi riferimento *hardcoded* a un sistema specifico. 
In aggiunta si organizzano le verifiche in una *tassonomia di domini* con priorità esplicite ciascuna corredata dei riferimenti normativi corrispondenti, così che ogni risultato sia tracciabile verso standard come **OWASP** e **CWE**.

Da qui discende quasi naturalmente il secondo obiettivo: un tool che deriva tutta la sua conoscenza a runtime dalla *specifica e dalla configurazione* è per costruzione applicabile a *qualsiasi sistema REST documentato*. 
Restare generici, però, non significa perdere profondità: con un'adeguata *astrazione* è possibile mantenere verifiche approfondite pur restando applicabili a qualsiasi sistema.

Il terzo obiettivo si articola in due parti. 
La prima è il **determinismo**: esecuzioni successive, con la *stessa configurazione* sullo stesso target, devono produrre *output identici*, indipendentemente da chi le esegue. 
La seconda è la conseguenza diretta della prima: solo tramite un *output deterministico* un tool può essere integrato in un **ciclo di sviluppo continuativo**, perché solo allora la pipeline può interpretarlo *automaticamente* e reagire di conseguenza, senza un operatore.

Il quarto obiettivo è, insieme al primo, quello su cui questo lavoro investe maggiormente: dimostrare che per ogni *verifica di sicurezza* è possibile ricavare un **criterio di valutazione** dalla *conoscenza del dominio* del controllo specifico, e *codificarlo* direttamente nella logica del singolo test. 
Una volta definito, quel criterio si applica sempre **deterministicamente**, senza bisogno di generarlo di nuovo ogni volta né di interpretarne manualmente il risultato.

Vediamo ora come questi obiettivi prendono forma concreta: le scelte di progettazione, la metodologia, e le decisioni che costituiscono il cuore di questo lavoro.

# Speech — Slide 04: Agnosticismo applicativo e contract-driven

Vediamo ora i due principi su cui si fonda tutta la metodologia di questo lavoro: l'**agnosticismo applicativo** e il **paradigma contract-driven**.

Il primo principio è l'agnosticismo applicativo. 
Le uniche due sorgenti di conoscenza del target a runtime sono la specifica **OpenAPI** e un file di **configurazione** (O1): essendo le uniche, nel codice non c'è nulla di *hardcoded* (config-driven) su un sistema specifico, e il tool è deployabile su *qualsiasi API REST documentata* senza modificare una riga. 
Questo stesso principio si estende anche al **gateway**: i test che ispezionano la configurazione amministrativa passano attraverso un'*interfaccia astratta*, e aggiungere supporto per un prodotto diverso da **Kong** significa scrivere una nuova implementazione di quell'interfaccia, senza toccare i test esistenti.

Questo presupposto rende possibile il paradigma contract-driven, che la specifica OpenAPI realizza in **tre modi distinti**.
Prima di tutto guida la **costruzione delle richieste**: un fuzzer che genera payload senza conoscere il contratto si scontra con un ostacolo *prima ancora di raggiungere la logica applicativa*, perché una quota sostanziale delle richieste viene *respinta* con un semplice errore di formato; usare la specifica come fondamento evita questo, e l'osservazione si sposta dalla *sintassi* alla *logica applicativa* vera e propria. 
In secondo luogo, la specifica delimita la **superficie di attacco**: solo gli endpoint documentati sono nel *perimetro del test*, e qualsiasi cosa risponda fuori da quella lista è, per definizione, una **Shadow API**. 
E infine, la specifica fornisce anche un primo **criterio di valutazione**, per esempio se una risposta rispetta il *formato e i campi attesi*. 
È però un criterio *strutturale*: la profondità *semantica* vera e propria nasce solo quando questo contratto si combina con la *conoscenza del dominio*, che vedremo con gli **specified oracles**.

# Speech — Slide 05: Specified oracles

Abbiamo appena visto che la OAS da sola garantisce solo una validità *strutturale*, la stessa *verifica funzionale* di cui parlavamo all'inizio. 
Per giudicare se un comportamento osservato viola davvero una *garanzia di sicurezza* serve qualcosa in più, ed è qui che entrano gli **specified oracles**.

Nella letteratura sul testing automatico, *generare richieste* verso un sistema è oggi un problema affrontato con tecniche piuttosto mature. 
**Giudicare** se quello che si *osserva è corretto* resta invece un problema molto più aperto: è il cosiddetto **problema dell'oracolo**.

Il tool codifica per ogni test un **criterio definito a priori**, ricavato dalla *conoscenza del dominio* di sicurezza del *controllo specifico.*
Questa conoscenza non ha una forma unica: a volte arriva direttamente dallo **schema della specifica**, per esempio confrontando una risposta con il tipo e i campi che ci si aspetta; altre volte arriva da **standard tecnici pubblicati**, come le linee guida **NIST** sul TLS; altre volte ancora nasce da un **confronto specifico per quel controllo**, come osservare le risposte ottenute con credenziali di ruolo diverso per giudicare un'autorizzazione. 
Quello che conta, in ogni caso, è che il *test sappia* già in anticipo cosa significherebbe per quel controllo *una violazione*.

Il risultato è che ogni test produce un **verdetto in autonomia**, senza bisogno di interpretazione manuale. 
Il criterio è fisso, quindi lo *stesso sistema nella stessa configurazione* produce sempre lo *stesso verdetto*: è questa proprietà a fondare la **riproducibilità** di cui parleremo più avanti.

Ora che abbiamo il criterio di giudizio, vediamo come abbiamo organizzato cosa valutare: la *tassonomia dei domini di sicurezza* e i *livelli di accesso* necessari per condurre ciascun test.

# Speech — Slide 06: Tassonomia e box gradient

Prima di costruire qualsiasi test, è stato necessario *studiare* a fondo il *tipo di sistema* su cui il tool sarebbe andato a operare: non un'applicazione specifica, ma l'*intera categoria* delle **API REST esposte tramite gateway**. 
Da questo studio è nata una **tassonomia di otto domini** di sicurezza, che si allinea anche ai controlli runtime descritti nello standard **NIST SP 800-228**.

I primi tre domini seguono una **catena di precondizioni logiche**: non ha senso verificare l'*autorizzazione*, **D2**, se non si è già verificato che l'*autenticazione* funzioni, **D1**; e non ha senso verificare l'*autenticazione* se non si conosce prima la *superficie di attacco* del sistema, **D0**. 
Gli altri domini non seguono questo stesso ordine vincolato: **D3** verifica l'*integrità dei dati*, **D4** la *disponibilità*, **D5** l'*osservabilità*, **D6** la *configurazione del gateway*, **D7** le falle di *logica applicativa* più complesse, come SSRF e race condition. 
Di questi, D5 è il solo *predisposto architetturalmente* ma non ancora coperto da test attivi in questa versione. 
In totale, **18 test** sono già **implementati** e altri **14** sono stati individuati durante questo *lavoro di ricerca* e pianificati per sviluppi futuri. Fanno **32 garanzie distinte**, mappate su questi otto domini.

Ogni singolo test, indipendentemente dal dominio a cui appartiene, dichiara anche il proprio *livello di accesso necessario*: il **box gradient**. 
In modalità **Black Box** *non servono credenziali*: si simula un attaccante *esterno*, e si verificano solo i controlli perimetrali che il gateway applica a chiunque. 
In modalità **Grey Box** bastano token validi per almeno *due ruoli distinti*, e si sbloccano le verifiche di autorizzazione, come **RBAC** e **BOLA**. 
In modalità **White Box** serve *l'accesso diretto all'**Admin API*** del gateway, per ispezionare direttamente la configurazione. 
Questo livello viene dichiarato nei **metadati del test**, ma non è una scelta arbitraria: è il riflesso diretto delle *precondizioni che quella garanzia richiede per essere verificata*, perché alcune garanzie restano semplicemente inaccessibili senza un certo privilegio.

# Speech — Slide 07: Pipeline di esecuzione

Le prime **quattro**, in rosso, sono **bloccanti**: un errore in una di queste interrompe l'avvio prima che un solo test venga eseguito. 
La **prima fase** legge il file di configurazione; un errore qui produce un **ConfigurationError**. 
La **seconda** scarica e valida la specifica OpenAPI, costruendo la superficie di assessment; senza di essa, **OpenAPILoadError**. 
La **terza** costruisce due **contesti distinti**: uno *fisso*, con la conoscenza del target raccolta a inizio assessment, e uno *mutabile*, che accumula lo stato prodotto durante l'esecuzione dei test; qui non sono previsti errori recuperabili. 
La **quarta** scopre dinamicamente tutti i test disponibili, grazie al **discovery dinamico** che permette di aggiungerne uno nuovo con un solo file, e costruisce il **grafo delle dipendenze**; un ciclo in quel grafo produce un **DAGCycleError**.

Le ultime **tre**, in verde, sono invece **non bloccanti**: un errore qui viene isolato, e la pipeline prosegue comunque.
La **quinta fase** esegue effettivamente i test, nell'ordine stabilito dal grafo delle dipendenze; un'eccezione interna qui produce solo un risultato di **errore isolato** (TestResult(ERROR)), non un crash. 
La **sesta** fa il **teardown** delle risorse create durante i test, nell'ordine esattamente *opposto* a come sono state create; un fallimento qui produce solo un **WARNING strutturato**. 
La **settima** genera il **report** finale.
Il **risultato** di tutto questo è uno dei quattro **exit code** che vedremo nel dettaglio nella prossima slide.

# Speech — Slide 08: Riproducibilità e integrazione CI/CD

La riproducibilità di questo lavoro si fonda su **quattro meccanismi distinti**, due dei quali li abbiamo già incontrati: come visto parlando di **specified oracles**, un *criterio di valutazione fisso* garantisce sempre lo *stesso verdetto a parità di input*; e il **file di configurazione**, visto parlando di *agnosticismo*, qui non più come fonte di conoscenza del target ma come **unica fonte di verità** per tutti i parametri operativi del tool, così che la *stessa configurazione produca sempre lo stesso comportamento*. 
Li ritroviamo qui insieme agli altri due, che riguardano invece come l'esecuzione viene orchestrata.

L'**ordine topologico** del **DAG scheduler** garantisce invece che i test con dipendenze vengano eseguiti nel giusto ordine. 
Alcuni test presuppongono che altri abbiano già prodotto risorse sul target: i test di autorizzazione, per esempio, richiedono che il test di autenticazione abbia già ottenuto i token validi. 
L'ordine topologico garantisce questo, eseguendo ogni test solo dopo i suoi prerequisiti. 
Non basta fermarsi qui, perché tra test pronti allo stesso livello, senza dipendenze reciproche, l'ordine di estrazione non sarebbe garantito da solo. 
Un **ordinamento lessicografico** esplicito sul nome del test risolve proprio questo, assicurando una sequenza sempre identica a parità di input.

Questo determinismo trova il suo significato pratico negli **exit code semantici**, il segnale che rende l'esito leggibile automaticamente da una pipeline. 
**Zero** significa che tutti i test sono PASS o SKIP, e la pipeline può procedere. 
**Uno** indica almeno un FAIL, e blocca il merge o il deploy. 
**Due** segnala un malfunzionamento interno del tool, da rivedere manualmente. 
**Dieci** indica invece un errore infrastrutturale, come una specifica non raggiungibile. 
Questa distinzione tra un *fallimento del target* e un *fallimento del tool* è ciò che permette a un sistema come **GitHub Actions** o **GitLab CI** di reagire automaticamente, senza dover analizzare i log.

# Speech — Slide 09: Validazione sperimentale

La validazione è stata condotta su **Forgejo 14.0.3**, esposto tramite **Kong 3.9** in modalità **DB-less**, in un ambiente Docker locale. 
Forgejo è stato scelto per le sue *proprietà strutturali*, e non per qualche affinità con lo strumento: ha una *specifica OpenAPI* generata *nativamente*, un'*autenticazione reale* con ruoli distinti su più livelli di privilegio, ed endpoint con gradi diversi di protezione. 
Vale anche la pena dire che nel codice del tool *non c'è alcun riferimento a Forgejo*: è la conferma pratica dell'**agnosticismo applicativo** di cui abbiamo parlato.

Prima di passare ai numeri vale la pena fare un'osservazione sulla qualità dello strumento di misura stesso, perché la credibilità di un risultato dipende anche dalla credibilità di chi lo produce. 
**Cinque strumenti** di analisi statica, dal *linting* (**ruff**) alla ricerca di *pattern insicuri* (**bandit**) fino al controllo delle *dipendenze note per vulnerabilità* (**pip-audit**), non riportano errori sulla codebase; a questo si aggiunge un doppio livello di **controllo dei tipi**, *statico* tra i moduli del tool (**mypy**) e *a runtime* sui dati che arrivano dall'esterno (**Pydantic**). 

Due run indipendenti sullo stesso target hanno prodotto risultati **byte-identici**: il determinismo dichiarato è quindi verificato empiricamente, non solo enunciato. 
Su questa base, i **18 test** attivi sui **7 domini** hanno prodotto **9 PASS**, **7 FAIL**, **2 SKIP** e **0 ERROR**, per un totale di **98 finding**.
I FAIL non sono errori del tool, ma configurazioni *deliberatamente non conformi* inserite nel testbed apposta per produrre esiti negativi attesi, e il tool li ha *distinti correttamente* in ogni run.

Il risultato più significativo, però, è la **discrepanza** che si vede nel box: Forgejo dichiara nella sua specifica un requisito di *autenticazione globale*, ma alcuni endpoint sono *genuinamente pubblici per progettazione*, e rispondono correttamente anche senza credenziali.
È esattamente la classe di anomalia che il paradigma **contract-driven** è pensato per individuare: un *disallineamento* tra quello che il *contratto promette* e quello che il *sistema fa* davvero. 
È il **finding singolo più rilevante** di tutta la validazione.

# Speech — Slide 10: Conclusioni

Prima di chiudere, una precisazione che mi sembra importante: questo lavoro **non risolve** il testing della sicurezza delle API REST, è un settore ancora *troppo giovane* perché abbia senso parlare di *soluzioni definitive*. 
Quello che presento sono **contributi concreti**, verificati empiricamente su un caso reale.

Questi contributi si collocano su **due piani distinti**. 
Sul piano **metodologico** c'è la **tassonomia a otto domini** che abbiamo visto, *applicabile indipendentemente dagli strumenti* con cui viene poi implementata, insieme alla *metodologia sistematica* per definire gli **specified oracles**. 
Sul piano propriamente **ingegneristico** c'è invece l'**assessment engine deterministico basato sul DAG**, che garantisce la *correttezza dell'ordine di esecuzione* anche quando i test hanno dipendenze tra loro.

A questo si aggiunge la **validazione** che abbiamo appena visto: non su uno scenario *sintetico* costruito apposta per il tool, ma su **Forgejo dietro Kong**.

Tra un penetration testing tradizionale e questo lavoro (assurance continuativa), la differenza principale riguarda il *tipo di garanzia* che si ottiene.
Un **penetration testing tradizionale** produce un'**osservazione puntuale**, condotta da un *operatore in un momento specifico*: rieseguirlo in condizioni nominalmente identiche produce risultati comparabili solo per convenzione.
Questo lavoro produce invece risultati **deterministicamente identici** a ogni riesecuzione, *verificabili da chiunque* senza dover ricostruire il *processo di chi li ha generati*. **Da osservazione puntuale a garanzia misurabile.**

# Speech — Slide 11: Sviluppi futuri

Va detto onestamente qual è il **limite strutturale principale** di questo lavoro: il tool dipende dalla *qualità della specifica OpenAPI* del target. 
Un contratto incompleto, o disallineato con l'implementazione reale, produce un assessment parziale, senza che il sistema possa accorgersene da solo. 
È un limite **intrinseco** a qualsiasi approccio *contract-driven*, qualcosa che *non si risolve aggiungendo una funzionalità* in più.

Oltre a questo limite, ci sono *margini di miglioramento* su due fronti distinti:  **estensioni operative**, e **direzioni di ricerca** più aperte. 

La prima **estensione** riguarda la *copertura*: alcuni domini, come quello dell'autorizzazione o quello dell'osservabilità, hanno ancora *test pianificati ma non implementati, e completarli* significa estendere il numero di connector e di verifiche attive *senza toccare il core* del sistema.
La seconda riguarda i **gateway cloud managed** (in contrapposizione al gateway API dedicato come kong), come **AWS API Gateway** o **Azure APIM**: non esponendo un'Admin API ispezionabile come quella di Kong, ma *API proprietarie* e *vendor-specific*, oggi *limitano la copertura* alle sole verifiche Black Box e Grey Box.

Sul fronte della **ricerca**, le direzioni sono più ampie e richiederebbero validazione sperimentale indipendente.
Una è la trasformazione in una **piattaforma modulare** per protocolli eterogenei, come **gRPC** o **GraphQL**, dove il *contratto formale non sarebbe più la specifica OpenAPI* ma uno schema diverso. 
Un'altra riprende il tema degli **specified oracles** e lo porta avanti: quello che presento qui è un *contributo iniziale*, e resta molto da fare per definire **criteri formali e automatizzabili** per le garanzie di sicurezza, un *problema che la letteratura ha appena cominciato ad affrontare.* (il mio G4)

C'è poi la **coverage augmentation progressiva**: l'idea è che alcuni test, *scoprendo* endpoint non dichiarati o token di autenticazione, *alimentino direttamente i test successivi* nella stessa run. 
La sfida è soprattutto **metodologica**: capire *quanto fidarsi* e di *che osservazioni*, e come distinguere un endpoint genuinamente non documentato da uno solo inaccessibile.
E infine la **parallelizzazione intra-batch**, per *ridurre i tempi di esecuzione* mantenendo intatta la *correttezza dell'ordinamento* garantita dal DAG.

# Speech — Slide 12: Ringraziamenti

Vi ringrazio per l'attenzione e sono a disposizione per eventuali domande e approfondimenti.