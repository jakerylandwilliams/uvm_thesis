#!/bin/bash
pdflatex dissertation;
for auxfile in chapter*.aux
do
    bibtex `basename $auxfile .aux`
done

for bblfile in chapter*.bbl
do
        sed -i 's/thebibliography/references/' $bblfile
done

bibtex dissertation;
pdflatex dissertation;
pdflatex dissertation;
pdflatex dissertation;
