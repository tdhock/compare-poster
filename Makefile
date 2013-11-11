HOCKING-svm-compare.pdf: HOCKING-svm-compare.tex figure-norm-data-doc.pdf figure-results.pdf figure-hard-margin-doc.pdf sushi.pdf
	rm -f *.aux *.bbl
	pdflatex $<

# TODO: 

# SVMrank optimization problem.

# pictures of big/small n, \rho on the left/right of the results
# figures.

# Lemma.

# ref R package.

sushi.pdf: sushi.tex table-sushi.tex
	pdflatex $<

figure-norm-data-doc.pdf: figure-norm-data-doc.tex figure-norm-data.tex
	pdflatex $<
figure-norm-data.tex: figure-norm-data.R tikz.R colors.R
	R --no-save < $<

figure-hard-margin-doc.pdf: figure-hard-margin-doc.tex figure-hard-margin.tex
	pdflatex $<
figure-hard-margin.tex: figure-hard-margin.R tikz.R colors.R
	R --no-save < $<
table-sushi.tex: table-sushi.R sushi.csv
	R --no-save < $<

figure-results.pdf: figure-results.tex figure-norm-level-curves.tex figure-simulation-samples.tex figure-auc.tex
	pdflatex $<
figure-simulation-samples.tex: figure-simulation-samples.R simulation.samples.RData tikz.R colors.R sushi.samples.RData
	R --no-save < $<
figure-norm-level-curves.tex: figure-norm-level-curves.R tikz.R simulation.samples.RData colors.R
	R --no-save < $<
figure-auc.tex: figure-auc.R simulation.roc.RData tikz.R colors.R sushi.roc.RData
	R --no-save < $<
## RData files are copied from compare-paper.