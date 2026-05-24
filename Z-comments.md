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

