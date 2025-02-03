# Grammatical Error Correction Using Machine Learning Web Application

> A Hanoi University of Science and Technology Thesis

Template taken from [Overleaf](https://www.overleaf.com/latex/templates/thesis-template-for-hanoi-university-of-science-and-technology/nfpspdwmgjmz)

Comply with the [SOICT's guidelines](https://soict.hust.edu.vn/trang-chu/template-va-quy-cach-dong-quyen-do-an-tot-nghiep)

## How to Compile

```sh
latexmk -file-line-error -synctex=1 -interaction=nonstopmode  -xelatex -outdir=build main.tex
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
