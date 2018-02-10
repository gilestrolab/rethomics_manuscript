
all: manuscript.pdf all-figures.pdf

FIGS := $(shell ls fig/*.pdf)

all-figures.pdf: $(FIGS)
	pdftk $^ cat output $@
	

manuscript.tex: manuscript.Rnw results.Rnw
	R -e "library(knitr);knit(\"$<\")"


manuscript.pdf: manuscript.tex all-figures.pdf
	pdflatex $<
	bibtex manuscript.aux
	pdflatex $<
	pdflatex $<
clean:
	rm *.log *.aux *.tex *.out  *.pdf *.blg *.bbl  -f 
	rm -rf cache/ 
