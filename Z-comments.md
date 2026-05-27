# 6
"Il Capitolo~\ref{chap:experiments} ha risposto a una domanda circoscritta: APIGuard Assurance produce i risultati dichiarati su un target reale? I dati confermano. Rimane aperta una domanda di portata diversa: entro quali confini strutturali quella risposta vale, e come il sistema si inserisce in contesti d'uso più ampi di quello sperimentale?"
-> il contenuto è veramente bello ma non userei tutte quelel doamdne

"La prima è critica: i limiti strutturali del paradigma contract-driven, ciascuno radicato in una proprietà architetturale specifica e non eliminabile con un refactoring locale, vengono discussi senza attenuarli (Sezione~\ref{sec:limiti})." -> lo riscrivere un po meglio, dire discussi senza attenuarli mi sa molto di AI e frase senza un vero senso

"La seconda è applicativa: le condizioni concrete in cui il tool è integrabile in pipeline \gls{CI/CD} industriali e i pattern di deployment che ne massimizzano il valore (Sezione~\ref{sec:devsecops})." -> non mi convince del tutto e vedere se con le modifiche dobbiamo aggioranrlo

"prospettica" -> non mi paice molto come termine

"La terza è prospettica: le traiettorie di sviluppo distinte in estensioni operative che seguono direttamente dall'architettura attuale, e direzioni di ricerca che pongono problemi aperti e richiedono validazione sperimentale indipendente (Sezione~\ref{sec:sviluppi-futuri})."
_> capisoc il senso ma non è scritto benissimo, cioè facciamoc apire che ci sono due traiettorie di coe future


## 6.1

"Ogni proprietà architetturale che garantisce un vantaggio specifico impone, per costruzione, una classe di situazioni in cui quel vantaggio diventa vincolo. I limiti discussi in questa sezione non sono anomalie correggibili per via implementativa: sono conseguenze dirette di scelte deliberate, e come tali richiedono di essere nominati con precisione piuttosto che attenuati."
-> è molto diretta ma mi paice abbastanza il contenuto e la forma, vedere se si può perfezioanre ancora un po
magri andando una ttimo a afare le solite frasi che riasumono brevement eil contenuto

"dei probe"
-> delle probe, è femminile


"Il vantaggio è la precisione semantica: dove un fuzzer cieco produce \texttt{HTTP~400} a causa di payload strutturalmente invalidi, APIGuard Assurance costruisce richieste conformi al contratto e sposta l'osservazione dalla sintassi alla semantica del controllo di sicurezza."
-> è un po fuorviante detto  osi in quantoio nei test nativi non facico nessun tipo di fuzzing ma uso nuclei, non so lui come lo gestisce ma non epnso che lo informo io, piuttsoto farei la cosa della'cceso e dei parametri relatvi tipo quello dello user e repo

"Questo è precisamente il \emph{combinatorial wall} che il paradigma contract-driven abbatte." -> qua va sicuramente messo un riferiemnto al caitolo 2 dove se ne aprla o parlerà


"Il prezzo è la dipendenza dalla qualità di ciò che si assume come oracolo. Una specifica che non riflette endpoint aggiunti dopo l'ultima pubblicazione restringe la superficie di attacco osservabile senza che il sistema possa rilevare l'incoerenza: l'assenza di un endpoint dall'assessment è indistinguibile dalla sua assenza dalla specifica." -> caisco il putno ma lo scriverei in modo meno contorto

"Una specifica costruita per escludere endpoint sensibili produce un assessment formalmente corretto su una superficie artificialmente ristretta." -> questa non la cpaico emssa li cosi a caso sebra
 RIcordarsi che siamo nel capitolo delal dsicussionee sviluppi futuri, di quese cose a livello teorico ne abbiamo gia parlto priam, non dobbiamoa gigugenre qcos enuove.


"Il prezzo è la dipendenza dalla qualità di ciò che si assume come oracolo. Una specifica che non riflette endpoint aggiunti dopo l'ultima pubblicazione restringe la superficie di attacco osservabile senza che il sistema possa rilevare l'incoerenza: l'assenza di un endpoint dall'assessment è indistinguibile dalla sua assenza dalla specifica. Una specifica costruita per escludere endpoint sensibili produce un assessment formalmente corretto su una superficie artificialmente ristretta. In entrambi i casi il tool non dispone di un meccanismo per distinguere l'assenza di vulnerabilità dall'assenza di copertura; lo specification drift tra documentazione e implementazione reale è una delle cause principali di copertura incompleta nel testing contract-driven, indipendentemente dallo strumento adottato. Qualsiasi approccio che utilizzi una specifica formale come oracolo eredita la stessa dipendenza: la correttezza dell'assessment è necessariamente condizionale alla correttezza del contratto. La traiettoria di ricerca che affronta strutturalmente questo paradosso, l'inferenza automatica della specifica dall'analisi del traffico reale tramite tecniche di \gls{ML}, è discussa nella Sezione~\ref{sec:sviluppi-futuri} come direzione aperta, non come soluzione disponibile."
-> quesot paragrfo è bellisismo ma dobbiamo andare a fare il riferiemnto al cpaitolo 2 e a vedere se saraà ancoa necessaio tutto questo contenuto,sopratutto in merito alle cose deel config drift ecc. attualemtne eprò il contenuto mi paice

"In termini operativi, la mitigazione praticabile è procedurale: l'operatore che esegue l'assessment è responsabile di verificare che la specifica fornita sia aggiornata e completa prima di interpretare i risultati. Il tool segnala parzialmente questa dipendenza producendo un \texttt{SKIP} con motivazione esplicita quando uno scope di test è vuoto, il che indica all'operatore che quel dominio non ha endpoint applicabili nella specifica fornita; non può tuttavia distinguere se lo scope è vuoto perché la specifica è corretta e quegli endpoint non esistono, o perché la specifica è incompleta e quegli endpoint esistono ma non sono documentati."
_> quesot mi smebra un po privo di senso, una racocamdnazien ceh nonè nemmeno fattibile concretmente, andrei a rimuoverlo de tutto

### 6.1.2

"La Sezione~\ref{subsec:gateway-adapter} ha introdotto \texttt{BaseGatewayAdapter} come interfaccia astratta verso il piano di configurazione del gateway: i test \texttt{WHITE\_BOX} interrogano il gateway attraverso questa interfaccia, e aggiungere il supporto per un nuovo prodotto richiede una nuova implementazione concreta senza toccare i test che la utilizzano."
-> è scritt in modo controrot vedere se possiamos criverlo emglio e inmodo piu ciro

"Il vantaggio è la portabilità; il vincolo conseguente è che l'interfaccia può esporre solo ciò che è concettualmente generalizzabile a tutti i gateway che la implementano."-> questo mi smebra messo li inmodoun po trppo brusco, possiamo acocmpagnarlo emglio

"Un esempio rende la tensione concreta." -> fars bruttissima, rimuoveere

"un test che li utilizzasse" -> bruttissimo il tempo verbaele utilizzasse qua

"Un esempio rende la tensione concreta. Kong supporta l'ordinamento esplicito dei plugin tramite il campo \texttt{ordering} della sua Admin \gls{API}: un plugin di autenticazione eseguito dopo un plugin di trasformazione del payload riceve dati già alterati, con potenziali implicazioni sulla sicurezza. Verificare questa condizione richiede metadati Kong-specifici privi di equivalente strutturale in altri gateway; un test che li utilizzasse dovrebbe dipendere da \texttt{KongGatewayAdapter} direttamente, rompendo l'agnosticismo. Il design attuale non percorre questa strada."
-> capisco la volotna di fre un esempio, verificare se c'è qualche esempio migliroe e poi indipendentemente da risutlato scriverlo in mood più chairo e compensibile. ora è brutto con frasi brevi a caso e tempi verbali strani


"La tensione ammette una direzione di sviluppo percorribile" -> bruttisismo il temrien ensianoe usato cosi secodno me

"La tensione ammette una direzione di sviluppo percorribile: l'estensione della gerarchia dell'adapter \texttt{BaseGatewayAdapter} rimane l'interfaccia comune con i metodi generalizzabili, ma classi intermedie come \texttt{BaseKongAdapter} o \texttt{BaseAWSAdapter} potrebbero esporre metodi vendor-specifici per i test che li richiedono, senza impattare i test che operano sul livello comune. Questa struttura a tre livelli rifletterebbe la stessa logica della gerarchia dei connector descritta nella Sezione~\ref{subsec:connector-hierarchy}. Un deployment che usa esclusivamente Kong potrebbe adottare test scritti contro \texttt{BaseKongAdapter}; un deployment multi-vendor userebbe solo i test del livello comune. La ricerca necessaria riguarda la specifica del contratto di compatibilità tra i livelli, non la fattibilità tecnica dell'approccio." -> il contenuto è perfetto ma non mi paice coem è mesos giu

cioè la metterei come che una possibile idea di sviluppo futuro, che però allo ra andrebbe messo nela sezioen degli sviluppi futuri? coem lo gstiamo?
comquneu uno svilupo futuro potrebbe esere ampliare la gerarchai per rendere lastrazioen un po più specifica in abse al casoe permettere richeiste più specifiche, la base id aprtenza c'è bisogna estende.
Non modificare tutto il tuto contenuto perchè era gia bello ma andiamoa perfezioanrloe scrivelro emglio magari con qualche mini dettaglio (NO CODICE ovviamente)

### 6.1.3

"La prassi industriale che affronta questo limite è l'accordo di accesso privilegiato: nell'ambito di un assessment formale, il team di sicurezza ottiene accesso read-only alle \gls{API} di gestione del cloud provider per la durata dell'analisi, tipicamente con credenziali temporanee e scope limitato alle risorse del progetto. Questo modello presuppone un accordo esplicito con il provider o con il team di governance interna, e garantisce che la lettura della configurazione avvenga senza possibilità di modifica. Con quell'accesso disponibile, \texttt{gateway\_adapter} nel \texttt{config.yaml} viene popolato con le credenziali e l'endpoint dell'adapter specifico per il provider, e la copertura si estende ai domini \texttt{WHITE\_BOX} senza modifiche al codice. La condizione è che quell'adapter esista: la sua implementazione per i cloud provider principali è una delle estensioni operative discusse nella Sezione~\ref{subsec:roadmap-operativa}.
"
-> questo punto non si coellga bene con le affermazioni che lo rpecedono, perchè priam dici che ci mancano quegli adattatori e che dovremmo svilupaprli per avere anche le api che loro espongono da poter itnerrogare e poi parlaim di parssi industriale con accesos privilegiato. quello indusrtraile è un altro caso in cui per potr far si che i tool faccia tutto in modo comeplto serve ovvimente questo accordo ama non capsico se sto sbaglaino io ma non lo riecoa colelgare alal qquestioen dei clodu provider
piuttosto presentiamoli come problemi distnint, cioè che questa dipendenza dalle api si manifesta o si puuò manifestare sotto varie forme e queste sono alcunqe diq uelelidentificate
non ha più senso cosi?

## 6.2
"Le proprietà di riproducibilità e degradazione controllata discusse nei Capitoli~\ref{chap:methodology} e~\ref{chap:implementation} vanno oltre le garanzie interne al tool: definiscono le condizioni concrete in cui APIGuard Assurance è integrabile come componente di una pipeline \gls{CI/CD} industriale. Questa sezione descrive quelle condizioni: la semantica del canale di comunicazione con la pipeline, i due profili di esecuzione disponibili e la variabilità di copertura nei diversi contesti organizzativi."
-> questa intro è bruttissima, poi coem ti dicevo in teoria in qeusto cpaitolo non sidovrebbe agigugenre del cotenut nuovo, quello va dentro glialtri cpaitoli, qua si tirano unpo le somme si discute e si parla del futuro
dire le prorpeità e indicare 2 cpaitliè cme non dire nulla, un utente non ha la miniamidea di cosa si itnede,q uesto pezzo fva proprio rifatto

### 6.2.1

"Il contratto tra APIGuard Assurance e la pipeline che lo ospita è espresso da quattro valori interi. Quando il processo termina, l'exit code riflette lo stato aggregato del \texttt{ResultSet} calcolato da \texttt{report/builder.py}: \texttt{0} indica che nessun test ha prodotto \texttt{FAIL} o \texttt{ERROR}; \texttt{1} indica che almeno un test ha prodotto \texttt{FAIL}; \texttt{2} indica che nessun test ha prodotto \texttt{FAIL} ma almeno uno ha prodotto \texttt{ERROR}; \texttt{10} indica un errore infrastrutturale bloccante nelle fasi di startup (Fase~1, 2 o~4), ovvero il processo non ha mai raggiunto l'esecuzione dei test. La priorità tra i codici è ordinata: \texttt{FAIL} prevale su \texttt{ERROR}, quindi un assessment con entrambe le condizioni restituisce~\texttt{1}."
-> lo inizierei in modo più genrale dicendo che abbiamo struturato dei codic di uscita conun signficato associato, dove atutalmente 4 valori vengono suati
non userei temrini di codice in questo cpaitolo ne riferienti a file python o moduli, vanno nel capitolo di implementazione in caso o eperiemnti
Non è molto chaira lultiam frse su fail ed error


"La separazione tra \texttt{1} e \texttt{10} è il punto architetturalmente rilevante. Da una pipeline automatizzata, "almeno un test ha trovato una violazione" e "il tool non si è avviato" sono condizioni con diagnosi e azioni correttive completamente diverse; trattarle con lo stesso valore scarica sull'operatore l'onere di leggere i log per distinguerle"
-> quesot psoto in questo modo mi smebr avermaente ovvio, cio li separiamo eprchè hann signifcati diversi? mava? dobbiamo trovare un modo più sensato di dirlo, soprattuto se vogliamo effetivmnete mettere questo paragrfo se no possiamo integarre queste cose nel paragrfo i priam dato che parliamo gia del sucita 1 e del sucia 10 , magari come footentoe se diventa troppo lungo 

"L'integrazione in sistemi di \gls{CI/CD} come GitHub Actions o GitLab \gls{CI}\footnote{GitHub Actions e GitLab CI sono piattaforme di integrazione continua che eseguono pipeline di build, test e deployment automatizzato al variare del codice sorgente. Entrambe trattano qualsiasi exit code diverso da zero come fallimento del passo, bloccando l'avanzamento della pipeline.} si integra attraverso il meccanismo nativo del check sull'exit code. Un passo che esegue \texttt{apiguard run -{}-config config.yaml} blocca la pipeline se il tool restituisce exit~\texttt{1}: in un workflow di merge request, questo impedisce l'integrazione del codice finché le garanzie di sicurezza non sono soddisfatte. Il report prodotto rimane disponibile come artefatto scaricabile per l'analisi post-hoc; il gate decisionale è il codice di uscita."
-> scrvere megli non mi paice molto


"La granularità attuale è binaria rispetto all'esito: o l'assessment è pulito o non lo è. Una traiettoria di sviluppo naturale è rendere il predicato di blocco configurabile per livello di priorità, così che una violazione di priorità P0 su un endpoint di autenticazione blocchi la pipeline mentre una violazione P3 su una configurazione subottimale produca un avviso senza interrompere il rilascio. Questa direzione è discussa nella Sezione~\ref{subsec:roadmap-operativa} come estensione operativa." -> non è molto chairo

# TODO fare da 6.2.2

"L'assessment completo descritto nel Capitolo~\ref{chap:experiments} ha richiesto circa cinque minuti su un target con 18 test attivi. In un gate su una merge request, dove l'obiettivo è verificare rapidamente che le modifiche non abbiano introdotto regressioni di sicurezza perimetrale, attendere il completamento dell'intero assessment è un costo sproporzionato rispetto alla decisione da prendere: se un test P0 rileva una violazione critica, il blocco della pipeline è già giustificato prima che i test successivi vengano eseguiti.
"
_> qusta qui non mio paice motlo come introduzione, cioè va benissimo ilr iferimeno al caitolo prima ma vorrei far tarsparire meglio ilprobme ch ene csneguerebbe o comuqnue lutilità del avere questo fdial fast, come al solit nenel intro cechaimo di far eu po un quadro sul come mai labbiamo pensati, cosa risolve, ce vantaggio cida averlo ecc, tutte cose di questo tipo che defisicono il perimtero in cuio ageisce


"Con \texttt{fail\_fast:~true}, l'engine interrompe la Phase~5 alla prima violazione confermata su un test di priorità P0: i test rimanenti non vengono eseguiti, il \texttt{ResultSet} contiene solo i risultati prodotti fino a quel punto, e il processo termina con exit~\texttt{1}. La condizione di interruzione include anche \texttt{ERROR} sui test P0, perché una verifica perimetrale incompleta per malfunzionamento del tool è operativamente equivalente a una violazione confermata: in entrambi i casi il controllo non garantisce ciò che deve garantire." -> quiè scritto un po male va a ripetere che alla prima violazione si ferma e poi diciamo che include anche gli error su P0 che mis mebra messo lic osi a caso, nonè ovvio che se si ferma alla priam vioalzione sono autoamticamente inclusi gli erorr?
andrei a veedere diriscrivelro perhè ora capsico il putno m è un p disordinato

"I due profili si adattano a scenari d'uso distinti. La modalità fail-fast è appropriata per i gate sulle merge request, dove la velocità di risposta ha valore: all'interruzione alla prima violazione P0, il wall-clock si riduce da cinque minuti a pochi secondi nel caso peggiore."
-> qua si riepte ancoa la cosa delle pull request

io piuttosto andri a riscrivere unpo tutta questa subseciotn e suerei 3 paragrafi, il primo lo suaimo come intrope fare chairezza suquesto punto, ils econdo cin il fail fast spieagto e suato pe rle pulle  e,rge request che dicevi e il tero lo usiamo per lapprocci nrmale e compelto

"La combinazione con \texttt{execution.min\_priority} nel \texttt{config.yaml} aggiunge un'ulteriore dimensione: limitare l'esecuzione ai soli test P0 in modalità fail-fast produce un gate veloce sui controlli perimetrali critici; estendere a tutti i livelli di priorità in modalità completa produce l'assessment di profondità." -> questa cosa non la diciamo giua da nessunaltra parte del livello di priorità da setatre? in caso nonlo riepterei ma andrei a ariprendere le sezioni dove ne aprlaimo

"Il medesimo tool, lo stesso file di configurazione di base, due comportamenti configurabili senza modifiche al codice." -> questa che è un po la conslusioen di tutto va riemssoa meglio, capire anche dove metterla data la nuova struttura che ti ho proposto


### 6.2.3

"Il tool adatta la propria copertura alle precondizioni disponibili senza che l'operatore scelga esplicitamente quale "modalità" attivare: la variazione è nell'insieme di credenziali fornite nel \texttt{config.yaml} e nel campo \texttt{gateway\_adapter}, e la degradazione verso livelli di copertura inferiori avviene in modo automatico e documentato, come stabilito nella Sezione~\ref{subsec:box-gradient}. Nei deployment industriali, questa proprietà si traduce in tre scenari concreti che riflettono le diverse condizioni di accesso delle organizzazioni che adottano il tool." -> non è molto chairo il punto che sta cercando di itnrodurre
il riferimento al box gradient iin teoria è gisuto ma lo metetrei giu melgio, dicendo appunto che è uan cos che abbiamo gi apresentato inq uella sezione e ora andremoa avedere alcuni esempi di cocnretizzazione di questo

"In contesti di integrazione continua su rami di sviluppo, i token di autenticazione per i ruoli configurati sono disponibili come segreti di pipeline, e la Admin \gls{API} del gateway è accessibile dall'interno della rete di staging. Tutti e tre i livelli del box gradient sono raggiungibili, e l'assessment copre l'intera matrice dei domini \texttt{BLACK\_BOX}, \texttt{GREY\_BOX} e \texttt{WHITE\_BOX}."
-> spigare meglio, secondo me ci sono dentro molte assunzioni che non rendono chairoil paragrafo, speiagre meglio

"In contesti di integrazione continua su rami di sviluppo, i token di autenticazione per i ruoli configurati sono disponibili come segreti di pipeline, e la Admin \gls{API} del gateway è accessibile dall'interno della rete di staging. Tutti e tre i livelli del box gradient sono raggiungibili, e l'assessment copre l'intera matrice dei domini \texttt{BLACK\_BOX}, \texttt{GREY\_BOX} e \texttt{WHITE\_BOX}.

Quando la governance interna limita la distribuzione delle credenziali con privilegi amministrativi agli esecutori della pipeline su ambienti di pre-produzione condivisi, il tool opera sui livelli \texttt{BLACK\_BOX} e \texttt{GREY\_BOX}: i test \texttt{WHITE\_BOX} producono \texttt{SKIP} con motivazione esplicita, e la riduzione di copertura è documentata nel report.

In contesti di red team o penetration test esterno, solo l'accesso di rete al target è garantito. Il tool opera in modalità \texttt{BLACK\_BOX}: i test \texttt{GREY\_BOX} e \texttt{WHITE\_BOX} producono \texttt{SKIP}, e l'assessment si concentra sui controlli perimetrali verificabili da un attaccante senza credenziali. In questo scenario, la copertura ridotta non è una limitazione da correggere: è il dato che misura la postura perimetrale del sistema così come la vedrebbe un attaccante esterno.
"
-> tutto questo pezzo non mi aice, mi sembrano prorpi ocose messe li un poa caso senza discuter veramente o dare una qualche considerazione valida, soprattutot dopo che di queste cose ne abbiamo palato nella sezione del box gradient

## 6.3
"Le traiettorie di sviluppo si articolano su due scale temporali con natura diversa. Le estensioni operative sono conseguenze dirette dell'architettura corrente: connector progettati e non ancora implementati, domini predisposti nella tassonomia e non ancora coperti, componenti di pipeline che seguono direttamente dai meccanismi già validati. Non richiedono scelte di design nuove." -> va benissimo ma non mi piacicono tutte quelle mini frasi

"Le traiettorie di sviluppo si articolano su due scale temporali con natura diversa. Le estensioni operative sono conseguenze dirette dell'architettura corrente: connector progettati e non ancora implementati, domini predisposti nella tassonomia e non ancora coperti, componenti di pipeline che seguono direttamente dai meccanismi già validati. Non richiedono scelte di design nuove. Le traiettorie di ricerca pongono invece problemi aperti che richiedono analisi formale o validazione sperimentale indipendente prima dell'implementazione, e in alcuni casi costituiscono oggetti di studio autonomi. La distinzione non è di importanza ma di natura: confonderle produrrebbe impegni di consegna su lavoro che richiede ricerca."
-> tutto somamto va bene perchè itnroduce bene, vedere se si ptorebbe scrive meglio ma il contenuto mi smebra essere ok

### 6.3.1
"Le estensioni elencate in questa sezione seguono direttamente dall'architettura corrente: i punti di estensione sono già predisposti, i contratti tra i componenti sono già definiti. La mancata implementazione nella fase attuale riflette scelte di priorità, non vincoli architetturali. Le estensioni si raggruppano in tre aree."
-> il cocnetto che vuol esprimere è corretto ma non mi paice come è scritto. Provare a riformualrelo, capisco però di dire che appunto queste cose che amncano sono impekentnaili direttamente e andare a spiegare he sarebbero le cose per render il tool compelto che si basano su cose che gi aabbiamo, essenod che i putni di estensione sono rpedispsti e che ci sono gia tuttii contratti definti ecc
Apunto sono selte di priorità e quelel che abbiamo fatto servivano coem validazioen ma le altre rendono otutto compelto.
andare a verificare cocnrettamente nelal repsoitory del codic chw ci sono soloq ueste 3 aree che vegnon elencate dopo e non ne abbiamo trascurate

"\paragraph{Copertura dei test e connectors.}
Il Dominio~5 (Observability) è l'unico non coperto da nessun test nella fase attuale, come dichiarato nella Sezione~\ref{subsec:domini-tassonomia}. I test~5.1 (audit logging) e~5.2 (alert real-time su eventi anomali) sono già specificati nella metodologia; la loro implementazione richiede l'estensione del testbed con un log aggregator e un sistema di alerting nel Docker Compose, dipendenze di infrastruttura che si mantengono architetturalmente isolate dal core del tool."
-> va bene fare il putno sul dominio 5 ma dire un p melgio 
poi a sto punto lo separeie e metterei tipo il paragraph di copertura di tuttii test dei domini deifniti

poi un altro sarebbe quello di integrazione di vcari conenctor trovati

"Tra i connector Categoria~A non ancora implementati, il \texttt{JwtToolConnector} sblocca la copertura del ciclo di vita delle credenziali nel Dominio~1: i test~1.2 (validazione strutturale del \gls{JWT}) e~1.3 (expiry check), pianificati come \texttt{depends\_on~=~["1.1"]}, sono schedulati in una fase successiva del \gls{DAG} e non possono avviarsi finché test~1.1 non ha prodotto un token valido nel \texttt{TestContext}. La struttura del \gls{DAG} è già predisposta per accogliere questa Phase~C senza interventi sull'ordinamento topologico. Analogamente, il Dominio~2 (Authorization) nella fase attuale copre solo il test~2.1; i test~2.2--2.5, pianificati con il connector OFFAT per la generazione dinamica di probe \gls{BOLA}/\gls{IDOR} derivati dalla specifica OpenAPI, completerebbero la copertura del controllo accessi a livello di oggetto. Estendere il Dominio~3 con \texttt{Schemathesis} per l'injection testing\footnote{L'uso di Schemathesis come connector esterno, che genera e delega l'esecuzione dei probe, è distinto dall'uso come strumento di testing autonomo discusso nella Sezione~\ref{subsec:contract-driven}; qui Schemathesis opera come fornitore di dati grezzi, la cui valutazione rimane responsabilità del test.}, il Dominio~6 con \texttt{ext.6.3.socket} per HTTP request smuggling, e il Dominio~7 con connector Vegeta e Interactsh per race condition e \gls{SSRF} blind completano il quadro dei connector Cat~A pianificati.
"
-> qua alal fine prendi come esmepi solo jwt, gli altri li emtti tutti colalsati dopo, cerchaio di esser un po più uniformi, che senso ha dare tutto quel dettaglio soloa  ajwt? andiamo a aristrutturarlo un attimo meglio, lo dividiamo indue pezzi uno per agigugnere tutit i test che mancano, altro epr integrware tutti i comepojenti esterni che ho trovasto io che andrebbero ad aiuare o sostituire i test antivi che avevo identificato

"Due di questi meritano una nota tecnica specifica. Il test~7.3 (\gls{TOCTOU}) richiede richieste simultanee con sincronizzazione sub-millisecondo: il \gls{GIL} di Python rende questo requisito inaffidabile, e il \texttt{VegetaConnector} delega la generazione del carico a Vegeta, scritto in Go con goroutine native, ottenendo la finestra di concorrenza necessaria. Il connector è riutilizzabile dal test~4.1 per il load testing del rate limiting, in coerenza con il principio di separazione dati/valutazione discusso nella Sezione~\ref{subsec:connector-hierarchy}. L'SSRF blind (test~\texttt{ext.7.4.interactsh}) richiede invece un oracle fuori banda: \texttt{InteractshConnector} registra un \gls{URL} controllato su un server interactsh remoto, lo inietta nel probe e verifica il callback ricevuto. L'evidenza non è nella risposta \gls{HTTP} al probe, ma nella richiesta in uscita dal server verso l'indirizzo controllato."
-> parte su interctshConnector non è scrutta in modo molto chairo ma poi suona prorpio male un paragarafo messo qua cosi che smbra un altra cosa e in realtà parla ancora dei conenctor
Capiamo una ttimo come ogliao metetre giu questa cosa perchè pra mi smebra hce c'è motla ocnfusione in coem voliamo organizzare questo pezzettino, sia  alivello di contenuto che a lviello di coem lo raccontiamo che semrba nona vere ordine

"\paragraph{Integrazione della pipeline.}
Due estensioni riguardano il canale di comunicazione con la pipeline \gls{CI/CD}, già descritto nella Sezione~\ref{subsec:exit-codes}. La prima è la granularità degli exit code per livello di priorità, che permetterebbe di distinguere violazioni P0 (bloccanti in qualsiasi scenario) da violazioni P2/P3 (segnalabili come avvertimenti senza bloccare il rilascio). La seconda è l'implementazione degli adapter per i cloud provider principali (Amazon \gls{API} Gateway, Azure \gls{APIM}), che consentirebbe la copertura \texttt{WHITE\_BOX} nei deployment cloud managed discussi nella Sezione~\ref{subsec:limite-admin-api}."
-> veriricare se ci sono solo queste, se sono corrette o se ce ne sono anche altre

"\paragraph{Ottimizzazioni del motore.}
La struttura a batch del \gls{DAG} è già parallelizzabile per costruzione, come discusso nella Sezione~\ref{subsec:dag-impl}: i test all'interno di uno stesso batch non hanno dipendenze reciproche. Introdurre un \texttt{ThreadPoolExecutor} nella Phase~5 ridurrebbe il wall-clock proporzionalmente al numero di test eseguibili in parallelo, con un effetto stimabile dalla distribuzione osservata nella Sezione~\ref{sec:footprint-dag}. La ricerca necessaria riguarda i problemi di thread-safety su \texttt{EvidenceStore} e \texttt{TestContext}, discussi nella Sezione~\ref{subsec:ricerca-aperta}."
-> vai a legegre il capitolo che riferisci poiche a me non sembra che in quel capitolo si parla dell effetto stimale della aprallelizzazione, se non erro si riamnda la paralelizzazioena glis viluppi futri e possiamo solo pensare com'è. vai lo stesso a cotnrllare quel capitolo cosi vediamo coem riscriere questo pezzo
e nonmetterei il riferimentoa riceca aperta che è letteralemnte la sezione seguente, cioè proprio la frase dopo

### 6.3.2
"Le direzioni descritte in questa sezione non sono estensioni implementative:"
-> soltia frase negativa che dice coa non è e non mi piace

"Le direzioni descritte in questa sezione non sono estensioni implementative: sono problemi che l'architettura attuale abilita o porta alla luce, ma che richiedono analisi formale, validazione sperimentale indipendente o scelte di design nuove prima di poter essere affrontati concretamente."
-> non mi paice per iente coem itnro diciamo, adare a rifarla

Sei sicuro che le cos eche proponi sotto siano tutte? non ce ne sono altri di sivluppi futuri valid da rirpotare? fai un controllo epr esserne siucro

"\paragraph{Parallelizzazione intra-batch e thread-safety.}
L'estensione della parallelizzazione al livello intra-batch, anticipata nella Sezione~\ref{subsec:roadmap-operativa}, richiede la risoluzione di due problemi di thread-safety che richiedono analisi formale come prerequisito all'implementazione. Il primo riguarda l'\texttt{EvidenceStore}: il metodo \texttt{begin\_test()} apre un file in append e lo mantiene aperto per la durata del test; con più test concorrenti che chiamano \texttt{log\_transaction()}, le scritture devono essere serializzate senza introdurre un lock globale che annulli il vantaggio della parallelizzazione. Il secondo riguarda il \texttt{TestContext}: il canale dei token è condiviso tra tutti i test, e chiamate concorrenti a \texttt{acquire\_tokens()} potrebbero produrre login multipli per lo stesso ruolo, violando la proprietà di idempotenza discussa nella Sezione~\ref{subsec:auth-layer}. La strada percorribile, per entrambi i problemi, è la separazione dei contesti per batch anziché per run, con un \texttt{TestContext} locale a ogni batch e un meccanismo di merge controllato alla fine di ciascuno. L'analisi formale della correttezza di questo schema è il prerequisito all'implementazione."
-> quesot pezzo o sa qua nelal traiettoria di ricefrca aperta o va sopra nelle estensioni operative, ora comapre in due aprtei, qua con amggiore dettaglioe sorpa meno, ma deve stare inunpsoto unico almeno è coerente
Oppure dici che ha un senso logico mettelro in entrambe? se si valorizza il eprhè una parte sta tra le modifhce oeprative e una negli sviluppi futuri allora va bene

"Il primo riguarda l'\texttt{EvidenceStore}: il metodo \texttt{begin\_test()} apre un file in append e lo mantiene aperto per la durata del test; con più test concorrenti che chiamano \texttt{log\_transaction()}, le scritture devono essere serializzate senza introdurre un lock globale che annulli il vantaggio della parallelizzazione."
-> questo non ho proprio cpaito la probelamtica che stavi cercando di itnrodurre
se ogni test usa un file diverso come facciamo ad avere sto problema?

"Il secondo riguarda il \texttt{TestContext}: il canale dei token è condiviso tra tutti i test, e chiamate concorrenti a \texttt{acquire\_tokens()} potrebbero produrre login multipli per lo stesso ruolo, violando la proprietà di idempotenza discussa nella Sezione~\ref{subsec:auth-layer}."
-> il probelam qua nonè proprio tutta la gestioen condivisa dellos tato? cioè ci sono test che scrivono nello stato, test che leggono e che fanno entrambi, bisogna capire una ttimo coem fare
cioè la questione problemtica non è solo il login o sbaglio?

"La strada percorribile, per entrambi i problemi, è la separazione dei contesti per batch anziché per run, con un \texttt{TestContext} locale a ogni batch e un meccanismo di merge controllato alla fine di ciascuno. L'analisi formale della correttezza di questo schema è il prerequisito all'implementazione."
-> non sono sicuro di questa soluzione, possiamo andare a riragioanrci spra un attimo e a vlautare cosa si potebbe fare?

"dalla specifica \gls{OAS},"
-> OAS = OPENAPI SPecification, non ripetere specifica prima

"\paragraph{APIGuard come piattaforma modulare.}
L'architettura attuale è costruita attorno al paradigma \gls{REST}/OpenAPI: i test nativi derivano la superficie di attacco dalla specifica \gls{OAS}, i connector integrano tool pensati per quel protocollo, e il modello di evidenza riflette la semantica di richiesta/risposta \gls{HTTP}. " -> andare a scriver meglio, rappresenta un po lo stato attuale

"Esistono tuttavia classi di \gls{API} che questo modello non raggiunge: endpoint GraphQL, servizi gRPC, sistemi event-driven basati su AsyncAPI. La traiettoria di ricerca è trattare APIGuard Assurance non come un tool monoprotocollo ma come una piattaforma di assurance estendibile, dove il core (engine, \gls{DAG} scheduler, evidence store, report) rimane invariato e i moduli di protocollo vengono aggiunti come plugin indipendenti. Un modulo \texttt{apiguard-graphql} contribuirebbe i propri test nativi e connector per GraphQL rispettando i contratti di \texttt{BaseTest} e \texttt{BaseConnector}, senza modificare il core. "
- qua hai capit il putno ma scrivere meglio ma lidea è proprio quelal di avere u tool che ha una base solida e poi poteremo trasformar tutto in plugin cosi che uno possa un po buildarsi il tool coem gli serve ep quello specifico contesto oppure andare ad integrare cose nuove per aggiugenre un contesto che può valutare. saebbe sensato mettere anche la parte API rest dentro un plugin ecc

"Il paradosso del Ground Truth discusso nella Sezione~\ref{subsec:limite-ground-truth},"
-> sei sicuro che ha senso mettere il riferiemnto a quel cpaitolo? nondovremmo metetre qualcosa del capitolo 2 magari che è quello teorico?

"apre una traiettoria di ricerca che non richiede traffico passivo né inferenza statistica."
-> non ha senso dire cosa non è

"Questa direzione, diversa dall'inferenza di una specifica sintetica dal traffico,"
-> anche qua che seno ha apragoanrlo ad uan cosa che manco facciamo

"\paragraph{Drift detection tra specifica e comportamento osservato.}
Il paradosso del Ground Truth discusso nella Sezione~\ref{subsec:limite-ground-truth}, per cui la specifica può essere obsoleta o incompleta senza che il tool possa rilevarlo, apre una traiettoria di ricerca che non richiede traffico passivo né inferenza statistica. Durante l'esecuzione, il tool raccoglie già osservazioni sistematiche sul comportamento del target: status code restituiti, header presenti o assenti, schemi di risposta effettivi. Confrontare formalmente queste osservazioni con le asserzioni della specifica OpenAPI potrebbe rivelare endpoint non documentati che rispondono, comportamenti difformi dalla specifica dichiarata, e silenziosamente produrre un indicatore di confidenza sulla completezza dell'oracolo usato. Questa direzione, diversa dall'inferenza di una specifica sintetica dal traffico, usa i dati che il tool già produce come input per una valutazione della qualità dell'oracolo stesso. Le sfide aperte riguardano la definizione formale di "difformità significativa", la distinzione tra deviazioni intenzionali e involontarie, e l'integrazione dell'indicatore nel report senza trasformarlo in un ulteriore vettore di falsi positivi."
-> capsico il punto ma andare a riscrvivere, ora sembra un po incasianto
Dobbiamo apssare un idea un po più generale e meno cocnreta, nel senso lidea è prorpioq uelal di fare come augmentation delal specifica sulal abse elle cose raccolte inlive, non possiamo prenderci la briga di dire coem andarà fatto. bisognerea fare ricerrca e capire quale mtodo approciare ma è una cosa buoan e valdia da considerae