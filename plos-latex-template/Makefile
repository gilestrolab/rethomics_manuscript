all: manuscript.pdf

manuscript.tex: manuscript.Rnw results.Rnw
	R -e "library(knitr);knit(\"$<\")"
	
manuscript.pdf: manuscript.tex
	pdflatex $<

clean:
	rm *.log *.aux *.tex *.out -f
