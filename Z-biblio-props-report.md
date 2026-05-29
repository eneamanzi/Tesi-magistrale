# Report Bibliografico — APIGuard Assurance
*Versione: 29 maggio 2026 — per gestione Zotero e inserimento in `biblio.bib`*

---

## Note di utilizzo

Il report è organizzato in due fasce di priorità. All'interno di ciascuna fascia, le voci sono raggruppate per capitolo della tesi. Per ogni paper sono riportati: i metadati verificati (non la versione di Gemini), la motivazione estesa con riferimenti espliciti al contenuto del paper, il punto di inserimento nella tesi con il label LaTeX, e il BibTeX corretto pronto per l'importazione.

Tutte le correzioni applicare alle voci BibTeX sono marcate con `% CORRETTO:` nel commento inline. I campi segnati `% DA VERIFICARE:` richiedono un passaggio manuale prima dell'inserimento.

---

## FASCIA A — RACCOMANDATO / RACCOMANDATO CON CORREZIONI

---

### Capitolo 2 — Background e Stato dell'Arte

---

#### [A-01] RESTler: Stateful REST API Fuzzing

**Metadati**
- **Titolo**: RESTler: Stateful REST API Fuzzing
- **Autori**: Vaggelis Atlidakis, Patrice Godefroid, Marina Polishchuk
- **Sede**: 41st International Conference on Software Engineering (ICSE 2019)
- **Anno**: 2019
- **DOI**: `10.1109/ICSE.2019.00083`
- **Accesso aperto**: https://patricegodefroid.github.io/public_psfiles/icse2019.pdf
- **Stato**: Pubblicazione peer-reviewed, venue tier-1 (ICSE). Nessuna correzione necessaria.

**Rilevanza**
RESTler introduce il primo fuzzer stateful per REST API in grado di inferire automaticamente le dipendenze producer-consumer a partire dalla specifica OpenAPI/Swagger, superando il limite strutturale dei fuzzer black-box stateless che si schiantano contro l'esplosione combinatoria delle sequenze di chiamate. Il paper dimostra empiricamente che un fuzzer ignaro dello stato genera in massima parte richieste HTTP 400/401 perché non soddisfa le precondizioni degli endpoint profondi, confermando che la copertura logica richiede la comprensione delle dipendenze tra operazioni. Questo è il riferimento canonico per il concetto di "combinatorial wall" discusso nel §2.4 della tesi, nonché la baseline rispetto alla quale si posiziona l'approccio contract-driven di APIGuard. Il paper è già citato indirettamente attraverso la `tab:semantic-gap` (Tabella C) nella tesi; questa voce bibliografica ne formalizza l'inserimento nel testo.

**Punto di inserimento**
`\subsec:semantic-gap` (§2.3.1) per la definizione del semantic gap rispetto al testing sintattico, e §2.4 per la discussione del combinatorial wall e della necessità del fuzzing stateful. Citabile anche in §3.2 (`\subsec:openapi-sot`) come precedente architetturale che usa OpenAPI come SSoT per la generazione di sequenze.

```bibtex
@inproceedings{atlidakis2019restler,
  title={RESTler: Stateful REST API Fuzzing},
  author={Atlidakis, Vaggelis and Godefroid, Patrice and Polishchuk, Marina},
  booktitle={Proceedings of the 41st International Conference on Software Engineering},
  pages={748--758},
  year={2019},
  publisher={IEEE Press},
  doi={10.1109/ICSE.2019.00083}
}
```

---

#### [A-02] Pythia: Grammar-Based Fuzzing of REST APIs with Coverage-guided Feedback

**Metadati**
- **Titolo**: Pythia: Grammar-Based Fuzzing of REST APIs with Coverage-guided Feedback and Learning-based Mutations
- **Autori**: Vaggelis Atlidakis, Roxana Geambasu, Patrice Godefroid, Marina Polishchuk, Baishakhi Ray
- **Sede**: arXiv preprint
- **Anno**: 2020
- **DOI**: `10.48550/arXiv.2005.11498`
- **Accesso aperto**: https://arxiv.org/pdf/2005.11498
- **Stato**: Preprint verificato, stesso gruppo di RESTler. Nessuna correzione necessaria.

**Rilevanza**
Pythia estende RESTler incorporando un meccanismo di feedback basato sulla copertura del codice e mutazioni guidate da algoritmi di apprendimento, affrontando il problema residuo che affligge i fuzzer puramente grammaticali: la necessità di esplorare lo spazio dei valori primitivi (stringhe, interi, booleani) che rimane computazionalmente esplosivo anche dopo aver risolto le dipendenze tra operazioni. Gli autori dimostrano che le mutazioni euristiche, ancorate alla copertura dei branch, individuano vulnerabilità che sfuggono sia ai fuzzer stateless sia a RESTler stesso. Questo paper completa il quadro evolutivo del fuzzing per API REST che la tesi descrive nel §2.4, mostrando la traiettoria dal black-box al coverage-guided e motivando perché un approccio ancora diverso (contract-driven con oracolo formale, come APIGuard) sia necessario per le vulnerabilità semantiche.

**Punto di inserimento**
§2.4, in chiusura del paragrafo sull'evoluzione del fuzzing, come passaggio dalla grammatica al coverage-guided prima di introdurre i limiti residui che motivano l'approccio di APIGuard.

```bibtex
@article{atlidakis2020pythia,
  title={Pythia: Grammar-Based Fuzzing of REST APIs with Coverage-guided Feedback and Learning-based Mutations},
  author={Atlidakis, Vaggelis and Geambasu, Roxana and Godefroid, Patrice and Polishchuk, Marina and Ray, Baishakhi},
  journal={arXiv preprint arXiv:2005.11498},
  year={2020},
  doi={10.48550/arXiv.2005.11498}
}
```

---

#### [A-03] HDiff: A Semi-automatic Framework for Discovering Semantic Gap Attack in HTTP Implementations

**Metadati**
- **Titolo**: HDiff: A Semi-automatic Framework for Discovering Semantic Gap Attack in HTTP Implementations
- **Autori**: Kaiwen Shen, Jianyu Lu, Yaru Yang, Jianjun Chen, Mingming Zhang, Haixin Duan, Jia Zhang, Xiaofeng Zheng
- **Sede**: 52nd Annual IEEE/IFIP International Conference on Dependable Systems and Networks (DSN 2022)
- **Anno**: 2022
- **DOI**: `10.1109/DSN53405.2022.00014`
- **Accesso aperto**: https://netsec.ccert.edu.cn/files/papers/HDiff_DSN2022.pdf
- **Stato**: Pubblicazione peer-reviewed, Best Paper Award DSN 2022. **Correzione applicata**: DOI corretto da `00004` a `00014`.

**Rilevanza**
HDiff fornisce la definizione formale più citata di "semantic gap attack" nel contesto HTTP: le inconsistenze di interpretazione semantica tra componenti della catena di elaborazione (WAF, reverse proxy, CDN, server applicativo) che consentono a payload malevoli di sfuggire all'ispezione perimetrale. Il paper progetta un framework semi-automatico che estrae regole dalla specifica RFC via NLP e applica differential testing per scoprire casi di elusione. La tesi usa il termine "semantic gap" in un senso più ampio (cecità dei WAF rispetto alla logica applicativa), ma HDiff ne è la radice accademica: un `\cite{}` in §2.3.1 con una frase di contestualizzazione ("nel senso più stretto di inconsistenza di parsing protocollare") conferisce al concetto una base bibliografica rigorosa prima di allargarne la portata alle business logic vulnerability.

**Punto di inserimento**
`\subsec:semantic-gap` (§2.3.1), primo paragrafo, all'introduzione del termine "semantic gap" come concetto formale. Usare con una riga di raccordo del tipo: "HDiff formalizza il termine a livello di parsing HTTP; la presente trattazione ne estende la portata al livello del contratto applicativo."

```bibtex
@inproceedings{shen2022hdiff,
  title={HDiff: A Semi-automatic Framework for Discovering Semantic Gap Attack in HTTP Implementations},
  author={Shen, Kaiwen and Lu, Jianyu and Yang, Yaru and Chen, Jianjun and Zhang, Mingming and Duan, Haixin and Zhang, Jia and Zheng, Xiaofeng},
  booktitle={2022 52nd Annual IEEE/IFIP International Conference on Dependable Systems and Networks (DSN)},
  pages={1--13},
  year={2022},
  organization={IEEE},
  doi={10.1109/DSN53405.2022.00014} % CORRETTO: era 00004
}
```

---

#### [A-04] Enhancing REST API Fuzzing with Access Policy Violation Checks (EvoMaster)

**Metadati**
- **Titolo**: Enhancing REST API Fuzzing with Access Policy Violation Checks and Injection Attacks
- **Autori**: Omur Sahin, Man Zhang, Andrea Arcuri
- **Sede**: arXiv preprint (arXiv:2604.00702)
- **Anno**: 2026
- **DOI**: `10.48550/arXiv.2604.00702`
- **Accesso aperto**: https://arxiv.org/pdf/2604.00702
- **Stato**: Preprint, sottomissione futura prevista. Verificato all'URL, contenuto e autori confermati.

**Rilevanza**
Il paper propone nove oracoli automatizzati integrabili in fuzzer REST esistenti per rilevare violazioni di policy di accesso (BOLA, BFLA, anonymous modifications, existence leakage) e attacchi injection (SQL, XSS). Gli autori estendono EvoMaster e validano il sistema su 52 API distinte, dimostrando che i fuzzer tradizionali che giudicano il successo in base ai soli codici HTTP 500 non riescono a individuare le vulnerabilità logiche che restituiscono HTTP 200 con dati illeciti. Questo paper è la referenza più diretta per due punti chiave della tesi: (1) §2.6, dove si argomenta che BOLA e BFLA sono invisibili ai fuzzer sintattico-volumetrici; (2) §3.3, dove si descrive il meccanismo di oracolo di APIGuard come rilevazione semantica piuttosto che rilevazione di crash. La complementarità con APIGuard è evidente: EvoMaster è un fuzzer che arricchisce il suo approccio con oracoli; APIGuard è un assessment tool che parte dall'oracolo come principio fondante.

**Punto di inserimento**
`\subsec:categorie-fallimento` (§2.3.2) per BOLA/BFLA come vulnerabilità invisibili ai fuzzer classici. Secondariamente, §3.3 per la discussione dell'oracolo formale come strumento di rilevazione semantica.

```bibtex
@article{sahin2026enhancing,
  title={Enhancing REST API Fuzzing with Access Policy Violation Checks and Injection Attacks},
  author={Sahin, Omur and Zhang, Man and Arcuri, Andrea},
  journal={arXiv preprint arXiv:2604.00702},
  year={2026},
  doi={10.48550/arXiv.2604.00702}
}
```

---

#### [A-05] Mining REST APIs for Potential Mass Assignment Vulnerabilities (LightMass)

**Metadati**
- **Titolo**: Mining REST APIs for Potential Mass Assignment Vulnerabilities
- **Autori**: Arash Mazidi, Davide Corradini, Mohammad Ghafari
- **Sede**: 28th International Conference on Evaluation and Assessment in Software Engineering (EASE 2024), Salerno
- **Anno**: 2024
- **DOI**: `10.1145/3661167.3661204`
- **Accesso aperto**: https://arxiv.org/pdf/2405.01111
- **Stato**: Pubblicazione peer-reviewed, ACM EASE 2024. Nessuna correzione necessaria.

**Rilevanza**
Il paper introduce LightMass, un approccio leggero per identificare le operazioni e gli attributi vulnerabili alla Mass Assignment direttamente dalla specifica OpenAPI, senza necessità di eseguire il sistema. Analizzando 100 API reali, gli autori trovano che il 25% è potenzialmente vulnerabile e confermano sperimentalmente nove endpoint vulnerabili in sei API. Il risultato metodologicamente rilevante per la tesi è che l'unica via di rilevamento è strutturale: confrontare gli schemi di lettura e di scrittura degli stessi oggetti per individuare attributi sovrascrivibili che non dovrebbero esserlo. Questo dimostra sia il limite dei WAF perimetrali (un payload JSON formalmente valido non tradisce nulla), sia la centralità dell'analisi della specifica OpenAPI come strumento di security assessment, principio fondante di APIGuard.

**Punto di inserimento**
§2.3.2 (`\subsec:categorie-fallimento`), nella parte dedicata alla Mass Assignment. È il riferimento primario per questo vettore di attacco nella tesi.

```bibtex
@inproceedings{mazidi2024mining,
  title={Mining REST APIs for Potential Mass Assignment Vulnerabilities},
  author={Mazidi, Arash and Corradini, Davide and Ghafari, Mohammad},
  booktitle={Proceedings of the 28th International Conference on Evaluation and Assessment in Software Engineering (EASE 2024)},
  pages={369--374},
  year={2024},
  publisher={ACM},
  doi={10.1145/3661167.3661204}
}
```

---

#### [A-06] WENDIGO: Deep Reinforcement Learning for Denial-of-Service Query Discovery in GraphQL

**Metadati**
- **Titolo**: WENDIGO: Deep Reinforcement Learning for Denial-of-Service Query Discovery in GraphQL
- **Autori**: Shae McFadden, Marcello Maugeri, Chris Hicks, Vasilios Mavroudis, Fabio Pierazzi
- **Sede**: IEEE Symposium on Security and Privacy Workshops (Deep Learning Security and Privacy — DLSP), co-located con IEEE S&P 2024
- **Anno**: 2024
- **DOI**: `10.1109/SPW63631.2024.00017`
- **Accesso aperto**: https://kclpure.kcl.ac.uk/ws/portalfiles/portal/251249221/Wendigo.pdf
- **Stato**: Pubblicazione peer-reviewed, workshop co-located con IEEE S&P. Nessuna correzione necessaria.

**Rilevanza**
WENDIGO implementa un agente DRL che, conoscendo solo lo schema GraphQL del target, costruisce automaticamente query semanticamente profonde in grado di esaurire le risorse del database con appena due richieste HTTP per ora. Questo risultato demolisce l'assunzione implicita che il rate-limiting volumetrico (misura di richieste per secondo) sia sufficiente a proteggere un endpoint GraphQL: l'unità di misura rilevante non è la quantità di richieste HTTP bensì la complessità computazionale della singola query. Per la tesi, questo paper è la referenza diretta per la sezione sul Resource Accounting Mismatch (pattern 5 della matrice di testing in §2.8) e per l'argomento che le difese perimetrali WAF non possono ispezionare il costo computazionale dell'AST GraphQL prima di inoltrarla al backend.

**Punto di inserimento**
§2.8 (GraphQL e bypass delle difese WAF), nella discussione del DoS semantico come classe di attacco distinta dal DoS volumetrico. Il paper supporta direttamente la riga della tabella 2-background_compact.md che recita "Batching rate limit bypass" per GraphQL con API Gateway.

```bibtex
@inproceedings{mcfadden2024wendigo,
  title={WENDIGO: Deep Reinforcement Learning for Denial-of-Service Query Discovery in {GraphQL}},
  author={McFadden, Shae and Maugeri, Marcello and Hicks, Chris and Mavroudis, Vasilios and Pierazzi, Fabio},
  booktitle={2024 IEEE Symposium on Security and Privacy Workshops (SPW)},
  pages={68--75},
  year={2024},
  organization={IEEE},
  doi={10.1109/SPW63631.2024.00017}
}
```

---

#### [A-07] Rethinking Broken Object Level Authorization Attacks Under Zero Trust Principle (BoLAZ)

**Metadati**
- **Titolo**: Rethinking Broken Object Level Authorization Attacks Under Zero Trust Principle
- **Autori**: Anbin Wu, Zhiyong Feng, Ruitao Feng, Zhenchang Xing, Yang Liu
- **Sede**: arXiv preprint (arXiv:2507.02309) — "future journal/conference submission intended"
- **Anno**: 2025
- **DOI**: `10.48550/arXiv.2507.02309`
- **Accesso aperto**: https://arxiv.org/pdf/2507.02309
- **Stato**: Preprint non ancora pubblicato in sede peer-reviewed. Contenuto e autori verificati. Citare come `arXiv preprint`.

**Rilevanza**
BoLAZ propone un framework di difesa contro BOLA fondato su static taint tracking: analizza il flusso degli ID risorsa nel codice sorgente, identifica i punti di iniezione (endpoint consumer) e determina gli intervalli di autorizzazione leciti, impedendo che un ID "alieno" raggiunga il livello di query al database. L'approccio contrasta direttamente con il modello di difesa basato su policy statiche redatte manualmente (che il paper dimostra essere insufficienti), e rappresenta la formalizzazione accademica del principio Zero Trust applicato al livello di oggetto. Per la tesi, fornisce il supporto bibliografico per l'affermazione che BOLA non è rilevabile da strumenti perimetrali che non tracciano la propagazione degli ID nella logica applicativa, e che l'unica via è l'analisi della relazione tra il chiamante e la risorsa richiesta.

**Punto di inserimento**
§2.3.2 (`\subsec:categorie-fallimento`), nella parte dedicata a BOLA/IDOR, in supporto all'argomento che il WAF non può verificare la corrispondenza tra identità del chiamante e ID dell'oggetto richiesto.

```bibtex
@article{wu2025bolaz,
  title={Rethinking Broken Object Level Authorization Attacks Under Zero Trust Principle},
  author={Wu, Anbin and Feng, Zhiyong and Feng, Ruitao and Xing, Zhenchang and Liu, Yang},
  journal={arXiv preprint arXiv:2507.02309},
  year={2025},
  doi={10.48550/arXiv.2507.02309}
}
```

---

#### [A-08] An Analysis of How Many Undiscovered Vulnerabilities Remain in Information Systems

**Metadati**
- **Titolo**: An analysis of how many undiscovered vulnerabilities remain in information systems
- **Autori**: Jonathan M. Spring
- **Sede**: *Computers & Security*, vol. 131, art. 103191 (Elsevier)
- **Anno**: 2023
- **DOI**: `10.1016/j.cose.2023.103191`
- **Accesso aperto**: https://arxiv.org/pdf/2304.09259
- **Stato**: Rivista peer-reviewed, Elsevier Computers & Security. Nessuna correzione necessaria.

**Rilevanza**
Spring argomenta formalmente, attraverso i concetti della teoria della computabilità (indecidibilità, densità dei difetti), che il numero di vulnerabilità non scoperte in qualsiasi software moderno in esercizio è praticamente illimitato e non si esaurisce con strategie di testing basate sul campionamento esterno. Il paper supporta il punto metodologico della tesi riguardante l'asimmetria informativa: i sistemi di difesa perimetrale (WAF, DAST stateless) operano in condizioni di asimmetria massima rispetto all'attaccante che conosce la logica interna del target. Questa asimmetria non è superabile con l'ispezione black-box, indipendentemente dalla quantità di richieste inviate. Va usato con una riga di raccordo che precisi che Spring tratta l'asimmetria nel senso della scoperta delle vulnerabilità in generale, mentre la tesi ne estende il concetto al contesto specifico del testing autorizzato dei gateway API.

**Punto di inserimento**
§2.9 (asimmetria informativa e limiti strutturali del testing perimetrale), in supporto all'affermazione che il paradigma black-box non può garantire copertura sufficiente per le vulnerabilità logiche. **Nota di utilizzo**: il paper di Spring argomenta l'illimitatezza delle vulnerabilità non scoperte sul piano della teoria della computabilità, non tratta esplicitamente il black-box testing come paradigma di assessment. Il `\cite{}` va associato a un'affermazione circoscritta — ad esempio "la persistenza strutturale di vulnerabilità non scoperte nei sistemi software moderni è stata formalizzata su basi computazionali" — evitando di attribuirgli affermazioni sul confronto tra paradigmi di testing che il paper non contiene.

```bibtex
@article{spring2023analysis,
  title={An analysis of how many undiscovered vulnerabilities remain in information systems},
  author={Spring, Jonathan M.},
  journal={Computers \& Security},
  volume={131},
  pages={103191},
  year={2023},
  publisher={Elsevier},
  doi={10.1016/j.cose.2023.103191}
}
```

---

### Capitolo 3 — Metodologia

---

#### [A-09] Deriving Semantics-Aware Fuzzers from Web API Schemas (Schemathesis)

**Metadati**
- **Titolo**: Deriving Semantics-Aware Fuzzers from Web API Schemas
- **Autori**: Zac Hatfield-Dodds, Dmitry Dygalo
- **Sede**: 2022 IEEE/ACM 44th International Conference on Software Engineering: **Companion Proceedings (ICSE-Companion)**
- **Anno**: 2022
- **DOI/arXiv**: `10.48550/arXiv.2112.10328`
- **Accesso aperto**: https://arxiv.org/pdf/2112.10328
- **Stato**: Pubblicazione peer-reviewed. **Correzione applicata**: la sede è ICSE-Companion (proceedings supplementari), non la conferenza principale ICSE. Il BibTeX di Gemini non faceva questa distinzione.

**Rilevanza**
Il paper introduce Schemathesis, uno strumento che deriva fuzzers strutturalmente e semanticamente consapevoli dalle specifiche OpenAPI o GraphQL, basandosi su property-based testing. Gli autori dimostrano su trenta esecuzioni indipendenti contro sedici API containerizzate open source che Schemathesis supera tutti i competitor per numero di difetti unici trovati (1.4x–4.5x rispetto al secondo classificato), ed è l'unico strumento a gestire più di due terzi dei target senza errori interni fatali. Il paper è rilevante per la tesi in due punti: (1) §3.2, dove si descrive OpenAPI come fonte autoritativa per la derivazione dei test; (2) come benchmark rispetto al quale APIGuard si posiziona: Schemathesis fuzza per trovare difetti (crash, conformity violation), APIGuard testa per verificare garanzie di sicurezza specifiche, orientandosi verso un assessment sistematico piuttosto che verso una scoperta statistica.

**Punto di inserimento**
§3.2 (`\subsec:openapi-sot`), nella discussione su OpenAPI come Single Source of Truth per la generazione dei test. Citabile anche nella `tab:semantic-gap` (Tabella C), che lo menziona già come "Fuzzer OAS (RESTler/Schemathesis)".

```bibtex
@inproceedings{hatfield2022schemathesis,
  title={Deriving Semantics-Aware Fuzzers from Web API Schemas},
  author={Hatfield-Dodds, Zac and Dygalo, Dmitry},
  booktitle={2022 IEEE/ACM 44th International Conference on Software Engineering:
             Companion Proceedings (ICSE-Companion)}, % CORRETTO: era "ICSE" senza "Companion"
  pages={345--346},
  year={2022},
  organization={ACM/IEEE},
  doi={10.48550/arXiv.2112.10328}
}
```

---

#### [A-10] SATORI: Static Test Oracle Generation for REST APIs

**Metadati**
- **Titolo**: SATORI: Static Test Oracle Generation for REST APIs
- **Autori**: Juan C. Alonso, Alberto Martin-Lopez, Sergio Segura, Gabriele Bavota, Antonio Ruiz-Cortés
- **Sede**: 40th IEEE/ACM International Conference on Automated Software Engineering (ASE 2025)
- **Anno**: 2025
- **DOI/arXiv**: `10.48550/arXiv.2508.16318`; disponibile anche su IEEE Xplore (ASE 2025 proceedings)
- **Accesso aperto**: https://arxiv.org/pdf/2508.16318
- **Stato**: Pubblicazione peer-reviewed, ASE 2025. **Correzione applicata**: Gemini includeva "Ernst, M.D." come autore (errato) e ometteva Gabriele Bavota. La lista corretta è quella riportata sopra.

**Rilevanza**
SATORI (Static API Test ORacle Inference) genera automaticamente oracoli di test per REST API analizzando staticamente la specifica OpenAPI con LLM, senza necessità di eseguire il sistema target. Il paper valuta l'approccio su 17 operazioni da 12 API industriali, raggiungendo un F1-score del 74.3% e superando il precedente stato dell'arte dinamico (AGORA+, 69.3%). Il risultato più utile per la tesi è la dimostrazione di complementarità tra metodi statici e dinamici: SATORI e AGORA+ insieme coprono il 90% degli oracoli nel ground-truth. Questo supporta la scelta architetturale di APIGuard di ancorare la verifica a oracoli derivati formalmente dalla specifica OpenAPI piuttosto che da euristica dinamica, anticipando anche la discussione sul limite dell'oracle problem nel §6.

**Punto di inserimento**
§3.3 (oracolo formale basato su OpenAPI), per supportare l'affermazione che la specifica OpenAPI è sufficiente come base per la derivazione di oracoli di verifica delle garanzie di sicurezza. Citabile anche in §6 per la discussione sull'oracle problem e le sue soluzioni emergenti.

```bibtex
@inproceedings{alonso2025satori,
  title={{SATORI}: Static Test Oracle Generation for {REST} {APIs}},
  author={Alonso, Juan C. and Martin-Lopez, Alberto and Segura, Sergio and
          Bavota, Gabriele and Ruiz-Cort{\'e}s, Antonio},
  % CORRETTO: rimosso Ernst M.D. (non è autore); aggiunto Bavota, Gabriele
  booktitle={Proceedings of the 40th IEEE/ACM International Conference on
             Automated Software Engineering (ASE 2025)},
  year={2025},
  organization={IEEE/ACM},
  doi={10.48550/arXiv.2508.16318}
}
```

---

#### [A-11] Vulnerability-oriented Testing for RESTful APIs (VOAPI2)

**Metadati**
- **Titolo**: Vulnerability-oriented Testing for RESTful APIs
- **Autori**: Wenlong Du, Jian Li, Yanhao Wang, Libo Chen, Ruijie Zhao, Junmin Zhu, Zhengguang Han, Yijun Wang, Zhi Xue
- **Sede**: 33rd USENIX Security Symposium (USENIX Security 2024), Philadelphia
- **Anno**: 2024
- **Pagine**: 739--755
- **ISBN**: 978-1-939133-44-1
- **Accesso aperto**: https://www.usenix.org/system/files/usenixsecurity24-du.pdf
- **Stato**: Pubblicazione peer-reviewed, USENIX Security (top-tier). **Correzione critica applicata**: Gemini attribuiva a questo URL il titolo inventato "Understanding OpenAPI Parsing and Syntax Rules for Fuzzing Automation". Il titolo reale è quello riportato sopra.

**Rilevanza**
VOAPI2 propone un framework di testing orientato alla vulnerabilità che, partendo dall'osservazione che la tipologia di vulnerabilità nascosta in un endpoint è inferibile dal suo comportamento e dalla sua struttura, genera sequenze di test mirate a innescare specifiche classi di difetti (SSRF, path traversal, information disclosure) piuttosto che a esplorare genericamente lo spazio degli input. La sede (USENIX Security) garantisce la solidità peer-reviewed. Per la tesi, il contributo è doppio: (1) supporta l'argomentazione che i fuzzer generici non raggiungono le vulnerabilità semantiche perché non sanno cosa cercare; (2) mostra come la struttura della specifica OpenAPI (path parameters, request body schema, response schema) possa essere usata per orientare la generazione dei test verso le condizioni che espongono le vulnerabilità di interesse.

**Punto di inserimento**
§3.2 (`\subsec:openapi-sot`), come precedente che usa OpenAPI per orientare il testing verso vulnerabilità specifiche, in linea con l'approccio di APIGuard ai domani di garanzia.

```bibtex
@inproceedings{du2024voapi2,
  title={Vulnerability-oriented Testing for {RESTful} {APIs}},
  % CORRETTO: titolo completamente diverso da quello fornito da Gemini
  author={Du, Wenlong and Li, Jian and Wang, Yanhao and Chen, Libo and
          Zhao, Ruijie and Zhu, Junmin and Han, Zhengguang and
          Wang, Yijun and Xue, Zhi},
  booktitle={33rd USENIX Security Symposium (USENIX Security 24)},
  pages={739--755},
  year={2024},
  isbn={978-1-939133-44-1},
  publisher={USENIX Association},
  url={https://www.usenix.org/conference/usenixsecurity24/presentation/du}
}
```

---

#### [A-12] Parallelization in System-Level Testing: Novel Approaches to Manage Test Suite Dependencies (PFAST)

**Metadati**
- **Titolo**: Parallelization in System-Level Testing: Novel Approaches to Manage Test Suite Dependencies
- **Autori**: Pasquale Polverino, Fabio Di Lauro, Matteo Biagiola, Paolo Tonella, Antonio Carzaniga
- **Sede**: *IEEE Transactions on Software Engineering*, vol. XY (articolo online first), 2025
- **Anno**: 2025
- **DOI**: `10.1109/TSE.2025.3572388`
- **Accesso aperto**: https://www.inf.usi.ch/carzaniga/papers/pdbtc_tse25.pdf
- **Stato**: Pubblicazione peer-reviewed, IEEE Transactions on Software Engineering (top-tier). **Due correzioni applicate**: (1) DOI corretto da `10.1109/TSE.2025.11008768` (numero documento IEEE Xplore) a `10.1109/TSE.2025.3572388` (DOI canonico); (2) autori completi includono Biagiola e Tonella, omessi da Gemini.

**Rilevanza**
Il paper formalizza due algoritmi (PFAST e Mem-FAST) per il rilevamento automatico delle dipendenze tra test di sistema e la costruzione di schedule paralleli coerenti, con valutazione su sei applicazioni web e sui test di MySQL. L'algoritmo PFAST costruisce un Test Dependency Graph attraverso ordinamento topologico e rimozione iterativa di dipendenze, esattamente la struttura che APIGuard implementa per gestire l'ordine di esecuzione dei 18 test distribuiti su 7 domini. Il paper dimostra speedup significativi rispetto all'esecuzione sequenziale mantenendo l'integrità dei dati di test, confermando la scelta architetturale del DAG come meccanismo di scheduling. Per la tesi, è la referenza accademica centrale per la proprietà D2.P2 (DAG-Based Dependency Scheduling).

**Punto di inserimento**
§3.4 (DAG scheduling e ordinamento topologico delle dipendenze), come validazione formale della scelta architetturale. Citabile anche in §4 nell'implementazione dello scheduler.

```bibtex
@article{polverino2025parallelization,
  title={Parallelization in System-Level Testing: Novel Approaches to
         Manage Test Suite Dependencies},
  author={Polverino, Pasquale and Di Lauro, Fabio and Biagiola, Matteo
          and Tonella, Paolo and Carzaniga, Antonio},
  % CORRETTO: aggiunti Biagiola, Matteo e Tonella, Paolo (omessi da Gemini)
  journal={IEEE Transactions on Software Engineering},
  year={2025},
  publisher={IEEE},
  doi={10.1109/TSE.2025.3572388} % CORRETTO: era 10.1109/TSE.2025.11008768
}
```

---

#### [A-13] Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing

**Metadati**
- **Titolo**: Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing
- **Autori**: Nathaniel Bennett, Tyler Tucker, Carson Stillman, William Enck, Patrick Traynor, Kevin Butler
- **Sede**: 47th IEEE Symposium on Security and Privacy (IEEE S&P / Oakland 2026)
- **Anno**: 2026
- **DOI**: `10.1109/SP63933.2026.00091` — **DA VERIFICARE** una volta che i proceedings IEEE saranno completamente indicizzati.
- **Accesso**: https://www.computer.org/csdl/proceedings-article/sp/2026/606500b689/2bojwkNTstO
- **Stato**: Pubblicazione peer-reviewed, IEEE S&P (top-tier). DOI provvisorio da verificare. Autori e titolo confermati dalla pagina degli accepted papers del convegno.

**Rilevanza**
Fizzle affronta il problema del non-determinismo nel fuzzing di rete imponendo un'esecuzione sequenziale deterministica attraverso l'interposizione delle librerie di sistema che intercettano le chiamate asincrone e serializzano le primitive di I/O e di sincronizzazione. Il framework garantisce che dato lo stesso seed iniziale, una sequenza di test produca sempre gli stessi risultati indipendentemente dalla latenza di rete o dal bilanciamento del carico del target. Questo è direttamente rilevante per la proprietà di riproducibilità di APIGuard descritta nella sezione `\subsec:reproducibility` della tesi: la capacità di APIGuard di produrre risultati idempotenti (run 1 = run 2, documentata nell'audit Milestone 1) si basa su principi analoghi di isolamento del contesto e determinismo nell'ordinamento delle operazioni.

**Punto di inserimento**
§3.5 (riproducibilità e determinismo nel security testing), come riferimento accademico per il principio che la riproducibilità richiede controllo esplicito della fonte di non-determinismo.

```bibtex
@inproceedings{bennett2026fizzle,
  title={Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing},
  author={Bennett, Nathaniel and Tucker, Tyler and Stillman, Carson and
          Enck, William and Traynor, Patrick and Butler, Kevin},
  booktitle={47th IEEE Symposium on Security and Privacy (S\&P)},
  % pages: DA VERIFICARE — non reperibili da fonti disponibili al momento della verifica;
  %         aggiungere il campo dopo conferma su IEEE Xplore
  year={2026},
  organization={IEEE},
  doi={10.1109/SP63933.2026.00091} % DA VERIFICARE: confermare DOI su IEEE Xplore
}
```

---

### Capitolo 4 — Implementazione

---

#### [A-14] SoK: Understanding CI/CD Security

**Metadati**
- **Titolo**: SoK: Understanding CI/CD Security: A Comprehensive Review of Architecture, Attacks, and Defenses
- **Autori**: R. Zmuda, R. Graves, M. Shepherd, S. Brookes — **DA VERIFICARE**: i nomi per esteso non sono stati reperiti nei risultati di ricerca; aprire il PDF all'URL per confermare.
- **Sede**: 2025 IEEE Secure Development Conference (SecDev 2025), Indianapolis
- **Anno**: 2025
- **URL**: https://www.computer.org/csdl/proceedings-article/secdev/2025/959500a058/2bPJoAN55Ju
- **Stato**: Pubblicazione peer-reviewed, IEEE SecDev 2025. **Correzione critica applicata**: Gemini attribuiva a questo URL il titolo inventato "Automated Secret Redaction and Credential Hygiene in CI/CD Environments". Il titolo reale è quello riportato sopra.

**Rilevanza**
Il paper è un Systematization of Knowledge sulla sicurezza delle pipeline CI/CD, che include il threat model, la tassonomia degli attacchi (code injection, supply chain, credential leakage) e la revisione delle difese architetturali. Per la tesi, la sezione più pertinente è quella sulla gestione dei segreti nelle pipeline: i segreti che transitano attraverso i runner di test (token JWT, API key, password) devono essere trattati come dati sensibili e mai scritti in chiaro nei log, principio che APIGuard implementa tramite la proprietà D5.P4 (Structured Logging con Credential Redaction Obbligatoria). Il SoK fornisce la contestualizzazione accademica di questo principio nel quadro più ampio della sicurezza delle pipeline CI/CD.

**Punto di inserimento**
§4 (implementazione), nella sezione dedicata alla proprietà D5.P4 (credential redaction nel logging strutturato), come riferimento per il principio che la gestione dei segreti nei log di audit è un problema riconosciuto nella letteratura CI/CD.

```bibtex
@inproceedings{zmuda2025sok,
  title={{SoK}: Understanding {CI/CD} Security: A Comprehensive Review
         of Architecture, Attacks, and Defenses},
  % CORRETTO: titolo completamente diverso da quello fornito da Gemini
  author={Zmuda, R. and Graves, R. and Shepherd, M. and Brookes, S.},
  % DA VERIFICARE: nomi per esteso da confermare sul PDF
  booktitle={2025 IEEE Secure Development Conference (SecDev)},
  year={2025},
  organization={IEEE},
  url={https://www.computer.org/csdl/proceedings-article/secdev/2025/959500a058/2bPJoAN55Ju}
}
```

---

### Capitolo 5 — Validazione Sperimentale

---

#### [A-15] Automated Verification of Idempotence for Stateful Serverless Applications (Flux)

**Metadati**
- **Titolo**: Automated Verification of Idempotence for Stateful Serverless Applications
- **Autori**: Haoran Ding, Zhaoguo Wang, Zhuohao Shen, Rong Chen, Haibo Chen
- **Sede**: 17th USENIX Symposium on Operating Systems Design and Implementation (OSDI 2023), Boston
- **Anno**: 2023
- **Pagine**: 887--910
- **ISBN**: 978-1-939133-34-2
- **Accesso aperto**: https://www.usenix.org/system/files/osdi23-ding.pdf
- **Stato**: Pubblicazione peer-reviewed, USENIX OSDI (top-tier). Nessuna correzione necessaria.

**Rilevanza**
Il paper introduce Flux, un sistema che verifica formalmente la proprietà di idempotenza per applicazioni serverless stateful, definendo "idempotence consistency" come la condizione per cui ogni possibile albero di esecuzione contenente retry ha una traccia lineare corrispondente (senza retry) che simula lo stesso comportamento osservabile. Flux non richiede la verifica esaustiva di tutti gli interleaving (computazionalmente proibitiva) ma usa un approccio composizionale che identifica le funzioni che violano l'idempotenza e inietta selettivamente meccanismi di write-ahead log. Per la tesi, il concetto di idempotenza formalizzato in questo paper è la base teorica per la sezione sperimentale che documenta la stabilità run-su-run di APIGuard (n=2, come da `AUDIT_milestone1_release.md`). La proprietà verificata nell'audit ("stessi finding, stesso ordine, stesso numero di transazioni") è una forma empirica di idempotenza dell'assessment.

**Punto di inserimento**
§5 (validazione sperimentale), nella sezione sull'idempotenza dei test, per ancorare il concetto a una definizione formale. Citabile anche in §6 per la discussione sui limiti della verifica formale dell'idempotenza in sistemi Turing-completi.

```bibtex
@inproceedings{ding2023flux,
  title={Automated Verification of Idempotence for Stateful Serverless Applications},
  author={Ding, Haoran and Wang, Zhaoguo and Shen, Zhuohao and Chen, Rong and Chen, Haibo},
  booktitle={17th USENIX Symposium on Operating Systems Design and
             Implementation (OSDI 23)},
  pages={887--910},
  year={2023},
  isbn={978-1-939133-34-2},
  publisher={USENIX Association},
  url={https://www.usenix.org/conference/osdi23/presentation/ding}
}
```

---

---

## FASCIA B — TENERE CON RISERVA

*Le voci in questa fascia sono reali e pertinenti ma presentano uno o più dei seguenti limiti: venue di profilo basso per la disciplina, status di preprint senza conferenza assegnata, autori parzialmente non verificati, o rilevanza solo indiretta. Inserire con cautela, preferibilmente come citazioni secondarie a supporto di un punto già fondato da una voce Fascia A.*

---

### Capitolo 2 — Background e Stato dell'Arte

---

#### [B-01] Shepherd: Adaptive Detection of Suspicious API Interaction Flows in Microservices

**Metadati**
- **Autori**: Chaeho Kim, Jaehyun Nam
- **Sede**: 29th Asia-Pacific Conference on Communications (APCC 2025)
- **Anno**: 2025
- **PDF**: https://www.ieice.org/publications/proceedings/bin/pdf_link.php?fname=T3-1-6.pdf&iconf=APCC&year=2025
- **Limite**: Venue di basso profilo per la cybersecurity; nessun DOI canonico reperibile.

**Rilevanza**
Il paper propone un sistema basato su Graph Attention Network per rilevare in tempo reale flussi di interazione anomali tra microservizi, usando sia feature strutturali (topologia del grafo di comunicazione) sia semantiche (contenuto delle richieste). È pertinente per §2.5 (Shadow API e anomaly detection negli ecosistemi a microservizi).

**Punto di inserimento**
§2.5, come nota laterale sulla possibilità di rilevazione comportamentale delle Shadow API in ambienti runtime, in contrasto con l'approccio dichiarativo di APIGuard.

```bibtex
@inproceedings{kim2025shepherd,
  title={Shepherd: Adaptive Detection of Suspicious API Interaction
         Flows in Microservices},
  author={Kim, Chaeho and Nam, Jaehyun},
  booktitle={2025 29th Asia-Pacific Conference on Communications (APCC)},
  year={2025},
  organization={IEEE}
}
```

---

#### [B-02] A Model to Limit Batching Denial of Service Attacks on GraphQL

**Metadati**
- **Autori**: Arno Möller, Sheunesu M. Makura, Hein S. Venter
- **Sede**: 2024 IST-Africa Conference (IST-Africa), IEEE
- **Anno**: 2024
- **Limite**: Venue di profilo basso per la sicurezza informatica; nessun DOI canonico verificato.

**Rilevanza**
Analizza il meccanismo di batching in GraphQL come vettore per aggirare i controlli volumetrici e propone un modello ibrido di Query Cost Analysis. Complementare a WENDIGO [A-06], che affronta lo stesso problema con DRL. Se WENDIGO è già citato, questo paper aggiunge la prospettiva difensiva (limitazione lato server).

**Punto di inserimento**
§2.8 (GraphQL DoS), come riferimento secondario sulle difese, dopo WENDIGO.

```bibtex
@inproceedings{moller2024graphql,
  title={A Model to Limit Batching Denial of Service Attacks on {GraphQL}},
  author={M{\"o}ller, Arno and Makura, Sheunesu M. and Venter, Hein S.},
  booktitle={2024 IST-Africa Conference (IST-Africa)},
  year={2024},
  organization={IEEE}
}
```

---

### Capitolo 3 — Metodologia

---

#### [B-03] ORANalyst: Systematic Testing Framework for Open RAN Implementations

**Metadati**
- **Autori**: Tianchang Yang, Syed Md Mukit Rashid, Ali Ranjbar, Gang Tan, Syed Rafiul Hussain
- **Sede**: 33rd USENIX Security Symposium (USENIX Security 2024), Philadelphia
- **Anno**: 2024
- **Pagine**: 1921--1938
- **Accesso aperto**: https://www.usenix.org/system/files/usenixsecurity24-yang-tianchang.pdf
- **Limite**: Il dominio (reti 5G Open RAN) è distante dalla tesi; il collegamento al DAG di APIGuard è per analogia metodologica, non per identità di contesto. **Correzione critica**: Gemini attribuiva a questo URL il titolo inventato "Static Analysis based on Program Dependency Graph for Test Sequencing". Il titolo reale è quello riportato.

**Rilevanza**
ORANalyst combina static analysis e dynamic tracing per mappare le dipendenze tra componenti microservice in O-RAN, poi usa questa mappa per generare input che esercitano le dipendenze e testano ogni componente target. La struttura (mappa delle dipendenze → schedule ordinato → test mirato) è analogica al DAG di APIGuard. La sede (USENIX Security, top-tier) è ottima; il problema è la distanza di dominio.

**Punto di inserimento**
§3.4 (DAG scheduling), come citazione di supporto che mostra lo stesso principio applicato a un dominio diverso (5G microservices), rafforzando la generalità dell'approccio.

```bibtex
@inproceedings{yang2024orananalyst,
  title={{ORANalyst}: Systematic Testing Framework for Open {RAN}
         Implementations},
  % CORRETTO: titolo completamente diverso da quello fornito da Gemini
  author={Yang, Tianchang and Rashid, Syed Md Mukit and Ranjbar, Ali
          and Tan, Gang and Hussain, Syed Rafiul},
  booktitle={33rd USENIX Security Symposium (USENIX Security 24)},
  pages={1921--1938},
  year={2024},
  isbn={978-1-939133-44-1},
  publisher={USENIX Association},
  url={https://www.usenix.org/conference/usenixsecurity24/presentation/yang-tianchang}
}
```

---

#### [B-04] Valkyrie: Improving Fuzzing Performance through Deterministic Techniques

**Metadati**
- **Sede**: 2022 IEEE International Conference on Software Quality, Reliability and Security (QRS 2022)
- **Anno**: 2022
- **URL IEEE Xplore**: https://ieeexplore.ieee.org/document/10062373/
- **Limite**: Gli autori non erano reperibili dai risultati di ricerca disponibili. **DA VERIFICARE**: aprire il link IEEE Xplore e recuperare la lista completa degli autori prima di inserire in Zotero.

**Rilevanza**
Documenta le performance superiori del fuzzing greybox quando supportato da tecniche deterministiche rispetto alle mutazioni puramente randomiche. Complementare a Fizzle [A-13]; mentre Fizzle tratta il determinismo a livello di rete, Valkyrie lo tratta a livello di mutazione dei payload.

**Punto di inserimento**
§3.5 (riproducibilità), come citazione secondaria a supporto del principio che il determinismo migliora la qualità del fuzzing.

```bibtex
% DA COMPLETARE: recuperare autori da https://ieeexplore.ieee.org/document/10062373/
@inproceedings{valkyrie2022deterministic,
  title={Valkyrie: Improving Fuzzing Performance Through Deterministic Techniques},
  author={}, % DA VERIFICARE: autori non disponibili al momento della verifica
  booktitle={2022 IEEE 22nd International Conference on Software Quality,
             Reliability and Security (QRS)},
  year={2022},
  organization={IEEE},
  url={https://ieeexplore.ieee.org/document/10062373/}
}
```

---

### Capitolo 5 — Validazione Sperimentale

---

#### [B-05] DASTestBed: An Automated Benchmarking Framework for DAST Scanners

**Metadati**
- **Autori**: Rand Deeb, Alisa Vorobeva, Omar Farshad Jeelani
- **Sede**: 14th International Symposium on Digital Forensics and Security (ISDFS 2026)
- **Anno**: 2026
- **DOI**: Non disponibile al momento della verifica — **DA VERIFICARE** su IEEE Xplore o ACM DL dopo la pubblicazione.
- **Limite**: ISDFS è una conferenza reale ma di profilo basso; nessun DOI canonico verificato.

**Rilevanza**
Il paper presenta DASTestBed, un framework containerizzato per il benchmarking comparativo di scanner DAST su un ground truth estendibile. I dati empirici confrontano Nuclei (CPU 0.92%, RAM 937MB, precisione 1.00, richiamo 0.15) con OWASP ZAP (CPU 91%, RAM 3.2GB, precisione 0.70, richiamo 0.97), dimostrando il trade-off fondamentale tra footprint delle risorse e copertura della vulnerabilità. Questi dati sono direttamente utili per contestualizzare il profilo di performance di APIGuard (286s wall-clock, 287MB picco) nella discussione del §5 e per motivare le scelte di progettazione orientate all'efficienza delle risorse.

**Punto di inserimento**
§5, nella sezione sulle performance e sul profilo di resource consumption, come termine di confronto per il footprint di APIGuard rispetto ad altri strumenti DAST.

```bibtex
@inproceedings{deeb2026dastestbed,
  title={{DASTestBed}: An Automated Benchmarking Framework for {DAST}
         Scanners with Extensible Ground Truth Modeling},
  author={Deeb, Rand and Vorobeva, Alisa and Jeelani, Omar Farshad},
  booktitle={14th International Symposium on Digital Forensics and Security
             (ISDFS 2026)},
  year={2026},
  note={DOI non disponibile al momento della verifica}
}
```

---

#### [B-06] Adaptive and AI-Augmented Security Testing: A Systematic Survey

**Metadati**
- **Autori**: Michael Wienczkowski
- **Sede**: arXiv preprint (arXiv:2604.27000)
- **Anno**: 2026
- **DOI**: `10.48550/arXiv.2604.27000`
- **Limite**: Preprint single-author; nessuna sede peer-reviewed verificata.

**Rilevanza**
Survey sistematico che include la formalizzazione del concetto di "proof of coverage" (prova di copertura) come metrica statistica per valutare la completezza delle campagne di security testing. Utile per §5 come riferimento teorico alla nozione di copertura dimostrabile, che APIGuard implementa attraverso l'audit trail completo delle transazioni HTTP (incluse quelle PASS).

**Punto di inserimento**
§5, nella discussione sulla proof of coverage e sulla dimostrazione forense che la superficie dichiarata è stata testata.

```bibtex
@article{wienczkowski2026adaptive,
  title={Adaptive and {AI}-Augmented Security Testing: A Systematic Survey
         of Program Analysis, Feedback-Driven Testing, and Hybrid
         Learning-Based Approaches},
  author={Wienczkowski, Michael},
  journal={arXiv preprint arXiv:2604.27000},
  year={2026},
  doi={10.48550/arXiv.2604.27000}
}
```

---

### Capitoli 6 e 7 — Discussione e Sviluppi Futuri

---

#### [B-07] API Drift Detection: Enhancing Data Protection

**Metadati**
- **Autori**: McKinley Sconiers-Hasan et al.
- **Sede**: International Journal of Computer Applications Technology and Research (IJCATM)
- **Anno**: 2024
- **URL**: https://www.researchgate.net/publication/386251964
- **Limite**: IJCATM non è indicizzato in Scopus o WoS; venire di profilo incerto. "et al." perché la lista completa degli autori non era verificabile dalla ricerca.

**Rilevanza**
Affronta lo specification drift nei contratti OpenAPI, definendo le cause (velocità di sviluppo Agile, mancanza di validazione continua) e le conseguenze sulla postura di sicurezza (endpoint non documentati, parametri orfani). Pertinente per §6, dove si discute il limite principale dell'approccio contract-driven: se la specifica OpenAPI diverge dall'implementazione reale, le garanzie di APIGuard valgono rispetto al contratto dichiarato, non rispetto al comportamento effettivo.

**Punto di inserimento**
§6 (limiti del contract-driven testing e specification drift), come evidenza empirica del fenomeno.

```bibtex
@article{sconiers2024apidrift,
  title={API Drift Detection: Enhancing Data Protection},
  author={Sconiers-Hasan, McKinley and others},
  % DA VERIFICARE: lista completa degli autori
  journal={International Journal of Computer Applications Technology
           and Research},
  year={2024},
  url={https://www.researchgate.net/publication/386251964}
}
```

---

#### [B-08] PyPitfall: Dependency Chaos and Software Supply Chain Vulnerabilities in Python

**Metadati**
- **Autori**: Jacob Mahon, Chenxi Hou, Zhihao Yao
- **Sede**: IEEE International Conference on Big Data 2025 (conferma pubblicazione da verificare)
- **Anno**: 2025
- **DOI/arXiv**: `10.48550/arXiv.2507.18075`
- **Accesso aperto**: https://arxiv.org/html/2507.18075v1
- **Limite**: La pubblicazione su IEEE Big Data 2025 è indicata ma non confermata con DOI definitivo.

**Rilevanza**
PyPitfall analizza 378.573 pacchetti PyPI e trova che 4.655 richiedono esplicitamente dipendenze con CVE note e 141.044 ammettono versioni vulnerabili. Questo quantifica l'entità del rischio di supply chain nell'ecosistema Python, che è l'ecosistema di sviluppo di APIGuard. Pertinente per §6/§7 nella discussione sull'integrità della supply chain dello strumento stesso (reproducible builds, lock file, SBOM).

**Punto di inserimento**
§6/§7, nella discussione sulla sicurezza della supply chain di APIGuard come strumento Python, e nella motivazione dell'uso di pip-audit e hash pinning nel processo di build.

```bibtex
@inproceedings{mahon2025pypitfall,
  title={PyPitfall: Dependency Chaos and Software Supply Chain
         Vulnerabilities in Python},
  author={Mahon, Jacob and Hou, Chenxi and Yao, Zhihao},
  booktitle={IEEE International Conference on Big Data},
  year={2025},
  doi={10.48550/arXiv.2507.18075}
  % DA VERIFICARE: confermare pubblicazione IEEE Big Data 2025
}
```

---

#### [B-09] DoD Enterprise DevSecOps Reference Design

**Metadati**
- **Istituzione**: Chief Information Officer, US Department of Defense
- **Anno**: 2021
- **URL**: https://dodcio.defense.gov/Portals/0/Documents/DoD%20Enterprise%20DevSecOps%20Reference%20Design%20v1.0_Public%20Release.pdf
- **Tipo**: Documento normativo istituzionale (non peer-reviewed)
- **Limite**: Non è una pubblicazione accademica peer-reviewed. Accettabile come riferimento normativo/industriale.

**Rilevanza**
Il documento definisce i paradigmi architetturali e i requisiti di processo del DevSecOps per infrastrutture enterprise a scala globale, includendo il principio "fail-fast, fail small, and fail forward" come elemento progettuale per le pipeline CI/CD. Per la tesi, è il riferimento normativo per la sezione che descrive l'integrazione di APIGuard in pipeline CI/CD (proprietà D6.P1, semantic exit codes) e la filosofia fail-fast che giustifica l'interruzione immediata della pipeline in presenza di finding P0.

**Punto di inserimento**
§6 (integrazione CI/CD e DevSecOps), come documento normativo di riferimento per i principi architetturali delle pipeline sicure.

```bibtex
@techreport{dod2021devsecops,
  title={{DoD} Enterprise {DevSecOps} Reference Design},
  author={{US Department of Defense}},
  institution={Chief Information Officer, US Department of Defense},
  year={2021},
  url={https://dodcio.defense.gov/Portals/0/Documents/DoD\%20Enterprise\%20DevSecOps\%20Reference\%20Design\%20v1.0_Public_Release.pdf}
}
```

---

#### [B-10] Continuous Security Assurance in Multi-Platform CI/CD Environments

**Metadati**
- **Titolo**: Da verificare aprendo l'URL — il link punta a un articolo MDPI Future Internet sulla Continuous Security Assurance in ambienti CI/CD multi-piattaforma (GitHub Advanced Security, Azure DevOps).
- **Autori**: **DA VERIFICARE** — il BibTeX prodotto da Gemini riportava autori fittizi ("MDPI Authors"). Aprire l'URL e recuperare la lista reale prima di qualsiasi utilizzo.
- **Sede**: MDPI *Future Internet*, vol. 18, n. 2, art. 99 (2026 o anni prossimi)
- **Anno**: 2026 (anno indicato da Gemini; confermare sulla pagina)
- **URL**: https://www.mdpi.com/1999-5903/18/2/99
- **Limite**: MDPI Future Internet ha impact factor basso e politica open-access a pagamento; non è una sede tier-1. Gli autori non sono stati verificati. Usare solo dopo aver letto il paper e confermato che il contenuto supporta effettivamente le affermazioni citate.

**Rilevanza**
Il paper analizza l'integrazione della Continuous Security Assurance in pipeline CI/CD eterogenee, includendo la discussione su alert fatigue e il bilanciamento tra velocità di deployment e rigore dei controlli. Pertinente per §6 nella trattazione dell'integrazione di APIGuard in pipeline CI/CD (proprietà D6.P1 e D6.P2) e nella discussione sul trade-off tra coverage e overhead operativo, che la tesi affronta nel contesto degli ambienti enterprise.

**Punto di inserimento**
§6 (integrazione CI/CD e Continuous Security Assurance), come riferimento per il concetto di sicurezza continua nelle pipeline multi-piattaforma. Citabile solo dopo verifica del contenuto e degli autori reali.

```bibtex
% DA COMPLETARE prima dell'inserimento in Zotero:
% 1. Aprire https://www.mdpi.com/1999-5903/18/2/99
% 2. Recuperare titolo esatto, autori completi, anno definitivo
% 3. Sostituire i placeholder sottostanti con i dati reali
@article{mdpi2026continuous,
  title={}, % DA VERIFICARE: titolo esatto dalla pagina MDPI
  author={}, % DA VERIFICARE: autori reali (Gemini aveva prodotto autori fittizi)
  journal={Future Internet},
  volume={18},
  number={2},
  pages={99},
  year={2026}, % DA VERIFICARE: anno definitivo
  publisher={MDPI},
  url={https://www.mdpi.com/1999-5903/18/2/99}
}
```

---

## Appendice — Errori Sistematici Rilevati nei Risultati di Gemini

Questa sezione è inclusa a titolo di documentazione per futuri utilizzi dello stesso workflow.

**Titoli inventati su URL reali**: almeno tre paper riportavano il contenuto reale all'URL citato ma con un titolo completamente fabbricato. I casi identificati: (1) `usenixsecurity24-du.pdf` → titolo reale "Vulnerability-oriented Testing for RESTful APIs", non "Understanding OpenAPI Parsing and Syntax Rules for Fuzzing Automation"; (2) `usenixsecurity24-yang-tianchang.pdf` → titolo reale "ORANalyst", non "Static Analysis based on Program Dependency Graph for Test Sequencing"; (3) link SecDev 2025 → titolo reale "SoK: Understanding CI/CD Security", non "Automated Secret Redaction and Credential Hygiene".

**DOI di un paper diverso**: Il DOI `10.1145/3696410.3714825` attribuito da Gemini al paper "Internal APIs Are All You Need" appartiene in realtà al paper "Tool Learning in the Wild: Empowering Language Models as Automatic Tool Agents" (Shi et al., ACM Web Conference 2025). Il paper di Tham et al. è un preprint arXiv del 2026 (arXiv:2604.00694), non una pubblicazione ACM 2025.

**DOI come numero documento**: Il DOI `10.1109/TSE.2025.11008768` di Polverino et al. era il numero del documento su IEEE Xplore, non il DOI canonico. Il DOI corretto è `10.1109/TSE.2025.3572388`.

**Autori errati**: SATORI includeva "M.D. Ernst" (non autore) e ometteva Gabriele Bavota. Polverino et al. ometteva Biagiola e Tonella.

**Metadato arXiv mal attribuito**: il paper descritto come avente tre stati PASS/FAIL/INCONCLUSIVE in arXiv:2605.13898 è in realtà "Bidirectional Empowerment of Metamorphic Testing and Large Language Models: A Systematic Survey", un survey sull'MT applicato ai LLM. Il paper che effettivamente implementa verdetti trivalenti è AgentAssay (arXiv:2603.02601), non citato in questa lista perché il dominio (agenti AI) è troppo lontano dalla tesi.











































# Nuove Voci Bibliografiche — Ricerca Indipendente
*Ricerca eseguita il 29 maggio 2026 — Integrazioni al file `bibliografia_apiguard.md`*

---

## Nota metodologica

Questo documento riporta le voci trovate tramite ricerca web indipendente, non presenti nei tre file originali di Gemini. Ogni voce è stata verificata su almeno una fonte primaria (IEEE Xplore, ACM DL, USENIX, NIST CSRC, arXiv). Il formato è identico al documento principale; le voci possono essere inserite direttamente nel file `bibliografia_apiguard.md` alla posizione indicata.

---

## FASCIA A — RACCOMANDATO / RACCOMANDATO CON CORREZIONI

---

### Capitolo 2 — Background e Stato dell'Arte

---

#### [NEW-A-01] Automated Black-box Testing of Mass Assignment Vulnerabilities in RESTful APIs

**Metadati**
- **Titolo**: Automated Black-box Testing of Mass Assignment Vulnerabilities in RESTful APIs
- **Autori**: Davide Corradini, Michele Pasqua, Mariano Ceccato
- **Sede**: 45th IEEE/ACM International Conference on Software Engineering (ICSE 2023), Melbourne
- **Anno**: 2023
- **Pagine**: 2553--2564
- **DOI**: `10.1109/ICSE48619.2023.00213`
- **Accesso aperto**: https://arxiv.org/pdf/2301.01261
- **Stato**: Pubblicazione peer-reviewed, ICSE 2023 (tier-1, la sede più prestigiosa del software engineering).

**Rilevanza**
Il paper propone un approccio black-box completamente automatizzato per rilevare vulnerabilità di Mass Assignment nelle API RESTful, basato esclusivamente sulla specifica OpenAPI. La metodologia usa il clustering delle operazioni per identificare i campi read-only, genera poi sequenze di interazione che tentano di sovrascrivere quei campi tramite binding automatico del framework, e verifica il successo dell'exploit attraverso un oracolo di risposta. Questo paper è **più forte di Mazidi et al. EASE 2024 (A-05)** per la stessa categoria di vulnerabilità, grazie alla venue (ICSE vs EASE) e al contributo tecnico più rigoroso (testing automatico eseguibile vs analisi statica delle specifiche). I due paper sono complementari e vanno citati entrambi: Corradini dimostra la vulnerabilità tramite testing attivo, Mazidi la rileva in modo preventivo tramite mining delle specifiche. La connessione con APIGuard è diretta: entrambi dimostrano che i WAF non vedono il Mass Assignment e che solo l'analisi strutturale della specifica OpenAPI permette di identificare i campi a rischio.

**Punto di inserimento**
§2.3.2 (`\subsec:categorie-fallimento`), nella parte dedicata al Mass Assignment, come riferimento principale (con venue più forte di A-05) per l'affermazione che il rilevamento automatico di questa vulnerabilità richiede l'analisi dello schema OpenAPI e non l'ispezione del traffico.

```bibtex
@inproceedings{corradini2023massassignment,
  title={Automated Black-box Testing of Mass Assignment Vulnerabilities
         in {RESTful} {APIs}},
  author={Corradini, Davide and Pasqua, Michele and Ceccato, Mariano},
  booktitle={2023 IEEE/ACM 45th International Conference on Software
             Engineering (ICSE)},
  pages={2553--2564},
  year={2023},
  organization={IEEE},
  doi={10.1109/ICSE48619.2023.00213}
}
```

---

#### [NEW-A-02] Checking Security Properties of Cloud Service REST APIs

**Metadati**
- **Titolo**: Checking Security Properties of Cloud Service REST APIs
- **Autori**: Vaggelis Atlidakis, Patrice Godefroid, Marina Polishchuk
- **Sede**: 2020 IEEE 13th International Conference on Software Testing, Validation and Verification (ICST 2020), Porto
- **Anno**: 2020
- **Pagine**: 387--397
- **DOI**: `10.1109/ICST46399.2020.00046`
- **Accesso aperto**: https://patricegodefroid.github.io/public_psfiles/icst2020.pdf
- **Stato**: Pubblicazione peer-reviewed, IEEE ICST 2020. Stesso gruppo di ricerca di RESTler [A-01].

**Rilevanza**
Il paper estende RESTler con active property checkers che verificano automaticamente quattro proprietà di sicurezza formali delle API REST: (1) nessuna risorsa accessibile senza autenticazione, (2) nessuna risorsa accessibile dopo la sua cancellazione, (3) nessuna risorsa di un utente accessibile da un altro, (4) nessuna escalation di privilegi. Gli autori applicano questi checker su Azure e Office365, trovando bug reali che vengono poi corretti. Questo paper è il precedente diretto più vicino all'approccio di APIGuard nell'intera letteratura: un assessment tool che verifica garanzie di sicurezza formali piuttosto che cercare crash generici, con verifica dell'autenticazione (Domain 2 APIGuard), dell'autorizzazione orizzontale (Domain 3, BOLA), e dell'isolamento dei ruoli (Domain 4). Permette di posizionare APIGuard rispetto allo stato dell'arte: APIGuard estende questo framework a un API Gateway con oracolo formale basato sulla specifica OpenAPI e architettura multi-dominio a 7 aree.

**Punto di inserimento**
§3.3 (oracolo formale e property checking), come il precedente accademico più diretto che introduce la nozione di "security property checker" per REST API. Citabile anche in §2.4 nella discussione sull'evoluzione del fuzzing verso il security assessment formale.

```bibtex
@inproceedings{atlidakis2020checking,
  title={Checking Security Properties of Cloud Service {REST} {APIs}},
  author={Atlidakis, Vaggelis and Godefroid, Patrice and Polishchuk, Marina},
  booktitle={2020 IEEE 13th International Conference on Software Testing,
             Validation and Verification (ICST)},
  pages={387--397},
  year={2020},
  organization={IEEE},
  doi={10.1109/ICST46399.2020.00046}
}
```

---

#### [NEW-A-03] OWASP API Security Top 10 — Edizione 2023

**Metadati**
- **Titolo**: OWASP API Security Top 10 2023
- **Autore istituzionale**: OWASP Foundation
- **Anno**: 2023 (pubblicato luglio 2023)
- **URL canonico**: https://owasp.org/API-Security/editions/2023/en/0x11-t10/
- **Tipo**: Documento normativo di progetto open source, non peer-reviewed
- **Stato**: Riferimento normativo universalmente adottato nel settore. La tesi lo cita già come `\cite{MISSING:owasp:apisec:2023}` con un commento `% TODO: add to Zotero`. Questa voce risolve quella pendenza.

**Rilevanza**
Il documento classifica le dieci vulnerabilità API più critiche, con BOLA (API1:2023), Broken Authentication (API2:2023), Broken Object Property Level Authorization (API3:2023), Unrestricted Resource Consumption (API4:2023) e BFLA (API5:2023) nelle prime cinque posizioni. Tutte queste sono vulnerabilità di natura semantica, invisibili ai WAF tradizionali, e corrispondono esattamente ai domini di test di APIGuard (D3, D2, D3, D5, D3 rispettivamente). Il documento è già citato nel testo LaTeX della tesi (`\cite{MISSING:owasp:apisec:2023}`) ma manca la voce BibTeX. Non si tratta di una scelta: è una citazione obbligatoria per qualsiasi lavoro sull'API security nel 2024-2026.

**Punto di inserimento**
§2.3.1 e §2.3.2, come definizione normativa delle categorie di vulnerabilità semantica. Già referenziato nel testo; questa voce risolve il TODO esistente.

```bibtex
@misc{owasp2023apisec,
  title={{OWASP API Security Top 10} 2023},
  author={{OWASP Foundation}},
  year={2023},
  howpublished={OWASP Foundation},
  url={https://owasp.org/API-Security/editions/2023/en/0x11-t10/},
  note={Rilasciato luglio 2023}
}
```

---

### Capitolo 3 — Metodologia

---

#### [NEW-A-04] The Oracle Problem in Software Testing: A Survey

**Metadati**
- **Titolo**: The Oracle Problem in Software Testing: A Survey
- **Autori**: Earl T. Barr, Mark Harman, Phil McMinn, Muzammil Shahbaz, Shin Yoo
- **Sede**: *IEEE Transactions on Software Engineering*, vol. 41, n. 5, pp. 507--525
- **Anno**: 2015
- **DOI**: `10.1109/TSE.2014.2372785`
- **Accesso aperto**: http://www0.cs.ucl.ac.uk/staff/m.harman/tse-oracle.pdf
- **Nota sul filtro temporale**: Il paper è del 2015, fuori dal filtro "2019 in poi" applicato da Gemini. L'inclusione è giustificata: si tratta del survey canonico su un concetto fondamentale della tesi. È citato da tutti i paper del campo (Sahin 2026, SATORI 2025, EvoMaster) come definizione di riferimento. Omettere un survey fondazionale perché precedente al 2019 sarebbe metodologicamente scorretto.

**Rilevanza**
Il paper definisce il problema dell'oracolo di test nel modo più rigoroso e citato della letteratura: data una coppia (input, output), il problema dell'oracolo è determinare se l'output osservato è corretto. Il survey classifica le tecniche di automazione dell'oracolo (modellazione, specifica formale, contract-driven testing, metamorphic testing) e analizza i trade-off di ciascuna. Per la tesi, questo è il riferimento fondazionale per §3.3 (oracle formale in APIGuard) e per §6 (oracle problem come limite aperto). Ogni affermazione sulla difficoltà di definire un oracolo per le vulnerabilità semantiche delle API trova qui la propria giustificazione teorica. Citato esplicitamente anche in biblio-5-6-7.md (fonte 28) come riferimento per la discussione sull'oracle problem.

**Punto di inserimento**
§3.3 (oracolo formale basato su OpenAPI), come definizione di riferimento del problema che APIGuard risolve tramite la specifica come oracolo formale. Citabile anche in §6 nella discussione sul limite dell'oracle problem per le vulnerabilità semantiche non verificabili senza ground truth.

```bibtex
@article{barr2015oracle,
  title={The Oracle Problem in Software Testing: A Survey},
  author={Barr, Earl T. and Harman, Mark and McMinn, Phil and
          Shahbaz, Muzammil and Yoo, Shin},
  journal={IEEE Transactions on Software Engineering},
  volume={41},
  number={5},
  pages={507--525},
  year={2015},
  publisher={IEEE},
  doi={10.1109/TSE.2014.2372785}
}
```

---

### Capitoli 6 e 7 — Discussione e Sviluppi Futuri

---

#### [NEW-A-05] Guidelines for API Protection for Cloud-Native Systems (NIST SP 800-228)

**Metadati**
- **Titolo**: Guidelines for API Protection for Cloud-Native Systems
- **Autori**: Ramaswamy Chandramouli, Zack Butcher
- **Istituzione**: National Institute of Standards and Technology (NIST)
- **Anno**: 2025 (con aggiornamenti al 13 marzo 2026)
- **DOI**: `10.6028/NIST.SP.800-228`
- **Accesso aperto**: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-228.pdf
- **Tipo**: NIST Special Publication (normativo, non peer-reviewed nel senso accademico). Equivalente, per autorevolezza, alle RFC e agli IETF standard in campo protocollare.

**Rilevanza**
NIST SP 800-228 è il primo documento normativo ufficiale del governo USA specificamente dedicato alla protezione delle API nei sistemi cloud-native. Copre: identificazione e analisi dei fattori di rischio nelle fasi di sviluppo e runtime delle API, controlli di base e avanzati per le fasi pre-runtime e runtime, e analisi dei trade-off tra opzioni di implementazione. Per la tesi, questo documento è rilevante in due modi distinti. Nel capitolo di discussione (§6), fornisce il contesto normativo che giustifica un assessment tool come APIGuard: le garanzie che APIGuard verifica (autenticazione, autorizzazione, rate limiting, TLS) sono esattamente le categorie di controllo che NIST SP 800-228 prescrive come "basic controls" per qualsiasi API cloud-native. Nel capitolo di metodologia (§3), può essere citato come quadro normativo di riferimento all'interno del quale si collocano le scelte metodologiche del framework.

**Punto di inserimento**
§6 (discussione), nella contestualizzazione di APIGuard rispetto agli standard normativi industriali e governativi. Eventualmente §3.1 come riferimento normativo che motiva i domini di assessment scelti.

```bibtex
@techreport{nist2025sp800228,
  title={Guidelines for {API} Protection for Cloud-Native Systems},
  author={Chandramouli, Ramaswamy and Butcher, Zack},
  institution={National Institute of Standards and Technology (NIST)},
  number={{NIST SP} 800-228},
  year={2025},
  doi={10.6028/NIST.SP.800-228},
  url={https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-228.pdf}
}
```

---

#### [NEW-A-06] It's like flossing your teeth: Reproducible Builds for Software Supply Chain Security

**Metadati**
- **Titolo**: It's like flossing your teeth: On the Importance and Challenges of Reproducible Builds for Software Supply Chain Security
- **Autori**: Marcel Fourné, Dominik Wermke, William Enck, Sascha Fahl, Yasemin Acar
- **Sede**: 44th IEEE Symposium on Security and Privacy (IEEE S&P 2023), San Francisco
- **Anno**: 2023
- **Pagine**: 1527--1544
- **DOI**: `10.1109/SP46215.2023.10179320`
- **Accesso aperto**: https://par.nsf.gov/servlets/purl/10425119
- **Stato**: Pubblicazione peer-reviewed, IEEE S&P 2023 (tier-1, la sede di riferimento per la sicurezza informatica).

**Rilevanza**
Il paper conduce 24 interviste semi-strutturate con esperti del progetto Reproducible-Builds.org e identifica i fattori che rendono i reproducible builds difficili da adottare nella pratica industriale, proponendo un percorso incrementale. La tesi di fondo — che la riproducibilità delle build è un prerequisito necessario per l'integrità della supply chain, e che l'impossibilità di verificare bitwise l'artefatto compilato lascia aperta la finestra di attacco alla catena di distribuzione — è la giustificazione accademica per il principio di riproducibilità del testing discusso in §3.5 e per la discussione sulla supply chain di APIGuard come strumento Python. Questo paper è significativamente più forte di PyPitfall [B-08] per la stessa area tematica, per venue (IEEE S&P vs IEEE Big Data) e per la profondità della trattazione dei reproducible builds come prassi di sicurezza.

**Punto di inserimento**
§6/§7 (supply chain e riproducibilità dello strumento), come riferimento principale per il principio che la riproducibilità delle build è una garanzia di sicurezza e non solo una proprietà di ingegneria del software. Il paper motiva perché APIGuard deve avere un processo di build riproducibile (lock files, hash pinning, SBOM) per essere fidato come strumento di assessment.

```bibtex
@inproceedings{fourne2023reproducible,
  title={It's like flossing your teeth: On the Importance and Challenges
         of Reproducible Builds for Software Supply Chain Security},
  author={Fourn{\'e}, Marcel and Wermke, Dominik and Enck, William and
          Fahl, Sascha and Acar, Yasemin},
  booktitle={2023 IEEE Symposium on Security and Privacy (S\&P)},
  pages={1527--1544},
  year={2023},
  organization={IEEE},
  doi={10.1109/SP46215.2023.10179320}
}
```

---

## FASCIA B — TENERE CON RISERVA

---

### Capitolo 2 — Background e Stato dell'Arte

---

#### [NEW-B-01] WuppieFuzz: Coverage-Guided, Stateful REST API Fuzzing

**Metadati**
- **Titolo**: WuppieFuzz: Coverage-Guided, Stateful REST API Fuzzing
- **Autori**: Thomas Rooijakkers, Anne Nijsten, Cristian Daniele, Erieke Weitenberg, R. Groenewegen, A. Melissen
- **Sede**: 12th International Conference on Information Systems Security and Privacy (ICISSP 2026), Vol. 2, pp. 221--231. SciTePress
- **Anno**: 2026
- **arXiv**: 2512.15554
- **Accesso aperto**: https://arxiv.org/pdf/2512.15554
- **Limite**: ICISSP è una conferenza reale ma di profilo medio; non è IEEE/ACM/USENIX.

**Rilevanza**
WuppieFuzz è un fuzzer REST API stateful e coverage-guided costruito su LibAFL, che supporta esplicitamente le tre modalità black-box, grey-box e white-box a partire dalla specifica OpenAPI. La struttura a tre modalità di testing è concettualmente analoga al Box Gradient di APIGuard (D3.P3 in apiguard_property.md): il livello di accesso al sistema determina il tipo di test eseguibile. Il paper costruisce grafi di dipendenza dalle specifiche OpenAPI (CRUD ordering, parameter linking) per generare sequenze di test coerenti, meccanismo analogo al DAG di APIGuard. Citabile come strumento dello stato dell'arte contemporaneo per il confronto nella `tab:semantic-gap` (Tabella C della tesi) o in §6 per la discussione sugli strumenti correlati.

**Punto di inserimento**
§6 (strumenti correlati e confronto), come strumento contemporaneo che condivide la filosofia multi-box e OpenAPI-driven ma con approccio fuzzing piuttosto che assessment formale. Eventualmente §2.4 per completare il panorama degli strumenti di fuzzing stateful.

```bibtex
@inproceedings{rooijakkers2026wuppiefuzz,
  title={WuppieFuzz: Coverage-Guided, Stateful {REST} {API} Fuzzing},
  author={Rooijakkers, Thomas and Nijsten, Anne and Daniele, Cristian
          and Weitenberg, Erieke and Groenewegen, R. and Melissen, A.},
  booktitle={Proceedings of the 12th International Conference on
             Information Systems Security and Privacy (ICISSP 2026)},
  volume={2},
  pages={221--231},
  year={2026},
  publisher={SciTePress},
  doi={10.48550/arXiv.2512.15554}
}
```

---

## Riepilogo delle aggiunte

| Codice | Paper | Sede | Capitolo tesi | Fascia |
|---|---|---|---|---|
| NEW-A-01 | Corradini et al. 2023 — Mass Assignment black-box testing | ICSE 2023 (tier-1) | §2.3.2 | A |
| NEW-A-02 | Atlidakis et al. 2020 — Security Properties Cloud REST APIs | ICST 2020 | §3.3, §2.4 | A |
| NEW-A-03 | OWASP API Security Top 10 2023 | OWASP Foundation | §2.3.1, §2.3.2 | A (obbligatorio) |
| NEW-A-04 | Barr et al. 2015 — Oracle Problem Survey | IEEE TSE (tier-1) | §3.3, §6 | A |
| NEW-A-05 | NIST SP 800-228 — API Protection Guidelines | NIST 2025 | §6, §3.1 | A |
| NEW-A-06 | Fourné et al. 2023 — Reproducible Builds | IEEE S&P 2023 (tier-1) | §6/§7 | A |
| NEW-B-01 | Rooijakkers et al. 2026 — WuppieFuzz | ICISSP 2026 | §6, §2.4 | B |

---

## Note sulla metodologia di ricerca

Le ricerche eseguite e i termini utilizzati:

1. `Corradini Pasqua Ceccato "Mass Assignment" RESTful APIs ICSE 2023` — trovato su arXiv, ACM DL, ResearchGate, sito personale degli autori.
2. `Fahl "flossing your teeth" "Reproducible Builds" IEEE Security Privacy 2023` — trovato su TeamUSEC, DBLP, OpenAlex (DOI canonico).
3. `Barr Harman McMinn Shahbaz Yoo "Oracle Problem" IEEE Transactions 2015` — trovato su KAIST, UCL Discovery, IEEE Xplore.
4. `NIST SP 800-228 Guidelines API Protection Cloud-Native` — trovato direttamente su NIST CSRC (csrc.nist.gov).
5. `Atlidakis Godefroid Polishchuk "Checking Security Properties" ICST 2020` — trovato su Semantic Scholar, ResearchGate, IEEE Xplore, sito personale di Godefroid.
6. `WuppieFuzz Coverage-Guided Stateful REST API Fuzzing arXiv 2512.15554` — trovato su arXiv, ResearchGate, GitHub del progetto (con citation ufficiale della conferenza ICISSP).
7. `OWASP API Security Top 10 2023 official citation` — trovato su owasp.org.

**Paper valutati e non raccomandati nel corso della ricerca** (motivo):
- NIST SP 800-63B (Digital Identity Guidelines): troppo generico rispetto al caso specifico API; APIGuard vi fa riferimento indiretto tramite i test JWT ma la citazione diretta sarebbe forzata.
- Man Zhang, Arcuri "Open Problems in Fuzzing RESTful APIs" (ACM TOSEM 2023): paper di benchmark/comparison di fuzzer per REST API; rilevante come survey sul campo ma la tesi non fa affermazioni specifiche sui limiti degli strumenti di fuzzing che richiederebbero questa fonte.
- Lamb, Zacchiroli "Reproducible Builds: Increasing the Integrity of Software Supply Chains" (arXiv:2104.06020 / IEEE S&P 2021): concettualmente identico a Fourné et al. 2023; il paper di Fourné è più recente e ha un focus più pratico (interviste). Preferire Fourné se si cita un solo paper sul tema.