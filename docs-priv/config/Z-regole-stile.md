# Regole di Stile Approvate — APIGuard Tesi Magistrale

## Regole Assolute

- **Em dash (—) categoricamente vietato** in qualsiasi output. Usare due punti, virgola, punto e virgola, o riformulare.
- **Output esclusivamente in italiano accademico formale.**
- **Mai generare un intero capitolo in una singola risposta.** Una sezione approvata alla volta.
- **Tutte le affermazioni fattuali su APIGuard devono tracciare alla knowledge base**, non alla conoscenza generale.

---

## Stile della Prosa

### Negazioni

Il test è semplice: se si può riformulare "X non è/non fa Y" in "X fa/è Z" dove Z è il fatto positivo corrispondente, si deve fare.

Le uniche eccezioni ammesse sono:
- L'assenza è precisamente il fatto rilevante (es. "ToolBaseError non si solleva direttamente")
- La struttura "non X, ma Y" dove il contrasto è la sostanza dell'argomentazione

### Frasi brevi

Le frasi brevi (sotto le 15 parole circa) sono efficaci solo come:
- Conclusione di un argomento già costruito
- Transizione di giuntura tra due blocchi logici

Una frase breve che introduce un paragrafo o che appare nel mezzo di una spiegazione tecnica risulta sospesa. Non si vietano; si usano con funzione specifica e consapevole.

### Enumerazioni in prosa

Quando si elencano tre o più operazioni nella stessa frase, verificare se l'ordine ha una logica interna (dal più semplice al più specifico, dal generale al caso limite, ecc.). Se quella logica esiste, nominarla. Un'enumerazione senza logica interna è una lista travestita da prosa.

---

## Struttura dell'Argomento

### Ordine problema-soluzione

Dove viene naturale e segue il flusso logico: nominare prima la tensione o il requisito, poi il meccanismo che lo risolve, poi eventualmente il limite accettato. Non è un template obbligatorio: forzarlo dove non serve produce testi uniformi e meccanici.

### Il costo delle scelte

Dove il flusso logico lo richiede e viene naturale: ogni scelta architetturale discrezionale ha un costo. Nominarlo è parte dell'argomentazione, non un disclaimer. Non è una regola fissa: va inserito dove rafforza il ragionamento, non sistematicamente.

### Un'affermazione centrale per paragrafo

Ogni paragrafo dovrebbe avere un'affermazione centrale identificabile. Se ce ne sono due distinte senza connettivo logico esplicito, sono due paragrafi. Applicare con parsimonia: non è un vincolo ferrigno, è una guida per identificare paragrafi che sembrano confusi.

---

## Connettivi e Transizioni

### Tra sezioni

Le frasi di transizione devono nominare la relazione logica dove viene naturale: estensione, specifica, contrasto, conseguenza, prerequisito. "Come anticipato in X" è corretto e accademicamente appropriato; può essere arricchito quando la relazione è più specifica (es. "estende il principio introdotto in X", "porta a livello implementativo quanto stabilito in X").

### Filo conduttore

Mantenere un collegamento logico spontaneo tra i paragrafi di una sezione. Il filo conduttore si costruisce riprendendo una cosa appena detta, introducendone una che da essa dipende, o dicendo di più su qualcosa già menzionato. Il collegamento deve essere naturale, non forzato. Dove non c'è un collegamento reale, non inventarne uno.

---

## Gestione dei Livelli di Dettaglio

### Capitolo 3 vs Capitolo 4

- Cap. 3 opera a livello di sistema: principi, domini, proprietà architetturali, motivazioni.
- Cap. 4 opera a livello di modulo e classe: metodi specifici, costrutti Python, meccanismi concreti.
- Le due prospettive si richiamano con rimandi espliciti; la trattazione primaria di ogni concetto appartiene a uno solo dei due capitoli.

### Approccio top-down

L'esposizione segue la discesa top-down dichiarata nella metodologia: dal sistema ai moduli, dai moduli ai meccanismi. Non perdersi nei dettagli senza prima aver stabilito il contesto.

---

## Uso di Liste ed Elenchi

Gli elenchi puntati e numerati si usano quando la struttura è genuinamente enumerativa e l'elenco aggiunge chiarezza che la prosa non offrirebbe. Non si usano per scomporre argomentazioni che reggono come prosa fluida. Quando si usa un elenco, i sottolivelli devono avere una ragione strutturale precisa.

---

## Onestà Epistemica

- Le proprietà architetturali non validate empiricamente nella Milestone 1 non vengono presentate come validate.
- Se la knowledge base non contiene informazione sufficiente per supportare un'affermazione tecnica, si dichiara il gap invece di riempirlo con contenuto plausibile.
- I claim quantitativi (percentuali, tempi, conteggi) tracciano tutti all'`AUDIT_milestone1_release.md`.

---

## Riferimenti interni e label

### Label

- Ogni sezione ha una sola label. Se una sezione viene spostata o rinominata,
  aggiornare la label di conseguenza prima di aggiornare i riferimenti.
- Le label seguono il pattern `sec:nome-semantico` per le sezioni e
  `subsec:nome-semantico` per le sottosezioni. Il nome deve riflettere il
  contenuto attuale, non la collocazione originale.
- Mai lasciare label orfane (definite ma non referenziate) o riferimenti rotti
  (referenziati ma non definiti). Verificare entrambe le direzioni dopo ogni
  spostamento di sezione.

### Riferimenti a sezioni, tabelle e figure

- I riferimenti interni usano sempre il prefisso tipografico appropriato:
  `Sezione~\ref{}`, `Capitolo~\ref{}`, `Tabella~\ref{}`, `Figura~\ref{}`.
- Non usare mai `\ref{}` nudo senza prefisso: il numero da solo non ha contesto.
- Per riferimenti a capitoli e sezioni di altri capitoli, usare la stessa forma
  con `Sezione~\ref{}`: il lettore deve poter navigare senza conoscere il numero
  a memoria.

### Riferimenti a proprietà architetturali

- I codici di proprietà (D1.P1, D4.P3, ecc.) non sono oggetti citabili in modo
  autonomo: sono identificatori interni. Il riferimento primario punta sempre
  alla sezione dove la proprietà è discussa: `Sezione~\ref{subsec:label}`.
- Il codice può comparire come testo aggiuntivo per orientamento del lettore, ma
  non sostituisce il riferimento alla sezione: scrivere "come descritto nella
  Sezione~\ref{subsec:fail-safe}" e non "\hyperref[subsec:fail-safe]{D4.P3}".
- `\hyperref[label]{testo}` si usa solo quando il testo da mostrare è diverso
  dal numero di sezione e non è un codice di proprietà — tipicamente per
  costruire la forma `\hyperref[label]{Sezione~\ref*{label}}` che mostra il
  numero senza doppio link.
- I riferimenti alle sezioni di Cap 5 (validazione) usano la forma
  `\hyperref[sec:label]{Sezione~\ref*{sec:label}}` per evitare il doppio
  hyperlink generato da `Sezione~\ref{}` quando hyperref è attivo.