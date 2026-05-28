# 2

"Il problema affrontato in questa tesi non è sorto nel vuoto:" ffrase bruttissiam e inizio pessimo rispetto allo standard he abbiamo negli altri capitoli

"è il prodotto di una traiettoria evolutiva precisa, in cui la distribuzione della logica applicativa su reti di servizi autonomi ha moltiplicato la superficie esposta e reso obsoleti gli strumenti pensati per architetture monolitiche." -> ne cpaisco il senso ma è scritto veramente male, facciamo caire meglio questa liena evolutiva per far cpaire un po che si è passati a sistem in cloud di mscroservizi

"Questo capitolo ricostruisce quella traiettoria in quattro movimenti." -> bruttissimo
di solito quando andimoa a fare questie frasi che riasusmono brevemente il contenuto delle sezioni del capitolo non lo impsotiamo inq uesto modo ma è u po più sciolto e coelgato, anturale nel discorso diciamo; ovviamente senza forzarlo ma solo dove si riesce

Le farsi delel varie sezioni mi paicicono però. non avrebbe senso modificarle ora dato che dobbiamo andare a modifcarne il contneuto e poi le riscriverem dopo quando il contneuto andrà bene

Prima di iniziare a scender nei dettagli facciamo una overview sulla strututra di qeusto cpaitolo guardando rispettivamente section e subsection. DObbiamo valutare se quelle presenti attualmente sono sufficienti e compelte per la mia tesi o se è necessarioq ualche mldifica alla struttura prima che al contenuto.
Ora tutti i capitoli delal tesi sono stabili tranne qeusto, quindi possiamo avere un idea chaira di cosa potrebbe servirci e di cosa è necessario aprlare o introdurre nellos tato della'arte.

Non sto dicendoa priori che quello che abbiamo è sbaglaito ma voglio valutarloe avere delle garanzie aggiuntive che nkn amnci nulla e che vada bene.

fatto qeusot primo step iniziamo poi con i diff normali che facciamo di solito
Ora ha anche una struttura comeòtlamente simemtrica dove ogni section ha 3 subsesction, non dobbiamo per forza rispettare queso ritmo o definirme uno se non c'è. sentiti libero di criticare in mod logico e coerente 


"L'architettura monolitica, in cui tutta la logica applicativa risiede in un singolo processo deployabile, ha dominato lo sviluppo enterprise per decenni. Le sue proprietà sono note: deployment atomico, transazioni interne semplificate, toolchain di sviluppo consolidato. Il suo limite strutturale lo è altrettanto: la scala è ottenuta replicando l'intero monolite, indipendentemente da quale sottoinsieme funzionale sia effettivamente sotto carico, e ogni modifica richiede il redeployment dell'intera applicazione, aumentando il rischio di regressione con la crescita della codebase." -> questa intro deve essere fatat decismaente meglio e più argomentata, come le latre sezioni, analizza un po quelel per capire il modo incui piace a me


"L'architettura a microservizi risponde a questo limite decompondo il sistema in servizi autonomi, ciascuno responsabile di un sottodominio delimitato del business, deployabile e scalabile indipendentemente dagli altri~\cite{MISSING:newman:2015:microservices}. % TODO: add to Zotero — Newman, S. (2015). Building Microservices. O'Reilly Media.
La decomposizione ridistribuisce la complessità: ogni servizio è più semplice del monolite, ma il sistema nel suo complesso introduce un nuovo ordine di problemi che il monolite non presentava. La comunicazione tra servizi avviene attraverso interfacce programmabili esposte in rete, ciascuna con il proprio contratto, il proprio ciclo di vita e la propria superficie di attacco. Il numero di queste interfacce cresce con le interazioni tra servizi, non linearmente con il numero di servizi in sé: un sistema a $n$ servizi può esporre fino a $O(n^2)$ canali di comunicazione, ciascuno potenzialmente raggiungibile, interrogabile e abusabile indipendentemente dal contesto applicativo." 
-> qua forse ha senso fare due paragrafi, il primo, con ul livello di dettaglio che segue la stessa ritic di prima per itnrodurre i microservizi ecc
e il secodno per parlare dlel epoblematiche che questa migliroa ha rotato con se diciamo, mi smebra opportuno dividerle nel senso, cosi la logica del paragrafo diventa origine-> evoluzione-> problemi dellevoluzione

### 2.1.2
"I servizi autonomi comunicano attraverso stili architetturali con proprietà tecniche distinte, ciascuno con implicazioni di sicurezza proprie. La rassegna che segue è orientata a quelle proprietà, non alla sintassi dei protocolli." -> come intro non mi paice ma poi inrealtà io voelvo da qualche aprte la rassegan sui protocolli che ho nei file che ti ho caricato della consocsza sul captiolo 2 background
cioè questo cpaiteltto andrebbe inanziuttto suddivso in paragrafi con titoletto il nome del relativo protocoolo, poi in ognuno di questi apragradfi andare a spieagarlo un po, le propeità ecc, il contenuto lo dovremmo predere dai due fiel markdown che ti o hmesso nelal consocneza sul background
Vai a leggere dettaglaitamente quei due file, si chaimano "2-Background_compact.md" e "2-Background_extensive.md" cosi da avee un quadro comeplto delel cose che io ho trovato. poi essendo argoemtni classiici e diffusi potresti avere anche tu nelal tua consocenza o facendo altre ricerce web delle cose da dire. vediamo di mettere giu ben questa cosa inq uanto è un po una sorta di rassegan dei protocolli che ci sono i giro, del loor utilizzo, cosa comprotano rporpeitaà ecc, qualsisi cosa che abbia senso dire. Ovviamente nondobbiamo esagerare nel contenuto, non devono sucire 10 pagine tipo
-> per ora non leggo i conenuto che hai messo, lo rvaluto dop quando avrai letto bene i meii docuemnti


REGOLA PORTANTE: come negli altri capitoli è fodnamentale avere un flusso narrativo che viene risepttato durante tutot ilc aptiolo e durante tutta la tesi, gli altri cpaitoli sono aposot e anche uq adobbiamo assicurarc che quest lfusso si apresente, espresos inmodo quando più lineare e anturale senza forzare colelgamenti dove non ci sono ma valorizzand quelli che escono naturali

### 2.1.3
"La decomposizione in microservizi, combinata con cicli di sviluppo rapidi e team decentralizzati, produce un effetto collaterale documentato: la proliferazione incontrollata di endpoint esposti che sfugge a qualsiasi inventario centralizzato~\cite{MISSING:apisecurity:sprawl:2023}. % TODO: add to Zotero — ricerca web non ha restituito paper peer-reviewed specifico su API sprawl; le fonti disponibili sono report di settore (IBM, Gartner). Verificare esistenza di paper accademico prima di aggiungere." -< il tesot qua dentro è ababstanza bello, cioè mi paice, valutare sol se s può fare di emglio ma è gia molto bello

"Il fenomeno si manifesta in tre categorie distinte." -> non mi aice questa farse cosi breve e scolelgata e non diciamo mai API sprawl da nessun aparte se non nel titolo

"creati durante lo sviluppo, mai rimossi, raggiungibili ma non documentati." -> non è vero che sono epr forza durane los viluppo, possonoa nceh essrci docuemtnazioni nona ggiroante ecc. non diamo implciazioni non vere 

"Le \emph{Deprecated API} sono endpoint formalmente obsoleti che continuano a rispondere perché la loro disattivazione non è mai avvenuta o perché dipendenze non mappate li mantengono attivi. Le \emph{Zombie API} sono endpoint di versioni precedenti del servizio che persistono in deployment non aggiornati."
-> veriricare meglio queste 3 definizioni, da dove arrivnao sono affidabili,sono corrette?
SOno solo qeuste 3 le categorie? chi li ha categorizzati cosi? c'è un paper che cotneien dentro esplciitamente quester 3 categorie?



"Tutte e tre le categorie condividono una proprietà critica per il security assessment: sono invisibili agli strumenti che costruiscono la propria conoscenza del target a partire dalla documentazione." -> uqetsa qua molto belal se effettimanete è vera anche se penso di si

"Un fuzzer che enumera gli endpoint dalla specifica OpenAPI non può raggiungere un endpoint non documentato; uno scanner che confronta le risposte con i codici attesi dalla specifica non può rilevare una Shadow API perché non sa che dovrebbe cercarvela." -> quesot epzzo non mi piace
"La rilevazione delle Shadow API richiede un approccio inverso: confrontare la superficie effettivamente raggiungibile con quella dichiarata, identificando la discrepanza" -> approcci inverso a cosa scusa? tutto qursto epzzo mi smebra un po confuso

"Questo è precisamente uno degli obiettivi del Domain-0 (API Discovery) descritto nella Sezione~\ref{subsec:domini-tassonomia}.
"
.> ontrlla bene sul web ma non esno che sia corretto mettere dei riferiemnti enllos tato dellarte a delel mie cos e eocme le ho fatte. in toeria qua parliamo apputno dellos tt dellarte e d cosa c'è in giro. non mi sa di psoto dove mettere riferiemnti cosi


## 2.2 TODO