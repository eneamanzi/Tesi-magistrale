# 7

"Tre tensioni hanno orientato le scelte di questo lavoro:" -> farse proprio brutta

"l'incapacità degli approcci tradizionali di rilevare vulnerabilità semantiche nelle \gls{API} REST, l'assenza di strumenti che combinino agnosticismo applicativo con testing guidato dal contratto formale, e la non confrontabilità dei risultati di un assessment tra esecuzioni successive."
-> fare un controllo e verificare che siano effettivamente solo queste le cose. consulta sia la repo che i file che la tua ocnscenza intern per cpair ebene cosa dire e metetre qua

"Il framework sviluppato risponde a ciascuna con meccanismi architetturali verificabili empiricamente. Questo capitolo ripercorre quella risposta, ne valuta la portata effettiva e colloca il contributo nel contesto più ampio della sicurezza come proprietà misurabile del processo di sviluppo." -> non mi apcie tanto la forma cioè è ilc apitolo delel conclsuoni dove si tirano le somem e si cnulde ilalvoro. questa introduzione non è per niente belal e adaguata o comuqnue allaltezza rispetto alel altre cose che abbiamo scritto

Poi prima di inziiare, siamo sicuro del conetnuto di qusto cpaitolo? cioè delle varie sezioni che lo compongono' è ciò che s mette in un capitolo consluvo di uan tesi amgistrale di alto livello? disctiaomne un atitmo e vediamo se c'è qualche mdofiica strututrale ce dobbiamo andare a fare

Una volta onfermato qeusto discutiamo dle resto

Poi come ti dicevo priam tieni conto che il cpaitoo 1 e 7 sono altamene colelgati, nel apitolo 1 aniamo a a definrie tramite dei paragrfi con i vari gaps e obiettivi e qua dentro inqeusta sezione, coem di norma fare in uan tesi, bisognrbebe rierendere quelle csoe dellitnroduzione per tirare un p le somem, nelal mia tesi trienanle lo faceamo cosi tipo "L'Obiettivo \nameref{o1: estensione ae} di questa tesi, che va a risolvere il primo Gap \nameref{g1: generalizzabilità}," -> cioè dove possibiel si cercava un colelgamento tra gli obbietivi e i gaps per definire un po la logic delal tesi e tutto

Dunque adobbiamo andare a rispettare qquesta pratica 

dato chq euto capitolo di consluioni è strututrato in modo diverso da quello delal mia triewnnale (è fatto emglio qeusto) dobbiamo caprie bene in che putno andare a metere quest aocsa di gaps e obbiettii o se è necessaia uan nuova sezione apposita

## 7.1


\section{Sintesi del Lavoro e Risoluzione del Problema Iniziale}%
\label{sec:sintesi-risoluzione}
%  -> questo pezz a me a intuti sembra il puntt dve dvremm fare qui riferimeti al cpaiotlo 1 e non al capiolto 3 e 2 come attualemnte presente, andrebeb anche strututrato in modo diverso come ti dicevo prima, per ora queto cpaitolo non lo leggo. dopo che labbiamo ristrutturato sulla base della riistrututrazione del capitolo 1 ti do un commento e modifichiamo/sistemiamo il contenuto, falro ora non avrebbe senso

## 7.2

"I contributi di questo lavoro si articolano su due piani distinti che si rinforzano senza sovrapporsi: la formalizzazione metodologica, che produce strumenti analitici riutilizzabili indipendentemente dall'implementazione specifica, e la realizzazione ingegneristica, che dimostra la concreta praticabilità di quella metodologia con le garanzie di qualità richieste da un artefatto industriale."
-> queesot molto bello, ha questa doppai valenza sia teoria che pratica ed è olto bello da valorizzarlo, se ci sono altre cose sensate da dire le agigugnerei, semore comeintroduzone, il dettaglio verrà dopo

"La tassonomia a otto domini di assurance, descritta nella Sezione~\ref{subsec:domini-tassonomia}, definisce cosa misurare: organizza la superficie di sicurezza di un'\gls{API} esposta tramite gateway in categorie semanticamente distinte, ciascuna con le proprie precondizioni di accesso e i propri criteri di valutazione, applicabile a qualsiasi assessment strutturato indipendentemente dagli strumenti impiegati. "
-> quesot qui non è prorio vero, cioè quelal divisoe è teorica in amcroacateogri ma nonè che preclude speifiche dei test o meno, quelle sono itnerne a ongi singolo test, consulta la repo e la consocenza ch ti h caricato epr cofnrma requesta cosa
Essendo un cpaitolo di consluusioni cercherei di esprimere in modod chairo queti contributi, andando inanziutto a verificare che sono solo questi 3 e non ce ne sono anche altri da dire che potrebebro essere improtanti outile e abbiamo trascurato e poi forse è il caso di metterli o coem paragrafi se sono molto grandi opprue come unelenco? tu cosa ne pensi? mi da lidea che sono un po p iù evidenti almeno quali sono i tot contributi aportati

"Le trentanove proprietà architetturali distribuite su sette domini, raccolte nella Tabella~\ref{tab:property-index} e trattate nei Capitoli~\ref{chap:methodology} e~\ref{chap:implementation}, definiscono come costruire il sistema che misura: un vocabolario di design che cattura le decisioni architetturali con le loro motivazioni e i costi accettati, riutilizzabile come modello per sistemi analoghi."
-> quesot epzzettino qua è u po da rivedere dopo tutti i cambiamenti che abbiamo fatto ai captioli priam diq uesto

"Sul piano ingegneristico, il design di un assessment engine deterministico basato su \gls{DAG}, descritto nella Sezione~\ref{subsec:dag}, costituisce un contributo architetturale autonomo: la struttura a batch con risoluzione topologica garantisce la correttezza semantica dell'ordine di esecuzione indipendentemente dal numero e dalla natura dei test, una proprietà che uno scheduler a priorità statica non raggiunge perché non possiede la rappresentazione delle dipendenze tra test. La codebase che implementa questo design è stata validata empiricamente contro un target reale: su Forgejo~14.0.3 esposto tramite Kong~3.9 DB-less, due run indipendenti hanno prodotto risultati identici per tutti i contatori aggregati (\texttt{9~PASS\,/\,7~FAIL\,/\,2~SKIP\,/\,0~ERROR\,/\,98~finding}, delta wall-clock inferiore allo 0,3\%), come verificato nella \hyperref[sec:coverage-idempotenza]{Sezione~\ref*{sec:coverage-idempotenza}}. La qualità del codice è verificabile per analisi statica: 0~errori mypy in strict mode su 90~file sorgente, come documentato nella Sezione~\ref{subsec:dual-layer-type-safety}; un tool che si propone come strumento di assurance applica alla propria implementazione lo stesso rigore che applica ai target che valuta.
"
-> qua rieptiam un po troppo dei contenuti che abbiamo gia detot bene negli altri cpaitolid elal tesi, cotnrolal pure tu dove. dovremmoc ercare di esprieme qmelgio qeusto controibuto inggneristico e vedere se ce ne sono anche altri che magaria bbiamo trasucrato o ci siamo dimenticati di riprotare
Pure qua come priam ha forse senso metterli inmod pià visiil inmodo che si vedano tutti, magari con un elenco. fai una belal analisi per veriicare se ce qualcosa che abbiamo trascuato magari


## 7.3

"La differenza tra il penetration testing tradizionale e l'automated security assurance è epistemica, non di scala."
-> non mi paice coem frase cona cneh il no, la riscriverei

"La differenza tra il penetration testing tradizionale e l'automated security assurance è epistemica, non di scala. Il penetration testing produce un referto: un'osservazione puntuale condotta in un momento specifico, da un operatore con un insieme specifico di conoscenze e tecniche; rieseguire il test in condizioni nominalmente identiche produce output confrontabili solo per convenzione, perché quella variabilità è incorporata nel metodo."
-> non ho capito cioè perchè dovrebbe essere un problema riseguirlo con le stesse cose, è scritot veramente in modo poco chairo e fuorviante osi

"L'automated security assurance produce una garanzia: lo stesso assessment, rieseguito con la stessa configurazione sullo stesso target, produce risultati deterministicamente identici, verificabili da chiunque senza ricostruire il processo mentale di chi l'ha condotto."
-> cioè cosa dovrebeb cambire da sta cosa? a me sebrano la stessa cosa che si contradice psota cosi

"La riproducibilità dimostrata nella \hyperref[sec:coverage-idempotenza]{Sezione~\ref*{sec:coverage-idempotenza}} non è una proprietà accessoria del sistema: è la condizione che trasforma un'osservazione in un'affermazione verificabile da terzi."
-> sucsa tutto questo giro strano di aprole per andare a rideire ancora la ripdoucibilità^ c'è qualcosa che non mi torna su sto epzzo discutiamone una ttimoe capiamo cosa ci sarebebdovuto andare o magari sono i o che sono confuso

"APIGuard Assurance è la dimostrazione che la sicurezza delle \gls{API} può essere trattata come una proprietà dell'ingegneria del software: verificabile per analisi statica e per esecuzione, tracciabile attraverso un audit trail forense, integrabile nel ciclo di sviluppo tramite exit code semantici senza richiedere intervento manuale a ogni release. Applicare alle \gls{API} lo stesso rigore che si applica al codice, dalla verifica dei tipi alla regressione automatizzata fino ai quality gate di pipeline, non è un'aspirazione teorica: è ciò che un framework deterministico e config-driven rende operativamente praticabile. Quando l'assurance è continuo, la sicurezza smette di essere un attributo certificato una volta all'anno e diventa una proprietà del processo stesso, contestata a ogni commit e confermata a ogni deploy."
-> non ho cpaito nemen qeusto pezzo

cioè non cpaisoc lo scopo di qeusta sezione, itnroduci cosi lassurance continuo sen aunminimo di cotnesto o che e nn si cpaisce neinete, non si sa nememno cosa i itnende er assurance continuo e non cpasico perchè vupoi introdurre uan cosa nuova nelale conslusioni. nonti sto dicendo che è sbaglaito ma che non ho capito nulal di sta sezione e dobbiamo chiarirci meglio
