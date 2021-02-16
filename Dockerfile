FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
      texlive \
      texlive-latex-base \
      texlive-font-utils \
      texlive-lang-european \
      pandoc \
      ghostscript

WORKDIR /statutter
#
#COPY ./generate.sh /
#
#CMD /generate.sh
