# 4.6

### 4.6.2


"Per le transazioni HTTP dei test nativi, la redazione
opera al livello del modello"
-> specificare se si itnende il mdoello pydantic, detto cosi è ancora unpo vago

"il \texttt{field\_validator} su \texttt{EvidenceRecord.request\_headers} sostituisce sempre il valore dell'header \texttt{Authorization} con \texttt{[REDACTED]} al momento della costruzione dell'oggetto, indipendentemente da come il record viene creato e prima che raggiunga l'\texttt{EvidenceStore}."
-> Questo pezzo mi sembra anche buono ma valutare se lo pssamo mettere gi meglio dato che modifichaimo la frase chelo itnroduce

"confrontando nomi interi e non sottostringhe."
-> coem mai queasta cosa? siamo sicuroi ceh avviene effettivmanete cosi?

"\item \textbf{\gls{JWT} value detection}: la regex \texttt{\_SANITIZE\_JWT\_PATTERN} riconosce la struttura a tre segmenti base64url separati da punto e redacta qualsiasi stringa con quella forma, " 
-> qua fores è ilc aso di emtetre una foot note su comè un segemnto jwt? per dare une sempio e faicliter la comrpensione

"Un connector di terze parti che non sanitizza i propri dati non introduce una violazione nell'audit trail: la garanzia è nel punto di scrittura su disco, non nel punto di produzione del dato."
-> essendo n po la frase chaive di qesta sezione cercherei di spieagrla un attimo melgio argomentando


"I tre meccanismi appena descritti si applicano esclusivamente agli artifact dei connector. La sanitizzazione delle transazioni \gls{HTTP} prodotte dai test nativi avviene su un percorso distinto, già descritto all'inizio di questa sezione: il \texttt{field\_validator} su \texttt{EvidenceRecord.request\_headers} garantisce la redazione dell'header \texttt{Authorization} al momento della costruzione del modello, prima che il record raggiunga l'\texttt{EvidenceStore}."
-> questo pezzo è però proprio uguale a questo pezzo che sta nell'itnroduzione "Per le transazioni \gls{HTTP} dei test nativi, la redazione opera al livello del modello: il \texttt{field\_validator} su \texttt{EvidenceRecord.request\_headers} sostituisce sempre il valore dell'header \texttt{Authorization} con \texttt{[REDACTED]} al momento della costruzione dell'oggetto, indipendentemente da come il record viene creato e prima che raggiunga l'\texttt{EvidenceStore}.
"
-> direi che nonha senso avere due posti distini e separati, per giunta nelal stessa sezione dove si parla della stessa cosa

Cosa ne pensi di parlare priam della sanitizzazione degli artifcat e mettere lelenco dei 3 livelli

poi dopo invece dire che apputnisi applicano solo ad artifact e la santiizzazioen dei test interni avviene dversamnte?
cosi quando uno legge si trova il amcroargoemtnazo della sanitizzazione, la priam parte è su quei test esterni e la secodna aprte è su quelli itnenri, può avere senso?

Quesot è il capitlo di sanitizzazione "
\subsection{Sanitizzazione Centralizzata delle Credenziali (D4.P2)}\label{subsec:sanitization}

Un audit trail che contiene token di autenticazione, \gls{API} key o password è esso stesso una superficie di rischio: \texttt{evidence.json} viene condiviso con il team di sicurezza, archiviato nei sistemi di ticketing, e potenzialmente incluso in repository. Delegare la redazione ai singoli connector presuppone che ogni implementazione, incluse quelle di terze parti, ricordino di sanitizzare i propri campi sensibili: una convenzione distribuita su un sistema estensibile non è verificabile staticamente e non regge nel tempo.

La responsabilità è centralizzata in un unico punto, con due meccanismi distinti per i due tipi di evidenza. Gli artifact dei tool esterni passano per \texttt{EvidenceStore.\_sanitize\_artifact()}, invocato automaticamente da \texttt{pin\_artifact()} prima della scrittura su disco: il connector non è tenuto a fare nulla, la sanitizzazione avviene per costruzione su qualsiasi output grezzo prodotto da un connector. Per le transazioni \gls{HTTP} dei test nativi, la redazione opera al livello del modello: il \texttt{field\_validator} su \texttt{EvidenceRecord.request\_headers} sostituisce sempre il valore dell'header \texttt{Authorization} con \texttt{[REDACTED]} al momento della costruzione dell'oggetto, indipendentemente da come il record viene creato e prima che raggiunga l'\texttt{EvidenceStore}.

La sanitizzazione degli artifact applica tre meccanismi in sequenza, sovrapposti per coprire pattern che i singoli meccanismi da soli non intercetterebbero:

\begin{enumerate}
  \item \textbf{Key-pattern matching}: una regex controlla ricorsivamente ogni chiave del dizionario rispetto a 11 pattern sensibili (\texttt{token}, \texttt{password}, \texttt{api\_key}, \texttt{apikey}, \texttt{authorization}, \texttt{bearer}, \texttt{secret}, \texttt{credential}, \texttt{auth}, \texttt{private\_key}, \texttt{access\_token}), confrontando nomi interi e non sottostringhe. Qualsiasi chiave che corrisponde vede il proprio valore sostituito con \texttt{[REDACTED]}, indipendentemente dal tipo.
  \item \textbf{\gls{JWT} value detection}: la regex \texttt{\_SANITIZE\_JWT\_PATTERN} riconosce la struttura a tre segmenti base64url separati da punto e redacta qualsiasi stringa con quella forma, indipendentemente dalla chiave che la contiene. Cattura i token che appaiono come valori di chiavi con nomi arbitrari.
  \item \textbf{Header prefix matching}: qualsiasi stringa che inizia con \texttt{"Bearer "}, \texttt{"Basic "}, \texttt{"Token "} o \texttt{"token "} viene redactata, intercettando i token che compaiono nei valori di header \gls{HTTP} inclusi nei record di evidenza.
\end{enumerate}


La sovrapposizione dei tre meccanismi copre scenari che nessuno dei tre individualmente intercetterebbe: un token \gls{JWT} in una chiave \texttt{"result"} arbitraria supera il primo meccanismo (nome non riconosciuto) ma viene catturato dal secondo (struttura base64url); un header \texttt{Authorization} in un dict annidato viene catturato dal primo meccanismo (key-pattern matching ricorsivo). Un connector di terze parti che non sanitizza i propri dati non introduce una violazione nell'audit trail: la garanzia è nel punto di scrittura su disco, non nel punto di produzione del dato.

I tre meccanismi appena descritti si applicano esclusivamente agli artifact dei connector. La sanitizzazione delle transazioni \gls{HTTP} prodotte dai test nativi avviene su un percorso distinto, già descritto all'inizio di questa sezione: il \texttt{field\_validator} su \texttt{EvidenceRecord.request\_headers} garantisce la redazione dell'header \texttt{Authorization} al momento della costruzione del modello, prima che il record raggiunga l'\texttt{EvidenceStore}."

### 4.6.3
"\subsection{Dual Audit Trail e Report Domain-Centric (D5.P5)}\label{subsec:dual-audit-trail}"
-> siamo sicur che sia gisuto chiamarlo "dual", per cosa dovrebeb satre inqeusto contesto?

"La distinzione più importante è quella tra i due meccanismi di audit trail, che operano con politiche di raccolta diverse."
-> quali inende con due metodi di audit trail? evidence e assesemre reprot? oppure sono altre cose

"he accompagnano l’array dei record" suona un po male usare array di record in un contesto json o sbaglio?

"Il file è strutturato come oggetto \gls{JSON} con campi di intestazione (\texttt{generated\_at\_utc}, \texttt{record\_count}) che accompagnano l'array dei record, in modo che un sistema esterno possa leggere metadati e dati dallo stesso file. Il formato è direttamente ingestibile da sistemi di log aggregation." 
-> questo vorse andrebbe unito in un unica frase?

"generato da \texttt{report/renderer.py} tramite Jinja2." -> metetre uan foot ntoe su jinja2 e speiagre cos'è penso sia utile, detto cosi semrba un temrine buttato lis enza conteso

"\texttt{assessment\_report.html} è il deliverable operativo, generato da \texttt{report/renderer.py} tramite Jinja2. Include l'executive summary con le statistiche aggregate, la tabella dei risultati per test con riferimenti normativi, e per ogni test il \texttt{TransactionSummary}: il log completo di ogni transazione \gls{HTTP} eseguita, incluse quelle sui test con esito \texttt{ENFORCED} o \texttt{PASS}, con body troncati a 2.000 caratteri per richiesta e 1.000 per risposta. Il \texttt{TransactionSummary} ha funzione di proof of coverage: permette di verificare che il tool abbia effettivamente interrogato gli endpoint dichiarati e di fare triage senza aprire \texttt{evidence.json}. Il report è un file \gls{HTML} completamente autonomo: tutto il \gls{CSS} e il JavaScript sono inline nel template, senza dipendenze da \glspl{CDN} o asset esterni. Può essere aperto da qualsiasi browser offline, allegato a un ticket, inviato per email o archiviato come artefatto di un'esecuzione \gls{CI/CD}, senza che il destinatario debba installare nulla. Per gestire report di grandi dimensioni, l'audit trail di ogni test usa lazy loading e rimane collassato per default."
-> il contenuto va benissimo, lho letto ed è giusto solo che mi smebra partiiolaremnte più lungo rispetto agli altri 2 file rpodtti che descriviamo nelal stessa sezione. senza perdere cotnenuto inforamtiov riusciamo a stignelr oun po?


"\texttt{apiguard\_report.json} è la serializzazione strutturata del \texttt{ReportData}: contiene tutti i risultati inclusi \texttt{PASS} e \texttt{SKIP}, le statistiche aggregate e i metadati del run, in formato adatto all'integrazione con pipeline \gls{CI/CD}, dashboard e sistemi \gls{SIEM}."
-> questo in qualche modo va colelgato alla questione del TransactionSummary ceh fa da aaudit trail
se non erro avevo proprio investito del tempo per assicurarmi che il file apiguard_report.json che viene generato dal tool fosse identico al unione di tutti i transaction summary presenti, cosi che se uno dalla pagina html del reprot che creo prova a scaricarsi il repot in formato json dovebbe otterenre lo stesso contenuto di apiguard_report.json diretytaemnte prodotto dal tuool.
In teoia l'avevamo fatto per evitare incocngruenze tra il reprot generato dalla cli in json e il report html che permetta di scaricare tuttoil json. Limprotante però era far capire che apputno i dati sono gli stessi, per comodità il tool produce apiguard_reprot.jsonc he è quello compelto e ingestibile dai sistemi CICD ecc ecc mentre per quanto rigardfa lutiltià dell'utente ha tutto dentro il file html che lgi permetet anceh di scaricare il json di report , che dvrebbe essere uguale a quello prodotto dalla cli.
Sono sicuor che questa cosa c'è  perchèp abbiamo invetito del tempo per fifxarlo dato che allinizio comaprivnao contenuti diversi, quindi ifnrmativi facendo passare tutta la douemtnazione, tutto il docie e la mia repo per caprie dove se ne aprla di questa cosa  e farci una delucidazione sulla base della mai richeista


"La struttura del report è determinata dall'aggregazione prodotta da \texttt{report/builder.py}: per ogni dominio di assurance, i risultati dei test nativi precedono quelli dei test con tool specializzati, distinzione che emerge dal campo \texttt{TestResult.source} senza richiedere sezioni fisicamente separate nel template."
-> è sèoehato troppo brevemente, cvome frase conclusiva non si capisce dove vule andare a aprare, andrei a riscrivere una ttimo meglio quello che intendiamo o a spiegare meglio