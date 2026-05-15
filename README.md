[![CC BY-NC-ND 4.0][cc-by-nc-nd-shield]][cc-by-nc-nd]

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it
[cc-by-nc-nd-shield]: https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg

[English version](README.en.md) | **Versione Italiana**
# Template Tesi Magistrale — Università degli Studi di Milano

Template LaTeX per tesi magistrale (e presentazione Beamer) al Dipartimento di Informatica "Giovanni Degli Antoni", UniMI.

Derivato dalla tesi triennale di Enea Manzi (A.A. 2023-2024), supervisore Prof. Marco Anisetti.

---

## Struttura

```
├── Tesi/               # Documento principale (scrbook, LuaLaTeX)
│   ├── main.tex
│   ├── glossary.tex    # Acronimi (\gls{}, \glspl{})
│   ├── biblio.bib      # Bibliografia (stile IEEE)
│   ├── sections/       # Un file per capitolo
│   └── style/          # Syntax highlighting: yaml.sty, rust.sty, json.sty
├── Presentazione/      # Slide Beamer 16:9
│   ├── main.tex
│   ├── sections/       # Un file per sezione
│   ├── 00_common_tikz.tex   # Stili TikZ avanzati
│   └── chapters/special_slides.tex  # Ambienti chapter e sidepic
├── Riassunto/          # Sommario breve (scrartcl, ~1 pagina)
│   └── main.tex
└── .github/workflows/  # CI: compila i 3 PDF e li pubblica su pdf-release
```

---

## Compilazione

Richiede TeX Live con LuaLaTeX e latexmk. Con VSCode: estensione **LaTeX Workshop** con la recipe `Compila (LuaLaTeX)`.

```bash
cd Tesi/
latexmk -pdflua main.tex
```

I file ausiliari vengono scritti in `.temp/`. Per pulire:

```bash
latexmk -c
```

Il PDF è configurato in formato **PDF/A-3b** (`\usepackage[a-3b,pdf17]{pdfx}` in `Tesi/main.tex`).

---

## Comandi e ambienti custom

### Tesi — definiti in `Tesi/main.tex`

#### Highlight per revisione
Evidenziano testo con colori diversi per distinguere le note dei revisori durante la scrittura. Da rimuovere prima della consegna.

```latex
\hlA{testo}   % sfondo cyan
\hlB{testo}   % sfondo arancione
\hlC{testo}   % sfondo verde
```

Per personalizzare con i nomi dei tuoi revisori, aggiungi alias nel preambolo di `Tesi/main.tex`:
```latex
\newcommand{\hlmarco}[1]{\hlA{Marco: #1}}
\newcommand{\hlrelatore}[1]{\hlB{Prof. Rossi: #1}}
```

#### Simboli
```latex
\cmark   % ✓  (da pifont)
\xmark   % ✗  (da pifont)
```

#### Notazione matematica
Scorciatoie per la notazione del gruppo di ricerca.

```latex
\angled{x}          % ⟨x⟩
\bigangled{x}       % big⟨x⟩
\bigsquared{x}      % big[x]
\tuple{x, y}        % (x, y)
\interval{a}{b}     % [a, b]
```

#### Pseudocode
Estensioni di `algpseudocode` per lo stile del gruppo.

```latex
\AlgLineComment{testo}      % ▷ testo  (commento inline)
\AlgForIn{var}{iterable}    % for var in iterable
\AlgFalse                   % false (grassetto)
\AlgTrue                    % true  (grassetto)
```

#### Tipi colonna per tabularx
```latex
P{3cm}   % colonna p raggedright di larghezza fissa
C        % colonna X centrata
L        % colonna X raggedright
R        % colonna X raggedleft
```

#### Ambienti
```latex
\begin{exmp}   % Esempio formale, numerato per sezione
\begin{defn}   % Definizione formale, numerata per sezione

\begin{inlineenum}          % Enumerazione inline nel testo
    \item primo \item secondo   % → "i) primo ii) secondo"
\end{inlineenum}
```

---

### Presentazione — definiti in `Presentazione/main.tex`

```latex
\testcolor{maincolor}           % colorbox per visualizzare/verificare un colore
\hrefcol{https://...}{testo}    % hyperlink colorato in cyan
```

**Stili TikZ globali** (disponibili in tutti i frame):
```latex
\node[boxes] {testo}        % rettangolo con bordo nero
\node[rboxes] {testo}       % rettangolo con angoli arrotondati
\node[arrow_label] {testo}  % etichetta bianca su una freccia
```

---

### Presentazione — stili TikZ avanzati in `00_common_tikz.tex`

Stili per diagrammi del gruppo di ricerca. Disponibili dopo `\input{00_common_tikz.tex}`.

| Stile | Uso |
|-------|-----|
| `entity` | ellisse sottile (nodi concettuali) |
| `artifact` | rettangolo arrotondato grigio |
| `service` | rettangolo smussato a 30° |
| `highlight` | bordo e sfondo oro |
| `highlight light` / `highlight very light` | sfondo oro 50% / 20% |
| `highlight text` | testo color Goldenrod |
| `connector` | freccia Stealth |
| `connector assurance` | freccia Stealth tratteggiata |
| `link` | freccia Latex |
| `lattice element bound/selected/not chosen` | nodi per diagrammi a reticolo |
| `arrow` | shape=signal, sfondo DarkBlue/White |

**Overlay condizionale** — mostra un nodo solo su una slide specifica:
```latex
\node[boxes, on slide=<2>{opacity=0}] {testo};
```

**Macro**:
```latex
\highlightprofilecolor   % colore corrente highlight (ridefinibile)
```

---

### Presentazione — comandi del tema `beamertheme_statale.sty`

Il tema è stato sviluppato per l'ateneo. Comandi disponibili nel documento:

```latex
\course{Laurea Magistrale in ...}   % corso nel titolo
\IDnumber{987326}                   % matricola nel titolo

\footlinecolor{maincolor}           % colore barra inferiore
% colori disponibili: maincolor, stataledarkgreen, statalegreen,
%   statalelightgreen, statalered, stataleyellow, statalelilla

\footlinepayoff{testo custom}       % testo personalizzato nella barra

\titlebackground{assets/file}       % sfondo fullscreen slide titolo
\titlebackground*{assets/file}      % sfondo split slide titolo

\themecolor{main}   % tema chiaro (default)
\themecolor{dark}   % tema scuro

\backmatter             % slide finale di ringraziamenti
\backmatter[notitle]    % variante senza ripetizione titolo

\hrefcol{url}{testo}    % link colorato in cyan
\testcolor{color}       % colorbox per debug colori
```

**Ambienti speciali** (definiti in `chapters/special_slides.tex`):

```latex
% Slide divisore capitolo
\begin{chapter}[assets/background_negative]{maincolor}{Titolo capitolo}
    contenuto opzionale
\end{chapter}

% Slide con immagine laterale fissa
\begin{sidepic}{assets/path/image}{Titolo frame}
    contenuto
\end{sidepic}
```

---

## Licenza

[![CC BY-NC-ND 4.0][cc-by-nc-nd-image]][cc-by-nc-nd]

Distribuito con licenza **Creative Commons BY-NC-ND 4.0**.
Puoi condividerlo purché citi l'autore, non lo usi commercialmente e non lo modifichi.

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/deed.it
[cc-by-nc-nd-image]: https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png
