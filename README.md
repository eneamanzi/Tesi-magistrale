[![CC BY-NC-ND 4.0][cc-by-nc-nd-shield]][cc-by-nc-nd]

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it
[cc-by-nc-nd-shield]: https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg

[English version](README.en.md) | **Versione Italiana**
# Tesi di Laurea Triennale: Design e sviluppo di una soluzione per la valutazione di sistemi distribuiti

## Informazioni sulla Tesi

Questa repository contiene i sorgenti LaTeX della tesi di Laurea Triennale in Sicurezza dei sistemi e delle reti informatiche.

* **Titolo:** Design e sviluppo di una soluzione per la valutazione di sistemi distribuiti
* **Autore:** Enea Manzi (Matricola: 987326)
* **Corso di Laurea:** Sicurezza dei sistemi e delle reti informatiche
* **Università:** Università degli Studi di Milano
* **Relatore:** Prof. Marco Anisetti
* **Correlatore:** Dr. Filippo Berto
* **Anno Accademico:** A.A. 2023-2024

***

## Abstract

Le moderne architetture distribuite, caratterizzate da decentralizzazione e dalla suddivisione in microservizi, pongono sfide rilevanti nella **valutazione del comportamento del sistema**.
Data la complessità introdotta da tali architetture, vengono richiesti sistemi di monitoraggio avanzati in grado di verificare Proprietà Non Funzionali (PNF) per valutare il comportamento dell'infrastruttura. Le soluzioni attuali, sebbene efficaci nella valutazione di performance, risultano limitate quando si tratta di fornire una valutazione olistica e continua di tali sistemi, basata sulla verifica di *proprietà non funzionali* tramite *contratti formali e specifici*. È sorta quindi la necessità di sistemi di monitoraggio sempre più sofisticati, che possano raccogliere informazioni su molteplici aspetti del sistema in modo da garantire il soddisfacimento di specifiche proprietà.

Questa tesi, sfruttando una *metodologia di assurance* innovativa, mira a colmare alcune lacune nel monitoraggio e nella valutazione delle ormai comuni infrastrutture distribuite. La metodologia si basa su:
i) una raccolta continua e trasparente di *evidence*, o prove, che misurano stati rilevanti del sistema, tramite metriche che interrogano sistemi di monitoring dei nodi distribuiti,
ii) la verifica formale di specifiche proprietà non funzionali, sulla base delle *evidence* raccolte con le metriche, attraverso contratti che ne definiscono i controlli da effettuare.

Viene proposta, basandosi su tale metodologia, un'integrazione per **Elasticsearch** tra le funzionalità dell'*Assurance Engine*, il sistema di monitoraggio e valutazione in corso di sviluppo, permettendo la raccolta di dati e la verifica di specifici e complessi contratti. Questo lavoro contribuisce quindi allo sviluppo di un sistema modulare flessibile, efficiente e scalabile per *verifiche di Assurance* basate su proprietà non funzionali, indipendentemente dalla complessità dell'infrastruttura sottostante.

I contributi di questa tesi sono:
i) integrazione dell'Assurance Engine con Elasticsearch, sfruttando la metodologia adottata,
ii) espressione di contratti complessi per valutare formalmente proprietà non funzionali su un target,
iii) una valutazione sperimentale approfondita delle performance e dell'efficienza dell'integrazione sviluppata.

La tesi mostra una implementazione concreta della metodologia adottata con l'obiettivo di costruire un unico sistema centrale, efficiente e affidabile per monitorare sistemi distribuiti, l'*Assurance engine*, riducendo al minimo l'impatto sulle risorse computazionali. I risultati confermano che il sistema è in grado di fornire prestazioni efficienti nella raccolta di evidence tramite metriche e nella valutazione di contratti.

## Compilazione

Per compilare la tesi, è necessario avere una distribuzione LaTeX installata (es. **TeX Live** o **MiKTeX**).

Il file principale è `Tesi/main.tex`.

### Comandi di Compilazione

1.  **Naviga nella directory della tesi:**

    ```bash
    cd Tesi/
    ```

2.  **Compila il documento (utilizzando LuaLaTeX):**
    Come indicato nella configurazione di build, la compilazione deve essere eseguita con l'engine **LuaLaTeX** (opzione `-pdflua`).

    ```bash
    latexmk -pdflua main.tex
    ```

    *Il file PDF finale (`main.pdf` o `Tesi.pdf`) verrà generato nella cartella `Tesi/`.*

### Pulizia dei File Ausiliari

Per rimuovere tutti i file ausiliari generati dal processo di compilazione (come `.aux`, `.log`, `.bbl`, ecc., che sono diretti nella cartella `.temp`):

```bash
latexmk -c
```

## Licenza

[![CC BY-NC-ND 4.0][cc-by-nc-nd-image]][cc-by-nc-nd]

Questo lavoro è distribuito con licenza
**Creative Commons Attribuzione - Non commerciale - Non opere derivate 4.0 Internazionale**.

Puoi condividerlo liberamente purché tu citi l'autore,
non lo usi per scopi commerciali e non lo modifichi.

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it
[cc-by-nc-nd-image]: https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png
