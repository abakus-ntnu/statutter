ifeq ($(shell uname -s), Darwin)
	OPEN='open'
else
	OPEN='see'
endif

ABAKUS=abakus-statutter
FOND=fond-statutter
# Used to check if any of the tex files have been changed
all: $(ABAKUS).pdf $(FOND).pdf

test: clean all jekyll

%.pdf: %.tex
	@ mkdir -p logs
	@ latexmk -pdf $<  >> logs/compile \
	  && echo "Compiled $@" || (cat logs/compile && fail)

$(ABAKUS).tex: $(ABAKUS)/*.tex
	@touch $@

$(FOND).tex: $(FOND)/*.tex
	@touch $@

open: $(ABAKUS).pdf $(FOND).pdf
	$(OPEN) $(FOND).pdf $(ABAKUS).pdf

clean:
	rm -f *.log *.aux *.lof *.pdf *.toc *.lot *.out *.fdb_latexmk *.fls
	rm -rf logs
	rm -f gh-pages/index.html gh-pages/fond/index.html gh-pages/*.pdf

jekyll: clean gh-pages/index.html gh-pages/fond/index.html gh-pages/$(ABAKUS).pdf gh-pages/$(FOND).pdf

gh-pages/index.html: $(ABAKUS).tex
	@echo "---\nlayout: abakus\n---" > gh-pages/index.html
	@pandoc -f latex -t html $(ABAKUS)/innhold.tex >> gh-pages/index.html
	@echo "Created $@"

gh-pages/fond/index.html: $(FOND).tex | gh-pages/fond
	@echo "---\nlayout: fond\n---" > gh-pages/fond/index.html
	@pandoc -f latex -t html $(FOND)/innhold.tex >> gh-pages/fond/index.html
	@echo "Created $@"

gh-pages/fond:
	@mkdir -p $@

gh-pages/%.pdf: %.pdf
	cp $< $@

.PHONY: open clean jekyll
