TIMESTAMP=`eval date +%d.%B.%Y`

# Convert abakus LaTeX to html
pandoc -f latex -o public/index.html \
  --include-in-header=static/head.html \
  --include-before-body=static/abakus.html \
  --include-after-body=static/end.html \
  statutter/abakus-statutter/innhold.tex

# Move other static files to the public folder
cp static/main.css static/abakule.jpg public/

# Convert abakus LaTeX to PDF
pdflatex -halt-on-error statutter/abakus-statutter.tex
pdflatex -halt-on-error statutter/abakus-statutter.tex
pdflatex -pdf -halt-on-error -output-dir="./public" statutter/abakus-statutter.tex

# Store a copy of the pdf in the archive
mkdir -p public/archive/
cp public/*.pdf public/archive/$TIMESTAMP.pdf

# Clean up the Statutter directory, as it used to genereate fles
rm -f ./statutter/*.log \
      ./statutter/*.aux \
      ./statutter/*.out \
      ./statutter/*.toc \
      ./statutter/*.pdf # The result PDF is moved to /public by pdflatex

# Clean up the public directory, as it's used to genereate fles
rm -f ./public/*.log \
      ./public/*.aux \
      ./public/*.out \
      ./public/*.toc \
