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
	@ test -d logs || mkdir logs
	@ pdflatex -halt-on-error -interaction=nonstopmode $<  >> logs/compile \
	  && echo "Compiled $@" || (cat logs/compile && fail)
	@ pdflatex -halt-on-error -interaction=nonstopmode $< >> logs/compile2 \
	  && echo "Compiled again $@" || (cat logs/compile2 && fail)

$(ABAKUS).tex: $(ABAKUS)/*.tex
	@touch $@

$(FOND).tex: $(FOND)/*.tex
	@touch $@

open: $(ABAKUS).pdf $(FOND).pdf
	$(OPEN) $(FOND).pdf $(ABAKUS).pdf

clean:
	rm -f *.log *.aux *.lof *.pdf *.toc *.lot *.out
	rm -rf logs
	rm -f gh-pages/index.html gh-pages/fond/index.html gh-pages/$(ABAKUS).pdf gh-pages/$(FOND).pdf

jekyll: clean gh-pages/index.html gh-pages/fond/index.html gh-pages/$(ABAKUS).pdf gh-pages/$(FOND).pdf

publish: jekyll
	rm -rf gh-pages/_site
	ghp-import gh-pages
	git push origin gh-pages -f

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


.PHONY: open clean publish jekyll
