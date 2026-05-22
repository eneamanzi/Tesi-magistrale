## 3.2
Le proprietà della sezione precedente definiscono il perimetro del sistema. Questa sezione
ne segue la concretizzazione strutturale: quali componenti realizzano quei vincoli, come
si relazionano tra loro, e quale esigenza architetturale specifica ciascuna scelta soddisfa -> noj è proprio corretta, cioè uqetsa non èa la concretizzazionestrututrale di quellprecedenti, stiamo sempre scendndo con la'pprpcio top-down e troviamo questo tipo di prorpeitaà quelle di prima erano più generiche, qeuste iniziano a divenare poco più nel dettaglio ma diciamo che sonoa ncoa propreità teoriche di fondamenta, come se sia giggunessero a quelle di rpiam tipo

### 3.2,1
un test che trova conveniente importare un’utility
da un altro test, un connector che ha bisogno di un modello definito nell’orchestratore. -> concldui tipo con i 3 punti di sospensione o cn etc etc non so cosa si usi in accademia


### 3.2.2
Qeusot lo metterei come lenco putnato 
Lo scheduler include due proprietà di correttezza strutturale. La prima è la rilevazione
statica dei cicli: se il grafo delle dipendenze contiene un ciclo, l’errore viene segnalato
prima che un singolo test venga eseguito, impedendo che stati inconsistenti si propaghino
silenziosamente nella pipeline. La seconda è una salvaguardia difensiva: se il grafo risulta
ancora attivo ma non riesce a estrarre nessun test pronto, il sistema emette un errore
strutturato che elenca i test mai schedulati e interrompe l’esecuzione in modo controllato,
fornendo all’operatore la diagnostica necessaria senza dover ricostruire lo stato interno
del grafo.

tie-breaking -> aggiguenre uan foot noe con un breve comemnto s cosa singica

### 3.2.3
il loader le risolve e le espone tramite il modello di configu-
razione validato, che viene anch’esso congelato all’avvio -> un po troppo vago dire tramite il mdoello di configuazioenvaldiato, cosa si itnende?

la separazioen ta target context e contesto di esecuone la metetri suun elenco putnato dove mettiamo i n grasstto i nomi dei due contesi almeno risalta meglio la separazione

### 3.2.4


L'agnosticismo applicativo dichiarato in \hyperref[subsec:agnosticismo]{D1.P1} riguarda la conoscenza del target applicativo: la specifica OpenAPI e il \texttt{config.yaml} come sole sorgenti. \hyperref[subsec:gateway-adapter]{D1.P6} estende lo stesso principio a un livello distinto: lo strato di controllo del gateway. Alcune garanzie di sicurezza non sono osservabili dall'esterno del sistema, cioè interrogando gli endpoint esposti ai client. La verifica che un timeout sia configurato sui servizi upstream, che il plugin di circuit breaking sia attivo, che le credenziali di servizio non siano hardcoded nelle variabili d'ambiente del gateway: queste informazioni risiedono nel piano di configurazione amministrativo del gateway, non nella superficie \gls{HTTP} che il client vede. Accedervi richiede un meccanismo separato dagli \gls{HTTP} probe ordinari.
Il conenut va bene ma non mi piaqce molto come è formualto a livello di struttura delel frasi. le frasi intoduttive mi sembranot roppo corte che buttano cocnetti quanodo le si ptorebbe legare i una fase strututate 
mnetre un elenco con dei due putni dopo è proprio strano da veder "La verifica che un timeout sia configurato sui servizi upstream, che il
plugin di circuit breaking sia attivo, che le credenziali di servizio non siano hardcoded
nelle variabili d’ambiente del gateway: queste informazioni risiedono nel piano di con-
figurazione amministrativo del gateway, non nella superficie HTTP che il client vede"

questa astrazione, senza di-
pendere dal tipo concreto sottostante. -> spiegherei meglio cos asi intende che non diepndono dal tipo

 un adapter astratto con interfaccia uniforme e read-only -> pure questo no è proprio chairo, tanti aproloni 

 non sono convintissimo diq usto pezzo dobbiamo dicsuterne una ttimo

 a conseguenza diretta per l’estensibilità è precisa: aggiungere supporto per un gateway
diverso richiede una nuova implementazione concreta dell’adapter, senza modificare nes-
suno dei test che lo utilizzano, perché la loro logica opera sull’interfaccia astratta. Il limi-
te intrinseco di questa astrazione, vale a dire la tensione tra la generalità dell’interfaccia
e la profondità delle verifiche vendor-specific che essa non può esprimere, costituisce uno
dei limiti strutturali discussi nella Sezione ??. -> qua so cos avuoi itnednere che appunto basta aggigugner ladapter ed essendo tuto absato suelle classi ABC usaimao le interfacce espsote e quid non si modica nulal a costo che però le implementazioni venodor specific on ci sono o bisigona fare delle modifhce più consistenti am detto come è detto priam è u p contorto, ribuuttiamolo giu meglio

### 3.2.5
no a quedste farsi che sembra palrino a qualcuo "Questa non è una
funzionalità opzionale per la presentazione del report"

riscivere meglio il primo apragrafo sulal uestioen dei finings dimsotabil con le evideze, in modo un po meno contorto

bruttissimo pure esplciitare cosi iltipo di relazione La relazione con D3.P5, proprietà discussa nella sottosezione seguente, è di tipo prere-
quisito.
prue quesot messo male Questo vincolo non è accidentale:

risciriviamo quesot paragrafo conlusivo collegadolo in modo aturale al cpaitoletto che segue dato che il colelgaemnto è anturale e non c'è bisogno diforzarlo

### 3.2.6

capsico il senso ma non mi paice del tutto come apertura Un tool che richiede un database, un message broker o una cache esterna per funzionare
sposta il problema della sua affidabilità fuori dai propri confini. L’exit code restituito
al termine dell’esecuzione riflette lo stato dell’assessment solo se tutti i servizi da cui
dipende erano disponibili e corretti: verificarlo richiede readiness check preventivi che
complicano il deployment e rendono il comportamento del tool difficile da ragionare in
isolamento.

Questa invece belal, portrebbe quasi essere messa qusta come prim paragrafo unito a quellaltro 
APIGuard Assurance non ha dipendenze di stato esterno a runtime. Tutto lo stato
mutabile del processo risiede in memoria o in file locali. Le uniche connessioni di rete
aperte durante un run sono quelle verso il target applicativo e, opzionalmente, verso la
Admin API del gateway: entrambe sono connessioni di test verso il sistema da valutare,
non dipendenze infrastrutturali del tool stesso.

qua buttiaomod entro milel cose espresse inmodo un po confuso secondo me
Questo vincolo è verificabile per ispezione del manifesto delle dipendenze del progetto:
nessun client di database, nessun client di cache distribuita, nessun Software Develop-
ment Kit (SDK) di storage remoto è incluso tra le dipendenze obbligatorie. Il deploy-
ment si riduce all’installazione del package e alla fornitura del file di configurazione:
una semplicità che non è una scorciatoia ma una garanzia architetturale. Ed è anche
il presupposto che rende affidabile D6.P1: i semantic exit codes discussi nella Sezio-
ne ?? possono essere considerati fedeli allo stato dell’assessment perché non esiste alcun
servizio accessorio il cui failure silenzioso potrebbe alterarli.

