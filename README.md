# rethomics manuscript

The sweave (`R` + `latex`) files used to generate the rethomics manuscript.
Curently available under the CC-BY license as a preprint on [biorxiv](https://www.biorxiv.org/content/early/2018/04/21/305664)


**IMPORTANT** do *not* modify the `.tex` files (see below).

## Set up

1. Clone this repo
2. check you have the arch packages `texlive-most gcc-fortran r`
3. Install the `R` packages required:

```R
# these should take a few min
install.packages(c("devtools", 
					"knitr", 
					"cowplot",
					"ggetho",
					"zeitgebr",
					"damr"),
				repos = c(CRAN = "http://cran.rstudio.com"))
	
# sleepr installed from github (ignore the warning about submodule)
devtools::install_github("rethomics/sleepr")
```

## Building the whole manuscript

Once the necessary packages are installed, we can compile 
the whole manuscript with a makefile using `make all`.

The generates two targets: 

* `geissmann_et_al_2018.pdf` -- The whole formated manuscript
* `manuscript-changes.pdf`  -- The manuscript with track changes for revisions (made with latexdiff)

To clean the project, one can run `make clean`


## Editing the manuscript

**IMPORTANT** do *not* modify the `.tex` files. Tex files are compiled from the  `.Rnw` files.
The text of the manuscript is contained in two files:

* `manuscript.Rnw` -- All the text, except the result section
* `results.Rnw` -- The result section only


