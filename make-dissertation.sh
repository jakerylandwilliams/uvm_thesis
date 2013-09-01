#!/bin/bash
pdflatex dissertation;

STYLE="Standard"

if [ $STYLE -eq "JA" ]; then
  for auxfile in chapter*.aux
  do
      bibtex `basename $auxfile .aux`
  done
  
  for bblfile in chapter*.bbl
  do
          sed -i 's/thebibliography/references/' $bblfile
  done
fi

bibtex dissertation;
pdflatex dissertation;
pdflatex dissertation;
pdflatex dissertation;
