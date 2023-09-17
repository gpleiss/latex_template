paper = main

# Grab all possible source
source := $(shell ls **/*.tex *.sty figures/*pdf figures/*png figures/*jpg 2>/dev/null)
sourcebib := $(shell ls *.bib)

all:
	pdflatex ${paper}.tex
	bibtex ${paper}.aux
	pdflatex ${paper}.tex
	pdflatex ${paper}.tex

${paper}.bbl: ${sourcebib}
	pdflatex ${paper}.tex
	bibtex ${paper}.aux
	pdflatex ${paper}.tex

${paper}.pdf: ${paper}.bbl ${source}
	pdflatex ${paper}.tex

quick:
	pdflatex ${paper}.tex

watch:
	while true; do if [ sections -nt ${paper}.pdf ] || [ ${paper}.tex -nt ${paper}.pdf ] || [ figures -nt ${paper}.pdf ]; then make quick; fi; sleep 1; done

clean:
	rm -rf *.aux *.blg *.bbl *.log *.out ${paper}.pdf
