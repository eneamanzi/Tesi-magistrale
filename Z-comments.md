# 5

### La tensione strutturale principale

La tensione più rilevante riguarda il nome e il contenuto della Sezione 4, `sec:footprint-dag`. Il titolo dichiara "Benchmarking del DAG", ma la sottosezione sul DAG (`subsec:topologia-dag`) è prevalentemente un argomento di **correttezza**, non di performance. Spiega perché il DAG era necessario per la correttezza dei risultati (dipendenze tra test, non-determinismo senza scheduling), con il footprint come considerazione secondaria a fine sezione. Il regime IO-bound appartiene al footprint; l'argomento sul perché eseguire 1.4 e 2.1 dopo 1.1 sia semanticamente necessario appartiene alla validazione del meccanismo di scheduling. La sezione mescola due domande distinte: *quanto costa?* e *il meccanismo produce i risultati corretti per le ragioni giuste?*. Non è un problema grave, ma è l'unico punto dove la struttura interna non segue una singola linea argomentativa.

---

### Una tensione minore nell'apertura

L'introduzione del capitolo enuncia quattro livelli analitici e li nomina, ma non rivela che sono una gerarchia di precondizioni. Il lettore li percepisce inizialmente come paralleli. La Sintesi finale rivela la dipendenza. Questo crea un effetto che funziona come struttura ad anello, ma produce anche un momento di rilettura: il lettore capisce la relazione tra le sezioni solo alla fine. In Capitolo 3 e 4 la dipendenza tra argomenti era enunciata prima, non rivelata dopo. Non è una scelta sbagliata per un capitolo sperimentale, ma è una differenza di registro rispetto ai precedenti.

"Tutti i dati quantitativi di questo capitolo traggono origine dal Milestone~1 Pre-Release Audit, condotto il 2026-05-17 sulla versione \texttt{0.1.0} del tool con 73 verifiche indipendenti"
-> valutare se tenre questa scritta di dove arriav e del numero dei 73 verifiche

"Nessun risultato è stimato o interpolato: ogni numero citato ha un corrispondente punto di verifica nell'audit che lo ha prodotto. Questa tracciabilità è deliberata. Un capitolo di risultati senza riferimento alla procedura di misura che li ha generati è, dal punto di vista della riproducibilità, un capitolo di affermazioni."
-> questo è una frasee unica a mio avviso

## 5.1
" Serviva un'applicazione con una \gls{OAS} nativa"
-> footnote conspeiagzioen su cosa sia una OAS

"Serviva un'applicazione con una \gls{OAS} nativa, non generata a posteriori, che esponesse endpoint protetti da autenticazione reale, supportasse almeno due livelli di privilegi distinti, e producesse comportamenti osservabili e stabili sufficienti a validare i Domini D0, D1, D2, D3, D4, D6 e D7 senza che il target dovesse essere modificato tra un run e l'altro." 
-> questa farse è pesantissiam da leggere

"e aggiunge una caratteristica rilevante per la validazione dell'agnosticismo applicativo (discusso nella Sezione~\ref{subsec:agnosticismo}): il tool non contiene nessun riferimento hardcoded a Forgejo, e il medesimo file \texttt{config.yaml} che governa questo assessment è strutturalmente identico a quello che si userebbe su qualsiasi altra \gls{API} REST documentata."
-> scusa ma cosa aggiugnerebeb di nuovo? in caso va solo a cofnermare agnsoticiscmo e config drive, che tutto dipende dal file e non è hardocded ma non agigugne niente di nuovo, questo apitolo validaio solo cose gia dette

-> in conclusione va riformualta tutta la itnro di Topologia del Testbed Sperimentale

"Il testbed è provisioned tramite un singolo file Docker Compose su host di sviluppo, senza hardware dedicato né virtualizzazione separata."
-> bruttissimo usare provisioned in una frase cosi a caso, riscriviamola meglio, non erchè sia sbaglaita ma il termien suoan male in quelal frase

"Kong espone due porte di proxy: la~8000 in \gls{HTTP} semplice, usata esclusivamente dal test~1.5 per verificare il redirect verso \gls{HTTPS}, e la~8443 con certificato self-signed generato localmente, che costituisce l'endpoint primario del tool. L'Admin \gls{API} di Kong è accessibile sulla porta~8001 e rappresenta la sorgente dei dati per tutti i test di strategia \texttt{WHITE\_BOX} dei Domini~3, 4 e 6."
-> verificare se queste cose sono vere e sono allo stato più recente del mio tool, poi in caso riscrivere meglio, non che sia sbaglaito ma so che possiamo scriverlo emglio e maariqconq ualche dettaglio in più se rielvante

"La configurazione Kong è interamente dichiarativa, contenuta in un file \texttt{kong.yml} montato in sola lettura: questo è il pattern DB-less che il box gradient della Sezione~\ref{subsec:box-gradient} identifica come prerequisito per il testing a visibilità piena sul gateway."
-> questa frase bho souona strana, riamdna ad uan cosa che in realtà è teorica e no si copsice bene il cocnreto del riamdno, va di sicuro scritto emglip


### 5.1.2

"Un aspetto metodologicamente rilevante della configurazione riguarda quali comportamenti del gateway sono stati deliberatamente non induriti al momento dei run di validazione. Un testbed completamente hardened produrrebbe una suite con tutti \texttt{PASS} e nessun \texttt{FAIL}: un risultato tautologico, non informativo. Che il tool sappia identificare le violazioni presenti in un ambiente realmente misconfigured è il dato di validazione funzionale più utile."
-> capsicoils enso ma è scritto malissimo

"\item Forgejo espone token \gls{API} e metadati di sessione attraverso
        alcuni endpoint documentati nella propria specifica OpenAPI senza
        applicare restrizioni di campo sulla risposta. Il test~1.1, che sonda
        ogni endpoint della specifica senza credenziali, registra 74 finding
        per gli endpoint che restituiscono \texttt{2xx} in assenza di
        autenticazione: il verdetto è \texttt{FAIL} con 74 finding nella
        categoria \texttt{BYPASSED}."
-> argoemntare meglio questa cosa, nel senso che acacdeva se non sbaglio che tutti gli endpoitn ereditavano la classe protetta erhè era tipo dichairata nelal root delal psecifca openapi, di consegeunza non è che fa cgare forgejo ma su alcun tool che sono oblbigaotiramente pubblici venvia segnalato comeinfrazione, il che per ilnsotro tool è gisuto perchè si discosta dalal specifica. potremmo portare questo come esempio di una spearazione dalal configurazione, quello che dicevamoc nei cpaitoi 3 e 4 che se il file delal consocneza è fuckupapto non ce ne accorgiamoe ci si basa su quello
va però argoemtnato e psiegato meglio iltutto, cerca delal ifnromazioni nella repo

"Di conseguenza, tre scelte di configurazione producono \texttt{FAIL} osservabili e attesi nell'assessment:"
-> siamos icuri che ci siano solo queste 3 scelte? controlal a a fondo che ci siano solo queste 3 e non ce ne siano altree, mi smebra un po strano, in caso vediamo cosa metetre e come

\subsection{Configurazione Intenzionale per la Copertura dei Finding}
-> mi smerba di cpaire che inq eusto capitolo definiamo coemlabbiamo cofoigrto per far si che alcuen cose fossero passe  altre fail, andrei a spiegare un po tutto meglio basandosi anche sulel considerazionic he ti ho fatto sorpa.

Non è un capitolo fodnamental ema presnta delel scelte che appunto ci dicono cosa fallsice e cosa no, come per fare delel verifiche, che poi abbiamoa nche provato ad abiltiare e disabiltiare per verificare si passase da fail a pass, nln per tutti ma epr alcuni


Struttura RBAC e Provisioning degli Utenti
-> capsico il senso ma riscrivere meglio e non suare "viene provisoned"
spiegre almeno come è colelagto questo container agli altri, come iviene invocato e da chi ecc, dare un po più di dettaglio e per gli utenti dici che servivano tutit e 3 ma non dici perchè, il terzo utnte serviva pe ril bola se nnsbaglio. consulta bene la consocneza e la repo per bvedere ocsa dire meglio

## 5.2
"n tool che dichiara di essere uno strumento di assurance della sicurezza non può essere esente da quel medesimo rigore applicato alla propria implementazione. Questa considerazione non è retorica."
-> questa farse è bruttissima

"Un codebase con errori di tipo non rilevati, dipendenze con \gls{CVE} note, o simboli pubblici privi di contratto documentato produce output il cui grado di affidabilità è difficilmente separabile dalla qualità del codice che lo genera. Prima di discutere cosa il tool ha trovato sul target, è quindi necessario stabilire su quali basi ingegneristiche poggia l'analisi."
-> queste mi viene da dire che sono le cose che vprrai speiagre, sei sicuro che sono solo queste? ci sono tute le cose che effettivamente testiamo? nelle altre intro di solito facciamo un overview di cosa è contenuto a livello di amcroargoemnti
contrllal bene cosa effettivamente verifichiamo e fammi sapre come e se lo modificheresti

"L'audit di Milestone~1 ha eseguito 73 verifiche distribuite in 9 categorie. Le prime due, l'analisi statica (verifiche~1--5) e l'ingegneria di produzione (verifiche~37--56), misurano la qualità del codebase indipendentemente dall'output di assessment. I risultati sono riportati come prerequisito di credibilità, non come contributo autonomo."
-> quando mi rispodnerai apri una piccola parentesi dove mi fai un attimo una sorta di overview/rassunto di queste 73 verifiche di cui parla, dovreti avere nelal consocena il fiel di audit che le contiene, voglio che me lo riasusmi unattimo sia  a livello di categorie incluse sia  alivello delle verifiche di ogni categoria. quel docuemnto lho fatto generare inautoamtico da lcaude priam di fare il push su github, mi serviva per essere sicuro che tutto il tool fosse corretto e che tutto fosse in liena, non so se effettivamente ha senso come docuemtno da protare alal tesi e coem proa. c'è anche da dire che quei controlli li ha effettivmanrte fatti clude code quindi sno veritieri però usereiq eul fiel con un po più di parsimonia, ora viene nomianto in tutt o ild ocemtno coem se fosse una fonte certa di verita attendibiel, si parla di queto audit mielstone 1 coem se avessero accesos al docuemnto. ricordiamoci che è un mio docuemtno che ho creat in fase di svilppo. va bene usarlo ecc ma non lo userei coem referenza coem se fosse uan fonte, questa ocsa va corretta in tutti i file, sia capitolo 3 che capitolo 4 che capitlo 5. va ben eusare le cose che ci sono dentro, dire che abbiamof atto quei cotnrolli, quelel verifihc e eche ci danno determiante garanzie o prove ma non userei audit mielstone 1 coem un riferiemtnoa  cui puntare da dove arrivnao le cose.
nei cpaitoli 3 e 4 diremo piuttosto che si vedrà nella sezione 5 come quelel cose vengono verificae con itest ecc e qua diremo che abbiamo vfatto queste verifiche ecc.

parlaimo come cose che abbiamof atto, non coem cose hce sono in uan fotne di verità dentro mielstone 1. non so se mi sono itneso, discutiamone una ttimo perchè mi sembra importante


### 5.2.1
Analisi Statica del Codebase
-> il contenuto va bene e la tabelal grosso modo va anche bene il fatto e che cosi vengono buttati li un botto di tool senza dire cosa efettivamente fanno, cioè va bene itnrodurre il capitlo dicendo che abbiamof attoq uesti test stati ecc eh si possono vedere nelal tabelal i vari tool, risuati ecc 
ma poi andrei a fare una sorta di mini elenco o comuqneu di speigazione per ciasucno di essi, dicendo cosa verific o comquneu come lo fa ecc. una mini spiegazione per cpire il perchè diq uel tool ,cosi che non smebrano buttati li a caso.
dato che facciamo questa spieagzione più detaglaita puoi modificare la tabelal tofielndo dettaglio, vedi tu se qualche altra colonna potrebbe servire

se le cose verrank o psieagrte meglio in una altro capitolo mettiamo i riferimenti com espresso nelel regole agiguntive che abbiamo definito in chat




### 5.2.2
Dual-Layer Type Safety (D6.P3
_> apisco la volonta di fare vede la doppia faccia della medagli ma attalemten non è proprio bellissimo ilt esto di questo capitoletto. inzia con un afras ebreivssiam di poco senza ma solo imaptto. dobbiamo considerare ocem risutrutturarlo sulal base di quello priam

Il punto che volgiamo espriem è che contolliamo sia il codice staticmente con myypy che i nsotri tipi di dati mis embra di cpaire, cerchiamo di descrivere meglio qla problematic che cera e coem labbiamo rsilta con questi due tool che cooperano per araggiugenre un obbietivo comuqne coprendo cose separte che si comeptlano a vicenda

è uan cosa molto improtante dire e dato che siamo dnelal fase deglie speriemnti ha senso dedicarci un pezzo, magari in tutte queste seioni coni coamdni potremmo mettere il epzzettino coem code contente il coamdno usato? coi da renderlo bene cairo? da vlautare coem prospota ma potrebeb avere senso cosi si mette li coamdno e una sorta di output 

### 5.2.3
"Oltre all'analisi statica, l'audit ha verificato una serie di proprietà ingegneristiche che contribuiscono alla riproducibilità e all'affidabilità operativa del tool. Tre meritano menzione esplicita per la loro rilevanza rispetto alle garanzie di assurance che il tool promette."
-> brutsisimo inziaire idcendo che ne abbiamo un po ma ne verifichiamo 3
cioè ha anche senso ma lo metterei giu diversamente, e siamo effettivmanete sicuri che queste sono quelle di cui oliamo aprlare? consulta bene al tua consocenza e discutiamo delel alternative presenti

"Il primo è la copertura della documentazione interna: 292 simboli pubblici su 292 analizzati tramite scansione \gls{AST} presentano una docstring di modulo o di classe (100\%). In un tool estensibile per design, la documentazione dei contratti pubblici non è decorativa: è il meccanismo attraverso cui un nuovo test può capire cosa può chiamare e con quali aspettative di comportamento."
-> come è avvenuta in concreto questa cosa? siamo nel capitolo deglie speriemtni dobbiamoa rgoentnare on cocnretezza, va bene spiegae prima el ocose e introdurle in mod che siano chaire ma dove possiamo ddiamo cocnretezza di coem  stato fatto un cotnrollo o una verifica, consultando sempre priam la repo e la cosnocenza per ssapere bene cosa dire

"Il secondo è la riproducibilità della build. Due esecuzioni consecutive di \texttt{hatch~build~-{}-target~wheel} producono un artefatto con SHA-256 identico (451\,261~byte). Una wheel non deterministica introduce una categoria di variabilità nel deployment che è metodologicamente inaccettabile per un tool che promette idempotenza sui propri risultati."
-> siamo sicuri di qusta cosa dello sha? dove lhai letta' contola bene se viene fettivmanete fatto cosi e in che modo ,diamo dettagli  coem ti dicevo prima

"Il terzo è il cold install: in un ambiente virtuale Python pulito, senza alcuna dipendenza preinstallata, l'esecuzione di \texttt{pip~install~apiguard\_assurance-0.1.0-py3-none-any.whl} seguita da \texttt{apiguard~version} restituisce \texttt{0.1.0}. Il tool è self-contained e non dipende da pacchetti installati nell'ambiente dell'esecutore."
-> mi sembra un po pintless detto cosi, va spiegato o argoetnato melgio

"Il verdetto complessivo dell'audit, sintetizzato nella Tabella~\ref{tab:verdetto-release}, è: pronto per la difesa di tesi e per il deployment in ambiente chiuso su target con \gls{OAS} documentata. Gli unici due item deferiti, il file \texttt{LICENSE} e il \texttt{CHANGELOG.md}, riguardano esclusivamente la distribuzione pubblica su PyPI e non hanno impatto sul comportamento operativo del tool."
-> questa qua frase palese di AI "pronto pe rla difesa" nessunos tudent los criverebe mai nelal tesi. idem nesusno parlreebeb dei due item differiti. sorpatuttuo dopo la spiegaizoen che ti ho fatt prima che laudit della mielstone lho fatto priamd i un oush per verificare che tutto fosse ok e cosa mi mancavada fare. NON é UNA GUID  UFFICIALE O CITABILE

di cosneguenza quest epzzo va riscritto

Idem, date le cosndierazioni di priam valuimao cosa e coem tenere la tabella Verdetto release-readiness al miestone 1
non ti riepterò ma valgoe le stese cose che ti ho detto pocofa e no usae gli em dash

## 5.3

"L'idempotenza è una proprietà delicata che richiede di essere attestata empiricamente. Test che creano risorse sul target, le interrogano, e poi le eliminano introducono dipendenze di stato che, se mal gestite, producono risultati diversi al secondo run: la prima esecuzione modifica il target, la seconda trova uno stato diverso. Che il sistema produca risultati identici su due run indipendenti è la dimostrazione empirica che la pipeline non lascia effetti collaterali osservabili, non un'affermazione di principio."
-> mi paice il senso ma penso che lo ptremmo riscrivere meglio cioè sembra un po confuso e ripetitiv per ccerti versi

"I due run sono stati eseguiti in sequenza nello stesso giorno contro lo stesso testbed, senza alcun intervento manuale tra l'uno e l'altro. La Tabella~\ref{tab:idempotenza-kpi} riporta i \gls{KPI} aggregati; la Tabella~\ref{tab:risultati-per-test} dettaglia lo status e il conteggio dei finding per ciascuno dei 18 test attivi."
-> direi gisuto qualcosa di più per il resto grosso modo mi paice e la tabela KPI di idemptenza sembra corretta e sensata, sempclieemtne confrotna due run su alcuni apramteri gisuto?

"La distribuzione dei finding non è uniforme. Il test~1.1, che sonda ogni endpoint della specifica OpenAPI di Forgejo in assenza di autenticazione, produce da solo 74 dei 98 finding totali: il 75.5\% dell'intero conteggio. Questo non è un artefatto di un test mal calibrato. Forgejo espone una superficie documentata di oltre cento endpoint, e la configurazione Kong del testbed non applica autenticazione a molti di essi per design sperimentale (come discusso nella Sezione~\ref{sec:testbed}).
Ciascun endpoint che risponde \texttt{2xx} a una richiesta non autenticata è un finding distinto nell'oracle a tre esiti della Safe HTTP Probing Policy (Sezione~\ref{subsec:probing-policy}, D4.P7): la cardinalità riflette la superficie reale del target, non un'amplificazione artificiale del contatore."
-> riscriver emeeglio e senza wuerlla frase di imaptto suepr breve allinizio.
Poi come ti dicevo priamquetsa cosa non è del tutto vera. è un po una miss generazioen da parte di forgejo delal loro specifica che amrchia molti endpoitn coem authenticated quando in realtà nnon lo sono
va riscritto

"I due \texttt{SKIP} meritano una lettura separata. Il test~0.3 verifica che gli endpoint marcati \texttt{deprecated:~true} nella specifica restituiscano \texttt{410~Gone} o portino un header \texttt{Sunset} valido (RFC~8594). La specifica OpenAPI di Forgejo~14.0.3 non dichiara nessun endpoint con questo marcatore: lo scope è legittimamente vuoto, e il test restituisce \texttt{SKIP} con motivo documentato. Il test~1.6 verifica la configurazione del session store tramite l'Admin \gls{API} di Kong; nella configurazione del testbed, Kong non espone un session store gestito esternamente, e la condizione di applicabilità non è soddisfatta. In entrambi i casi, \texttt{SKIP} non è un fallimento silenzioso: è la risposta semanticamente corretta all'assenza di condizioni di applicabilità, distinta dall'\texttt{ERROR} che indicherebbe un malfunzionamento della pipeline stessa."
-> corretto ma riscrivere uattimo meglio, presentando che coem si accennva nelel sezioni priam(controlal tu quale referenziar) se un test non trova tutte le sue dipendenze soddisfatte prduce uno skippesenza ntaccae glia ltri, cosi abbiamo un introduzione per quesotpezzo refenreziamo il pezzo teorico dove viene introddo e diamo la prova concreta

"I tre \texttt{FAIL} del Dominio~1 prodotti dai tool esterni riguardano la configurazione \gls{TLS}. Il certificato self-signed del testbed presenta configurazioni subottimali rilevabili dall'analisi statica del protocollo: \texttt{ext.1.5.sslyze} rileva 1 finding, \texttt{ext.1.5.testssl} ne rileva 3. Questi risultati sono attesi e coerenti con l'uso di un certificato generato localmente per ambiente di laboratorio."
-> i fiel dei tool esterni nel dominio 1 sono solo 2, alltro è il test antivo che faila
riscrivere meglio. poi lo trovo poc sensat parlare solo di alcuni che failano senza dire niente degli altri, piuttosto facicamo una verview velce di tutti  piuttst diciam che ad esempi tra quelli falliti ptrebeb essere interessante vedere X e ne parlaim
discutiamne

Nella tabella Status e finding cunt per test è pin di em dash

### 5.3.2
"Il delta sul wall-clock tra i due run"
-> trppi termini tecnici che nn sn per forza scontati, cose'è il wall-clock

"Questo margine rientra interamente nel rumore delle latenze di rete \gls{HTTP} verso il target e non è distinguibile dalla variabilità attesa di un sistema operativo in esecuzione su hardware condiviso."
-> non ho ben capito questa frase

"I contatori di finding, gli status per-test, il codice di uscita e il \texttt{pass\_rate\_pct} sono invece byte-identici: non vi è alcuna variazione nella parte deterministica del risultato."
-> questa cosa no labbiamo gia detta priam da qualche altra aprte? a me sembra di si, pupi controllre megio dove e vedere cosa fare? discutiamone

"L'idempotenza ha una precondizione concreta: il teardown deve restituire il target allo stato iniziale dopo ogni run, senza lasciare risorse residue che alterino i risultati dell'esecuzione successiva. La verifica live condotta dopo ciascuno dei due run ha confermato che la Phase~6 ha drenato il registro \gls{LIFO} con 4 risorse transitorie e 0 fallimenti su entrambe le esecuzioni. La Tabella~\ref{tab:teardown-verifica} riporta lo stato delle risorse osservabili sul target prima del primo run e dopo ciascuno dei due."
-> qua dovrebe vnire spontane un riferimento al cpaitlo 3 o 4 (non ricordo) dove parlaimo del teardown o sbaglio? colelgandolo in modo naturale al discorso coem abbiam ovsito

la tabella verifica live del teardown post-run è un po pintless, fa vedere tutto a zero e il verdetto passato senza dare un gran valore aggiunto, per me si potrebeb togleire a meno che secodnote ha aprticoalre senso
Spieghiamo poi meglio quelel cose li in modo testuale se la dovessimo togleire


"Zero risorse leakate su due run è la dimostrazione empirica che le proprietà discusse nella Sezione~\ref{subsec:teardown} (Best-Effort Teardown \gls{LIFO}, D4.P6) e nella Sezione~\ref{subsec:reproducibility} (Riproducibilità, D3.P4) si comportano nel modo dichiarato in presenza di stato reale. La correttezza teorica della logica di teardown trova il proprio banco di prova nello stato osservabile che produce: zero risorse residue è la misura diretta. Queste tabelle sono quella verifica."
-> vedo che ne aprlavi qua, che messa cosi in fondo è brutta e sembrano frasi uttate li , quando ivnece può essere una buoa apertura o intermezzo per contirnare il dsicorso

allroa facciamo cosi, andaimoa  ristrututrare questo cpaitolo da zero dato che ci sono vari emodifiche da fare, proponimele e ediscutiamone
proponimi la nuova versioen di queesto cpaitletto


## 5.4
"Il profilo di risorse di un tool di assessment è un criterio operativo primario. Un tool che satura la CPU, esaurisce la memoria o produce un output non ingestibile non è integrabile in una pipeline \gls{CI/CD} senza hardware dedicato. I dati di questa sezione rispondono a una domanda precisa: su quale classe di macchina e in quale regime di esecuzione APIGuard Assurance è operativamente sostenibile?"
-> cercherei di unire un attimo le frasi, sicuramente la rpiam e la seocnda frase potrebebro essere unite, l aquestioen delal doamdanprecis aosotto è un pos tran, cioè suona quasi forzzata messa li cosi, ne cpaico appien il senso ma non mi convicne del tutto qusto pezzo

"\begin{table}[ht]
  \centering
  \small
  \begin{tabularx}{\textwidth}{l C C}
    \toprule
    \textbf{Metrica}             & \textbf{Run~1}      & \textbf{Run~2}      \\
    \midrule
    Wall-clock elapsed           & 290.14\,s (4:50.14) & 290.81\,s (4:50.81) \\
    \addlinespace
    User time                    & 35.09\,s            & 34.67\,s            \\
    \addlinespace
    System time                  & 41.51\,s            & 41.62\,s            \\
    \addlinespace
    CPU utilization (media)      & 26\%                & (simile)            \\
    \addlinespace
    Peak resident set size       & 287\,MB             & 295\,MB             \\
    \addlinespace
    Voluntary context switches   & 145.356             & (simile)            \\
    \addlinespace
    Involuntary context switches & 20.685              & (simile)            \\
    \bottomrule
  \end{tabularx}
  \caption{Metriche di sistema sui due run.}
  \label{tab:performance-baseline}
\end{table}
"
-> sei sicuro dei valori di qeusta tabelal? vai a cotnrlalre meglio la repo e la consocenza per verifiare che tutto sia correto, che tutte le cose msiurate rielvanti siano lie che i valori siano crretti

Serve poi quantomeno uan footntoe che spieghi la differenza tra user time e system time che non è intuitivo
sei sicuro che quello 26% è lutilizzo delal cCPU
chi lha misuratoe in che modo? poi dire la percentuale delal cpu senza i vari mdoelli non ha senso e dato che sono su uan vm del uni non lo posso sapere con dettagli, non so se è uan info rilevante da dire cosi
La memoria come ha veriifcato quanto consuma al massimO? samo sicui che quela veriifa è corretta?
I context swithc volontari e invootnrari ch i li ah msiurait? e come? servono veramente? mi sano di dato a caso messo li er il mio contesto
Poi come nelal tabella che ti dicevo allinzo mi smebra, andrei a fare un paragrafino dove spieghiamo o comqune diciamo almeno uan riga su ogni record edelal tabelal per dare un minimo di speiagzione
-> d i cosnegeunza rifare questa itnro 
andrie peroò siurmante a spieagre i recorde delal tabelal oa referenziare s evengono spieagti poi

### 5.4.1
"Il dato più informativo nella tabella non è il wall-clock. È la relazione tra user time, system time e tempo totale. Su 290\,s di esecuzione reale, il processo ha consumato circa 35\,s di tempo CPU in user space e 41\,s in kernel space: la somma è 76\,s, il 26\% del wall-clock. I restanti 214\,s, il 74\% del tempo totale, il processo li ha trascorsi in attesa: attesa delle risposte \gls{HTTP} dal target, attesa del completamento dei processi esterni (nuclei, testssl.sh), attesa dell'I/O su disco per la scrittura dell'evidence store. Ne emerge un'inferenza architetturale diretta: il collo di bottiglia è la latenza di rete verso il target, non l'interprete Python né il \gls{DAG} scheduler. Qualsiasi refactoring del codice Python lascerebbe il wall-clock sostanzialmente invariato. Ciò che sposta effettivamente il wall-clock è la parallelizzazione dei test che non hanno dipendenze reciproche, traiettoria discussa nella Sezione~\ref{sec:limiti} come sviluppo futuro di Milestone~2. In assenza di parallelizzazione, il profilo attuale è il lower bound dell'architettura sequenziale, non un'inefficienza correggibile con refactoring locale."
-> mi paice il cotnenuto e ha anche senso se effettivmanete è vero, fai priam un controllo nelal repo e neella consocenza per verifica che effettivmante si acosi
poi cercherei di scriverlo in modo un po meno pesante, ma il messaggioe il contenuto mi paicicono ababsatnza.
vedere poi se ne riscrivelro esce fuori qualche dettaggli aggiuntivo da riprotare

"Il profilo di memoria è compatibile con l'integrazione \gls{CI/CD} su runner standard. 287--295\,MB di resident set size si collocano ampiamente entro i limiti delle configurazioni GitHub Actions e GitLab \gls{CI} di default (tipicamente 7\,GB per runner condivisi), senza richiedere runner dedicati né configurazioni di memoria particolari. Il footprint su disco è 4.5\,MB: \texttt{apiguard\_report.json} da 2.26\,MB, \texttt{assessment\_report.html} da 2.0\,MB e \texttt{evidence.json} da 254\,KB. I tre file sono autosufficienti e non richiedono dipendenze esterne per essere consultati."
-> riscrivere meglio e ricordarsidi nonsuare em dash
la porrei coem che i sistemi chepermettoo di eseguire runenr hanno capienza limitate (se metti dei dati tipo /GB serve uan garanzia, non so se ha seno metterli) farei però forza comquenu sul fattoche sono limitati e il nsoto tool non è esagerato in nessuan diq ueste andando a ripotare poi i vlaori improtanti che otteniamoe ah senso condividere
non che è sbaglaito il contenut che è ga presente

### 5.4.2
"L'esecuzione sequenziale di 18 test in due fasi non è la struttura più semplice realizzabile."
-> frase bruttissima

"Sarebbe stato possibile eseguire tutti i test in un singolo batch senza \gls{DAG}: meno codice, zero overhead di scheduling. Il problema che questa scelta avrebbe lasciato aperto è la correttezza dei risultati in presenza di dipendenze tra test."
-> pure qusto è scritto veramemte male, riscrivere ompeltamente 

poi forse qua conviene anche fare un riferimento ai cpaitoli 3 e/o 4 dove si parla del dag? alal fine verrbebe ababstanza naturale o sbaglio?


"Il test~1.4 (revoca del token) richiede un token valido prodotto da un login \gls{HTTP} riuscito. Il test~2.1 (\gls{RBAC} enforcement) richiede lo stesso token per tentare endpoint amministrativi con credenziali di utente ordinario. Entrambi dipendono dal fatto che il test~1.1 abbia già interrogato la superficie di attacco e che l'autenticazione abbia prodotto un token nel \texttt{TestContext}. Eseguire~1.4 o~2.1 in assenza di questo prerequisito non produce un \texttt{ERROR} in fase di bootstrap: produce risultati non deterministici, ovvero output che dipendono dall'ordine di esecuzione e non dall'effettivo comportamento del target."
-> questo è il riferiemnto concreto che forse accenanvamo nelal teoria, va benisismo per ocme è scritto, tranen la frase "Eseguire 1.4 o 2.1 in assenza di questo prerequisito
non produce un ERROR in fase di bootstrap" -> bisogna fae capire che è un conioxoanel, tipo se eeguissimo quei test. fare capire che è un ipotesi, che ci da un arogemtnazione a favore del perchè c'è il dag. altrimnti semrba che si possa incorrere inquelal casisitca mntee appunto è propri cioè che andaimo ad evitare

"La topologia del \gls{DAG} all'audit di Milestone~1, " -> stesse critiche fatte priam su audit mielstone 1, dobbiamo dsicuterne in generale cosa farne e poi renderla la modifica uniforme a tutti e 3 i documenti chap3 chap4 e chap5

"La topologia del \gls{DAG} all'audit di Milestone~1, riportata nella Figura concettuale della Tabella~\ref{tab:dag-topology}, risolve il problema alla radice: 16 test senza dipendenze formano la Phase~A ed eseguono per primi; 1.4 e~2.1, che dichiarano \texttt{depends\_on~=~["1.1"]}, vengono schedulati in Phase~B e non possono mai essere avviati prima che il test~1.1 abbia prodotto un risultato."
-> il contenuto è gfisuto ma vedere se si può argomentare un pelo di più o dire meglio

"Due considerazioni emergono da questa topologia. La prima è che il \gls{DAG} è sparso: su 18 nodi, solo 2 hanno dipendenze dichiarate, e queste convergono su un unico predecessore. L'overhead di scheduling introdotto dal \texttt{DAGScheduler} è quindi trascurabile rispetto al tempo di esecuzione dei test; la complessità del componente si giustifica non sul carico attuale ma sulla scalabilità futura, quando dipendenze tra domini distinti renderanno il grafo più denso."
-> questo non è molto chiaro, cioè il punto è un po come dire che se uno lo valutasse allo stat attuale sarbbe un overhead ma invecee noi loabbiamo rpedispsoto per il futuro, dimsotrando che fuzioa per la questioen dei due test che hanno il depends_on, dato chein questa caso negli esperiemnt e nelal tsi non si impeenta utto ma si portano dei cocnetti e la prova di quello che si è pensato funziona
riscriviamolo meglio

"La seconda considerazione riguarda la relazione tra topologia del \gls{DAG} e footprint di memoria. Con 16 test in esecuzione sequenziale nella Phase~A, il \texttt{EvidenceStore} mantiene aperto un file \texttt{.jsonl} per volta: il picco di memoria non è determinato dal numero di test paralleli ma dalla dimensione del singolo audit trail. I 287--295\,MB misurati rappresentano il profilo reale di questa esecuzione, non una stima conservativa. La transizione verso l'esecuzione parallela dei test all'interno della stessa fase, prevista in Milestone~2, richiederà una rivalutazione di questo profilo: più file \texttt{.jsonl} aperti concorrentemente comportano un footprint proporzionalmente maggiore, da misurare prima di fissare i requisiti di memoria per deployment \gls{CI/CD}."
-> questa è detta ababstanza bene, mi sembra la spiegazione di quel record che conteine la memoria in una tabelal con valore 287, sarebeb bello o spostare questa mini spiegazioni li sotto, dove ti dicevo che vorei uanspieagzione dei vari record edelal tabella, ha senso secondo te? opprue il suo psoto è meglio qua dove si trova ora?

## \section*{Sintesi della Validazione}
"I quattro livelli di analisi si stratificano in una gerarchia di precondizioni: ciascuno è condizione di interpretabilità del successivo. Il testbed stabilisce le condizioni di osservazione. La release-readiness certifica che lo strumento di misura è affidabile. La copertura funzionale e l'idempotenza dimostrano che i risultati prodotti sono stabili e non contaminati da effetti collaterali. Il profilo computazionale ne qualifica l'integrabilità operativa. Rimuovere uno qualsiasi di questi livelli non impoverisce la validazione: la invalida."
-> evitare frasi cosi brevi piene di punti inun paragrafo cosi picoclo, può essere decisamente riformualto meglio. già che ci sei fai un controlo per verificare che sia corretto ciò che dice

"Il risultato aggregato è leggibile in termini precisi. Su un target reale con una \gls{OAS} nativa, APIGuard Assurance v0.1.0 ha eseguito 18 test distribuiti su 7 domini di sicurezza, prodotto 98 finding in 9 categorie distinte, restituito risultati byte-identici su due run indipendenti, drenato tutte le risorse transitorie senza residui, e completato l'intero assessment in circa 4 minuti e 50 secondi su hardware non dedicato. Nessuno di questi numeri è stimato: tutti tracciano a un punto di verifica nell'audit."
-> dato che è un riassunto di un po tutot questo pezzo vedere se è effettivamente comelto e fa bene il trace delel cose che citiamo negliesperiemnti, fai un conrolloa ggintivo anche sulla repo e nella consocenza priam di conferma
"Nessuno di questi
numeri è stimato: tutti tracciano a un punto di verifica nell’audit." -> quetsa farse però non mi piace


"La validazione empirica misura comportamenti osservabili e non può pronunciarsi sui limiti del paradigma che il tool implementa. Un assessment corretto su una specifica errata produce verdetti formalmente validi ma sostanzialmente privi di significato. Un tool che astrae il gateway per garantire portabilità multi-vendor rinuncia, per costruzione, ai controlli vendor-specifici privi di un equivalente generalizzabile. Queste non sono anomalie dell'implementazione: sono tensioni strutturali del contratto che APIGuard Assurance stringe con il proprio dominio applicativo. La loro analisi è l'oggetto del Capitolo~\ref{chap:discussion}."
-> questo mi sembra un po outof context messo qua cosi o sbaglio? magari mi è sfuggito qualcosa a me, mi smebra che vogai fare da colelmento epr ilc aptiolo successvo ma risuta forzatissimo a mio avviso e soprattuo nel psoto sbaglaito, cioè non dovrebbe ssere dentro la sinesi, uan sintesi apputno riassuemsolo cose gia dette. il contenuto diq uesto pezzo che tu ho incollato lo diciamo già da qualche parte? sta di fatto che un po mi puzza























# 6 
"La validazione del Capitolo~\ref{chap:experiments} ha risposto a una domanda circoscritta: APIGuard Assurance si comporta come dichiarato su un target reale? La risposta è affermativa, e i dati la supportano con tracciabilità completa. Rimane aperta una domanda di portata diversa: entro quali confini strutturali quella risposta vale? Un sistema di assurance che conosce i propri limiti è più utile di uno che li ignora, perché consente a chi lo adopera di calibrare la fiducia nell'output in modo informato.
"
-> inizio ababstanza originale, mi paice e non mipaice allo stesso tempo. bello il riferiemto al capitolo rpecedente con una suer sintesi  di cosa tratta a mo di domanda
non mi apice tanto la sentenza "La rispsota èa ffermativa" sembra un po forzato; tracciabilità dei dat va bene ed è vera

"Un sistema di assurance che conosce i propri limiti è più utile di uno che li ignora, perché consente a chi lo adopera di calibrare la fiducia nell'output in modo informato."
-> frase un po altezzosa questa a mio avviso

"Questo capitolo esamina quei confini in tre direzioni. La prima è critica: i limiti strutturali del paradigma contract-driven, ciascuno radicato in una proprietà architetturale specifica, vengono discussi senza attenuarli (Sezione~\ref{sec:limiti}). La seconda è applicativa: le condizioni in cui il tool è integrabile in pipeline \gls{CI/CD} industriali e i pattern di deployment che ne massimizzano il valore (Sezione~\ref{sec:devsecops}). La terza è prospettica: le traiettorie di sviluppo, distinte tra estensioni operative pianificate per la Milestone~2 e direzioni di ricerca che richiedono validazione sperimentale indipendente (Sezione~\ref{sec:sviluppi-futuri}).
"
-> qua la situazione è un po iù complciata, le cose che sono scrite li dentro sono sucite man mano durante la scritutra dei vari cpaitoli in stato iniziale. ora i cpaitoli 3, 4 e 5 (quando affronteremo il capitolo 6 avremo gia risolto i prolemi elencati sopra nel 5) sono alal versione finale quindi potrebbe essere che abbiamo alre cose da disuctere, che quelel di cui volevamo discutere sono sparite o che abbiamo ulteriroi cose da dire pe rquelel gi presenti. non st dicendo che tutto è sbalgiaot ma sto facneod notare che abbiamo fatto grandi cambaiemnti sulel cos epriam che hanno conseguene dirette su qeusti quindi ianziutto dobbiamo fare una valutazion eapprofondita leggendo riga per riga i file delel sezini precedenti che ti ho detto ssere approvati e valutare cosa metetre inq uesto cpaitolo, se il contenuto che c'è gi ava bene o va aggiroanto e modificato

in aggiutna aquesto, avendo letto tutti e 3 icpaitoli precedneti dovrst avere un cpmtesot precissimo su quello che stiao facendo quindi potresti aiutarmi usando la tua consocenza base (nonq ueall che ti ho caricato io) oppure cercando sul web (soparattuto su siti di valori, non blog o cazzte del genere) delel altre cosniderazioni su cui discutere o mettere negli sviluppi futuri che magari abbiamo trascurato o non ci sono venute in mente. gisuto per fare un controllo extar e segurie unapprocio olsitico ed esaustivo diciamo. mi piacicono le cose tendenti a perfetto.

DI cosnegeunza se facciamo modifiche di quesot genere dobbiamoa ndare ad aggiaonre le intro sia del capitolo 6, quindi quelal pricnapel che dovrebeb un po tracciarne i vari conenuti, sia le intro di tutte le section e subsection che vengono coinvolte per rendere tutto ongruente.

## 6.1
"I tre limiti discussi in questa sezione non sono anomalie correggibili con un refactoring localizzato. Ciascuno è il prezzo di una scelta architetturale deliberata: una proprietà che garantisce un vantaggio specifico impone, per costruzione, una classe di situazioni in cui quel vantaggio si trasforma in vincolo. Nominarli con precisione è il modo corretto di presentare un sistema di assurance: l'alternativa è trasferire al lettore l'onere di scoprirli durante il deployment."
-> capsicoil senso ma è scritto male

"Come stabilito nella Sezione~\ref{subsec:openapi-sot} (D3.P2), la specifica OpenAPI costituisce l'unico oracolo formale della pipeline: costruisce le richieste, delimita la superficie di attacco, e valuta le risposte."
-> è cocnettualemtne scorretto, la specifica non formaual nessuanricheista, gaurda bene al consocenza che hai della repo e le cose che ti ho pasato e riformualalo meglgio ettendo effettivmanrete cosa fa. non inventare nulla. hai tutot il amteriale per fare scelte comprovate e logiche

"Il prezzo è la dipendenza dalla qualità di ciò che si assume come oracolo. Una specifica obsoleta, che non riflette endpoint aggiunti dopo l'ultima pubblicazione della documentazione, riduce la superficie di attacco osservabile senza che il sistema possa rilevare l'incoerenza: l'assenza di un endpoint nell'assessment è indistinguibile dalla sua assenza nella specifica. Una specifica deliberatamente incompleta, costruita per escludere endpoint sensibili dalla copertura del tool, produce un assessment formalmente corretto su una superficie artificialmente ristretta. In entrambi i casi il tool non dispone di un meccanismo per distinguere l'assenza di vulnerabilità dall'assenza di copertura."
-> qua si vogliono illsutrare le problemtiche ma non mi apcie come è scritto,la priam frase e la econda ptrebebro essere untie pe rundisocrso lienare -> grosos modo il rest è bello mavalutiamo se si può fare di meglio 

grosso modo il rsto del contenuto va bene ma mis emrba esagerato avrere 4 paragrafi, mi smebra un po cehal strututra si aelencare la pobkmatic ae i riferietnia dove la presentiamo noi, fornire deglie sempi cocneti di prblemtiche che psosonoa ccadere ocme al speciica obsoleta ecc e poi presentare le vie possibile future che ptorebbero risovlere queto prolema, dicendo che è un probkema apeto nel testing contact driven e tutto cio che ne consegue del ML ecc andando anche a dire che attualemnte apputno è necessaria la verifica delal spepficia che il tool non può saperlo da solo se no


### 6.1.2
"La proprietà di astrazione gateway (D1.P6, Sezione~\ref{subsec:gateway-adapter}) disaccoppia i test dal gateway concreto installato nel deployment: i test \texttt{WHITE\_BOX} accedono al piano di configurazione tramite \texttt{BaseGatewayAdapter}, un'interfaccia astratta i cui metodi sono implementabili per qualsiasi gateway che esponga un piano di controllo interrogabile. Il vantaggio è che aggiungere supporto per un nuovo gateway richiede una nuova classe concreta senza toccare nessuno dei test che la utilizzano.

Il costo è che l'interfaccia può contenere solo ciò che è concettualmente generalizzabile a tutti i gateway che la implementano. Un controllo che dipende da una semantica vendor-specific, priva di equivalente in altri prodotti, non può essere espresso tramite l'interfaccia senza romperla: richiederebbe un cast al tipo concreto, che accoppia il test a un'implementazione specifica e invalida la garanzia di agnosticismo. Il design corrente rinuncia deliberatamente a questa possibilità: è il prezzo della portabilità multi-vendor."
-> quesot pezzo se non sbaglio labibamo gia introdotto nel capitolo 3 o nel capitolo 4 e quindi ah senso andare a refernzialro meglio, sneza rieptere tutto ma facendono un bree riassunto di cosa è rpesente qa quel riferiemtno diciamo,coemfacevamo di solito

"Un esempio concreto chiarisce la tensione. Kong supporta l'ordinamento esplicito dei plugin tramite il campo \texttt{ordering} della sua \gls{API} di configurazione, una funzionalità che può avere implicazioni sulla sicurezza: un plugin di autenticazione eseguito dopo un plugin di trasformazione del payload potrebbe ricevere dati già alterati. Verificare questa condizione richiede accedere a metadati di configurazione Kong-specifici che non hanno un equivalente strutturale in altri gateway. Un test che effettuasse questa verifica dovrebbe dipendere da \texttt{KongGatewayAdapter} direttamente, non da \texttt{BaseGatewayAdapter}, e non sarebbe portabile."
-> capsico ils enso ma suoan prprio male scritto con "effettuasse", cerchaimo di riscrivelro un po meglio ma ils enso è ababsatnza chairo

"La tensione non è risolvibile per via architettonica senza modificare il contratto dell'astrazione: è intrinseca alla scelta di preferire la portabilità multi-vendor alla profondità delle verifiche vendor-specific. Un deployment che usa esclusivamente Kong e non prevede mai di cambiare gateway potrebbe valutare se abbandonare l'astrazione per quei test specifici; un deployment che deve funzionare su Kong, AWS \gls{API} Gateway e Azure \gls{APIM} non ha alternativa all'astrazione e accetta consapevolmente la riduzione di profondità come prezzo della portabilità."
-> questo non mi apice molto, impossibiel che non ci siano delel altre altenative, non siamo cosi negativi coem se avessimo vlautato tutto ic sono sicuramente delel strade,ad esmepio potremmo apliare la gerarchia delle astrazioni, sotto base gateway creiamo tipo basekonggateay e baseawsgateway che sono el classi astartte che erditando da basegateway ma che fornsicno i contratti per i metodi aggiunti specifici; questa è solo un idea ch emi è ventua ora in 30 secondi per contestarti. non devi per forza metetre al mia ma valutare delle possibili via di svilupp valide

### 6.1.3
"\subsection{La Dipendenza dall'Admin API (D4.P5)}\label{subsec:limite-admin-api}"
-> andrei ad unire i primi due paragrfi dicendo tipo "... il sistrma è robusto ma non privo/assente di conseguenze ..." o comquenue liunirei che stiamo rpesentando irpboeam diciamo
ricordati il disocrso su milestone 1 che ti ho fattopriam che non va bene come riferimento

"Ne consegue che la copertura dell'assessment in questi deployment si riduce ai domini \texttt{BLACK\_BOX} e \texttt{GREY\_BOX}: D0, D1, D2, D3, D4 parzialmente, D7. I domini D6 (Configuration \& Hardening) e le verifiche \texttt{WHITE\_BOX} di D4 rimangono esclusi. La perdita non è silenziosa: il report documenta ogni \texttt{SKIP} con la motivazione \textit{"Admin API not configured"}, rendendo la riduzione di copertura immediatamente leggibile dall'analista."
_> non los criverei in modo cosi macchinoso e pesante


"Dal punto di vista operativo, la prassi industriale che affronta questo limite è l'accordo di accesso privilegiato: nell'ambito di un assessment formale, il team di sicurezza ottiene credenziali read-only alle \gls{API} di gestione del cloud provider per la durata dell'analisi. In questo modello, APIGuard Assurance si inserisce naturalmente: il campo \texttt{gateway\_adapter} nel \texttt{config.yaml} viene popolato con le credenziali e l'endpoint dell'adapter specifico per il provider, e la copertura si estende ai domini \texttt{WHITE\_BOX} senza modifiche al codice. La condizione è che quell'adapter esista: la sua implementazione per i cloud provider principali è identificata come priorità nella roadmap di Milestone~2."
-> questa cpsa è una ffermazioen forte, andrei una ttimo a spiegare meglio o a chairire la questioen delal modifica al config.yaml ecc, cioè un po come fuznoioan nel cocnreto questa cosa. nel senso, amemttiaml hce uno dispone di questo accordo, che andrebbe spieagt meglio cosa intendi nel cocnreto, cioè dovrebbe essere un accorddo che quali garanzie ti da? quali permesis e cose ti eprmetet di fare? andiamoa specificarlo nelal frase o almeno con unfoot note ma è importnate capire che assunzioni stiamo facendo. chairite el assuznioni andaimo a adire incocnreto come ce ne occuepremmo avendo quelle cose con la snsotra strututra ttuale. Un mix tra un cocnetto teorico del accorddo priivlegiaot e la ccnretizzazione

## 6.2
"La riproducibilità deterministica e i limiti strutturali discussi nelle sezioni precedenti non sono solo caratteristiche di un sistema accademico"
-> qua andrei a fare come nelle altre introduzione dei cpaitoi dove segnmo il riferiemnto aò capitolo dato che dici che la riroducibilità determinsitica e i limiti li abbiamo dsicussi nelel sezioni precedentei, standardizzerei come congli altri conil riferimento della sezione

!Definiscono insieme il perimetro operativo dentro il quale APIGuard Assurance è integrabile come componente di una pipeline \gls{CI/CD} industriale, e fuori dal quale quella integrazione richiederebbe adattamenti che la Milestone~1 non ha prodotto."
-> capisoc il senso ma non è scritto benissimo,a nzi, andrei a riformualrlo per metterlo giu meglio
ricordati anche cla cosa che dicevo priam che milestone 1 non lo userei comeriferimento, ne tiriamo solo fuori i contenuti

-> riscriverei tutta la inro per impsotarla meglio e farei sempre un controllo sul contenuto, per verificare che riassimuiamo bene il contenuto di questo capitoletto

### 6.2.1
"Il contratto tra APIGuard Assurance e la pipeline che lo ospita è espresso da quattro valori interi."
-> puoi nadare un attimo a leggere il codie delal repsoitory e i file drelativi della consocenza per vedre un attio in cocnreto come viene gestita questa cosa? cioè abbiamo effettivamnete solo quei 4 valori? come sono codficati nel codice? sarebbe piossibile aggiugnerne di altri? uante modifiche al codice comprota andare a riscrivere la seantica degli exit codes magari per adattarlo ad unao scenario dove viene integrato?
Le psiegazioni che fai sono abbastanza chaire ma vorrei questi chairimenti in più
-> spiegehrei anche meglio al question del exit code 10 con magari unmini esempio per cocnretizare

"La separazione tra \texttt{1} e \texttt{10} non è una sottigliezza tecnica. "
-> farse bruttisma come intro che è troppo corta e in più parla dicendo cosa non, delal sottigliezza tecnica

"La separazione tra \texttt{1} e \texttt{10} non è una sottigliezza tecnica. Dal punto di vista di una pipeline automatizzata, "il tool ha trovato una vulnerabilità" e "il tool non si è avviato" sono condizioni con diagnosi e azioni correttive completamente diverse. Trattarle con lo stesso codice di uscita scarica sull'operatore l'onere di interpretare i log per capire perché la build è fallita. Distinguerle con codici separati rende la diagnostica automatizzabile: un alert su exit~\texttt{10} indica un problema infrastrutturale nel deployment della pipeline; un alert su exit~\texttt{1} indica una regressione di sicurezza nel codice deployato."
-> questo qui lo capisco e il contnuto è gisuto ma mi chiedevo se, dato che voglio uana psiegzione sugli exit code che mettii nel primo paragrafo nonavesse sesno andare ad unire il tutto

"Dal punto di vista di una pipeline automatizzata, "il tool ha trovato una vulnerabilità" e "il tool non si è avviato" sono condizioni con diagnosi e azioni correttive completamente diverse."
-> quesot è abbastanza bello ma cercherei di unirlo i qualche modo a questo, nel sesno è una consgeuza diretta  sbaglio e risutla meglio in una frase colelgata naturalmente "Trattarle con lo stesso codice di uscita scarica sull'operatore l'onere di interpretare i log per capire perché la build è fallita. "

!un alert su exit~\texttt{10} indica un problema infrastrutturale nel deployment della pipeline; un alert su exit~\texttt{1} indica una regressione di sicurezza nel codice deployato."
-> ma scusa il codice 1 in realtà indica che lanalisi ha trovato almeno 1 errore, cosa centra con la regressione del mio codice scusa



"L'integrazione in una pipeline GitHub Actions o GitLab \gls{CI} non richiede nessun wrapper: il check sul codice di uscita è il meccanismo nativo di entrambi i sistemi."
-> quets farase non è molto chiara, sopratutto la parte del wrapper, metetrei poi una footnote su github actions e gitlab ci per spieagre un minimo cosa sono e perchè possonoe ssere itneressanti/rilevanti

"Un passo di pipeline che esegue \texttt{apiguard run -{}-config config.yaml} blocca automaticamente il merge della \gls{PR} in presenza di exit~\texttt{1}, senza che sia necessario analizzare il contenuto del report."
-> cosa inendi qua con blocca la Pull Reqest? cioè in che senso? detto cosi mi sembra una frase forte messa li a caso senza le giuste argomentazioni per sostenerla

"Il report rimane disponibile come artefatto per l'analisi post-hoc; il gate è il codice di uscita."
-> pure questa frase non è proprio chiara

"Lo sviluppo futuro già identificato per questa proprietà prevede un exit code~\texttt{3} (attualmente riservato) per indicare \texttt{FAIL} esclusivamente su test P2/P3, permettendo una politica di \gls{CI/CD} che blocca solo su violazioni ad alta priorità e lascia passare quelle a bassa priorità come avvertimenti non bloccanti. Questa granularità è rilevante per deployment in cui una violazione P3 (configurazione subottimale ma non critica) non deve bloccare un rilascio urgente."
-> partiamo dal fatto che non capsico a che prorpeità ti riferisci quando dici per questa prorpeità, poi in qualsiasi dei casi se c'è uno sviluppo futuro dobbiamo referenzialro, dicendo tipo Anticpando lo sviluppo futuro che vedremo nelal seione X o comuqneu una cosa del gerne, ormai hai capito coem voglio i riferimenti

exit code 3 attualemne riservato cosa singifca? -> ica nonlo usiamod el tutto che abbiamo solo 0 1 2 de 10? siamo chairi quando facciamoa ffermazioni
ma poi sei sicuro che non te la sei inventata questa cosa? nei miei docuetni che ti ho caricato o nelal repo ho mai scritto che per P2 e P3 usiamo un exit code diverso?
Cioè capisco il senso di quello che vuoi dire ma la butterei giu meglio, pria diciamo coem fuznioan ora. poi facciamo il chiarimento che ti ho cheisot su coem bisognerbeb fare pe fargli uan mdofiica e poi possiamo andare a dire che come future works sarebeb bello andare a dfinrie un exit code per livello di prirpità ad esempio, ma non sevre nemno un esempio cosi specifco, lo scopo è quello di dire che si potrebbe rendere iù graulari gli exit codes attiburndigli signiicati diversie più specifici -> cioè mi viene da dire che la cosa improtante sia constire la granuilarità futura, che idepne da coem attualemtne è implementato e quant è moificabile

Mi sa che qua tutto ilc apitloetto busogna proare a riscriverlo o comunque sistemarloa nando a cecare meglio nelal repo e nei file cosa dire

### 6.2.2

"\subsection{Quality Gate a Due Velocità: Fail-Fast e Assessment Completo (D4.P8)}\label{subsec:fail-fast}"
-> va fato qualche rifeirmento a qualche alòtra sezione o possiam iniziare diretatmente

"La combinazione dei due parametri, \texttt{fail\_fast} e il filtro sulla priorità minima (\texttt{execution.min\_priority} in \texttt{config.yaml}), produce un sistema di quality gate configurabile senza modifiche al codice. Un gate che esegue solo i test P0 in modalità fail-fast, da affiancare ai test di integrazione nella pipeline di merge, e un assessment completo su tutti i livelli di priorità schedulato settimanalmente sono due configurazioni distinte dello stesso tool sullo stesso \texttt{config.yaml} di base."
-> è scritto un po male, si autoreferenzia come se fosse un cpaitoloesterno quando la d4.p8 eè effettivamnete di qeusta sezione. lo riformulerei meglio il tutto
eviterei "distinzione è architetturalmente precisa"

"Con \texttt{fail\_fast:~false} (default), la pipeline esegue tutti i test attivi indipendentemente dagli esiti intermedi e produce un report completo. Con \texttt{fail\_fast:~true}, l'engine interrompe la Phase~5 alla prima violazione confermata su un test di priorità P0: i test rimanenti non vengono eseguiti, il \texttt{ResultSet} contiene solo i risultati prodotti fino a quel punto, e il processo termina con exit~\texttt{1}. La condizione di interruzione include anche \texttt{ERROR} sui test P0: una verifica perimetrale incompleta per malfunzionamento del tool è trattata con la stessa urgenza di una violazione confermata, perché l'incertezza sul controllo perimetrale è operativamente equivalente alla sua assenza."
-> spiegare meglio sia coem avviene questa interruzione conil fail fast che anche lesempio. non è che il contenuto è sbaglaito ma so hce lo ptoremmo scrivere meglio e conqualche dettaglio in più
-> bisognerebeb più che altro far cpaire il perchè è utile avere il fail fast, cioè che vantaggio ci da aver agiguntoa nceh quel'opzione e in che scenari può tornae comdoo avere uan cosa del geren, inq uesto modo il discorso si mantiene lineare e gisutifica la presenza di un tale meccanismo e potrebbe essere usato come colelgamento naturale per riamdnare anche qua ai future works.
se non sbaglio nel corso di questocaitolo ci ono fari punti in cui si dirà che nel futuro ecc ed è opportuo che tutti utilizzino il riferiemnto alal sezione dei futurework con le regole che ci siamo definit inmerito ai riferimenti

"I due profili configurano in modo naturale due scenari d'uso distinti. Il profilo fail-fast è ottimale per i gate sulle \gls{PR}: se un test~1.1 rileva 74 endpoint privi di autenticazione, non è necessario attendere il completamento dei restanti 17 test per decidere di bloccare il merge; l'interruzione immediata riduce il wall-clock del gate da circa 4'50'' a pochi decine di secondi nel caso peggiore. Il profilo completo è ottimale per gli assessment periodici schedulati su rami stabili, dove la completezza del report ha più valore della velocità: ogni dominio deve produrre evidenza, e la distribuzione dei finding per dominio è l'input per le decisioni di remediation del team di sicurezza."
-> questa mi smebra un po la spieagzioen che ti cheidevo, il conenuto è abbastanza chairo er me ma non è espresso benissimo per un lettore, sulal base delle critiche della frase priam cercherei di ristrutturare pure questo, oltre al contneuto per capire anche la psozione se alscialro coem apragrafo a se o integarlo in uno di quelli che lo precedono

Forse ha senso emttere allinzio come introduzione che ci sono queste due modalità di esecuzione.

Rinfreschiamo un po coem avviene normlemente con il fail fast a false, mandando il richiamo alal sezioen che lo accenava nei captioli 3 o 4 opportuna e poi si ptrebbe dire che lalta modalità è questa del fail fast ed introdurla come lternativa e con la logica che ti dicevo priam di esprrre chairamente il problema e cosa questa soluzione ci fornsice, il eprchè abbiamo deciso di farlo cosi

Il contenuto grosso modo mi smebra corretto però, fai un controllo con i fiel delal repo e delal consocenza per verificare che quello che diciamo sia effettivmaente cosi, cioè che lo abbiamo effettivmanete impeentato inqeusto modo

"La combinazione dei due parametri, \texttt{fail\_fast} e il filtro sulla priorità minima (\texttt{execution.min\_priority} in \texttt{config.yaml}), produce un sistema di quality gate configurabile senza modifiche al codice. Un gate che esegue solo i test P0 in modalità fail-fast, da affiancare ai test di integrazione nella pipeline di merge, e un assessment completo su tutti i livelli di priorità schedulato settimanalmente sono due configurazioni distinte dello stesso tool sullo stesso \texttt{config.yaml} di base."
-> qua sembra che si usuppone che il fail fast fuzniona solo sui P0, è effettiamnete così? se è cosi dobbiamoa ndare a scrivelo priamq uando lo intrudiciamo che funziona inq uesto modo e che si porebeb cambiare facendo X ecc

"affiancare ai test di integrazione nella pipeline di merge" -> cosa intendi con test di integrazionee epipeline di merg? semrba che stai facendo delel assunzioni su un contesto senza renderel chaire e sorpatuttuo senza una segazione soltia iniziale sul fail fast

" sono due configurazioni distinte dello stesso tool sullo stesso \texttt{config.yaml} di base."
-> questa ciosa semrba un po il punto centrale, va forse protato allinzio di quest cpaitletto, unpo come motivazione dle perchè di questo fail fast, dop o aver speagto come è configurato e coem si potrebeb modificare ad esempio pere farlo fallrie su altre condizoni ecc si presenta poi ilf atto che inq uesta configurazione il tool ha una funzionalità e utilizzo distino dall'essere usato come assesment normale.


-> mi sa che questo cpaitoletto va una attimo riscritto


### 6.2.3

"Il box gradient discusso nella Sezione~\ref{subsec:box-gradient} non è solo una tassonomia metodologica. Nei deployment industriali, la disponibilità dei diversi livelli di privilegio varia sistematicamente in funzione del contesto organizzativo in cui il tool viene eseguito."
-> va bene fare la citazione al capitolo precedente ma come al solito non è nello andare a introdurre un paragrafo dicendo cosa non è. la prima e la secona farse andrebberp unite in una unica, dovee si inizia con il riferimentoalla sezione del cpaitolo 3 e/o 4 che lo introduce e si concretizzza poi nei deplyment industrili.
COme prima è come se il conteto industriale sia l argomentazione a favore che gisutiifca questa scelta e dimostra che è pensato per u ottica futura, quindi è bello perchè il fio lofgico diveta strutturato andando a prendere e cose che abbiamo definito o  presentato prima, ed essendo ilc apitolo delel discussioni argomentndolo con la visione insudtriale. 
se non erro ne abbiamo aprlato sia nel capitolo 3 che nel capitlo 4, fai una ricerca e vedi bene dove avviene

"In un contesto di integrazione continua su rami di sviluppo, i token di autenticazione per i ruoli configurati sono tipicamente disponibili come segreti di pipeline, e la Admin \gls{API} del gateway è accessibile dall'interno della rete di staging: tutti e tre i livelli del box gradient sono raggiungibili, e l'assessment copre l'intera matrice dei domini. È lo scenario di massima copertura."
-> questo non è per nulla chiaro, spiegare meglio cosa si intende, cioè suppongo tu voglia portare lesempi in cui tutto è disponbiile ma dobbiamo andare una ttimo a definrie cosa si intende concretamene contutto disponibile, rifacendosi ai livelli de graident box itnrodotti in un caitol prima e concludendo con la copertura piena del sistema analizzato

"In un contesto di verifica su ambienti di pre-produzione condivisi tra più team, le credenziali con privilegi amministrativi potrebbero non essere distribuite a tutti gli esecutori della pipeline per ragioni di governance. In questo scenario, il tool opera in modalità \texttt{GREY\_BOX}: i test \texttt{WHITE\_BOX} producono \texttt{SKIP} con motivazione esplicita, e l'assessment copre i domini che non richiedono accesso al piano di configurazione del gateway. La riduzione di copertura è documentata nel report, non silenziosa."
-> inanziutto non opera solo in contesto grey box ma anhe black box, in altri trmini esclude il livello white. poi mi smebra di vedere che ora ci sono 3 paragrafi che protano un esempio di come mai si passa da comeplto a grey e balck a slo balck. lo risrivrei un attimo meglio, nel senso bigosna dichairere allinzio di uqestazsezione che andremo a vedre ad esempio come questi livelli sono infleunzati dai deplyemnt indusrtriali condegli esempi cocnreti dei 3 scenari speigati meglio. in queto modo dovremmo risucire a rirpendere il discorso del capitolo 3 o 4, conrolla con esattzza quale capitolo effettivmaent ne parla, che introduce i vari lvielli di gradient e la questioen che un test dipende da dei prerequsiit, so che il contenuto che c'è in questo apragafo è una rgoemtno che ne abbiamo gia discusso e rpesentato durante la tesi, cerchiamo dove ne palraimo, leggiamo csa diciamo i e siamo sicuri cdi nonandare a ripetere le cose, ma aporle come se fosse una disucssione che va ad argoemntnare il perchè di quelal scelta, sostendndo le cose che dicevamo quando labbiamo rpesentata (cahp 3 o 4) e andando poi a protare questa nuoa sfaccettatura cocnreta dei deplyment e dei differenti livelli.
Mi ricordo però che di questa cosa ne palraimo anche in un altro capitolo quindi assicuriamoci di non riepte cose e di fare i riferimenti gisuti

"In un contesto di red team o penetration test esterno, solo l'accesso di rete al target è garantito. Il tool opera in modalità \texttt{BLACK\_BOX}: i test \texttt{GREY\_BOX} e \texttt{WHITE\_BOX} producono \texttt{SKIP}, e l'assessment si concentra sui controlli perimetrali che un attaccante esterno senza credenziali potrebbe sfruttare. Questo scenario è anche il più informativo per valutare la postura perimetrale del sistema: la copertura ridotta è il dato, non una limitazione da correggere."
-> questo paragrafo per ovvie ragioni verrà modififcato sulal abse di quelli rpecedenti, anch se appunt il senso che vuole espriemre è giusto

"Nessuno di questi tre scenari richiede una versione diversa del tool o un profilo di configurazione strutturalmente distinto: la variazione è nell'insieme di credenziali fornite nel \texttt{config.yaml} e nel campo \texttt{gateway\_adapter}. Il tool adatta la propria copertura alle precondizioni disponibili senza che l'operatore debba scegliere esplicitamente quale "modalità" attivare. La scelta è nella configurazione; la degradazione è automatica e documentata."
-> questa csa rirpende molto i cocnetti teorici che dicevamo nei  chap 3 e 4, non so se ha senso metterlo qua come conlusioen di questo pezzettino, icoè è gisuto ma è molto uan ripetizione, piuttosto non ha più senso metterlo allinzio? cosi si afferma che il tool si adatta autoamticamente e si protano i 3 esempi come possibili riduzioni di scenario?



## 6.3

"Le traiettorie di sviluppo di APIGuard Assurance si articolano su due scale temporali distinte che richiedono trattamenti separati. Le estensioni operative della Milestone~2 sono conseguenze dirette dell'architettura corrente: dipendenze architetturali già identificate, connector già progettati e non ancora implementati, domini già predisposti nella tassonomia e non ancora coperti. Non richiedono scelte di design nuove, solo implementazione. Le traiettorie di ricerca avanzata appartengono invece a una categoria diversa: direzioni che l'architettura attuale abilita per costruzione, ma che pongono problemi aperti, richiedono analisi formale prima dell'implementazione, e in alcuni casi costituiscono oggetti di ricerca indipendenti. La distinzione non è di importanza ma di natura: confondere le due categorie produrrebbe impegni di rilascio su lavoro che richiede ricerca.
"
-> come detto prima sicuraemnte non possiam ousare mielstone 1 come punto di riferiemnto citabile nel testo coem se fosse una veità assoluta, cioè ha sneso usarne il conmtenuto e riprotarlo dicendo come effettivmanete è ma non usare come fonte assouta quasi citabiele. duqne qeusto epzzo va riscritto.

La sezione poi va a riassuemre il cotnnuto di questo cpaitolo molto brevemnte come als olito, con una frase ciascuno. Dato che ora siamo andati a rendere solidi e satbili i capitoli 3 e 4 magari sono cambaite alcune cose, abbiamo amggiori dettagli su cose che abevamo gia definito, ne soperiamo di altre cose future o ne vogliamo rimuovere qualcuna. quando avevamo scritto questa sezione eravamo ancor aagli albori ed era tutto provvisorio, ti chieod quindi ora ti fare una nuova valutazione con lobbiettivo di andare a definrie la sezione degli sviluppi futuri. non sto dicendo che il contneuto attuale non va bene a pririo ma sto dicendo ch eessendo ch ele cose sono diventate più stabili ha senso anare a fare un controllo aggiuntivo aggirnato allo syato dei capitoli metodolog ae implementzione (3 e 4),
Fatto quel controllo dovresti avere una super consocenza sul topic della mia tesi quindi dovresti essere in grado di fare delel query opportune per cercare sul web delle poissibli considreazioni extra che non avevamo vlautato (ovviamente devono arrivare da fonti affidabili, non da blog tipo medium) cosi poi dovremo avere un quadro compelto, sia con gli dviluppi futri ch econ le prospettive cocnret .

### 6.3.1
"\subsection{Roadmap Milestone~2: Estensioni Operative}\label{subsec:milestone2}"
-> come detto priam non usere il noem milestone in quesot modo lo chiamerei proprio apunt come prossiam tapa da raggiugnere, e esetnesini ecc, o comuqneu anhce mielstone futura ma non con lccezioen che abbiamo suato finora di riferimento al mio documento

"\paragraph{Domain-5 Observability.}
Il Dominio~5 è l'unico dei sette domini di assurance non coperto da nessun test nella Milestone~1. La numerazione nella tassonomia è riservata intenzionalmente, come dichiarato nella Sezione~\ref{subsec:domini-tassonomia}. I test~5.1 (audit logging) e~5.2 (alert real-time su eventi anomali) sono già specificati nella metodologia; la loro implementazione è dipesa dalla necessità di estendere il testbed con un log aggregator (Elasticsearch o Loki) e un sistema di alerting (Alertmanager o un mock PagerDuty) nel Docker Compose. Entrambe le componenti aggiuntive sono architetturalmente isolate dal tool: lasciano intatto il core, richiedendo esclusivamente l'aggiunta dei servizi nel testbed e l'implementazione dei due test come \texttt{WHITE\_BOX} con accesso alla Admin \gls{API} del log aggregator."
-> spiegare meglio, cioè perchè servirebbero il log aggregator e un sistema di allerting,cioè il contnuto  gisuto ma scriviamolo eglio e ponaimolo melgio. si deve capire che non è che non labbiam implenenato perchp siamo svogliati ma che cerano delle diepdneze magigori da soddisfare e erano di improtanz aminroe quindi ha senso metetrel qua come cose future di sviluppo 

"\paragraph{jwt\_tool connector e Phase~C del DAG.}
Il \texttt{jwt\_tool} è classificato Categoria~A nella roadmap: la sua assenza blocca un'intera classe di test. I test~1.2 (validazione strutturale del \gls{JWT}), \texttt{ext.1.2.jwt\_tool} (verifica crittografica del \gls{JWT}) e \texttt{ext.1.3.jwt\_tool} (expiry check) dichiarano \texttt{depends\_on~=~["1.1"]} e sono schedulati in Phase~C del \gls{DAG}: non possono avviarsi finché il test~1.1 non ha prodotto un token valido nel \texttt{TestContext}. L'implementazione del \texttt{JwtToolConnector} sblocca questa intera fase e completa la copertura del ciclo di vita delle credenziali nel Dominio~1. La struttura del \gls{DAG} è già predisposta e accoglierà i nuovi test senza interventi sull'ordinamento topologico."
-> sei sicuro di nona ver atto un po troppe assunzioni qua? io nonho ancora dichairato il test ext.1.2 ne ext.1.3 quidi andiamoa  mettelo inottica futura, che se si impekentao quei test, secondo la pianificazine che ho fatto, serbirebeb il conetcot r il test 1.1 come dipendenza, specificare il perchè di queste cose. so che si può riscrivere meglio anche se il cotnenuto è gisuto
poi non so se ne farei cosi tanta imprtanz solo sul jwt, cioè ce en sono vai di conenctor di categoria A ch enon abbiam imeetnato, piuttsot palrarei ingeneaale di quelal quesitoen, che andrebbe ad amplaire lorizzonte id coeprtura de tool ecc, che è gia preispsoto, e un esempio poi lo potresti concretizzare sul jwt. a palrare solo del jwt sebra poi di andare a trascurare anche tutte le altre cose che potrebebro essere impleentnate e che abbiamo effettivmante ainficiato e fatto un lavoro sopra

"\paragraph{BOLA/IDOR con OFFAT e Domain-2 esteso.}
I test~2.2, 2.3, 2.4 e~2.5 estendono la copertura del Dominio~2 (Authorization) oltre il test~2.1 attualmente implementato. I test~2.2 e~2.3 prevedono un connector opzionale Categoria~B con OFFAT, che genera dinamicamente test per Broken Object Level Authorization e per accesso a risorse di altri utenti derivando i path direttamente dalla specifica OpenAPI. La generazione dinamica è architetturalmente coerente con la proprietà di discovery dinamico discussa nella Sezione~\ref{subsec:discovery-impl}: OFFAT analizza la specifica e produce un insieme di probe che il connector traduce in \texttt{ConnectorResult}. Il valor aggiunto rispetto ai test nativi è la capacità di testare sistematicamente tutti gli endpoint parametrici con coppie di identità distinte, senza che l'autore del test debba enumerarli manualmente."
-> spiegare meglio e colelgarlo al discorso generale che ci sono vari conenctor o tool che non sono stati impelentnati, tra questi cè questo e si fa questo esempio ma speiagto meglio


"\paragraph{Vegeta per Race Condition e test~7.3.}
Il test~7.3 verifica la vulnerabilità \gls{TOCTOU} (Time-Of-Check Time-Of-Use) su operazioni critiche: la finestra temporale tra la verifica di un'autorizzazione e l'esecuzione dell'operazione che la presuppone. Rilevare questa classe di vulnerabilità richiede l'invio di richieste simultanee con sincronizzazione sub-millisecondo. Il \gls{GIL} di Python rende inaffidabile questo requisito: lo scheduling del garbage collector introduce jitter sufficiente a sfasare la finestra temporale critica. Il \texttt{VegetaConnector} risolve il problema delegando la generazione del carico a Vegeta, scritto in Go con goroutine native: il flag \texttt{-rate=0~-max-workers=N} lancia $N$ goroutine in parallelo con sincronizzazione last-byte, producendo la finestra di concorrenza che il test deve osservare. Lo stesso connector è riutilizzabile dal test~4.1 per il load testing del rate limiting, in conformità con la proprietà di condivisione dei connector discussa nella Sezione~\ref{subsec:connector-injection}."
-> questo mi paice ed è ababstanza chairo, vedere se ensi che si può esprimere un po meglio e andare ad isnerirlo nel discorso generale delle cose amncanti se ha sneso 

"\paragraph{interactsh per SSRF blind.}
Il test~7.2 attualmente implementato rileva le vulnerabilità \gls{SSRF} che producono una risposta osservabile nel canale normale: il server effettua una richiesta verso un \gls{URL} interno e la risposta riflette il contenuto recuperato. La classe di \gls{SSRF} blind, in cui il server effettua la richiesta verso un server esterno controllato dall'attaccante senza produrre nessun output osservabile nel canale normale, richiede un oracle fuori banda. Il \texttt{InteractshConnector} fornisce questo oracle: registra un \gls{URL} controllato su un server \textit{interactsh} remoto, lo inietta come parametro nel probe, e verifica se il server ha effettuato una richiesta verso quell'indirizzo. L'evidenza non è nella risposta \gls{HTTP} al probe, ma nel callback ricevuto dal server interactsh. L'architettura del connector è già definita come \texttt{BaseSubprocessConnector}; l'implementazione è la sola dipendenza mancante."
-> è scritto veramente in modo contorto andare a esprieme in modo più chairo


ora poi sono finite le cose che hai messo come Estensioni Operative, ovviamentew queso elenco non è compelto, hai scelto tu a tua discreione cosa rirpotare, coe mai hai scelto questi paragrafi? siamo sicuri che isano i più di vlore? siamo sicuri che le coe non potrebber essere ragrgeupapte come in macro categorie per andare a rendere quasi compelto queste estensioni oeprative? magari conun po meno di dettagio per ogi cosa ma valutanodole tutte? sto olo proponendo ma a me quando si fanno glielenchi e non sono compelti mi puzza semrpe se non lo si dice. non sono per nulal convinto di queta sezione sulle estensooni operative, cioè oei hanno senso queste, am con che criterio sono li se ce ne sarebebro anche altre di cose oeprative da fare?

come altra cosa non possiamo iniziare uan sezioen con subito tutti questi paragrfi a modi elenco di cose senza un paragrfo di introduzione che presenta una ttimo la situaionze che si andrà ad affrotnare nella sezione

### 6.3.2
"\subsection{Traiettorie di Ricerca Avanzata}\label{subsec:ricerca-avanzata}"
-> ricerca avzata non vuole dire niente in academia ed è un po un termine altesso leggednolo csi a primo impatto

come altra cosa non possiamo iniziare uan sezioen con subito tutti questi paragrfi a modi elenco di cose senza un paragrfo di introduzione che presenta una ttimo la situaionze che si andrà ad affrotnare nella sezione

"\paragraph{Plugin System per Test di Terze Parti (D2.P1).}
Il discovery dinamico via \texttt{pkgutil} descritto nella Sezione~\ref{subsec:discovery-impl} è già tecnicamente compatibile con moduli di test contribuiti da terze parti: un package che aggiunge una directory al \texttt{sys.path} e rispetta le convenzioni di nomenclatura viene scoperto automaticamente senza modifiche al core. La barriera non è tecnica. È di governance: un plugin system aperto richiede una specifica pubblica del contratto di \texttt{BaseTest}, un meccanismo di versioning delle interfacce che garantisca compatibilità al variare del core, e un processo di validazione per i plugin distribuiti che voglia portare l'etichetta di compatibilità con APIGuard Assurance. Lo scenario concreto già identificato è un package \texttt{apiguard-tests-graphql} che aggiunga test specifici per endpoint GraphQL, un dominio non coperto dall'architettura REST-centrica della Milestone~1. Questo scenario è integrabile senza toccare nessuna riga del core attuale; la ricerca necessaria riguarda la specifica del protocollo di estensione."
-> quesot pezzo non ha proprio senso inizi aprlando del discovery dove va be lo riassumi upure male, vattia legere ora i cpaitoli 3 r 4 e riscrivi il pezettino, dato che apputno c'è differenza tra test antivi e test esterni con connector
Frase "la abrrierea non è tecncia. è di governace:" è veramente oscena, troppo corta e ocns eparazioen sneza senso, ma leggendo le mie regole che ti carico lo saprai benissimo
-> va bene dire cosa ovrebbe essere presente pe rfar si che i tool esterni possano predispsoi compatibili (ache se in conreto non capsico cosa itnendi e dov vui andare a parare).
la wuestioen di graphql mesa qua cosi nelal discovery delel cose estenre la trovo comepltamente senza senso. e bho trovo anche sena senso andare d imporre agli altri test di diventre comaptibili conil mio quando leggedo i captioli 3 e 4 saprai già che possiamo andae ad agigugenre test nuovi (interni ed estern( e connector senza farsi tanti problemi, quindi con i connector integriamoq ualsiais cosa di terze aprti. non capsic veramente cosa vuoi itnendere tu perhcè per me non ha senso sto apragrafo ma sper che con la tua spiegazine ci chiariremo))

Oppure tu intendi tipo di predisporre apiguard assurance coem un tool fatto a plugin buidlabili? che quind uno parte dalla struttura del core e poi in un qualche modo che appunto andremoa  definrei poiche chaive di questo future work ci permette di andare a definrei quesit plugin per cose specifiche come GraphQL, OASP e gli altri possibili protocolli che ti ho presentato nei due file teorici de capitolo di staot dell'arte (2-Background_compact.md e 2-Background_extensive.md)
detto inq uesto modo ha senso perchè è coem se si pedispone un sistema per fondarsi inmod modualre, dove quello ceh abbiamof atto roa potrebeb esser eun modulo API REST oppreu duemoduli API rest antive e API rest eternal e poia ggiugnere altri varimoduli rendendo questo tool compeltamente epsandibile con un po quello che si vuol, nel senso uno potrebber prenderlo cosi com'è, segurie i contratti che ci sono e svilupapre un pluigin che testa altre cose, am che ammagari epr il suo scopo speciico gli servono le ose sulle api che ho io tipo
spieghiamo meglio eprchè c'è un po di confusione


"\paragraph{Parallelizzazione Intra-Batch (D2.P2).}
La struttura a batch del \gls{DAG} è già parallelizzabile per costruzione: i test all'interno di uno stesso batch non hanno dipendenze reciproche e possono essere eseguiti concorrentemente. Introdurre un \texttt{ThreadPoolExecutor} nella Phase~5 dell'engine è una modifica localizzata allo scheduler, senza impatto sul design dei singoli test. La ricerca necessaria riguarda due problemi di thread-safety che richiedono analisi formale prima dell'implementazione. Il primo è l'\texttt{EvidenceStore}: il metodo \texttt{begin\_test()} apre un file in append e lo mantiene aperto per la durata del test; con più test concorrenti che chiamano \texttt{log\_transaction()} sullo stesso \texttt{EvidenceStore}, le scritture devono essere serializzate senza introdurre un lock globale che annulli il vantaggio della parallelizzazione. Il secondo è il \texttt{TestContext}: il canale dei token è condiviso tra tutti i test e i test \texttt{GREY\_BOX} in Phase~A che chiamano \texttt{acquire\_tokens()} concorrentemente potrebbero produrre login multipli per lo stesso ruolo, violando la proprietà di idempotenza descritta nella Sezione~\ref{subsec:auth-layer}. La complessità della soluzione impone l'analisi formale come prerequisito all'implementazione."
-> questo ha sneso, edere solo se lo si riusicrebbe ad espimere meglio e magari in modo un pelo più coinciso senza perdere conenuto informativo

"\paragraph{Auto-Seed dall'OpenAPI Spec (D2.P7).}
Il path seed configurato manualmente in \texttt{config.yaml} è la principale sorgente di attrito nell'onboarding di un nuovo target: l'operatore deve identificare valori concreti per ogni parametro di path prima che i test producano risultati interpretabili anziché \texttt{INCONCLUSIVE\_PARAMETRIC}. Una versione futura del \texttt{seed\_generator} potrebbe derivare il seed automaticamente cercando i campi \texttt{example:} e \texttt{x-example:} nella specifica OpenAPI per ogni parametro parametrico. La specifica OpenAPI~3.0 ammette entrambi i campi come annotazioni non vincolanti; la loro presenza nei target reali è disomogenea ma non trascurabile. L'auto-seed ridurrebbe il lavoro di configurazione iniziale senza modificare la logica di test: \texttt{path\_resolver.py} consumerebbe il seed con la stessa interfaccia, indipendentemente dalla sua origine."
-> questa future work è proprio pover ae senza senso, piuttoto andrei a dire uan cosa legata al contract driven dicendo che potremmo si aprtire dala specifica che abbiamo ma in qualche altro modo crearne una che la compelta, mutabile e che si aggoran durante il test, se ad esmepio la shadow api trova degli endpoint, quelli poi verranno suati per quell successivi e cosi via. al questoen del seed non ha molto senso mettere gli esempi. biogna andare a metetre cose chesi asa che esisotno concretaente sul server e nn c'è modo di risolverlo penso


"\paragraph{Inferenza dei Contratti tramite \gls{ML}/\gls{LLM}.}
Questa è la traiettoria più ambiziosa e la più distante dall'implementazione. Affronta direttamente il paradosso del Ground Truth discusso nella Sezione~\ref{subsec:limite-ground-truth}: se la specifica OpenAPI può essere obsoleta o incompleta, un sistema che inferisce il contratto dall'analisi del traffico reale renderebbe il tool indipendente dalla qualità della documentazione fornita. L'approccio richiederebbe l'osservazione passiva del traffico verso il target per un periodo sufficiente, l'inferenza statistica degli schemi di request e response attesi, e la costruzione di una specifica sintetica da usare come oracolo in assenza di quella formale. Le sfide aperte sono note nella letteratura sul contract-driven testing: la correttezza dell'inferenza degrada in presenza di traffico sparso, i falsi positivi generati da specifiche parziali possono superare quelli eliminati, e la privacy del traffico osservato introduce vincoli legali in contesti regolamentati. Nessuna di queste sfide è risolta dall'architettura attuale: richiedono ricerca e validazione sperimentale indipendente, non un'estensione dell'implementazione esistente."
-> va bene voler applciae il ML a quest tool ma non lo farei inquesto modo, non mi sembr astuto analizzare il raffico e fare delel previsioni cosi, cioè si ma non mi apice tantissimo. nel senso quanto è effettivmanete utie quella tu prosptoa? nonpossiamo vlautare se sempre tramite ML non ci siano altre prospote più valide?