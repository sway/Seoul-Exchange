LATEX = xelatex
BIB = biber -u 
PROJECT = soulexchange
TITLE = Seoul_Exchange

all: 	pdf notify

crop: 	docrop notify

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

docrop: 
	${LATEX} '\def\showcrops{} \input ${PROJECT}.tex'

notify:
	growlnotify -a "/Applications/TeX/TeXShop.app" -m "${PROJECT}.tex: Compilation done" ${LATEX}

clean:
	rm -f *.log *.aux *.bbl *.bcf *.blg *.lof *.lot *.dvi *.toc *.out *~ *.ps
