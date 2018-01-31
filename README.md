# Abakus Linjeforenings statutter [![Build Status](https://ci.abakus.no/api/badges/abakus-ntnu/statutter/status.svg)](https://ci.abakus.no/abakus-ntnu/statutter)

Her finner du latex kildekoden til statuttene til Abakus Linjeforening.
Send gjerne endringsforslag via pull-requests, les mer om reglene for
statuttendringer i [CONTRIBUTING.md](CONTRIBUTING.md).

## Bygg pdf for statuttene

Installer avhengigheter (Ubuntu):
```bash
sudo apt-get install texlive texlive-font-utils texlive-lang-european
```

Kompiler PDF (krever pdflatex):
```bash
make all
```

## Publiser på github pages
Ved å kjøre `make publish` vil man laste opp en html versjon og
en generert pdf til github pages på
[abakus-ntnu.github.io/statutter](http://abakus-ntnu.github.io/statutter).
Dette krever at man har [ghp-import](https://github.com/davisp/ghp-import)
og [pandoc](http://johnmacfarlane.net/pandoc/) installert.
