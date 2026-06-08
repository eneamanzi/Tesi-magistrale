





\subsection{Catalogo delle Verifiche di Sicurezza}\label{subsec:test-catalog}

Il framework realizza la tassonomia descritta nella Sezione~\ref{subsec:domini-tassonomia} attraverso un insieme di verifiche concrete, ciascuna corrispondente a una garanzia specifica all'interno del proprio dominio. Il catalogo seguente enumera i 18 test implementati e i principali test pianificati come sviluppo futuro, organizzati per dominio. Per ogni test sono indicati la garanzia verificata, la strategia operativa richiesta e la priorità assegnata; i criteri di valutazione specifici di ciascun test implementato sono descritti nella Sezione~\ref{subsec:test-oracles} del Capitolo~\ref{chap:implementation}.

\paragraph{Dominio~0 --- API Discovery e Inventory Management}
\begin{itemize}
  \item[\textbf{0.1}] \textit{Shadow API Discovery}: verifica che ogni path raggiungibile sul sistema corrisponda a un endpoint dichiarato nella specifica \gls{OAS}, rilevando endpoint attivi ma non documentati tramite fuzzing black-box su wordlist e confronto con la superficie contrattuale. Riferimenti: OWASP API9:2023, CWE-200. (\texttt{BLACK\_BOX}, P0, implementato)

  \item[\textbf{ext.0.1.nuclei}] \textit{Shadow API Discovery -- template scan}: estende la copertura del test 0.1 con rilevazione template-based di esposizioni note mediante Nuclei~\cite{ProjectdiscoveryNuclei2026}, includendo interfacce di documentazione accessibili pubblicamente, panel amministrativi e path di debug catalogati nella libreria di template della community. (\texttt{BLACK\_BOX}, P0, implementato)

  \item[\textbf{0.2}] \textit{Deny-by-Default}: verifica che il gateway restituisca \texttt{404} a path non registrati nella propria configurazione di routing, rilevando l'assenza di route catch-all o configurazioni permissive che renderebbero raggiungibili endpoint non intenzionali. Riferimenti: OWASP API9:2023, CWE-284. (\texttt{BLACK\_BOX}, P0, implementato)

  \item[\textbf{0.3}] \textit{Deprecated API Enforcement}: verifica che gli endpoint marcati \texttt{deprecated:~true} nella specifica restituiscano \texttt{410~Gone} oppure includano un header \texttt{Sunset} conforme a RFC~8594, confermando che le \gls{API} dismesse non rimangano operative oltre il loro ciclo di vita dichiarato. Riferimenti: OWASP API9:2023, CWE-200. (\texttt{BLACK\_BOX}, P0, implementato)
\end{itemize}

\paragraph{Dominio~1 --- Identità e Autenticazione}
\begin{itemize}
  \item[\textbf{1.1}] \textit{Authentication Required}: per ogni endpoint dichiarato come autenticato dalla specifica \gls{OAS}, invia richieste prive di credenziali e verifica che il gateway le respinga; un endpoint che risponde con \texttt{2xx} in assenza di autenticazione viola la garanzia perimetrale primaria del sistema. Riferimenti: OWASP API2:2023, CWE-306. (\texttt{BLACK\_BOX}, P0, implementato)

  \item[\textbf{1.4}] \textit{Token Revocation}: verifica che un token revocato esplicitamente dall'utente venga immediatamente rifiutato dal gateway, senza finestre temporali in cui il token invalidato rimanga accettato. Il test costruisce un token temporaneo, lo revoca tramite l'endpoint di gestione delle credenziali, e ri-proba con il valore revocato. Riferimenti: OWASP API2:2023, CWE-613, RFC~7009. (\texttt{GREY\_BOX}, P2, implementato)

  \item[\textbf{1.5}] \textit{Insecure Credential Transport}: verifica che le credenziali non possano transitare in chiaro, controllando che il gateway applichi redirect \gls{HTTP}$\to$\gls{HTTPS} e che l'header \gls{HSTS} sia presente con durata minima conforme a NIST SP 800-52 Rev.~2. Riferimenti: OWASP API2:2023, CWE-319. (\texttt{BLACK\_BOX}, P2, implementato)

  \item[\textbf{ext.1.5.testssl}] \textit{TLS Analysis -- testssl.sh}: approfondisce la copertura della garanzia 1.5 tramite testssl.sh~\cite{TestsslTestsslsh2026}, verificando la correttezza dei protocolli supportati, delle cipher suite e dei parametri del certificato rispetto ai requisiti di NIST SP 800-52 Rev.~2. (\texttt{BLACK\_BOX}, P2, implementato)

  \item[\textbf{ext.1.5.sslyze}] \textit{TLS Analysis -- SSLyze}: verifica la stessa garanzia di ext.1.5.testssl tramite SSLyze~\cite{diquetNablac0d3Sslyze2026}, offrendo una sorgente di evidenza indipendente ottenuta tramite un'implementazione Python che consente ispezione programmatica dei parametri di negoziazione \gls{TLS}. (\texttt{BLACK\_BOX}, P2, implementato)

  \item[\textbf{1.6}] \textit{Secure Session Management}: verifica che i cookie di sessione presentino i flag di sicurezza obbligatori (\texttt{HttpOnly}, \texttt{Secure}, \texttt{SameSite}) e che il session store del gateway sia configurato correttamente, prevenendo attacchi di session hijacking e fixation. Riferimenti: OWASP API2:2023, CWE-384. (\texttt{WHITE\_BOX}, P3, implementato)

  \item[\textbf{1.2, 1.3}] \textit{JWT Lifecycle} (due test): verificheranno la validità crittografica del token \gls{JWT} e le condizioni di scadenza, incluse tecniche di attacco quali algorithm confusion e token tampering. (pianificato)
\end{itemize}

\paragraph{Dominio~2 --- Autorizzazione e Controllo degli Accessi}
\begin{itemize}
  \item[\textbf{2.1}] \textit{RBAC Enforcement}: verifica che un utente con ruolo non privilegiato non possa accedere a endpoint riservati a ruoli superiori, rilevando bypass del controllo di accesso basato sui ruoli. Il test richiede credenziali per almeno due identità con livelli di privilegio distinti. Riferimenti: OWASP API5:2023, OWASP API1:2023, CWE-285. (\texttt{GREY\_BOX}, P2, implementato)

  \item[\textbf{2.2--2.5}] \textit{BOLA e IDOR} (quattro test): verificheranno l'accesso a risorse appartenenti ad altri utenti tramite manipolazione degli identificatori di path, inclusa la generazione dinamica di probe tramite il connector OFFAT\footnote{\url{https://github.com/OWASP/OFFAT}}. (pianificato)
\end{itemize}

\paragraph{Dominio~3 --- Integrità dei Dati}
\begin{itemize}
  \item[\textbf{3.3}] \textit{HMAC Configuration Audit}: verifica tramite Admin \gls{API} che il plugin \gls{HMAC} del gateway sia configurato con una finestra temporale entro le soglie prescritte da NIST SP 800-107 Rev.~1, prevenendo attacchi di replay su richieste firmate. Riferimenti: CWE-347, NIST SP 800-107 Rev.~1 §5.3.2. (\texttt{WHITE\_BOX}, P3, implementato)

  \item[\textbf{3.1}] \textit{Input Validation}: verificherà che il gateway rifiuti payload malformati o con valori fuori dai vincoli dichiarati dalla specifica, rilevando assenza di validazione dell'input al livello del gateway. (pianificato)
\end{itemize}

\paragraph{Dominio~4 --- Disponibilità e Resilienza}
\begin{itemize}
  \item[\textbf{4.1}] \textit{Rate Limiting}: verifica che il gateway imponga limiti di frequenza alle richieste, restituendo \texttt{429~Too Many Requests} al superamento della soglia configurata, prevenendo resource exhaustion e abuso automatizzato. Riferimenti: OWASP API4:2023, CWE-770. (\texttt{BLACK\_BOX}, P0, implementato)

  \item[\textbf{4.2}] \textit{Timeout Configuration Audit}: verifica tramite Admin \gls{API} che i timeout sui servizi upstream del gateway siano configurati entro soglie operative, prevenendo il blocco indefinito delle connessioni in presenza di backend non responsivi. Riferimenti: CWE-400. (\texttt{WHITE\_BOX}, P1, implementato)

  \item[\textbf{4.3}] \textit{Circuit Breaker Audit}: verifica tramite Admin \gls{API} che il gateway disponga di un meccanismo di circuit breaking o di un compensating control equivalente per la degradazione controllata in caso di errori ripetuti del backend. Riferimenti: CWE-400. (\texttt{WHITE\_BOX}, P1, implementato)
\end{itemize}

\paragraph{Dominio~5 --- Visibilità e Auditing}
I test di questo dominio (5.1 audit logging, 5.2 alerting real-time) sono architetturalmente predisposti nella struttura del sistema e pianificati come sviluppo futuro. La numerazione è preservata per coerenza della sequenza.

\paragraph{Dominio~6 --- Configurazione e Hardening}
\begin{itemize}
  \item[\textbf{6.2}] \textit{Security Headers Audit}: verifica tramite probe sugli endpoint esposti che il gateway inietti negli header di risposta i meccanismi di sicurezza obbligatori (\texttt{HSTS}, \texttt{X-Content-Type-Options}, \texttt{X-Frame-Options}, \texttt{Content-Security-Policy}, \texttt{Permissions-Policy}) e che gli header che rivelano informazioni sul server siano assenti o privi di versione. Riferimenti: OWASP API7:2023, CWE-693. (\texttt{WHITE\_BOX}, P3, implementato)

  \item[\textbf{6.4}] \textit{Hardcoded Credentials Audit}: verifica tramite Admin \gls{API} che le variabili d'ambiente dei servizi upstream non contengano pattern riconoscibili come credenziali hardcoded, rilevando una delle categorie di misconfiguration più frequenti nei deployment. Riferimenti: CWE-798, OWASP API7:2023. (\texttt{WHITE\_BOX}, P2, implementato)
\end{itemize}

\paragraph{Dominio~7 --- Business Logic e Flussi Sensibili}
\begin{itemize}
  \item[\textbf{7.2}] \textit{SSRF Prevention}: verifica che il gateway o il backend non eseguano richieste \gls{HTTP} verso indirizzi controllati dall'attaccante a seguito di input forniti dall'utente, rilevando vulnerabilità di Server-Side Request Forgery attraverso un vettore di injection su un endpoint autenticato. La strategia \texttt{GREY\_BOX} è necessaria perché il vettore di injection richiede la creazione di una risorsa autenticata come prerequisito. Riferimenti: OWASP API7:2023, CWE-918. (\texttt{GREY\_BOX}, P0, implementato)

  \item[\textbf{7.1, 7.3, 7.4}] \textit{Unsafe Consumption, Race Condition, SSRF Blind} (tre test): verificheranno rispettivamente il consumo non sicuro di \gls{API} di terze parti, condizioni di gara su operazioni sensibili tramite carico concorrente con il connector Vegeta\footnote{\url{https://github.com/tsenart/vegeta}}, e \gls{SSRF} out-of-band tramite il connector Interactsh\footnote{\url{https://github.com/projectdiscovery/interactsh}}. (pianificato)
\end{itemize}