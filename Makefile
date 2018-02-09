
all: manuscript.pdf all-figures.pdf

FIGS := $(shell ls fig/*.pdf)

all-figures.pdf: $(FIGS)
	pdftk $^ cat output $@
	

manuscript.tex: manuscript.Rnw results.Rnw
	R -e "library(knitr);knit(\"$<\")"
	
manuscript.pdf: manuscript.tex all-figures.pdf
	pdflatex $<
	pdflatex $<

clean:
	rm *.log *.aux *.tex *.out  *.pdf -f 
	rm -r cache/ 
