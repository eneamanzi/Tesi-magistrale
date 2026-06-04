# Report Bibliografico — APIGuard Assurance
*Versione integrale — 29 maggio 2026 — per gestione Zotero e inserimento in `biblio.bib`*

- [FASCIA A — RACCOMANDATO / RACCOMANDATO CON CORREZIONI](#fascia-a--raccomandato--raccomandato-con-correzioni)
  - [Capitolo 2 — Background e Stato dell'Arte](#capitolo-2--background-e-stato-dellarte)
    - [\[A-23\] Break the Wall from Bottom: Automated Discovery of Protocol-Level Evasion Vulnerabilities in Web Application Firewalls (WAF Manis)](#a-23-break-the-wall-from-bottom-automated-discovery-of-protocol-level-evasion-vulnerabilities-in-web-application-firewalls-waf-manis)
  - [Capitolo 3 — Metodologia](#capitolo-3--metodologia)
    - [\[A-15\] Parallelization in System-Level Testing: Novel Approaches to Manage Test Suite Dependencies (PFAST)](#a-15-parallelization-in-system-level-testing-novel-approaches-to-manage-test-suite-dependencies-pfast)
    - [\[A-16\] Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing](#a-16-fizzle-a-framework-for-deterministic-and-reproducible-network-fuzzing)
  - [Capitolo 4 — Implementazione](#capitolo-4--implementazione)
    - [\[A-18\] SoK: Understanding CI/CD Security](#a-18-sok-understanding-cicd-security)
  - [Capitolo 5 — Validazione Sperimentale](#capitolo-5--validazione-sperimentale)
    - [\[A-19\] Automated Verification of Idempotence for Stateful Serverless Applications (Flux)](#a-19-automated-verification-of-idempotence-for-stateful-serverless-applications-flux)
  - [Capitoli 6 e 7 — Discussione e Sviluppi Futuri](#capitoli-6-e-7--discussione-e-sviluppi-futuri)
    - [\[A-20\] Guidelines for API Protection for Cloud-Native Systems (NIST SP 800-228)](#a-20-guidelines-for-api-protection-for-cloud-native-systems-nist-sp-800-228)
    - [\[A-21\] It's like flossing your teeth: Reproducible Builds for Software Supply Chain Security](#a-21-its-like-flossing-your-teeth-reproducible-builds-for-software-supply-chain-security)
- [FASCIA B — TENERE CON RISERVA](#fascia-b--tenere-con-riserva)
  - [Capitolo 2 — Background e Stato dell'Arte](#capitolo-2--background-e-stato-dellarte-1)
    - [\[B-01\] Shepherd: Adaptive Detection of Suspicious API Interaction Flows in Microservices](#b-01-shepherd-adaptive-detection-of-suspicious-api-interaction-flows-in-microservices)
    - [\[B-03\] WuppieFuzz: Coverage-Guided, Stateful REST API Fuzzing](#b-03-wuppiefuzz-coverage-guided-stateful-rest-api-fuzzing)
  - [Capitolo 3 — Metodologia](#capitolo-3--metodologia-1)
    - [\[B-04\] ORANalyst: Systematic Testing Framework for Open RAN Implementations](#b-04-oranalyst-systematic-testing-framework-for-open-ran-implementations)
    - [\[B-05\] Valkyrie: Improving Fuzzing Performance through Deterministic Techniques](#b-05-valkyrie-improving-fuzzing-performance-through-deterministic-techniques)
  - [Capitolo 5 — Validazione Sperimentale](#capitolo-5--validazione-sperimentale-1)
    - [\[B-06\] DASTestBed: An Automated Benchmarking Framework for DAST Scanners](#b-06-dastestbed-an-automated-benchmarking-framework-for-dast-scanners)
    - [\[B-07\] Adaptive and AI-Augmented Security Testing: A Systematic Survey](#b-07-adaptive-and-ai-augmented-security-testing-a-systematic-survey)
  - [Capitoli 6 e 7 — Discussione e Sviluppi Futuri](#capitoli-6-e-7--discussione-e-sviluppi-futuri-1)
    - [\[B-08\] API Drift Detection: Enhancing Data Protection](#b-08-api-drift-detection-enhancing-data-protection)
    - [\[B-09\] PyPitfall: Dependency Chaos and Software Supply Chain Vulnerabilities in Python](#b-09-pypitfall-dependency-chaos-and-software-supply-chain-vulnerabilities-in-python)
    - [\[B-10\] DoD Enterprise DevSecOps Reference Design](#b-10-dod-enterprise-devsecops-reference-design)
    - [\[B-11\] Continuous Security Assurance in Multi-Platform CI/CD Environments](#b-11-continuous-security-assurance-in-multi-platform-cicd-environments)
- [Appendice — Errori Sistematici Rilevati nella Fase di Verifica Incrociata](#appendice--errori-sistematici-rilevati-nella-fase-di-verifica-incrociata)
- [Riepilogo Generale](#riepilogo-generale)
  - [Fascia A — 26 voci](#fascia-a--26-voci)
  - [Fascia B — 11 voci](#fascia-b--11-voci)
- [Note sulla Metodologia di Ricerca Bibliografica](#note-sulla-metodologia-di-ricerca-bibliografica)


## FASCIA A — RACCOMANDATO / RACCOMANDATO CON CORREZIONI

---

### Capitolo 2 — Background e Stato dell'Arte
---

#### [A-23] Break the Wall from Bottom: Automated Discovery of Protocol-Level Evasion Vulnerabilities in Web Application Firewalls (WAF Manis)

**Metadati**
- **Titolo**: Break the Wall from Bottom: Automated Discovery of Protocol-Level Evasion Vulnerabilities in Web Application Firewalls
- **Autori**: Qi Wang, Jianjun Chen, Zheyu Jiang, Run Guo, Ximeng Liu, Chao Zhang, Haixin Duan
- **Sede**: 2024 IEEE Symposium on Security and Privacy (IEEE S&P 2024), San Francisco
- **Anno**: 2024
- **Pagine**: 185--202
- **DOI**: `10.1109/SP54263.2024.00129`
- **Accesso aperto**: https://netsec.ccert.edu.cn/files/papers/wafmanis_sp24.pdf
- **Stato**: Pubblicazione peer-reviewed, IEEE S&P 2024 (top-tier). Jianjun Chen è lo stesso co-autore di HDiff [A-03] (stessa linea di ricerca CCERT/Tsinghua). Nessuna correzione necessaria.

**Rilevanza**
Il paper introduce WAF Manis, un sistema automatico per scoprire evasioni a livello protocollare nei WAF, valutato su 14 WAF commerciali e open-source (Cloudflare, ModSecurity, Fortinet, Alibaba Cloud, Huawei Cloud) e 20 framework web. In totale 311 casi di evasione confermati, tutti strutturalmente indipendenti dal payload specifico: qualsiasi contenuto malevolo (SQLi, XSS, Log4jShell) può passare attraverso questi WAF modificando unicamente la struttura protocollare della richiesta HTTP. Il risultato centrale è che le evasioni non dipendono da firme specifiche ma da discrepanze di parsing tra il parser del WAF e quello dell'applicazione — il che rende inutile l'aggiornamento delle signature rules. Per la tesi, questo paper è il riferimento accademico top-tier per supportare le affermazioni della sezione sul Payload Opacity e sull'impedance mismatch (§2.3.1, §2.3.2): i WAF tradizionali non possono garantire l'ispezione di traffico protocollare non-standard (gRPC/protobuf, WebSocket post-upgrade) perché il problema è strutturale, non di configurazione. La presenza di Jianjun Chen — co-autore anche di HDiff [A-03] — conferma la coerenza della linea di ricerca.

**Punto di inserimento**
§2.3.1 (`\subsec:semantic-gap`), in supporto all'affermazione che i WAF non possono garantire l'ispezione completa del traffico applicativo perché le evasioni sono strutturali e protocollari, non dipendenti dal payload. Citabile anche in §2.3.2 per la discussione sul Payload Opacity (gRPC/protobuf).

```bibtex
@inproceedings{wang2024breakwall,
  title={Break the Wall from Bottom: Automated Discovery of Protocol-Level
         Evasion Vulnerabilities in Web Application Firewalls},
  author={Wang, Qi and Chen, Jianjun and Jiang, Zheyu and Guo, Run and
          Liu, Ximeng and Zhang, Chao and Duan, Haixin},
  booktitle={2024 IEEE Symposium on Security and Privacy (S\&P)},
  pages={185--202},
  year={2024},
  organization={IEEE},
  doi={10.1109/SP54263.2024.00129}
}
```

---

### Capitolo 3 — Metodologia


#### [A-15] Parallelization in System-Level Testing: Novel Approaches to Manage Test Suite Dependencies (PFAST)

**Metadati**
- **Titolo**: Parallelization in System-Level Testing: Novel Approaches to Manage Test Suite Dependencies
- **Autori**: Pasquale Polverino, Fabio Di Lauro, Matteo Biagiola, Paolo Tonella, Antonio Carzaniga
- **Sede**: *IEEE Transactions on Software Engineering*, 2025 (online first)
- **Anno**: 2025
- **DOI**: `10.1109/TSE.2025.3572388`
- **Accesso aperto**: https://www.inf.usi.ch/carzaniga/papers/pdbtc_tse25.pdf
- **Stato**: Pubblicazione peer-reviewed, IEEE Transactions on Software Engineering (top-tier). **Due correzioni applicate**: (1) DOI corretto da `10.1109/TSE.2025.11008768` (numero documento IEEE Xplore) a `10.1109/TSE.2025.3572388` (DOI canonico); (2) autori completi includono Biagiola e Tonella, omessi nella versione originale.

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
  % CORRETTO: aggiunti Biagiola, Matteo e Tonella, Paolo (omessi nella versione originale)
  journal={IEEE Transactions on Software Engineering},
  year={2025},
  publisher={IEEE},
  doi={10.1109/TSE.2025.3572388} % CORRETTO: era 10.1109/TSE.2025.11008768
}
```

---

#### [A-16] Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing

**Metadati**
- **Titolo**: Fizzle: A Framework for Deterministic and Reproducible Network Fuzzing
- **Autori**: Nathaniel Bennett, Tyler Tucker, Carson Stillman, William Enck, Patrick Traynor, Kevin Butler
- **Sede**: 47th IEEE Symposium on Security and Privacy (IEEE S&P / Oakland 2026)
- **Anno**: 2026
- **DOI**: `10.1109/SP63933.2026.00091` — **DA VERIFICARE** una volta che i proceedings IEEE saranno completamente indicizzati.
- **Accesso**: https://www.computer.org/csdl/proceedings-article/sp/2026/606500b689/2bojwkNTstO
- **Stato**: Pubblicazione peer-reviewed, IEEE S&P (top-tier). DOI provvisorio da verificare. Autori e titolo confermati dalla pagina degli accepted papers del convegno.

**Rilevanza**
Fizzle affronta il problema del non-determinismo nel fuzzing di rete imponendo un'esecuzione sequenziale deterministica attraverso l'interposizione delle librerie di sistema che intercettano le chiamate asincrone e serializzano le primitive di I/O e di sincronizzazione. Il framework garantisce che dato lo stesso seed iniziale, una sequenza di test produca sempre gli stessi risultati indipendentemente dalla latenza di rete o dal bilanciamento del carico del target. Questo è direttamente rilevante per la proprietà di riproducibilità di APIGuard: la capacità di produrre risultati idempotenti (run 1 = run 2, documentata nell'audit Milestone 1) si basa su principi analoghi di isolamento del contesto e determinismo nell'ordinamento delle operazioni.

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

### Capitolo 4 — Implementazione

---

#### [A-18] SoK: Understanding CI/CD Security

**Metadati**
- **Titolo**: SoK: Understanding CI/CD Security: A Comprehensive Review of Architecture, Attacks, and Defenses
- **Autori**: R. Zmuda, R. Graves, M. Shepherd, S. Brookes — **DA VERIFICARE**: i nomi per esteso non sono stati reperiti nei risultati di ricerca; aprire il PDF all'URL per confermare.
- **Sede**: 2025 IEEE Secure Development Conference (SecDev 2025), Indianapolis
- **Anno**: 2025
- **URL**: https://www.computer.org/csdl/proceedings-article/secdev/2025/959500a058/2bPJoAN55Ju
- **Stato**: Pubblicazione peer-reviewed, IEEE SecDev 2025. **Correzione critica applicata**: la fonte originale attribuiva a questo URL il titolo inventato "Automated Secret Redaction and Credential Hygiene in CI/CD Environments". Il titolo reale è quello riportato sopra.

**Rilevanza**
Il paper è un Systematization of Knowledge sulla sicurezza delle pipeline CI/CD, che include il threat model, la tassonomia degli attacchi (code injection, supply chain, credential leakage) e la revisione delle difese architetturali. Per la tesi, la sezione più pertinente è quella sulla gestione dei segreti nelle pipeline: i segreti che transitano attraverso i runner di test (token JWT, API key, password) devono essere trattati come dati sensibili e mai scritti in chiaro nei log, principio che APIGuard implementa tramite la proprietà D5.P4 (Structured Logging con Credential Redaction Obbligatoria). Il SoK fornisce la contestualizzazione accademica di questo principio nel quadro più ampio della sicurezza delle pipeline CI/CD.

**Punto di inserimento**
§4 (implementazione), nella sezione dedicata alla proprietà D5.P4 (credential redaction nel logging strutturato), come riferimento per il principio che la gestione dei segreti nei log di audit è un problema riconosciuto nella letteratura CI/CD.

```bibtex
@inproceedings{zmuda2025sok,
  title={{SoK}: Understanding {CI/CD} Security: A Comprehensive Review
         of Architecture, Attacks, and Defenses},
  % CORRETTO: titolo corretto rispetto alla fonte originale
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

#### [A-19] Automated Verification of Idempotence for Stateful Serverless Applications (Flux)

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
  author={Ding, Haoran and Wang, Zhaoguo and Shen, Zhuohao and Chen, Rong
          and Chen, Haibo},
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

### Capitoli 6 e 7 — Discussione e Sviluppi Futuri

---

#### [A-20] Guidelines for API Protection for Cloud-Native Systems (NIST SP 800-228)

**Metadati**
- **Titolo**: Guidelines for API Protection for Cloud-Native Systems
- **Autori**: Ramaswamy Chandramouli, Zack Butcher
- **Istituzione**: National Institute of Standards and Technology (NIST)
- **Anno**: 2025 (con aggiornamenti al 13 marzo 2026)
- **DOI**: `10.6028/NIST.SP.800-228`
- **Accesso aperto**: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-228.pdf
- **Tipo**: NIST Special Publication (normativo, non peer-reviewed nel senso accademico). Equivalente, per autorevolezza, alle RFC e agli IETF standard in campo protocollare.

**Rilevanza**
NIST SP 800-228 è il primo documento normativo ufficiale del governo USA specificamente dedicato alla protezione delle API nei sistemi cloud-native. Copre: identificazione e analisi dei fattori di rischio nelle fasi di sviluppo e runtime delle API, controlli di base e avanzati per le fasi pre-runtime e runtime, e analisi dei trade-off tra opzioni di implementazione. Per la tesi, il documento è rilevante in due modi distinti. Nel capitolo di discussione (§6), fornisce il contesto normativo che giustifica un assessment tool come APIGuard: le garanzie che APIGuard verifica (autenticazione, autorizzazione, rate limiting, TLS) sono esattamente le categorie di controllo che NIST SP 800-228 prescrive come "basic controls" per qualsiasi API cloud-native. Nel capitolo di metodologia (§3), può essere citato come quadro normativo di riferimento all'interno del quale si collocano le scelte metodologiche del framework.

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

#### [A-21] It's like flossing your teeth: Reproducible Builds for Software Supply Chain Security

**Metadati**
- **Titolo**: It's like flossing your teeth: On the Importance and Challenges of Reproducible Builds for Software Supply Chain Security
- **Autori**: Marcel Fourné, Dominik Wermke, William Enck, Sascha Fahl, Yasemin Acar
- **Sede**: 44th IEEE Symposium on Security and Privacy (IEEE S&P 2023), San Francisco
- **Anno**: 2023
- **Pagine**: 1527--1544
- **DOI**: `10.1109/SP46215.2023.10179320`
- **Accesso aperto**: https://par.nsf.gov/servlets/purl/10425119
- **Stato**: Pubblicazione peer-reviewed, IEEE S&P 2023 (tier-1). Nessuna correzione necessaria.

**Rilevanza**
Il paper conduce 24 interviste semi-strutturate con esperti del progetto Reproducible-Builds.org e identifica i fattori che rendono i reproducible builds difficili da adottare nella pratica industriale, proponendo un percorso incrementale. La tesi di fondo — che la riproducibilità delle build è un prerequisito necessario per l'integrità della supply chain, e che l'impossibilità di verificare bitwise l'artefatto compilato lascia aperta la finestra di attacco alla catena di distribuzione — è la giustificazione accademica per il principio di riproducibilità del testing discusso in §3.5 e per la discussione sulla supply chain di APIGuard come strumento Python. Questo paper è più forte di [B-09] PyPitfall per la stessa area tematica, per venue (IEEE S&P vs IEEE Big Data) e per la profondità della trattazione dei reproducible builds come prassi di sicurezza.

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

*Le voci in questa fascia sono reali e pertinenti ma presentano uno o più dei seguenti limiti: venue di profilo basso per la disciplina, status di preprint senza conferenza assegnata, autori parzialmente non verificati, o rilevanza solo indiretta. Inserire con cautela, preferibilmente come citazioni secondarie a supporto di un punto già fondato da una voce Fascia A.*

---

### Capitolo 2 — Background e Stato dell'Arte

---

#### [B-01] Shepherd: Adaptive Detection of Suspicious API Interaction Flows in Microservices

**Metadati**
- **Titolo**: Shepherd: Adaptive Detection of Suspicious API Interaction Flows in Microservices
- **Autori**: Chaeho Kim, Jaehyun Nam
- **Sede**: 29th Asia-Pacific Conference on Communications (APCC 2025)
- **Anno**: 2025
- **PDF**: https://www.ieice.org/publications/proceedings/bin/pdf_link.php?fname=T3-1-6.pdf&iconf=APCC&year=2025
- **Limite**: Venue di basso profilo per la cybersecurity; nessun DOI canonico reperibile.

**Rilevanza**
Il paper propone un sistema basato su Graph Attention Network per rilevare in tempo reale flussi di interazione anomali tra microservizi, usando sia feature strutturali (topologia del grafo di comunicazione) sia semantiche (contenuto delle richieste). È pertinente per §2.5 (Shadow API e anomaly detection negli ecosistemi a microservizi) come nota laterale sulla possibilità di rilevazione comportamentale delle Shadow API in ambienti runtime, in contrasto con l'approccio dichiarativo di APIGuard.

**Punto di inserimento**
§2.5, come citazione di supporto sulla rilevazione comportamentale delle Shadow API a runtime.

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


#### [B-03] WuppieFuzz: Coverage-Guided, Stateful REST API Fuzzing

**Metadati**
- **Titolo**: WuppieFuzz: Coverage-Guided, Stateful REST API Fuzzing
- **Autori**: Thomas Rooijakkers, Anne Nijsten, Cristian Daniele, Erieke Weitenberg, R. Groenewegen, A. Melissen
- **Sede**: 12th International Conference on Information Systems Security and Privacy (ICISSP 2026), Vol. 2, pp. 221--231. SciTePress
- **Anno**: 2026
- **arXiv**: 2512.15554
- **Accesso aperto**: https://arxiv.org/pdf/2512.15554
- **GitHub**: https://github.com/TNO-S3/WuppieFuzz
- **Limite**: ICISSP è una conferenza reale ma di profilo medio; non è IEEE/ACM/USENIX.

**Rilevanza**
WuppieFuzz è un fuzzer REST API stateful e coverage-guided costruito su LibAFL, che supporta esplicitamente le tre modalità black-box, grey-box e white-box a partire dalla specifica OpenAPI. La struttura a tre modalità di testing è concettualmente analoga al Box Gradient di APIGuard (D3.P3): il livello di accesso al sistema determina il tipo di test eseguibile. Il paper costruisce grafi di dipendenza dalle specifiche OpenAPI (CRUD ordering, parameter linking) per generare sequenze di test coerenti, meccanismo analogo al DAG di APIGuard. Citabile come strumento dello stato dell'arte contemporaneo per il confronto nella `tab:semantic-gap` o in §6 per la discussione sugli strumenti correlati.

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

### Capitolo 3 — Metodologia

---

#### [B-04] ORANalyst: Systematic Testing Framework for Open RAN Implementations

**Metadati**
- **Titolo**: ORANalyst: Systematic Testing Framework for Open RAN Implementations
- **Autori**: Tianchang Yang, Syed Md Mukit Rashid, Ali Ranjbar, Gang Tan, Syed Rafiul Hussain
- **Sede**: 33rd USENIX Security Symposium (USENIX Security 2024), Philadelphia
- **Anno**: 2024
- **Pagine**: 1921--1938
- **Accesso aperto**: https://www.usenix.org/system/files/usenixsecurity24-yang-tianchang.pdf
- **Limite**: Il dominio (reti 5G Open RAN) è distante dalla tesi; il collegamento al DAG di APIGuard è per analogia metodologica, non per identità di contesto. **Correzione critica applicata**: la fonte originale attribuiva a questo URL il titolo inventato "Static Analysis based on Program Dependency Graph for Test Sequencing". Il titolo reale è quello riportato.

**Rilevanza**
ORANalyst combina static analysis e dynamic tracing per mappare le dipendenze tra componenti microservice in O-RAN, poi usa questa mappa per generare input che esercitano le dipendenze e testano ogni componente target. La struttura (mappa delle dipendenze → schedule ordinato → test mirato) è analogica al DAG di APIGuard. La sede (USENIX Security, top-tier) è ottima; il problema è la distanza di dominio.

**Punto di inserimento**
§3.4 (DAG scheduling), come citazione di supporto che mostra lo stesso principio applicato a un dominio diverso (5G microservices), rafforzando la generalità dell'approccio.

```bibtex
@inproceedings{yang2024orananalyst,
  title={{ORANalyst}: Systematic Testing Framework for Open {RAN}
         Implementations},
  % CORRETTO: titolo corretto rispetto alla fonte originale
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

#### [B-05] Valkyrie: Improving Fuzzing Performance through Deterministic Techniques

**Metadati**
- **Sede**: 2022 IEEE International Conference on Software Quality, Reliability and Security (QRS 2022)
- **Anno**: 2022
- **URL IEEE Xplore**: https://ieeexplore.ieee.org/document/10062373/
- **Limite**: Gli autori non erano reperibili dai risultati di ricerca disponibili. **DA VERIFICARE**: aprire il link IEEE Xplore e recuperare la lista completa degli autori prima di inserire in Zotero. Se gli autori non si trovano, scartare.

**Rilevanza**
Documenta le performance superiori del fuzzing greybox quando supportato da tecniche deterministiche rispetto alle mutazioni puramente randomiche. Complementare a Fizzle [A-16]; mentre Fizzle tratta il determinismo a livello di rete, Valkyrie lo tratta a livello di mutazione dei payload.

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

#### [B-06] DASTestBed: An Automated Benchmarking Framework for DAST Scanners

**Metadati**
- **Titolo**: DASTestBed: An Automated Benchmarking Framework for DAST Scanners with Extensible Ground Truth Modeling
- **Autori**: Rand Deeb, Alisa Vorobeva, Omar Farshad Jeelani
- **Sede**: 14th International Symposium on Digital Forensics and Security (ISDFS 2026)
- **Anno**: 2026
- **DOI**: Non disponibile al momento della verifica — **DA VERIFICARE** su IEEE Xplore dopo la pubblicazione.
- **Limite**: ISDFS è una conferenza reale ma di profilo basso; nessun DOI canonico verificato.

**Rilevanza**
Il paper presenta DASTestBed, un framework containerizzato per il benchmarking comparativo di scanner DAST su un ground truth estendibile. I dati empirici confrontano Nuclei (CPU 0.92%, RAM 937MB, precisione 1.00, richiamo 0.15) con OWASP ZAP (CPU 91%, RAM 3.2GB, precisione 0.70, richiamo 0.97), dimostrando il trade-off fondamentale tra footprint delle risorse e copertura della vulnerabilità. Questi dati sono direttamente utili per contestualizzare il profilo di performance di APIGuard (286s wall-clock, 287MB picco, come da `AUDIT_milestone1_release.md`) e per motivare le scelte di progettazione orientate all'efficienza delle risorse.

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

#### [B-07] Adaptive and AI-Augmented Security Testing: A Systematic Survey

**Metadati**
- **Titolo**: Adaptive and AI-Augmented Security Testing: A Systematic Survey of Program Analysis, Feedback-Driven Testing, and Hybrid Learning-Based Approaches
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

#### [B-08] API Drift Detection: Enhancing Data Protection

**Metadati**
- **Autori**: McKinley Sconiers-Hasan et al. — **DA VERIFICARE**: lista completa degli autori non reperibile.
- **Sede**: International Journal of Computer Applications Technology and Research (IJCATM)
- **Anno**: 2024
- **URL**: https://www.researchgate.net/publication/386251964
- **Limite**: IJCATM non è indicizzato in Scopus o WoS; venue di profilo incerto.

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

#### [B-09] PyPitfall: Dependency Chaos and Software Supply Chain Vulnerabilities in Python

**Metadati**
- **Titolo**: PyPitfall: Dependency Chaos and Software Supply Chain Vulnerabilities in Python
- **Autori**: Jacob Mahon, Chenxi Hou, Zhihao Yao
- **Sede**: IEEE International Conference on Big Data 2025 (conferma pubblicazione da verificare)
- **Anno**: 2025
- **DOI/arXiv**: `10.48550/arXiv.2507.18075`
- **Accesso aperto**: https://arxiv.org/html/2507.18075v1
- **Limite**: La pubblicazione su IEEE Big Data 2025 è indicata ma non confermata con DOI definitivo. Aggiornato a FASCIA B rispetto a [A-21] Fourné et al. 2023 che tratta lo stesso tema con venue superiore (IEEE S&P).

**Rilevanza**
PyPitfall analizza 378.573 pacchetti PyPI e trova che 4.655 richiedono esplicitamente dipendenze con CVE note e 141.044 ammettono versioni vulnerabili. Questo quantifica l'entità del rischio di supply chain nell'ecosistema Python, che è l'ecosistema di sviluppo di APIGuard. Pertinente per §6/§7 nella discussione sull'integrità della supply chain dello strumento stesso (reproducible builds, lock file, SBOM).

**Punto di inserimento**
§6/§7, come cifre empiriche a supporto della motivazione per pip-audit e hash pinning nel processo di build, in coppia con [A-21] Fourné et al. 2023.

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

#### [B-10] DoD Enterprise DevSecOps Reference Design

**Metadati**
- **Istituzione**: Chief Information Officer, US Department of Defense
- **Anno**: 2021
- **URL**: https://dodcio.defense.gov/Portals/0/Documents/DoD%20Enterprise%20DevSecOps%20Reference%20Design%20v1.0_Public%20Release.pdf
- **Tipo**: Documento normativo istituzionale (non peer-reviewed).
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

#### [B-11] Continuous Security Assurance in Multi-Platform CI/CD Environments

**Metadati**
- **Titolo**: **DA VERIFICARE** aprendo l'URL — il link punta a un articolo MDPI Future Internet sulla Continuous Security Assurance in ambienti CI/CD multi-piattaforma (GitHub Advanced Security, Azure DevOps).
- **Autori**: **DA VERIFICARE** — la versione di partenza del BibTeX riportava autori fittizi. Aprire l'URL e recuperare la lista reale prima di qualsiasi utilizzo.
- **Sede**: MDPI *Future Internet*, vol. 18, n. 2, art. 99
- **Anno**: **DA VERIFICARE** sulla pagina MDPI.
- **URL**: https://www.mdpi.com/1999-5903/18/2/99
- **Limite**: MDPI Future Internet ha impact factor basso; gli autori non sono stati verificati. Usare solo dopo aver letto il paper e confermato che il contenuto supporta effettivamente le affermazioni citate.

**Rilevanza**
Il paper analizza l'integrazione della Continuous Security Assurance in pipeline CI/CD eterogenee, includendo la discussione su alert fatigue e il bilanciamento tra velocità di deployment e rigore dei controlli. Pertinente per §6 nella trattazione dell'integrazione di APIGuard in pipeline CI/CD (proprietà D6.P1 e D6.P2) e nella discussione sul trade-off tra coverage e overhead operativo.

**Punto di inserimento**
§6 (integrazione CI/CD e Continuous Security Assurance), come riferimento per il concetto di sicurezza continua nelle pipeline multi-piattaforma. Citabile solo dopo verifica del contenuto e degli autori reali.

```bibtex
% DA COMPLETARE prima dell'inserimento in Zotero:
% 1. Aprire https://www.mdpi.com/1999-5903/18/2/99
% 2. Recuperare titolo esatto, autori completi, anno definitivo
% 3. Sostituire i placeholder sottostanti con i dati reali
@article{mdpi2026continuous,
  title={},   % DA VERIFICARE: titolo esatto dalla pagina MDPI
  author={},  % DA VERIFICARE: autori reali
  journal={Future Internet},
  volume={18},
  number={2},
  pages={99},
  year={},    % DA VERIFICARE: anno definitivo
  publisher={MDPI},
  url={https://www.mdpi.com/1999-5903/18/2/99}
}
```

---

## Appendice — Errori Sistematici Rilevati nella Fase di Verifica Incrociata

Questa sezione documenta le categorie di errore riscontrate nelle voci di partenza durante la fase di verifica. È inclusa per orientare la validazione manuale delle voci segnate `% DA VERIFICARE:`.

**Titoli errati su URL reali**: almeno tre paper presentavano il contenuto reale all'URL indicato ma con un titolo completamente diverso. I casi identificati: (1) `usenixsecurity24-du.pdf` → titolo reale "Vulnerability-oriented Testing for RESTful APIs", non "Understanding OpenAPI Parsing and Syntax Rules for Fuzzing Automation" [corretto in A-14]; (2) `usenixsecurity24-yang-tianchang.pdf` → titolo reale "ORANalyst: Systematic Testing Framework for Open RAN Implementations", non "Static Analysis based on Program Dependency Graph for Test Sequencing" [corretto in B-04]; (3) link SecDev 2025 → titolo reale "SoK: Understanding CI/CD Security: A Comprehensive Review of Architecture, Attacks, and Defenses", non "Automated Secret Redaction and Credential Hygiene" [corretto in A-18].

**DOI attribuito a paper diverso**: Il DOI `10.1145/3696410.3714825` attribuito nella fonte di partenza al paper "Internal APIs Are All You Need" appartiene in realtà al paper "Tool Learning in the Wild: Empowering Language Models as Automatic Tool Agents" (Shi et al., ACM Web Conference 2025). Il paper di Tham et al. è un preprint arXiv del 2026 (arXiv:2604.00694), non una pubblicazione ACM 2025. La voce è stata scartata per venue inventato.

**DOI come numero documento IEEE Xplore**: Il codice `10.1109/TSE.2025.11008768` attribuito a Polverino et al. era il numero del documento su IEEE Xplore, non il DOI canonico. Il DOI corretto è `10.1109/TSE.2025.3572388` [corretto in A-15].

**Autori errati o incompleti**: la voce SATORI includeva "M.D. Ernst" (non autore del paper) e ometteva Gabriele Bavota [corretto in A-13]. La voce Polverino et al. ometteva Biagiola e Tonella [corretto in A-15].

**Identificativo arXiv mal attribuito**: il paper descritto come avente tre stati PASS/FAIL/INCONCLUSIVE è stato associato a arXiv:2605.13898, che è in realtà "Bidirectional Empowerment of Metamorphic Testing and Large Language Models: A Systematic Survey". Il paper che effettivamente implementa verdetti trivalenti è AgentAssay (arXiv:2603.02601), non incluso in questo report perché il dominio (agenti AI) è troppo lontano dalla tesi.

---

## Riepilogo Generale

### Fascia A — 26 voci

| Codice | Autori | Titolo (abbreviato) | Sede | Anno | Capitolo tesi |
|---|---|---|---|---|---|
| A-01 | Atlidakis et al. | RESTler: Stateful REST API Fuzzing | ICSE | 2019 | §2.3.1, §2.4, §3.2 |
| A-02 | Atlidakis et al. | Pythia: Grammar-Based REST Fuzzing | arXiv | 2020 | §2.4 |
| A-03 | Shen et al. | HDiff: Semantic Gap Attack HTTP | DSN | 2022 | §2.3.1 |
| A-04 | Sahin et al. | EvoMaster: Access Policy Oracles | arXiv | 2026 | §2.3.2, §3.3 |
| A-05 | Mazidi et al. | LightMass: Mass Assignment Mining | EASE ACM | 2024 | §2.3.2 |
| A-06 | McFadden et al. | WENDIGO: GraphQL DoS via DRL | IEEE S&P Wksp | 2024 | §2.8 |
| A-07 | Wu et al. | BoLAZ: BOLA under Zero Trust | arXiv | 2025 | §2.3.2 |
| A-08 | Spring | Undiscovered Vulnerabilities | Computers & Security | 2023 | §2.9 |
| A-09 | Corradini et al. | Mass Assignment Black-box Testing | ICSE | 2023 | §2.3.2 |
| A-10 | Atlidakis et al. | Checking Security Properties REST APIs | ICST | 2020 | §3.3, §2.4 |
| A-11 | OWASP Foundation | OWASP API Security Top 10 2023 | OWASP | 2023 | §2.3.1, §2.3.2 |
| A-12 | Hatfield-Dodds, Dygalo | Schemathesis: Semantics-Aware Fuzzers | ICSE-Companion | 2022 | §3.2 |
| A-13 | Alonso et al. | SATORI: Static Oracle Generation | ASE | 2025 | §3.3, §6 |
| A-14 | Du et al. | VOAPI2: Vulnerability-oriented Testing | USENIX Security | 2024 | §3.2 |
| A-15 | Polverino et al. | PFAST: Parallel Test Scheduling (DAG) | IEEE TSE | 2025 | §3.4, §4 |
| A-16 | Bennett et al. | Fizzle: Deterministic Network Fuzzing | IEEE S&P | 2026 | §3.5 |
| A-17 | Barr et al. | The Oracle Problem: A Survey | IEEE TSE | 2015 | §3.3, §6 |
| A-18 | Zmuda et al. | SoK: CI/CD Security | IEEE SecDev | 2025 | §4 |
| A-19 | Ding et al. | Flux: Idempotence Verification | USENIX OSDI | 2023 | §5, §6 |
| A-20 | Chandramouli, Butcher | NIST SP 800-228: API Protection | NIST | 2025 | §6, §3.1 |
| A-21 | Fourné et al. | Reproducible Builds Supply Chain | IEEE S&P | 2023 | §6/§7 |
| A-22 | Golmohammadi et al. | Testing RESTful APIs: A Survey | ACM TOSEM | 2023 | §2.4 |
| A-23 | Wang et al. | Break the Wall from Bottom (WAF Manis) | IEEE S&P | 2024 | §2.3.1, §2.3.2 |
| A-24 | Godefroid et al. | Intelligent REST API Data Fuzzing | ESEC/FSE | 2020 | §3.2, §4 |
| A-25 | Alonso et al. | AGORA: Test Oracle Generation REST APIs | ISSTA ACM | 2023 | §3.3 |
| A-26 | Deng et al. | NAUTILUS: Automated API Vuln. Detection | USENIX Security | 2023 | §2.4, §3.2/§3.3 |

### Fascia B — 11 voci

| Codice | Autori | Titolo (abbreviato) | Sede | Anno | Capitolo tesi |
|---|---|---|---|---|---|
| B-01 | Kim, Nam | Shepherd: API Anomaly Detection | APCC | 2025 | §2.5 |
| B-02 | Möller et al. | GraphQL Batching DoS Model | IST-Africa | 2024 | §2.8 |
| B-03 | Rooijakkers et al. | WuppieFuzz: Coverage-Guided REST Fuzzing | ICISSP | 2026 | §6, §2.4 |
| B-04 | Yang et al. | ORANalyst: O-RAN Testing Framework | USENIX Security | 2024 | §3.4 |
| B-05 | Valkyrie authors | Valkyrie: Deterministic Fuzzing | IEEE QRS | 2022 | §3.5 |
| B-06 | Deeb et al. | DASTestBed: DAST Benchmarking | ISDFS | 2026 | §5 |
| B-07 | Wienczkowski | AI-Augmented Security Testing Survey | arXiv | 2026 | §5 |
| B-08 | Sconiers-Hasan et al. | API Drift Detection | IJCATM | 2024 | §6 |
| B-09 | Mahon et al. | PyPitfall: Python Supply Chain | IEEE Big Data | 2025 | §6/§7 |
| B-10 | US DoD | DoD Enterprise DevSecOps Reference | DoD CIO | 2021 | §6 |
| B-11 | DA VERIFICARE | Continuous Security CI/CD | MDPI Future Internet | DA VER. | §6 |

---

## Note sulla Metodologia di Ricerca Bibliografica

Per ciascuna voce del report sono state condotte ricerche su fonti primarie: IEEE Xplore e ACM Digital Library per DOI canonici e pagine dei proceedings; USENIX.org per titoli e PDF dei paper USENIX; siti personali degli autori per liste complete e preprint; NIST CSRC per dati normativi; arXiv.org per preprint e relative submission info. I termini di ricerca principali utilizzati sono elencati di seguito.

1. `Corradini Pasqua Ceccato "Mass Assignment" RESTful APIs ICSE 2023` — verificato su arXiv (abs/2301.01261), ACM Digital Library (DOI: 10.1109/ICSE48619.2023.00213), sito personale degli autori (Università di Verona).
2. `Fahl "flossing your teeth" "Reproducible Builds" IEEE Security Privacy 2023` — verificato su TeamUSEC, DBLP, OpenAlex (DOI canonico: 10.1109/SP46215.2023.10179320), NSF PAR.
3. `Barr Harman McMinn Shahbaz Yoo "Oracle Problem" IEEE Transactions 2015` — verificato su KAIST repository, UCL Discovery, IEEE Xplore (documento 6963470).
4. `NIST SP 800-228 Guidelines API Protection Cloud-Native` — verificato su NIST CSRC (csrc.nist.gov), PDF ufficiale su nvlpubs.nist.gov.
5. `Atlidakis Godefroid Polishchuk "Checking Security Properties" ICST 2020` — verificato su Semantic Scholar, sito personale di Godefroid (DOI: 10.1109/ICST46399.2020.00046).
6. `WuppieFuzz Coverage-Guided Stateful REST API Fuzzing arXiv 2512.15554` — verificato su arXiv, ResearchGate, GitHub del progetto (con citation ufficiale ICISSP 2026, SciTePress).
7. `OWASP API Security Top 10 2023 official citation` — verificato su owasp.org (pagina ufficiale del progetto).

**Paper valutati e non raccomandati:**

- NIST SP 800-63B (Digital Identity Guidelines): troppo generico rispetto al caso specifico API; APIGuard vi fa riferimento indiretto tramite i test JWT ma la citazione diretta sarebbe forzata.
- Man Zhang, Arcuri, "Open Problems in Fuzzing RESTful APIs" (ACM TOSEM 2023): paper di benchmark e comparison di fuzzer per REST API; rilevante come survey sul campo ma la tesi non fa affermazioni specifiche sui limiti degli strumenti di fuzzing che richiederebbero questa fonte come citazione primaria.
- Lamb, Zacchiroli, "Reproducible Builds: Increasing the Integrity of Software Supply Chains" (arXiv:2104.06020 / IEEE S&P 2021): concettualmente identico a [A-21] Fourné et al. 2023; il paper di Fourné è più recente e ha un focus più pratico (interviste con esperti). Preferire Fourné se si cita un solo paper sul tema.