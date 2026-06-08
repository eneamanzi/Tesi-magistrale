# todo -> doing
non faccione in chap3, ne 4, ne 5, l'elenco e la spiegazione dei test che ho pensato; poi andrebeb fatta anche la spiegazione un po più dettaglaita d quelli cheo fatto, niente di esagerato.





\item[\textbf{\texttt{7.2}}]
        Verifica che il sistema rifiuti \gls{URL} controllati dall'attaccante iniettati in richieste autenticate, rilevando \gls{SSRF} tramite sonde su indirizzi privati, endpoint IMDS cloud, encoding obfuscati e protocolli non-\gls{HTTP}. La strategia \texttt{GB} è necessaria perché il vettore di injection richiede autenticazione.
        (\gls{OWASP}~API7:2023\footnote{\gls{OWASP} API7:2023: \textit{Server Side Request Forgery}~\cite{OWASPTop10}.}, \gls{CWE}-918\footnote{\textit{CWE-918: Server-Side Request Forgery}.}, \gls{RFC}~1918\footnote{\gls{RFC}~1918: \textit{Address Allocation for Private Internets}, IETF.}) -> non mi paice coem è scritto


a condizioni di gara -> non si può sentire la traudzioenletterale initaliano, usaimo race codnition

Questa ha anora il riferimento in line e tra parentesi,nondovremmo toglierlo d aquello inlinee poi metterlo nel cpaitolodopo in caso?
"\item[\textbf{\texttt{0.3}}]
        \textit{Deprecated API Enforcement.} \texttt{BB}, P0.\\
        Verifica che gli endpoint marcati \texttt{deprecated:~true} nella specifica restituiscano \texttt{410~Gone} o includano un header \texttt{Sunset} conforme a \gls{RFC}~8594, confermando che le \gls{API} dismesse non rimangano operative rimangano operative oltre il ciclo di vita dichiarato.
        (\gls{OWASP}~API9:2023, \gls{CWE}-200, \gls{RFC}~8594\footnote{\gls{RFC}~8594: \textit{The Sunset HTTP Header Field}, IETF.})"

"Verifica che utenti con ruolo non privilegiato non possano accedere a una lista configurabile di endpoint riservati a ruoli superiori, rilevando bypass della \gls{BFLA}."
-> questa descrizione mi puzza un po non sono sicuro sia appropriata e corretta

"Verifica che ogni utente acceda esclusivamente alle risorse di propria titolarità, rilevando \gls{BOLA} tramite manipolazione degli identificatori di path con credenziali di un utente distinto."
-> quesat è corretat coe è scritta? mi semrba vago dire identificatori di apth, cioè non so se si usa ed è il termiencorretto

"Verifica che le policy di autorizzazione siano applicate uniformemente su tutti gli endpoint della stessa risorsa, rilevando inconsistenze tra varianti dello stesso path o tra versioni \gls{API}." -> questo siam sisucir che fa effettivmante quello che diciamo?

conta hce le mie non sono critiche perchè sono errati ma per avere chairimenti, certezze ecc e e se nonsono vere cambiare.

Questa non mi paice molto "\item[\textbf{\texttt{6.3}}]
            \textit{Gateway Hardening.} \texttt{BB}, P1.\\
            Verifica che la configurazione del gateway sia protetta contro exploit Layer-7 comuni, con rilevazione di vulnerabilità di HTTP request smuggling.
            (\gls{OWASP}~API8:2023, \gls{CWE}-444\footnote{\textit{CWE-444: Inconsistent Interpretation of HTTP Requests}.})"

"Verifica che le credenziali di servizio non siano esposte tramite endpoint di debug né hardcoded negli \gls{URL} dei servizi upstream o nella configurazione dei plugin del gateway." -> verificare se faccia effettimanrte quese cose, cioè se è corrett coem è definitio


Quesat è tutto fuckupapto, nonha nemmeno il nome di sto tet    \item[\textbf{\texttt{7.2}}]
            Verifica che il sistema rifiuti \gls{URL} controllati dall'attaccante iniettati in richieste autenticate, rilevando \gls{SSRF} tramite sonde su indirizzi privati, endpoint IMDS cloud, encoding obfuscati e protocolli non-\gls{HTTP}. La strategia \texttt{GB} è necessaria perché il vettore di injection richiede autenticazione.
            (\gls{OWASP}~API7:2023\footnote{\gls{OWASP} API7:2023: \textit{Server Side Request Forgery}~\cite{OWASPTop10}.}, \gls{CWE}-918\footnote{\textit{CWE-918: Server-Side Request Forgery}.}, \gls{RFC}~1918\footnote{\gls{RFC}~1918: \textit{Address Allocation for Private Internets}, IETF.})"
contrllal bene cos'è e come scriverl nel modo corretto
poi ora contutto quellelenco di cose è pesante da leggere

Com ti ho gia dettoriam è bruttssimo traduddre race conditionin condizioni di gara, usiamo race cndition "Verifica che operazioni sensibili non siano vulnerabili a condizioni di gara tramite richieste concorrenti, rilevando inconsistenze di stato di tipo \gls{TOCTOU}."
poi boh non mi ha convinto del tutto

"\item[\textbf{\texttt{7.4}}]
            \textit{\gls{SSRF} Blind.} \texttt{GB}, P2.\\
            Verifica \gls{SSRF} out-of-band, il cui esito non è osservabile nel canale di risposta, tramite un server di callback controllato."
-> questo va bene cosi? cioè è corretto il conenuto ed è soloq uesto che va detto?

Considera inanzitutto che le modifiche che andiamoa afare devono essere ancora chirurgiche, sui sinoli putni da modificaire.

Ti carico anche il mio stato attuale del cahp 3 almeno puoi vedere com'è e leggerlo per darmi i diff appropriati

Poi esponi anche tu una valutazione in merito a questa sezione su cui stiamo lavoando dei miei test. 

Dobbiamo anche andare a fact checkare ogni inforamzioni che mettiamo qua dentro sia rispetto al mio tool, quindi i miei codici pythn e i miei file markdown, sia rispetto agli stanrd che nominiamo ecc.

Quando tutto questo putno è ultimato e siamo daccordo procederemo a sistemare la controparte del capitolo 4






# todo
sistemare la questioen delle propreità che trattava il chap 3 (anche 4 e 5 forse) e adattarlo senza; piuttosto anche il pro fmi cosnigliaa di fare una sezione appsota cone le proprietà. L'idea geneale è quella di non usare più le proprietà come cosa centrale ma solo metetrle tipo tra parentexi per reference. dobbiamo indagarci sopa una ttimo su come fare.
## tabella 3.1
questa la dobbiamoc ambiare per il refactoring non più bsato sulel propreità



# TODO fianle - controlalre se ci sono rieptizioni eccessive o superflue tra sezioni, sub-sections e paragrafi