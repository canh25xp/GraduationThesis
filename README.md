# Grammatical Error Correction Using Machine Learning Web Application

> A Hanoi University of Science and Technology Thesis

Template taken from [Overleaf](https://www.overleaf.com/latex/templates/thesis-template-for-hanoi-university-of-science-and-technology/nfpspdwmgjmz)

Comply with the [SOICT's guidelines](https://soict.hust.edu.vn/trang-chu/template-va-quy-cach-dong-quyen-do-an-tot-nghiep)

## How to Compile

```sh
latexmk -file-line-error -synctex=1 -interaction=nonstopmode  -xelatex -outdir=build report.tex
```

## Convert markdown to pdf and tex

Download pandoc if you haven't

```sh
sudo apt install pandoc
```

The markdown contains mermaid diagrams, download mermaid-filter first

```sh
npm install --global mermaid-filter
```

Then convert the markdown to pdf

```sh
pandoc --filter mermaid-filter -o outlines.pdf OUTLINES.md
```

```sh
pandoc -f markdown -t latex --wrap=preserve --top-level-division=chapter -o outline.tex OUTLINES.md
```

## Export mermaid diagram

```sh
mmdc -i diagrams/usecase1.mmd -o diagrams/usecase1.png # or .pdf, .svg
```

## Export and crop pdf

```sh
qpdf --empty --pages references/ef-epi-2024-english.pdf 4 -- figures/ef-epi-2024-english.pdf
pdfinfo figures/ef-epi-2024-english.pdf
pdfcrop --margins '0 0 0 -330' figures/ef-epi-2024-english.pdf figures/ef-epi-2024-english-crop.pdf
```

## Tools

[Online Latex Annotate tool](https://ff.cx/latex-overlay-generator)

