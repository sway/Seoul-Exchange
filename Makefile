LATEX = xelatex
BIB = biber -u 
PROJECT = soulexchange
TITLE = Seoul_Exchange

all: 	pdf
	open -g ${PROJECT}.pdf
pdf:
	${LATEX} ${PROJECT}.tex 

bib:
	${BIB} ${PROJECT} >/dev/null

pdfb: 	bib
	${LATEX} ${PROJECT}.tex | grep -E 'undefined|Output written'

o:   	pdf
	open ${PROJECT}.pdf

kindle:
	${LATEX} "\def\kindle{} \input ${PROJECT}.tex" 
	${BIB} ${PROJECT} >/dev/null
	${LATEX} "\def\kindle{} \input ${PROJECT}.tex" | grep -E 'undefined|Output written' 

crop:
	${LATEX} '\def\showcrops{} \input ${PROJECT}.tex' | grep -E 'undefined|Output written'

clean:
	rm -f *.log *.aux *.bbl *.bcf *.blg *.lof *.lot *.dvi *.toc *.out *~ *.ps
