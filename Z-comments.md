```

Scriverei qualcosa di più su i parametri che incldue o comuqnue riamndeei che i dettagli vengonov sit nell paragrafo effettivo che parla del config driven diciamo

```latex
i parametri operativi quali \gls{URL}, credenziali e soglie di esecuzione
```

nel senso ci'è tuta la struttura gerarchica tipo peri ogni conf specifica di ogni test di ogni dominio, più i temaplte coni parametri delapi, più le config generali, guarda bene il file nelal repo e vedi osa contiene vermente, non dobbiamo elencare tutto ma descriverlo in modo sostanzioso però


```latex
OpenAPI del target, che fornisce la topologia completa degli endpoint, gli schemi dei payload e i tipi di risposta attes
```

aggiguene che ci da anche i apraemti delel varie api espsote

poi pensi che sia comelto il capitoletto 3.1.1?

### 3.1.2
L’agnosticismo applicativo stabilisce la sorgente della conoscenza del targe -> in realtà scusa non stabilsice che possiamo applciare il mio tool a qualsiais applcaitivo poichè si bas sulla specifica?
cioè la cosneguenza è che funioan su tutti, il motivo è che la consocenza viene dalla specifica openapi, è questo il colelamento


La specifica OpenAPI non è documenta-
zione destinata al tester umano: è il vincolo contrattuale che guida l’intera pipeline -> eviterei di dire cosa non è, piuttostoparlo di cosa effettivamente è e di come la usiamo tipo che la specifica OPEAN API è il vicnolo che guida l'itnera pipeline <conenttivo causlae> e il motivo o una affermazione

questa non mi paice "Non
descrive il target, lo vincola, e quella differenza è decisiva per la classe di vulnerabilità
che il tool è in grado di rilevare." la colelgherei a priam in qualche modo" va unit alle prime in qualche modo e spieagta non con quei termini geenrici

"Un fuzzer tradizionale che genera payload casuali affronta un ostacolo strutturale già
prima di raggiungere la logica applicativa: la maggioranza delle richieste viene rifiutata
con HTTP 400 dal layer di validazione dell’input, perché i tipi, i formati e i vincoli
enumerati nello schema non sono rispettati." -> quest affermazione è molto forte, siamosicuri? la stiamo ponendo coem una verità sicura e io non o se ffettimanete sia cosi
vedo ceh però ha un riferiemntoa combiantorial wall quindi potrebbe essere approfodnito per vedere se quelo che c'è scritot è corretto

questa farse molto belal, tienila "Questo è il combinatorial wall discusso
nel Capitolo 2: lo spazio di tutti i payload sintatticamente possibili è vastissimo, ma
lo spazio dei payload strutturalmente validi rispetto al contratto è definito e navigabile.
Usare la specifica come oracolo formale abbatte quella barriera: ogni richiesta è costruita
nel rispetto dei vincoli dichiarati, spostando il punto di osservazione dalla sintassi alla
semantica" -> direi che è la part focale delal propreità o sabglio?

Questa mi paice motlo il contenuto, è proprio scritto bene, solo uan doamda di curisotià, come mai tutto inline e tipo none lenchi o altre cose del genere(noncambaire nlla)?
"Ne derivano due capacità operativamente distinte rispetto al fuzzing cieco. In primo luogo, la superficie di attacco viene delimitata con precisione: gli endpoint documentati dalla specifica costituiscono l'insieme di ciò che il contratto dichiara raggiungibile, mentre qualsiasi endpoint risponda senza essere incluso in quella lista è, per definizione, una Shadow API. In secondo luogo, le risposte ricevute vengono valutate rispetto a ciò che il contratto prevede per quella richiesta, non rispetto a euristiche generiche: un campo sensibile restituito in risposta a una richiesta autenticata è un finding solo se lo schema di risposta contrattuale non lo dichiarava atteso."


Cosa cmabvia tra il "catch"  del paragrafo 3.1.1 e questo di 3.1.2
"Anche questa proprietà porta con sé un costo che vale la pena enunciare con precisione. Più il sistema si affida alla specifica come oracolo, più il suo comportamento dipende dalla correttezza di quell'oracolo. Una specifica obsoleta o deliberatamente incompleta produce un assessment parziale senza che il sistema possa rilevarne l'incoerenza: si tratta del paradosso del Ground Truth, discusso nella Sezione~\ref{sec:limiti} come limite strutturale del paradigma contract-driven e non come anomalia specifica di questa implementazione." -> cioè mi semrbano veramente molto simili e non ne capsico la diffrenza, ci sono anche gli stessi termini, qundi inanzitutot cpiamo se è loa stessa probelamtica del 3.1.1, se lo è allor diciamo nel 3.1.2 che va a riprendere la stessa problemica dle putno prcedente, altrimenti se sono diverse le spieghiamo con più chiarezza

### 3.1.3
Sto notando che alcuni (non se se tutit hanno quest aocsa) capitoletti tipo il 3.1.2 rispondono ad uan doamdna specifica, in questo caso risponde tipo a "dove risiede la consocenza che il tool ha sul target?" o una cosa simile
per il 3.1.1 rispodne tipo a "quali applciativi API posso testare?" o comqune il target contro cui si può andsre
mentre per tipo 3.1.3 rispodne a tipo "dove risiede la consocenza/configurazioen del tool verso il target scelto?"

Dato che spesso ci sonoq uese domande chiare ha senso andare ad introdurle nel primo paragrfo di queste sezioni, magari mettendolo in crsivo o comuqneu facendolo notare che è scritto diverso pe far saltare suito all'ovvhio cosa si trova li dentro, le rispsote a cosa

vedi tipo qua "D3.P1 risponde a questa questione in modo perentorio: ogni parametro di tuning operativo risiede nel file \texttt{config.yaml}." -> hai proato a fare quelal cosa che ti sto cheidendo ora ma non è sucita benissimo, rendaimola bene wsplcita coem ti ho cheisot in tutti 

Questo pezzo lo riscriverei con il dettagli che ti dicevo prima, quel punto diciamo che si viene qua a legegre meglio il conenuto ma ora dobbiamo speigarlo meglio cosi nonbasta "Il codice sorgente non contiene literal decisionali hardcoded. Soglie di timeout, credenziali, \gls{URL} del gateway, strategie di test abilitate, configurazione del path seed: tutto ciò che può variare tra un deployment e l'altro è dichiarato esplicitamente nel file di configurazione e validato a runtime prima che la pipeline si avvii." -> quel fil è bello strutturato, legiglo dalal memorai per capire bene cos apossiamod ire, non ti dico di rirportare tutot ma almeo tutte le amcro arre delel cose che possiamo cofnigurare

Questa farse nonha senso o sbalgio "Il vantaggio non è solo organizzativo. Separare la configurazione dal codice elimina la
classe di bug in cui il comportamento del tool cambia in assenza di qualsiasi modifica al
codice stesso, perché qualcuno ha alterato un parametro implicito. Con D3.P1 questa
classe di bug non può esistere per costruzione: se il comportamento è cambiato, è cam-
biata la configurazione, e quella modifica è tracciabile, versionabile e auditabile come
qualsiasi altro artefatto del progetto."

cioè se separi il codice dalal conf, e nonmodifichi il codice, allroa hai per forza modifcato la conf nel nsotro caso, cioè non cpaisco cosa vorrebbe espriemre è detto vermente male
ciò dat che lho scritto intendo quello che vuoi dire ma è espresso male
vogimao tipo dire che separiamo le risposanbilità, che la configurazioens ta tutta in un punto ma non fare giri strani di aprole

Qeusto pezzo mi paice perchè è un colelamento naturale con i capitlo successivo, non lo forzerei dicendo "la relazioen è cuasale" che semrba propri uan forzatura, dato che è una relaizone scontata è scilta rendiamola tale
"La relazione con la proprietà successiva è di tipo causale, non di semplice coesistenza.
D3.P1 è il prerequisito strutturale di D3.P4: senza la centralizzazione di ogni parametro
decisionale in un file di configurazione immutabile durante il run, la riproducibilità non
è garantibile. Un sistema che legge valori da ambienti variabili non dichiarati, da file di
stato impliciti o da sorgenti runtime non controllate non può produrre lo stesso risultato
a ogni esecuzione, indipendentemente dalla qualità della logica di test." -> cioè è gisutissimo il coelglamento che fai e le assuznioni che dici ma non rendiamolo cosi brutale questa cosa, rendaimolo sciolta  e colelgta alla successiva, coem se fosse un annunci di quello che c'è dopo tipo e perchè equsta cosa serve


### 3.1.4
frase compeltamente vuota "Un assessment di sicurezza non riproducibile non è un assessment: è un'osservazione irripetibile. Lo stesso target, nella stessa configurazione, interrogato con lo stesso \texttt{config.yaml}, deve produrre risultati deterministicamente identici a ogni esecuzione. Questa non è una proprietà di comodità operativa, ma il presupposto epistemico che conferisce valore dimostrativo ai risultati del Capitolo~\ref{chap:experiments}."
Cioè parlaimone in modo diverso, la priam frase con quelal negazioone è proprio inutle e fa passare sempre quell'atteggiamento altezzoso tipo
la frase in mezzo è la definzione di rirpducibilità. "propreità di cmodità" non si può setire in a tesi, capisoc a cosa serve per il captiolo 5 ma scrivamo tutto in modo diverso


Ho notato che spesso scrivi riferiemntia queste propeirtà tipo  "già descritto in D3.P1" ma quel numero di proprietà dovrebbe essere cickabile e mandare alla label delal relativa proprietà, non solo nell'esempi specifico che ti ho incolalto ma in tutti i punti in cui lo fai di riamdnare ad una propietà
e invece che riprotare solo il nuemro (che risulta scomdo poiche uno dovrebbe tornare a veder ecos'è mettitipo il titoletto ) "D3.P1 (Config-Driven Development)" o uan cossa simile come si fa nei paper


cosa intendi conq eusta affermazioen "Il secondo è
l’ordinamento deterministico del registro dei test: i test vengono ordinati in modo sta-
bile e riproducibile prima di essere passati allo scheduler, garantendo che l’insieme di
partenza del grafo sia sempre lo stess" puoi contrlalre nei miei file delal consocenza se effettivmaente è cosi e cos asignfica?


di questa affermazione siamo sicuri "La garanzia di riproducibilità non implica che l'output sia byte-identico in ogni sua componente. Timestamp e identificatori \gls{UUID} dei singoli record vengono esclusi dal confronto; ciò che è invariante sono i contatori PASS, FAIL e SKIP, la distribuzione dei finding per dominio, e la sequenza di batch prodotta dal \gls{DAG}. La validazione empirica di questa proprietà, condotta su due run indipendenti con un delta sul wall-clock di 0,32\%, è discussa nella Sezione~\ref{sec:idempotenza}." -> puoi contrlalre nelal cosncoenza se effettivamente è cosi?
cioè proverei a spiegare u pelo meglio qeusta valdiazione, so che verrà fatta dopo ma ora mis embra prprio accenanta a caso, ovviamente riamndiamoa dopo per il contenuto completo



per quesoto contenuto "Queste quattro proprietà, considerate insieme, rispondono alla domanda più generale che un lavoro di ricerca deve saper porre a se stesso: perché questo sistema, in questa forma, è un contributo e non un artefatto? La risposta è che un tool applicazione-agnostico (D1.P1), guidato da un oracolo formale (D3.P2), controllato da configurazione esplicita (D3.P1) e deterministicamente riproducibile (D3.P4) può essere validato, confrontato e integrato in processi automatici, laddove un tool manuale, opaco e target-specifico non può. Nella Sezione~\ref{sec:architettura} si mostrerà come questi principi si traducano in scelte strutturali concrete." -> per com'è posizioanto roa rientra sotto 3.1.4 che è cocnettualmente sbaglaito

seguendo la logica che ti ho psot priam dove ogni capitoletto tipo 3.1.1 3.1.2 ecc aveva una domanda all'inzio, possiamos eguire la stessa logica e metere al domanda anche nel intro del pezzo 3.1, così in quel caso la doamdna è generale sulal categoria, mentre sotot sono specifice per le singel proprietà

ovviamene mettendolo all'inzio, pima della spiegazione, bisogna cambaire tono con cui lo si espone, perchè appunto lo sia sta introudcendo coem la doamdan a cui stiamo dando una risposta

## 3.2
Vedo che qua stavi provando ad usare lapprocio che avev appena prospot delel doamdne, moltobene quindi avendo gia chaira la logica ti risulterà più semplcie 

"Prima ancora di descrivere i singoli componenti, occorre descrivere la regola che ne governa le relazioni. Il grafo delle dipendenze tra strati è strettamente aciclico e orientato in una sola direzione: il nucleo del sistema è importato dagli strati di integrazione, che sono importati dagli strati di test, che sono importati dall'orchestratore. Nessun modulo può importare da un livello superiore nella gerarchia. In termini operativi: modificare un test non può rompere il nucleo; aggiungere un connector non può influenzare l'orchestratore; l'intera base del nucleo può essere testata unitariamente senza istanziare alcun client \gls{HTTP} né alcun test di sicurezza." --> alcuni problemi, una frase come "resentarle in isolamento, senza nominare il problema che ciascuna
risolve, ridurrebbe la descrizione a un inventario di decisioni opache." è palesemnte scritta da un LLM, semba che sta aprlando ad un umano che legge, minimaente tono da paper

DIciamo che va un po ristrutturato anche secondo le idee che dicevo prima ma ne discuteremo


### 3.2.1
Bruttissima questa farse iniziata cosi "Questa regola non emerge da preferenze stilistiche, ma dal problema che risolve" sono sempre frasi troppo dure, coem se si dovessero difendere da unqualcosa e altezzose

tutto il pezzo dopo è praticament e perfetto invce, solo uan precisazioen che non so cosa sia uqetsa cosa "Il vincolo monodirezionale è verificabile staticamente per ispezione del
grafo di importazione"
a bene il riferiemnt ai dettagli sulal sezione dopo


"Ne deriva, come conseguenza diretta, la praticabilità del plugin system descritto come traiettoria futura nella Sezione~\ref{sec:sviluppi-futuri}: un modulo di test contribuito da terze parti viene scoperto automaticamente senza che nessuna modifica al nucleo del sistema sia necessaria, perché il nucleo non sa nulla dei test." -> allroa capisco ils enso di dire che dato che è strutturato in questo modo è faiclemente integrabile con altre cose, la metetrei giu in questo modo e direi che questo è appunto uno tra i sviluppi futuri come dicevi tu


### 3.2.2
"L’ordine in cui i test vengono eseguiti non è arbitrario, né è codificato a mano in un file
di configurazione. Viene calcolato a partire dalle dipendenze che ogni test dichiara espli-
citamente come parte del proprio contratto. Lo scheduler raccoglie queste dichiarazioni,
costruisce un DAG orientato e risolve l’ordine topologico, producendo una sequenza di
batch: gruppi di test il cui insieme di dipendenze è già stato soddisfatto. I batch sono
sequenziali tra loro; all’interno di ogni batch, i test sono privi di dipendenze reciproche.
La traduzione di questo schema in codice, incluse le strutture dati e le librerie impiegate,
è descritta nella Sezione 4.2.2" -> è gisutissimo ciò che dici ma non mi apice coem è espresso, è un po brutto inziiare smere ocn quelal negazione di cosa non è, quando è molto più improtante dire chairamente cos'è in questo caso, si può dire che non sono codificati in un fie eno è arbtrario ma nond eto cosi che semrba buttato li  a caso

Queta farse qua è un p vaga" Dichiarare questa dipendenza esplici-
tamente sposta la precondizione dallo stato implicito al contratto formale, verificato dal
DAG prima che la pipeline entri in esecuzione." capisco il seso ma la potremmo riscrivee più chaira, mentre il pezzo priam è gisuto 


Qeusot pezzo non ho capito bene "
Due proprietà di sicurezza completano l'ordinamento. La prima è la rilevazione statica dei cicli: se il grafo delle dipendenze contiene un ciclo, l'errore viene segnalato prima che un singolo test venga eseguito, non a runtime durante l'esecuzione. La seconda è la gestione dello stallo: se lo scheduler si trova in uno stato in cui non riesce a estrarre nuovi nodi pronti pur avendo lavoro pendente, il sistema registra l'elenco esatto dei test bloccati e interrompe il drain in modo controllato, garantendo all'operatore la diagnostica necessaria per individuare la dipendenza mal dichiarata." -> pupi cercare bene nelal repo come fuziona e risciverlo in modo più chiaro, soprattuto sulal gestoen dellos tallo?


Qua come al solito va ene espriemre il legame perchè crea colelgamento e filo di lettura ma non in un modo cosi forzato e imsptoato dove si dice "è causale, non accidentale"
"Il legame con la riproducibilità descritta in D3.P4 è causale, non accidentale. L'ordinamento topologico puro non garantisce un ordine unico quando più test sono pronti allo stesso livello: senza un criterio di rottura dei pareggi stabile, la sequenza potrebbe variare tra esecuzioni. La scelta di un criterio di ordinamento deterministico all'interno di ogni batch, descritta nella Sezione~\ref{subsec:dag-impl}, è il punto in cui il non-determinismo strutturale del grafo viene convertito in sequenza riproducibile.
" -> controlal bene nelal repo coem fuznioan e cosa abbiamos sritto nelal 4.2.2 perchè non sono sicuo che noi andaimo a agestire quello spareggio a livello di codice, duqneu conrllal che non vorrei affermare cose che in realtà non sono
cioè non so se noi allintenro di ogni batch fissiamo un ordien tramtie un criterio 

Queso pezzo "La struttura a batch ha infine una conseguenza per il futuro: ogni batch è già concettualmente parallelizzabile. Introdurre esecuzione parallela all'interno di un batch è una modifica localizzata allo scheduler che non richiede modifiche al design dei test, purché le implicazioni di concorrenza sullo stato condiviso vengano analizzate formalmente. Questo limite è documentato; la decisione di non parallelizzare nella versione attuale è una scelta esplicita, non una dimenticanza." va bene, la mettere giu diversamentre, nel senso che per com'è strutturato in batch col dag possiamo godere di una paralllezilaazione interna l batch inq uznto quei test sono indiepdneti e non si schaicciano i peidi a vicenda, a patto coem dievi tu di capire la questioen dellos tato codnvisio, che se non sbaglio se ne parla d auqlhce altra parte, forse alvori futuri non ricordo

### 3.2.3

Questo molto bene coem inizio "Durante l’esecuzione sequenziale dei test, due categorie di informazione coesistono nel
processo: ciò che si sapeva del target prima che la pipeline iniziasse, e ciò che si scopre
o si produce durante l’esecuzione"
questa farse è oscena " Trattarle con lo stesso oggetto mutabile è la ricetta
per una classe di bug difficile da diagnosticare:" proprio si ababsa il lviello con "ricetta" e classe d bug pur messo giu cosi. l'esempio che fai dopo è fatto bene, vediamo di unire le due cose inun tono migliroe

Questo epzzo forse ha senso mettelo coem elenco putnato in quanto è proprio uan separazioennetat di du e cose con compit distinti
!La soluzione è la separazione netta in due oggetti con caratteristiche opposte. Il contesto del target è immutabile per costruzione: viene popolato una volta sola prima che la pipeline inizi e qualsiasi tentativo di modifica produce un errore immediato nel punto in cui viene effettuato, non in un punto remoto della pipeline. Incapsula tutto ciò che si conosce del target prima dell'esecuzione: la specifica OpenAPI come modello della superficie d'attacco, le credenziali, i parametri di tuning, l'adapter del gateway. Il contesto di esecuzione, al contrario, è mutabile e raccoglie ciò che la pipeline produce: i token acquisiti, le risorse create sul target che dovranno essere rimosse al teardown, i dati condivisi tra test dipendenti. L'implementazione concreta di questa separazione, inclusi i tipi e i meccanismi di accesso, è descritta nella Sezione~\ref{subsec:split-state-impl}."
-> andrei a scrivere emglio cosa contienete il cotnesto target, rimueoverei "Punto remoto della pipelien"
idem per il contesto di esecuione, gaurderei la consocenza che hai dei mie file e delal repo per vdere se si può dire qualcosa di meglio
La struttura però va benissimo nulal da dire, solo a livello di contneuto che magri si può di re di più o meglio

contllare la repo per veerificare che effetivamente si a cosi "L'accesso allo stato mutabile avviene attraverso canali tipizzati distinti, non attraverso un dizionario libero. Il canale token è indicizzato per ruolo, eliminando le stringhe magiche. Il canale teardown mantiene un registro \gls{LIFO} delle risorse create durante il run, garantendo che il cleanup segua l'ordine inverso della creazione, come discusso nella Sezione~\ref{subsec:teardown}. Il canale dei dati condivisi permette a test in batch successivi di consumare risultati prodotti da batch precedenti senza introdurre dipendenze di importazione tra moduli." poi riscirvere melgio questa divisioe. batsa usare il cosa non è, dire appunto che ci sonoq eusti canali vari e separati per acceervi (se effetivament enelal code abse vedi ch eci sono ) e fare una brve spiegazien dei canali, con riamndi ad altre sezioni se necessario

Non la porrei come cosot accetato "Il costo accettato è la rigidità del contesto del target. Qualsiasi informazione scoperta a runtime, inclusi gli endpoint presenti sul target ma non dichiarati nella specifica, appartiene allo stato dell'assessment e non allo stato del target: non può quindi essere scritta sul contesto immutabile, ma trova il suo posto nel canale condiviso del contesto di esecuzione. Questo confine non è sempre intuitivo, ma la sua esplicitezza è la garanzia che rende la riproducibilità di D3.P4 dimostrabile senza ambiguità." -> direi che appunto le informazioi scoperte a runtime ovviamente non psosono andar enl etarget cotext ma risiedono in quello di esecuzione, lo metterei giu in modo diverso imuovendo frasi come questa "Questo confine non è sempre intuitivo" e magari metetndo all'inzio, ma nonso vavalutato se lascialro qua in fondo dato che si colega al discorsoiniziale delal separzione e saebeb tipo una rgoemtnazine che la enforca

### 3.2.4





