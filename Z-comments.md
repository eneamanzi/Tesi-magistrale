# 3
prima di quest afrase "La presentazione di APIGuard Assurance segue un approccio top-down: dai principi
generali di sistema che ne definiscono il perimetro fino alle scelte implementative che li
concretizzano" andrei a scrivere una breve introduzione a cos'è apiguard, non ci ho pensato a effettivamente ne palriamo cosi a caso sena nessuan premessa. dobbiamo dire tipo ch eil nsotr lavoro di progettazione e ricerca s è concretizzato in apiguard e poi ontinuiamo con quella frase che ti ho incolato
cioè da qualche aprte dovremo pure introdurre il mio laovor e diere che questo è il spoto gisto, il primo apragrafo faraà quello, po procedi con "La presentazione di ..."

"accoglie come mappa di riferimento per questo
capitolo e per il successivo." -> mi sa che le nominiamo o che anche in altri apragrafi, eviterei di precisare che è solo per qusesto e il successivo

## 3.1
Questa non mi paice "Ogni altra
scelta architetturale trattata in questo capitolo e nel seguente ne deriva, perché alcune
di queste proprietà strutturano lo spazio logico in cui le altre operano"
-> è proprio scritta inmodo sgramamtico e psota malissimo, capisco il discorso didire che qeuste sono lalbase e le altre si basano su queste ma riformualo meglio

### 3.1.1
"Ne
consegue un vincolo strutturale preciso"
"La conseguenza operativa di questo vincolo " un po brutte rieptere due volte los tesos verbo in due frasi vicinissime

"La conseguenza operativa di questo vincolo si manifesta nel comportamento osservabile
dei test. Un test che interroga la superficie di attacco derivata dalla specifica e non
individua endpoint pertinenti alle proprie condizioni di esecuzione restituisce uno stato
SKIP: la conseguenza prevista di uno scope legittimamente vuoto, distinta dall’ERROR
che segnalerebbe un malfunzionamento interno al tool."

La prima frase la riscriverei cambiando verbo e struttura e la unirei alla seconda; non suerei "SKIP:" ma piuttosto un inciso che mete in risalto i due stati skip e error
"a meno
che non si tratti di una violazione perimetrale critica confermata, caso in cui la pipeline
può essere interrotta esplicitamente tramite configurazione" -> qua forse è il caso di dire cosa si intende co vialazione perimetrale critica, cioè fae un esempio i cosa può cuasare questo (nons scriverei vialzione perimetrale che è generico e non vuol ire nulla)


Questa "La differenza tra uno script target-specifico e un tool di assessment generale
non è di complessità, ma di generalità. Uno script con path e credenziali
scritte nel codice esegue correttamente su quel target e solo su quello:
cambiate l'applicazione, il codice va riscritto. Un tool che deriva tutta la
propria conoscenza dalla specifica formale del target funziona su qualsiasi
\gls{API} REST documentata senza modifiche, e questa generalità è precisamente
il confine che separa un artefatto di progetto da un contributo riutilizzabile." forse la riscriverei mettendo dei ":" dopo generalità dicendo che se sono scritte nel codice fuznioan sol su quello, con un inciso dire che se si cambia applciazione va riscrfitto, e poi concludre con il pezzo che dice che deriva la consocenza dal target e dunzioan su tutta le api rest.
Il contenuto p perfetto non va cambiaot, imspoeri la frase però coni :

### 3.1.2
Bruttissimo coem è imspotato, molto macchioso dire "la domanda" e "la rispsota" in questo "L’agnosticismo applicativo richiede una risposta alla domanda su come la conoscenza
del target venga effettivamente impiegata. La proprietà D3.P2 la fornisce: la specifica
OpenAPI è il vincolo contrattuale che guida l’intera pipeline."
-< conta che la doamdan ora labbiamo emssa allinzio belal chaira possiamo irpendera, metetre una virgola, e poi dire tip qqeusto "la specifica
OpenAPI è il vincolo contrattuale che guida l’intera pipeline" ovvero dire che è lunico vincolo contrattuale ecc e cge costruisce gni richeista
rimuovee questoepzzo con i due putn "Il suo ruolo è operativo:" e colelarlo in qualche modo alal frase precedenri dicendo quindi in oconcreto cosa fa e epr cosa losuaimo
almeno divena un uncia frase coesa che parta da uan doamdna ene da u rispsota senza costrutti strani

### 3.1.3
Punterei a scrfivere questo paragrafo comeuna frase unica "La separazione tra logica e configurazione assegna a ogni variazione di comportamento
un’unica origine dichiarata: il file config.yaml attivo durante quella run. Ciò che
cambia tra un’esecuzione e l’altra è circoscritto a quell’artefatto, esplicito e confrontabile
tra versioni come qualsiasi altra componente del progetto."
La riscriverei mantenendo la priam frase che mi paice. Quesotepzzo non mi paice "circoscritto a quell’artefatto, esplicito e confrontabile
tra versioni come qualsiasi altra componente del progetto."
Direi appunto che asseganamo un uncia origine nel file config.yaml e rirpenderei il discorso che diciamo da qualche altra parte che quindi il tool produce un comprotamento dieverso cambiando il config, altriemnti è sempre lo stesso (tipo un coelgamento alal riproducibiità se non erro ma quello valuta tu)

Okei ho notato ora che sarebeb il paragrafo dopo ovvero "La centralizzazione di ogni parametro decisionale in un file esplicito è anche la condizione
che rende possibile la proprietà discussa nella sottosezione seguente ..." a sto punto ti direi di unire quesot e quello precedente in un unicoparagrafo il cu scopo dicimo è quello di dire che il comportamento può vraire solo se varia il config (e rirpende il primo apragrafo) e poi che questa centralizzazione in un file esplciito rende possibilie la propreità seguente (tra parentesi metteei comuqneu lhyper ref aquel elemento)

Il contenuto di eusto è praticamnte perfetto "La centralizzazione di ogni parametro decisionale in un file esplicito è anche la condizione
che rende possibile la proprietà discussa nella sottosezione seguente. Un sistema che
legga valori da variabili d’ambiente non dichiarate, da file di stato impliciti o da sorgenti
runtime non controllate non può garantire che due esecuzioni successive producano lo
stesso risultato, indipendentemente dalla correttezza della logica di test. Fissare la
configurazione è il primo passo necessario per fissare l’output.
" -> dunque non stravolgere nulla ma fai solo la semlcie unione che ti ho illustrato


### 3.1.4
Queot pezzo forse occorr metterlo inun elenco putnato che si presa bene a elencare le 3 proprietà "Il primo è il config-driven development già descritto in D3.P1 (Config-Driven
Development): se tutti i parametri decisionali sono fissi, la pipeline non ha sorgenti di
variazione endogene. Il secondo è l’ordinamento lessicografico dei test all’interno di ogni
batch del DAG: l’ordinamento topologico puro non garantisce stabilità tra test pronti
allo stesso livello, e senza un criterio di tie-breaking esplicito la sequenza potrebbe va-
riare tra esecuzioni; l’ordine lessicografico risolve questa ambiguità, garantendo che la
sequenza sia sempre identica a parità di input. Il terzo è la struttura del DAG stesso,
trattata nella Sezione 3.2.2: un grafo aciclico orientato con risoluzione topologica deter-
ministica produce sempre la stessa sequenza di batch, indipendentemente dall’ordine in
cui i test vengono scoperti a runtime." -> il contnuto è perfetto, non devi fare nessuna minima modifica su quello

cosa vuol dire "utcome KPI byte-equivalenti" sopratutto il KPI non capisco cosa sia

Questa farse "Considerate nel loro insieme, queste quattro proprietà definiscono il sistema a livello di
principio. La Sezione 3.2 ne mostra la concretizzazione strutturale: come ciascuna di
esse si traduca in componenti, contratti e regole di dipendenza" mi sembra ababstanza suerflua dato che poi el 3.2 inziiamo gia bene con un accenno alal sezioen precedente, la rimuoverei

### 3.2.4
Questa introduzione è molto bella "L'agnosticismo applicativo dichiarato in D1.P1 riguarda la conoscenza del target applicativo: la specifica OpenAPI e il \texttt{config.yaml} come sole sorgenti. D1.P6 estende lo stesso principio a un livello distinto: lo strato di controllo del gateway. Alcune garanzie di sicurezza non sono osservabili dall'esterno del sistema, cioè interrogando gli endpoint esposti ai client. La verifica che un timeout sia configurato sui servizi upstream, che il plugin di circuit breaking sia attivo, che le credenziali di servizio non siano hardcoded nelle variabili d'ambiente del gateway: queste informazioni risiedono nel piano di configurazione amministrativo del gateway, non nella superficie \gls{HTTP} che il client vede. Accedervi richiede un meccanismo separato dagli \gls{HTTP} probe ordinari." -> vorrei solo cheidere se fosse possibile unir ele priem due frasi dove dici di D1.P1 e che D1.P6 la estende a dun lviello distino, mi smeba meglio emttere questo ensso in un uncia affermazione. tutto ilr esto pe rfetto




