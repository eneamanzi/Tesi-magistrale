[![CC BY-NC-ND 4.0][cc-by-nc-nd-shield]][cc-by-nc-nd]

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[cc-by-nc-nd-shield]: https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg

**English version** | [Versione italiana](README.md)
# Master's Degree Thesis Template — Università degli Studi di Milano

LaTeX template for a master's degree thesis (and Beamer presentation) at the Department of Computer Science "Giovanni Degli Antoni", UniMI.

Derived from the bachelor's thesis of Enea Manzi (A.Y. 2023-2024), supervisor Prof. Marco Anisetti.

---

## Structure

```
├── Tesi/               # Main document (scrbook, LuaLaTeX)
│   ├── main.tex
│   ├── glossary.tex    # Acronyms (\gls{}, \glspl{})
│   ├── biblio.bib      # Bibliography (IEEE style)
│   ├── sections/       # One file per chapter
│   └── style/          # Syntax highlighting: yaml.sty, rust.sty, json.sty
├── Presentazione/      # Beamer slides 16:9
│   ├── main.tex
│   ├── sections/       # One file per section
│   ├── 00_common_tikz.tex   # Advanced TikZ styles
│   └── chapters/special_slides.tex  # chapter and sidepic environments
├── Riassunto/          # Short summary (scrartcl, ~1 page)
│   └── main.tex
└── .github/workflows/  # CI: compiles the 3 PDFs and publishes them to pdf-release
```

---

## Compilation

Requires TeX Live with LuaLaTeX and latexmk. With VSCode: **LaTeX Workshop** extension with the `Compila (LuaLaTeX)` recipe.

```bash
cd Tesi/
latexmk -pdflua main.tex
```

Auxiliary files are written to `.temp/`. To clean:

```bash
latexmk -c
```

The PDF is configured in **PDF/A-3b** format (`\usepackage[a-3b,pdf17]{pdfx}` in `Tesi/main.tex`).

---

## Custom Commands and Environments

### Tesi — defined in `Tesi/main.tex`

#### Review highlights
Highlight text with different colors to distinguish reviewer notes during writing. Remove before submission.

```latex
\hlA{text}   % cyan background
\hlB{text}   % orange background
\hlC{text}   % green background
```

To personalize with your reviewers' names, add aliases in the preamble of `Tesi/main.tex`:
```latex
\newcommand{\hlmarco}[1]{\hlA{Marco: #1}}
\newcommand{\hlsupervisor}[1]{\hlB{Prof. Rossi: #1}}
```

#### Symbols
```latex
\cmark   % ✓  (from pifont)
\xmark   % ✗  (from pifont)
```

#### Mathematical notation
Shortcuts for the research group's notation.

```latex
\angled{x}          % ⟨x⟩
\bigangled{x}       % big⟨x⟩
\bigsquared{x}      % big[x]
\tuple{x, y}        % (x, y)
\interval{a}{b}     % [a, b]
```

#### Pseudocode
Extensions of `algpseudocode` for the group's style.

```latex
\AlgLineComment{text}       % ▷ text  (inline comment)
\AlgForIn{var}{iterable}    % for var in iterable
\AlgFalse                   % false (bold)
\AlgTrue                    % true  (bold)
```

#### Column types for tabularx
```latex
P{3cm}   % fixed-width raggedright p column
C        % centered X column
L        % raggedright X column
R        % raggedleft X column
```

#### Environments
```latex
\begin{exmp}   % Formal example, numbered per section
\begin{defn}   % Formal definition, numbered per section

\begin{inlineenum}          % Inline enumeration in text
    \item first \item second    % → "i) first ii) second"
\end{inlineenum}
```

---

### Presentazione — defined in `Presentazione/main.tex`

```latex
\testcolor{maincolor}           % colorbox to display/check a color
\hrefcol{https://...}{text}     % cyan-colored hyperlink
```

**Global TikZ styles** (available in all frames):
```latex
\node[boxes] {text}         % rectangle with black border
\node[rboxes] {text}        % rectangle with rounded corners
\node[arrow_label] {text}   % white label on an arrow
```

---

### Presentazione — advanced TikZ styles in `00_common_tikz.tex`

Diagram styles for the research group. Available after `\input{00_common_tikz.tex}`.

| Style | Use |
|-------|-----|
| `entity` | thin ellipse (conceptual nodes) |
| `artifact` | rounded grey rectangle |
| `service` | 30° chamfered rectangle |
| `highlight` | gold border and fill |
| `highlight light` / `highlight very light` | gold fill at 50% / 20% |
| `highlight text` | Goldenrod-colored text |
| `connector` | Stealth arrow |
| `connector assurance` | dashed Stealth arrow |
| `link` | Latex arrow |
| `lattice element bound/selected/not chosen` | nodes for lattice diagrams |
| `arrow` | shape=signal, DarkBlue/White background |

**Conditional overlay** — show a node only on a specific slide:
```latex
\node[boxes, on slide=<2>{opacity=0}] {text};
```

**Macro**:
```latex
\highlightprofilecolor   % current highlight color (redefinable)
```

---

### Presentazione — commands from `beamertheme_statale.sty`

The theme was developed for the university. Commands available in the presentation document:

```latex
\course{Master's Degree in ...}     % degree program in title slide
\IDnumber{987326}                   % student ID in title slide

\footlinecolor{maincolor}           % footline bar color
% available colors: maincolor, stataledarkgreen, statalegreen,
%   statalelightgreen, statalered, stataleyellow, statalelilla

\footlinepayoff{custom text}        % custom text in footline

\titlebackground{assets/file}       % fullscreen title slide background
\titlebackground*{assets/file}      % split title slide background

\themecolor{main}   % light theme (default)
\themecolor{dark}   % dark theme

\backmatter             % final thank-you slide
\backmatter[notitle]    % variant without title repetition

\hrefcol{url}{text}     % cyan-colored link
\testcolor{color}       % colorbox for debugging colors
```

**Special environments** (defined in `chapters/special_slides.tex`):

```latex
% Chapter divider slide
\begin{chapter}[assets/background_negative]{maincolor}{Chapter Title}
    optional content
\end{chapter}

% Frame with fixed side image
\begin{sidepic}{assets/path/image}{Frame Title}
    content
\end{sidepic}
```

---

## License

[![CC BY-NC-ND 4.0][cc-by-nc-nd-image]][cc-by-nc-nd]

This work is licensed under a **Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License**.

You are free to share it as long as you credit the author, do not use it for commercial purposes, and do not modify it.

[cc-by-nc-nd]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[cc-by-nc-nd-image]: https://licensebuttons.net/l/by-nc-nd/4.0/88x31.png
