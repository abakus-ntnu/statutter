ifeq ($(shell uname -s), Darwin)
	OPEN='open'
else
	OPEN='see'
endif

# Used to check if any of the tex files have been changed
TEX = $(shell find . -name "*.tex")

all: statutter.pdf

test: clean statutter.pdf

statutter.pdf: $(TEX)
	@ test -d logs || mkdir logs
	@ pdflatex --jobname=statutter -halt-on-error main.tex >> logs/compile \
	  && echo "Compiled report" || (cat logs/compile && fail)

open: statutter.pdf
	$(OPEN) statutter.pdf

clean:
	rm -f *.log *.aux *.lof *.pdf *.toc *.lot
	rm -f gh-pages/index.html gh-pages/statutter.pdf

jekyll: clean gh-pages/index.html gh-pages/statutter.pdf

publish: clean gh-pages/index.html gh-pages/statutter.pdf
	rm -rf gh-pages/_site
	ghp-import gh-pages
	git push origin gh-pages -f

gh-pages/index.html: content.tex
	echo "---\nlayout: default\n---" > gh-pages/index.html
	pandoc -f latex -t html content.tex >> gh-pages/index.html

gh-pages/statutter.pdf: statutter.pdf
	cp statutter.pdf gh-pages/.

.PHONY: open clean publish
