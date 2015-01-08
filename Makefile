ifeq ($(shell uname -s), Darwin)
	OPEN='open'
else
	OPEN='see'
endif

all: open

test: compile

compile:
	@ test -d logs || mkdir logs
	@ pdflatex --jobname=statutter -halt-on-error main.tex >> logs/compile \
	  && echo "Compiled report" || (cat logs/compile && fail) 

open: compile
	$(OPEN) statutter.pdf

clean:
	rm -f *.log *.aux *.lof *.pdf *.toc *.lot

.PHONY: compile open clean
