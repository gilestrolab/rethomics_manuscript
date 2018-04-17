
geissmann_et_all_2018.pdf: geissmann_et_all_2018.tex manuscript.pdf all-figures.pdf geissmann_et_all_2018.tex
	pdflatex $<
	
FIGS := $(shell ls fig/*.pdf)

all-figures.pdf: $(FIGS)
	pdftk $^ cat output $@
	

manuscript.bib: rethomics_manuscript.bib
	cat $< | sed 's/journaltitle =/journal =/g' > $@
	#cat $< | sed 's/journal =/journal =/g' > $@

manuscript.tex: manuscript.Rnw results.Rnw manuscript.bib
	R -e "library(knitr);knit(\"$<\")"


manuscript.pdf: manuscript.tex all-figures.pdf
	pdflatex $<
	bibtex manuscript.aux
	pdflatex $<
	pdflatex $<
clean:
	rm *.log *.aux {manuscript,results}.tex *.out  *.pdf *.blg *.bbl *.tdo  -f 
	rm -rf cache/ 
	rm manuscript.bib -f
