# 4.5

se questa affermazioen è tuta vera mipaicee è scritta bene, fai un aftc check "L'architettura del \texttt{BaseGatewayAdapter} è stata descritta nella Sezione~\ref{subsec:gateway-adapter} a livello di interfaccia e di motivazione. Questa sezione ne completa il quadro con l'implementazione concreta, descrive i tre livelli di degradazione controllata che il sistema applica quando parti dell'infrastruttura non sono disponibili, e illustra il meccanismo di cleanup delle risorse create durante l'assessment."

.5.1 KongGatewayAdapter: Accesso Read-Only all’Admin API -> questo non mi convince molto, cioè allinzio dovremmo aprlare delal classe genrale, di come abbiamo applciao nel concreto l generalizzazioen che proclamavmo nel capitolo 3 ecc

forse lo sriscriverei, fai una ricerca nella consocenza che ti ho dato e valuta bene come scriverlo, ma so che possiamo migliroarlo


questi livewlli mis embrano gearchici, forse ha senso un elenco? "Il primo livello è il master switch \texttt{external\_tools.enabled} in \texttt{config.yaml}. Quando impostato a \texttt{false}, l'\texttt{ExternalTestRegistry} restituisce una lista vuota senza scandagliare il filesystem né importare moduli: zero overhead, zero \texttt{SKIP} nel log, comportamento completamente silenzioso. Questo livello serve ambienti in cui la presenza di tool esterni è impossibile per policy di sicurezza o di deployment.

Il secondo livello gestisce i tool esterni assenti a livello di singolo tool. Come illustrato nella Sezione~\ref{subsec:connector-injection}, la Phase~R4 dell'\texttt{ExternalTestRegistry} imposta \texttt{\_skip\_reason\_from\_registry} su ogni test del gruppo il cui tool non è disponibile: ogni test riceve \texttt{SKIP} con motivazione esplicita, un solo \texttt{WARNING} nel log per tool.

Il terzo livello gestisce l'assenza della Admin \gls{API} del gateway. Se \texttt{gateway\_adapter} non è configurato in \texttt{config.yaml} oppure se \texttt{check\_connectivity()} fallisce, \texttt{TargetContext.gateway} rimane \texttt{None}. Ogni test \texttt{WHITE\_BOX} chiama come prima operazione \texttt{self.\_requires\_admin\_api(target)}: se il campo è \texttt{None}, restituisce immediatamente \texttt{SKIP} con il testo \textit{"Admin API not configured"} senza eseguire nessuna logica di verifica. Il risultato dell'assessment in questo scenario copre i soli domini black-box e grey-box, con un numero di \texttt{SKIP} equivalente al numero di test white-box presenti nel set attivo.
" -> valutiamo come meterlo
ma poi qesta cosa non cpareiva gi atantissime vote anche prima? chelho gia letto da moltissime aprtie che diciamo che non f affial, che skippa ecc
se qesot è effettivmanete il ptno in cui lo spieghiamo va spegato meglio 
e poi daot che lho letto in tantissimi pnti dovremmo metetre dei riferimenti verso qesto sezione o cernao gia?

non mi paice come è scritto "Il meccanismo di teardown è registrazione esplicita al momento della creazione. Ogni
volta che un test effettua un’operazione che crea una risorsa persistente, chiama immedia-
tamente ctx.register_resource_for_teardown(method, path, headers) passando
l’endpoint di cancellazione. La registrazione avviene nella stessa transazione logica della
creazione: se il test va in eccezione dopo la creazione ma prima di completare la registra-
zione, la risorsa potrebbe non essere rimossa. Questa condizione è documentata come
limite noto e non è considerabile dai meccanismi di eccezione di D4.P3"

spieagre meglio "In Phase~6, l'engine chiama \texttt{ctx.drain\_resources()} che restituisce le risorse registrate in ordine \gls{LIFO}. L'ordine inverso rispetto alla creazione garantisce che risorse con dipendenze implicite vengano rimosse correttamente: una risorsa creata dopo un'altra e che dipende da essa viene eliminata per prima. Per ogni risorsa restituita, l'engine tenta la chiamata \gls{HTTP} di cancellazione tramite \texttt{SecurityClient}. Un fallimento solleva \texttt{TeardownError}, che viene catturato e registrato come \texttt{WARNING} strutturato: il fallimento del teardown è un avvertimento operativo, non un'invalidazione scientifica dei risultati dell'assessment che lo ha preceduto. Come dimostrato nell'audit di Milestone~1 e discusso nella \hyperref[sec:coverage-idempotenza]{Sezione~\ref*{sec:coverage-idempotenza}}, zero risorse sono state rilevate come non rimosse su due run indipendenti."

nonsi capisce nulal diq eusto "Un assessment eseguito in sviluppo locale raggiunge il target all'\gls{URL} \texttt{http://localhost:8080}; lo stesso assessment eseguito in un ambiente Docker Compose deve usare il nome del servizio Compose, ad esempio \texttt{http://api-gateway:8080}, per essere raggiungibile da un container che condivide la stessa rete. In assenza di un meccanismo di astrazione, ogni connector che costruisce \gls{URL} di destinazione conterrebbe logica condizionale di deployment.
"

di cosneguena nememno di qeso "Il campo effective_base_url di TargetContext risolve questo problema una vol-
ta sola in Phase 3. L’engine legge target.base_url dal config.yaml, verifica se è
presente la variabile d’ambiente APIGUARD_TARGET_EFFECTIVE_URL (usata per override
nei deployment Docker), e scrive il risultato nel campo frozen di TargetContext. Da
quel momento, tutti i connector usano target.effective_base_url tramite il meto-
do target.effective_endpoint_base_url(): zero logica condizionale distribuita nei
connector, zero differenze tra i deployment visibili al di fuori di Phase 3"


Questo può anche andare bene ma lo collegherei meglio al discorso generale
"Ogni verifica di sicurezza produce due tipi di output: un verdetto, espresso come TestResult,
e l’evidenza che lo sostiene, composta dalle transazioni HTTP effettuate e dai dati grez-
zi prodotti dai tool esterni. Il verdetto senza evidenza è un’asserzione; l’evidenza senza
sanitizzazione è un rischio. Questa sezione descrive come EvidenceStore gestisce en-
trambi i problemi, e come i due deliverable finali dell’assessment, il file evidence.json
e il report assessment_report.html, vengono prodotti e strutturati."

La motivazione architetturale dell'\texttt{EvidenceStore} è stata introdotta nella Sezione~\ref{subsec:evidence-store}: il design precedente basato su \texttt{deque(maxlen=100)} produceva audit trail rotti in silenzio. Qui si descrive l'implementazione concreta che ha sostituito quel design -> va beneil remidner am scritto cosi suona male


quesot mi semba gi ababstanza bello ma vlautare se si puo fare meglio "Il ciclo di vita dell’EvidenceStore si articola in quattro operazioni sincronizzate con le
fasi dell’engine. In Phase 3, l’engine istanzia EvidenceStore e crea la directory tempo-
ranea outputs/evidence_tmp/. Prima di eseguire ogni test in Phase 5, l’engine chiama
store.begin_test(test_id): il metodo apre il file outputs/evidence_tmp/{test_id}.jsonl
in modalità append e lo mantiene aperto per l’intera durata del test. Durante l’e-
secuzione, ogni chiamata a store.log_transaction() o store.pin_artifact() scri-
ve immediatamente un oggetto JavaScript Object Notation (JSON) su una singola ri-
ga del file con flush() esplicito: zero buffering in memoria, zero rischio di perdita
in caso di crash. Al termine del test, store.end_test() chiude il file. In Phase 7,
store.merge_and_finalize() legge tutti i file .jsonl dalla directory temporanea, li
ordina per test_id lessicografico per garantire un output deterministico, li concatena in
un unico array JSON e li scrive nel file definitivo outputs/evidence.json. La directory
temporanea viene poi rimossa."

 Il test 1.1 su Forgejo, che interroga oltre 100 endpoint documentati
nella specifica OpenAPI, produce un file 1.1.jsonl con un record per endpoint senza
nessuna perdita -> è vero che è un record per endpoint? che senso ha questo esempio qua cosi?

se diciamo questa cosa va psieagta perchè lo limitiamo "la dimensione dell'evidenza è limitata unicamente dalla costante nominata \texttt{RESPONSE\_BODY\_MAX\_CHARS~=~10\,000} che tronca i body di risposta singoli, non il numero di record."

capsico il punto ma scriver emeglio "Un audit trail che contiene token di autenticazione, API key o password è esso stesso una
vulnerabilità: il file evidence.json viene condiviso con il team di sicurezza, archiviato
nei sistemi di ticketing, e potenzialmente incluso in repository. La sanitizzazione delle
credenziali non può essere delegata ai singoli connector con l’aspettativa che ciascuno
ricordi di redactare i campi sensibili: in un sistema estensibile da terze parti, quella
convenzione non è verificabile staticamente e non è garantibile a lungo termine."

Spieagre decisament emelgio come avviene, è un punto fodnamentale "La sanitizzazione opera con tre meccanismi sovrapposti che si completano a vicenda. Il primo è il key-pattern matching: una regex compilata a word-boundary controlla ogni chiave del dizionario ricorsivamente rispetto a 11 pattern (\texttt{token}, \texttt{password}, \texttt{api\_key}, \texttt{apikey}, \texttt{authorization}, \texttt{bearer}, \texttt{secret}, \texttt{credential}, \texttt{auth}, \texttt{private\_key}, \texttt{access\_token}). Qualsiasi chiave che corrisponde a uno di questi pattern vede il proprio valore sostituito con \texttt{[REDACTED]}, indipendentemente dal tipo del valore."

i 3 meccanismi forse andrebebro messi in un elenco putnaot e dire ocme agiscono tra di loro, cioè sono na sequnza ecc

Spiegare melio "La tripla copertura garantisce che un token JWT leakato come valore di una chiave
"result" arbitraria in un tool non noto al sistema venga comunque redactato, perché
il secondo meccanismo opera sul valore indipendentemente dalla chiave. Un connector
futuro contribuito da terze parti che dimentica di redactare i propri campi sensibili non
crea una violazione nell’audit trail: la garanzia è nel punto di scrittura su disco, non nel
punto di produzione del dato."


i deliverable finalei non sono solo due "I due deliverable finali dell’assessment assolvono funzioni complementari e si rivolgono
a interlocutori distinti. evidence.json è il forensic trail tecnico: contiene ogni transa-
zione HTTP, ogni artifact di tool esterno, ogni record di finding con la sua evidenza di
supporto, in formato macchina nativamente ingestibile da log aggregator come Elastic-
search, Splunk o Loki. assessment_report.html è il deliverable operativo: generato da
report/renderer.py tramite Jinja2, è leggibile da browser senza dipendenze esterne e
riporta i risultati in linguaggio comprensibile a un team di sicurezza non specializzato
sullo specifico tool" -> andare a legge remeglio la consocenza e la repo pe vedere cosa effettivamente viene prodotto


spiegare meglio "La struttura del report è determinata dal modo in cui l'\texttt{EvidenceStore} aggrega i dati durante la Phase~7. Il \texttt{ReportBuilder} in \texttt{report/builder.py} raggruppa i \texttt{TestResult} per coppia \texttt{(domain,~source)}: per ogni dominio di assurance compaiono prima i risultati dei test nativi, con la loro evidenza \gls{HTTP} diretta, poi i risultati dei test con tool specializzati, con il raw output del tool. Questa partizione non richiede sezioni fisicamente separate nel template: emerge naturalmente dall'aggregazione dei dati e dal campo \texttt{TestResult.source} che distingue \texttt{"native"} da \texttt{"external"}."

spiegare emglio "Il report include anche la transaction log di ogni test: la lista ordinata di tutte le transazioni \gls{HTTP} effettuate durante l'esecuzione, incluse le richieste e le risposte con i body troncati alla costante \texttt{RESPONSE\_BODY\_MAX\_CHARS}. Questa sezione, renderizzata con lazy loading nel template \gls{HTML} per gestire report di grandi dimensioni, permette a un analista di ripercorrere l'intera sequenza di probe che ha prodotto un finding, riproducendo il ragionamento del tool senza dover rieseguire l'assessment." -> dobbiamo spiegre meglio tutta questa seione, roa è fatta npo male