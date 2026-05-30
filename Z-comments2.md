"Il \gls{SAST} analizza il codice sorgente o i binari compilati senza eseguire l'applicazione, identificando pattern noti di vulnerabilità a livello sintattico: buffer overflow, uso di funzioni non sicure, propagazione di dati non validati verso punti critici del codice come query al database o chiamate di sistema~\cite{MISSING:chess:2004:secure-programming}." -> quesot non lo trovo nel mio file

"Tuttavia la \gls{OAS} non copre tutte le classi di garanzie: il comportamento a livello di protocollo, come la configurazione \gls{TLS} o la presenza di header di sicurezza, e le policy operative come il rate limiting, richiedono criteri di valutazione indipendenti dalla specifica dell'endpoint." -> ae capie meglio che questi sono solo deglie esempie non tutto (dammi la mdofiica soo diq eusto pezzettino non ditutot il paragrafo)



Questo era il pezo che mi avevi propsot
"Su §2.3.2 e §2.3.3 — la questione strutturale:
Hai ragione sul problema. §2.3.2 è una tassonomia incompleta basata su OWASP più una categorizzazione in tre gruppi che non ha una fonte e non viene usata dopo. §2.3.3 dipende da §2.3.2 e poi chiude con riferimenti al tuo tool, che non appartengono allo stato dell'arte.
La mia proposta è questa: accorpare le due subsection in una sola, che non pretende di fare tassonomia ma porta tre o quattro esempi concreti di vulnerabilità semantiche per illustrare il semantic gap descritto in §2.3.1. La struttura sarebbe:

§2.3.1: evoluzione → semantic gap come concetto → OWASP come evidenza empirica della transizione
§2.3.2 (rinominata): "Manifestazioni del Semantic Gap" — esempi concreti di BOLA, BFLA, mass assignment, SSRF per mostrare in modo tangibile perché il testing sintattico non raggiunge queste classi. Non una tassonomia, ma una concretizzazione. La chiusura del paragrafo dice che queste classi richiedono precondizioni diverse, il che motiva l'approccio strutturato descritto nel capitolo successivo. Nessun riferimento al tuo tool.

Questo elimina la §2.3.3 come sezione autonoma, che era effettivamente debole.
Sei d'accordo con questo schema? Se sì procedo."

aggiroanre ance i titoli di cosnegeunza

