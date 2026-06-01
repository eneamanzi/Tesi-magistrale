**La regola d'oro accademica (Come e Quando citare):**

* **Quando:** Si inserisce la citazione **solo alla primissima occorrenza** del termine nel testo principale. Nelle occorrenze successive scrivi semplicemente il nome del tool.
* **Come:** * Se il tool ha un paper accademico di riferimento (es. *RESTler*, *Schemathesis*), usi la citazione bibliografica classica `\cite{...}`.
* Se è un software commerciale o open-source senza un paper (es. *Kong*, *AWS API Gateway*, *Pydantic*), crei una voce in Zotero di tipo "Software" o "Pagina Web" e usi `\cite{...}`, oppure (molto comune per le librerie minori) metti semplicemente un `\footnote{\url{https://...}}`.


### 1. Gateway, Cloud Provider e Infrastruttura

Questi sono i pilastri della tua tesi. La prima volta che li nomini nel Capitolo 2 o 5, devi assolutamente mettere una citazione al loro sito ufficiale o alla documentazione.

* **Kong / Kong DB-less** (Il tuo target principale)
* **Apigee** (Nominato nel Cap. 2)
* **AWS API Gateway** (Nominato nel Cap. 2 e 6)
* **Azure API Management / Azure APIM** (Nominato nel Cap. 2 e 6)
* **Google Cloud Endpoints** (Nominato nel Cap. 2 e 6)
* **Kubernetes, Nginx, Traefik** (Nominati nei modelli di Ingress nel Cap. 2)
* **Istio, Envoy** (Nominati nel service mesh, Cap. 2)
* **Docker / Docker Compose** (Usati per il tuo testbed, Cap. 5)
* **PostgreSQL** (Usato nel testbed, Cap. 5)

### 2. Target Applicativi

La prima volta che li introduci (soprattutto nel Capitolo 5) vanno citati.

* **Forgejo** (E la sua derivazione da **Gitea**)
* **crAPI** (Completely Ridiculous API, nominata nel Cap. 4 come target vulnerabile di esempio)

### 3. Tool di Sicurezza e Testing (Scanner, Fuzzer, Connector)

Per questi, il rigore è fondamentale. Se esiste il paper, usa quello, altrimenti la repo GitHub ufficiale.

* **OWASP ZAP** (Già citato nel Cap. 2 come `owasp2023zap`)
* **RESTler** (Già citato nel Cap. 2)
* **Schemathesis** (Nominato nel Cap. 2 e Cap. 6)
* **Nuclei / ProjectDiscovery** (Usato come connector, Cap. 4)
* **Testssl.sh** (Usato come connector, Cap. 4)
* **Sslyze** (Usato come connector, Cap. 4)
* **OFFAT** (Nominato negli sviluppi futuri, Cap. 6)
* **Vegeta** (Tool scritto in Go per il load testing, nominato nel Cap. 6)
* **Interactsh** (Usato per OOB SSRF, nominato nel Cap. 6)

### 4. Linguaggi, Standard e Protocolli

Gli standard formali si citano sempre alla prima occorrenza (spesso rimandando al sito dell'organizzazione o alla RFC).

* **OpenAPI Specification (OAS)** (A volte chiamata retroattivamente Swagger. È vitale citare la pagina ufficiale della OpenAPI Initiative la prima volta che ne parli nel Cap. 1 o 2).
* **GraphQL** (Sviluppato da **Facebook**, Cap. 2)
* **gRPC** (Sviluppato da **Google**) e **Protocol Buffers** (Cap. 2)
* **SOAP** e **WSDL** (Cap. 2)
* **AsyncAPI** (Nominato negli sviluppi futuri, Cap. 6)
* **Go (Golang)** (Nominato per Vegeta nel Cap. 6)
* **Rust** (Hai il file `rust.sty` per i listati, non so se lo citi nel testo)

### 5. Framework, Librerie Python e CI/CD

Per questi, una nota a piè di pagina con l'URL al repository GitHub o alla documentazione ufficiale (PyPI) è spesso sufficiente, ma puoi anche usare Zotero come "Web Page".

* **Pydantic / Pydantic v2** (Cuore del tuo validation system, Cap. 4 e 5)
* **Prance** (Libreria per dereferenziare OpenAPI, Cap. 4)
* **openapi-spec-validator** (Cap. 4)
* **Jinja2** (Motore di templating, Cap. 4)
* **Django REST Framework** (Nominato come esempio nel Cap. 4)
* **GitHub Actions** e **GitLab CI** (Cap. 6)
* **I tool di Analisi Statica (Cap. 5):**
* **Ruff**
* **Mypy**
* **Bandit**
* **Vulture**
* **pip-audit**
* **Hatch** (Build backend)



---

### Come procedere?

Il mio consiglio tattico per non impazzire:

1. Usa **Zotero Connector** (l'estensione del browser) per catturare rapidamente le homepage di *Kong*, *OpenAPI*, *Forgejo*, *Nuclei*, *Pydantic*, *AWS API Gateway*, ecc. come "Pagina Web" o "Software".
2. Esporta queste nuove voci nel tuo `biblio.bib`.
3. Fai un rapido giro nei tuoi file `.tex` e aggiungi il `\cite{...}` **solo al primo punto** in cui introduci quel termine.

Vuoi che prepari io i blocchi BibTeX per i tool più importanti (come Kong, Forgejo, OpenAPI, Pydantic, Nuclei) così fai copia-incolla nel tuo file `biblio.bib` senza doverli cercare uno a uno?