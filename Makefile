ifeq ($(shell uname -s), Darwin)
	OPEN='open'
else
	OPEN='see'
endif

ABAKUS=abakus-statutter
# Used to check if any of the tex files have been changed
all: $(ABAKUS).pdf

test: clean all jekyll

%.pdf: %.tex
	@ mkdir -p logs
	@ latexmk -pdf $<  >> logs/compile \
	  && echo "Compiled $@" || (cat logs/compile && fail)

$(ABAKUS).tex: $(ABAKUS)/*.tex
	@touch $@

open: $(ABAKUS).pdf
	$(OPEN) $(ABAKUS).pdf

clean:
	rm -f *.log *.aux *.lof *.pdf *.toc *.lot *.out *.fdb_latexmk *.fls
	rm -rf logs
	rm -f gh-pages/index.html gh-pages/*.pdf

jekyll: clean gh-pages/index.html gh-pages/$(ABAKUS).pdf

gh-pages/index.html: $(ABAKUS).tex
	@echo "---\nlayout: abakus\ntitle: Abakus' statutter\n---" > gh-pages/index.html
	@pandoc --filter pandoc-section-links -f latex -t html $(ABAKUS)/innhold.tex >> gh-pages/index.html
	@echo "Created $@"

gh-pages/%.pdf: %.pdf
	cp $< $@

.PHONY: open clean jekyll
