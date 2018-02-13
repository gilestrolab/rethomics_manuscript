
all: manuscript.pdf all-figures.pdf

FIGS := $(shell ls fig/*.pdf)

all-figures.pdf: $(FIGS)
	pdftk $^ cat output $@
	

manuscript.bib: rethomics_manuscript.bib
	cat $< | sed 's/journaltitle =/journal =/g' > $@

manuscript.tex: manuscript.Rnw results.Rnw manuscript.bib
	R -e "library(knitr);knit(\"$<\")"


manuscript.pdf: manuscript.tex all-figures.pdf
	pdflatex $<
	bibtex manuscript.aux
	pdflatex $<
	pdflatex $<
clean:
	rm *.log *.aux *.tex *.out  *.pdf *.blg *.bbl *.tdo  -f 
	rm -rf cache/ 
	rm manuscript.bib
