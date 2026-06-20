# contesto
dobbiamo fare passare le frasi del cpaitoletto 1.1 delal tesi sul fatto che appunto ci sono tantissime API rest ora grazie ai microservizi ecc

poi va benissimo itnrodurre il gateway 

poi va bene introdurre le vulenrabilità o lomitazini anche se la mettere giu più lieve forse qua, cioè è ancora il conesto generale

# statod dell'arte e gap
il g2 lo porrei diversamente, è più il fatto che spesso o sono troppo specifici per uno target e efanno assesment solo suquello o se sono generici non vanno abbastnza inprofondità

il g3 farei leva sulal questioen delel pipeline di sviluppo continuativo in qulh emodo e andrei poi anche a dire la questioen del fatto che manca lumano, forse avoce questo

il g4 mi paice ma vorrei che si casica bene che appunto la mancanza sono rpio i criteri per verificare se loutput è una vilalzioen omeno, che faccia uan vlautazioen affdiaible smepre ecco, e come priam senza itnervemto umano

# obiettivi
la frase ad effettomessa li cosi mi paice, andrei solo a capire se è effettivamente corretta e la frase adatta d ascrivere li, coem imaptto diciamo

cioè qua è un po strane perchè diciamo che 01 e 04 rispondono insieme al g1 e poi 04 da solo al g4 
diciamoc he con 01 diamo il presupposto per questo tool, dove ha una ocnsocneza epoi da li andiamo ad aggiugnerci altre cose

la scritta su o2 non mi paic

03 e 04 grosso modo mi paicciono

resta una ttimo da capire la quesitone su 01 nelal tesi che ora diciamo ancora che la OAS serve per fare cose semantiche quando non è vero, fa solo cose sitnattiche quindi dobbiamo fare un controllo in tutta la tesi e sistemarlo

# design contract driven
questa slide ha gia il titolo sbagliato in quanto parla di contract drivene  eagnsoticismo che sarebbero i primi due punti della metodologia delal tesi se non erro

Inanziutto non cpaisco perchè abbiamo invertito loridne rispetto alal tesi e probaiblemtne rispetot al riasusnto anche
in tutti non mettiamo prima agnsoticismo applciativo e poi contract driven?

il pezzettino su agnsoticismo applciativo smebra bello, dbbiamo  capire cosa dire bene nel riasusnto per esprimerlo bene al meglo

sul paradgima contract diven ritorna lerrore che ti ho detto priam che su cui dobbiamo andare ad indagare e sistemare int utta la tesi, vedendo se ci sono ripercussioni a catena
la OAS costruisce probe sintatticamente valide, la semntica non la si può capire solo da li. cioè alcune cose si, tipo endooint protetti ecc, ma non tutto. quindi non si può dire che si usa per fare cose semtnaiche. il suo utlizzo principale è quelel sitnattiche, poi fa anche lcuen cose semantiche, ma solo in aprte e assiem alle altre consocenze del dominio

# Tassonomia: otto domini di security assurance
questa slide anche se è imegnativa va bene perchè fa vedere motlo il laovor metodologico e di ricerca per indoviduare il tutto

secondo me dobbiamo provare ad impaginarla meglio, ovvero, ogni bulelt poitn va lo stesso su due righe, a questo punto io manterre sulla prima riga il numero del dominio e il nome colorato
sotto andrei a metetre quelle sorte di mini esempi, magari in corisvo ecco
Andrei sotto a mettere anche il numero di test totali pianificati e quelli implenmentati.
diciamo che quan anche nello speech la cosa da fare vedere è appunto la ricerca e individuaione di controlli utili da fare, la suddivisione n categorie conquesta tassonomia ecc
è stato il lavoor che è venuto prima dove si è studiato il target su cui si andava a lavorare, dove con target si intendono le api rest e i gateway

# box gradient
questa slide invece non lo so, non mi convice del tutto
cioè cpaisco che è molto improtante da dire ed effettivmanete basta parlarci poco sopra perchè nn c'è olto ma bho non so 

# specified oracles: il criterio di valutaizone
questa secondo me ha definitivamente troppo contenuto, non lho ancora letta ma ad occhio è tanto

ovviamente qua vanno tolte le citazioni

bisogna defirie megkio specified oracles, cioè da qule paper in teoria arrivnao da specifiche formali, che noi posisamo anche metterci dentro la consocenza del dominio e altre cose, in quanto alcuni criteri derivano da standard ecc, va ridetto un pochino meglio. però va bene dire che sono codificati nei test

il pezzo sorgenti per dominio da dove lhai preso? perchè io non ricordo di aver messo un epzzo di quel tipo nelal tesi

non mi ha convinto molto sta slide

# MISSING: ho visto che non mettiamo da nessuna parte la cosa del configdriven, scusa ma quella sia nel riassunto che nel absatrct comapre  sbaglio?


# pipleine di esecuzione e connector
pure qua secondo me le frasi sono molto lunghe ma non le h o ancora lette, cosi come imaptto visivo per ora

anche qua diciamo semrpe prima 4 bloccanti altre 3 no ma quella piuttosto è una cosa che si dice a voce, qua direi che ha senso mettere le fasi della pipeline scritte no? almeno uno le può vedere e poi io in caso gili dico quelle cose sorpa nello speech

vedo che c'è secondpo me un po troppo poco focus sulla pipleine, cioè viene detta cosi in una frase al volo, di sicuro nello speech qualcosa sulel varie fasi dobbiamo dire, anche solo una frase per fase ma qualcosa va detto penso

i connector gerarchici non cpaisco cosa centrano messi qua assieme alla pipeline

il punto sul discovery dinamico è anche coretto ma è un po strano aprlare solo di un putno della pipeline. qua dobbiamo capire una ttimo coem vogliao imsptoare sta cosa

cioè non lo so non vedo cosi tanto il focus sulal pipleine e non capsico se è perchè è una sldie che nons erve o labbiamo imsptoata male

# DAG scheduler e integrazioen CI/CD
anche questa senza averla ancora letta mi semrba molto piena coem slide a livello visivo

dobbiamo capire bene qualii sono le cose fodnamentali da scrivere per seguire il discorsoe quli sono invece arricchiemtni da fare a voce sul contenuto dela slide
 sicuramente la quesitone che sono espliciti si
 RIsolte topologicmanete cosa si itnende? cioè non ho ben chairo il cotnestoe magari è gisuto

Poi non cpasioc molto il nesso di unire dag schedukere e integrazioen ci/cd
cioè non sono cose colelgate o sbaglio? magari non lo vedo io ma mi fa strano dirle nellso tesso pezzo
cioè la questioen della integrazioene  delgie exit code è più una cosa da pipelien che da dag scheduelr, quindi da slide prima o sbaglio?

non so ma anche qua non mi ha convinto molto, c'è da farci sorpa un lavoro diciamo

# validazioen sperimentale
senza leggerlo, gurdando solo laspetto grafico mi sembra una sldie eccessivamente piena, c'è un po troppo contenuto infatti qua mi da addirittura un overfull latex

sia forgej che kong devono essere in risalto grafico diciamo

Va bene metere giu il test bed, va bene mettere giu i risultati ma nei risultati è inclusa anche la discrepanza rele rielvate, va bene metterlla in rialto rispetto agli altri ma fa semrpe parte dei risultati

la questioen dellidempotenza si può mettere coem frase sotto a tutto, larga coem la slide tipo

# conclusioni
guardandola cosi graficamente senza leggerla ti dico già che il contenuto è troppo pieno, c'è veramente troppo test qua seondo me

sicuramente poi è errato usare il termien "risolto", in quanto coem ho anche scritto nella tesi è un settore talemnte agli inizi che questo è un conributo, non ho risolto nulla
poi mi smebra un po eccessio quasi farlo cosi forzato con lelenco di tutti i gap ecco
diciamo che questo deve essere un po pù di imaptto, un po come la sezioen fianle del abstarct in ignelse che ti ho mandato.
cioè dovremmo un po tirare le somem di tutto quelloc he è stato fatto, dei cotnributi protati, di cosa abbiamo ottenuto ecc. un po un riassunto di tutto ecco

diciamo che si tratt aproprio di tutto il captiolo 7 7.1 7.2 7.3 e 7.4

# sviluppi futuri
questo è esattamente il captiolo 6.3 delal tesi

va bene mostrare la distinzione tra estensioni oeprative e traiettorie di ricerca aperte

unica cosa qu anelal tesi ne abbiamos critte un po, forse è eccessivo riprotarle tutte. qua dobbiamo caprie bene cosa siamoa ndati a dire nel riassutnoe e diciamo a parlare di quelle cose, vedendo poi se riamne spazio/tempo


