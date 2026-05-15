circa una decina in tutto no dettaglio tecnico

considerano molto l'esposizione -> discorso fatto completo e spiegare in modo fluido e deciso
ha senso avere in fondo alla presentazione tutte le immagini significative così che se vanno domande le cerco e ci parlo sopra
ultima slide di ringraziamenti e domande
slide vuota
e poi tutte le immagini tipo in un appendice 

APPROCCIO DA PRENDERE AL DISCORSO

--- 
io ho parlato un sacco di proprietà da verificare tutto ma poi nel concreto diciamo di quello che abbiamo fatto è stato predisporre un ambiente atto a poter fare queste verifiche nel senso non siamo andati a fare delle verifiche concrete su un sistema

non sono verifiche su proprietà non funzionali legate ai sistemi come appunto valutare l'affidabilità la disponibilità o così 
    abbiamo creato un sistema che permette di fare controlli più sofisticati ma che però attualmente non li fa

    Punto su cui fare forza: dire che questo sistema è generico perché permette di specificare queste verifiche (le pNF dipendono da quello che si vuole verificare) essendo questo un ambiente di test vengono poste le basi per poter fare queste verifiche

Non ci sono esperimenti su qualcosa di concreto --> ci vorrà dell'altro tempo 
--- 

# metodologia
Serve anche una parte che spiega ad alto livello la parte di metodologia: metriche contratti e proprietà (faccio un grafico molto semplice: dati -> metriche -> contratti -> proprietà verificate)
proprietà: misurano vari aspetti comportamentali di un sistema

# proprietà del sistema AE
è importante dire le proprietà che otteniamo e che vengono fornite dal nostro sistema, cosa ho risolto
performance e funzionalità

c'è da capire il perché serve una cosa del genere -> quindi la metodologia
il perché di utilizzare elastic e questo sistema intermedio di controlli va spiegato anche (prima motivazioni e poi obbiettivi)

Utilizzo elasticsearch perché mi permette di raccogliere informazioni su sistemi distribuiti anche complessi con agent pronti
prendo questi vantaggi e ci aggiungo quelli dell'infrastruttura
---


# funzionamento + perchè esiste
Serve spiegare come funziona il sistema, perché è stato fatto
Va spiegato il flusso del perché si fa questo tipo di verifiche
perché ha senso fare assurance su sistemi distribuiti, perché usare un infrastruttura del genere

-> sarebbe il capitolo del perché è importante questo middleman

spiegando quello si riesce a dare un contesto al perché è stata fatta tutta quanta la tesi
è molto importante che ci sia questa parte di spiegazione
---


# dettagli su AE
questo sistema, l'assurance agent, è sempre attivo; il nostro agent fa la parte di verifica: si aggancia ai sistemi che estraggono informazioni e fa i suoi controlli
e da ulteriori risultati sullo stato del sistema

Questo sistema è "event based": arriva un evento e rispondo a quell'evento -> motivo per il quale si richiedono prestazioni efficienti
il punto è proprio essere molto efficiente in questa parte di raccolta delle informazioni
per poi essere altrettanto reattivi nel momento in cui bisogna rispondere

lo collego al fatto che il sistema permette di salvare dati (non solo controlli in tempo reale) e quindi controlli time dependant sui risultati
---