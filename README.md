# Abakus' statutter

Her finner du LaTeX-kildekoden til statuttene til Abakus Linjeforening. Send gjerne endringsforslag via pull-requests, les mer om reglene for statuttendringer i [CONTRIBUTING.md](CONTRIBUTING.md).

## Organisering

`statutter` mappen inneholder kildekoden til statuttene.

`static` mappen inneholder filer som blir brukt under generering av nettsiden.

`public` mappen inneholder alt av output som docker containeren genererer. Denne mappen blir entrypoint for nettsiden, og det er disse html og css filene som brukere ser.

## Bygging av statutter

Alle statuttene bygges ved hjelp av et `docker` image som har all programvare som trengs, samt et generering script som bruker denne programvaren. Scriptet bygger både `pdf` og `html` versjon av statuttene.

### Kjør bilde ved hjelp av følgende kommando

Den mounter de tre volumene `statutter, static og public` som blir brukt av bildet når den bygger statutter.

I tillegg kan du sende inn `ASSEMBLY_DATE` som en variabel, og den genererte pdf filen som blir arkivert får dette navnet.

```sh
$ docker run --rm \
    -v `pwd`/statutter:/statutter/ \
    -v `pwd`/static:/static/ \
    -v `pwd`/public:/public/ \
    -e ASSEMBLY_DATE=01.januar.1970 \
    abakus/statuttbuilder:latest
```
