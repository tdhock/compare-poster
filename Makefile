HOCKING-svm-compare.pdf: HOCKING-svm-compare.tex figure-norm-data-doc.pdf #figure-hard-margin.pdf figure-simulation-samples.pdf figure-norm-level-curves.pdf figure-auc.pdf
	rm -f *.aux *.bbl
	pdflatex $<
figure-norm-data-doc.pdf: figure-norm-data-doc.tex figure-norm-data.tex
	pdflatex $<
figure-norm-data.tex: figure-norm-data.R tikz.R colors.R
	R --no-save < $<
figure-hard-margin.tex: figure-hard-margin.R tikz.R colors.R
	R --no-save < $<
figure-simulation-samples.tex: figure-simulation-samples.R simulation.samples.RData tikz.R Nsamp.R colors.R
	R --no-save < $<
figure-norm-level-curves.tex: figure-norm-level-curves.R tikz.R simulation.samples.RData Nsamp.R colors.R
	R --no-save < $<
figure-auc.tex: figure-auc.R simulation.roc.RData tikz.R colors.R
	R --no-save < $<
## RData files are copied from compare-paper.