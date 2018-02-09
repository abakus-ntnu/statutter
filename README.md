# Abakus' statutter [![Build Status](https://travis-ci.org/abakus-ntnu/statutter.svg?branch=master)](https://travis-ci.org/abakus-ntnu/statutter)
Her finner du LaTeX-kildekoden til statuttene til Abakus Linjeforening.
Send gjerne endringsforslag via pull-requests, les mer om reglene for
statuttendringer i [CONTRIBUTING.md](CONTRIBUTING.md).

## Bygging av PDF
### Installering av pdfTeX
pdfTeX kreves for å bygge statuttene. Det kan installeres på følgende måte:

macOS (krever [Homebrew](https://brew.sh/)):
```bash
brew cask install mactex
```

Ubuntu:
```bash
sudo apt-get install texlive texlive-font-utils texlive-lang-european latexmk
```

### Kompilere PDF
```bash
make
```

## Nettside
### Publisering
[GitHub Pages](https://pages.github.com/) brukes til å hoste
[statutter.abakus.no](https://statutter.abakus.no). Opplastning av siste versjon
skjer automatisk av [Travis](https://travis-ci.org/abakus-ntnu/statutter) når
commits blir pushet til master.

### Lokal utvikling
#### Avhengigheter
macOS (krever [Homebrew](https://brew.sh/)):
```bash
brew install pandoc
```

Ubuntu:
```bash
sudo apt-get install pandoc
```

#### Bygging
```bash
make jekyll
cd gh-pages
bundle exec jekyll serve
```
