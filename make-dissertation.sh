#!/bin/bash
pdflatex dissertation;

# set STYLE to JA for a journal article style thesis
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
