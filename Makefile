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
	rm -f gh-pages/index.html gh-pages/statutter.pdf

jekyll: clean gh-pages/index.html gh-pages/statutter.pdf

publish: clean gh-pages/index.html gh-pages/statutter.pdf
	rm -rf gh-pages/_site
	ghp-import gh-pages
	git push origin gh-pages -f

gh-pages/index.html:
	echo "---\nlayout: default\n---" > gh-pages/index.html
	pandoc -f latex -t html content.tex >> gh-pages/index.html

gh-pages/statutter.pdf: compile
	cp statutter.pdf gh-pages/.

.PHONY: compile open clean publish
