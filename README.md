# Abakus' statutter

Her finner du LaTeX-kildekoden til statuttene til Abakus Linjeforening.
Send gjerne endringsforslag via pull-requests, les mer om reglene for
statuttendringer i [CONTRIBUTING.md](CONTRIBUTING.md).

## Organisering

`statutter` mappen inneholder kildekoden til statuttene, og er der du gjør endringene vedtatt av generalforsamlingen.

`static` mappen inneholder statiske html template filer som blir brukt under generering av nettsiden.

`public` mappen inneholder alt av output som docker containeren genererer. Denne mappen blir entrypoint for nettsiden, og det er disse html og css filene som blir hostet.

## Bygging av statutter

Alle statuttene bygges ved hjelp av et `docker` image. Dette bildet inneholder
alle avhengigheter som trengs for å bygge både `pdf` og `html` versjon av statuttene.

### Kjør bilde ved hjelp av følgende kommondo

Den mounter de tre volumene `statutter, static og public` som blir brukt av bildet når den bygger statutter.

I tilegg kan du sende inn `ASSEMBLY_DATE` som en variabel, og den genererte pdf filen som blir arkivert får dette navnet.

```sh
$ docker run --rm \
    -v `pwd`/statutter:/statutter/ \
    -v `pwd`/static:/static/ \
    -v `pwd`/public:/public/ \
    -e ASSEMBLY_DATE=01.januar.1970 \
    abakus/statutter:latest
```

### Bygge bilde lokalt

```sh
$ docker build -t statutter .
```

## Publisering av statutter

Vi bruker [zeit](https://zeit.co/abakus-ntnu/statutter/) for å hoste statuttene på
[statutter.abakus.no](https://statutter.abakus.no/). Du må ha innstallert
[zeit-now](https://github.com/zeit/now) enten som vanlig `cli` eller gjennom `yarn` så du har
tilgang til `now` kommandoen. I tilegg må du har tilgang til abakus-ntnu sin
[org](https://zeit.co/abakus-ntnu) for å kunne deploye.

```sh
$ now
```
