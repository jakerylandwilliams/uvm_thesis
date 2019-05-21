#!/bin/bash

quick=0
if [ "$1" == "q" ]; then
    quick=1
fi

FILENAME_BASE="template"

## set STYLE to "JA" for a journal article style thesis
##      (and set the \input's to \include's in the main)
STYLE="JA"

pdflatex $FILENAME_BASE-main;

if [ $STYLE == "JA" ]; then
  for auxfile in $FILENAME_BASE.chapter*.aux
  do
      bibtex `basename $auxfile`
  done
  
  for bblfile in $FILENAME_BASE.chapter*.bbl
  do
          sed -i "" -e 's/thebibliography/references/' $bblfile
  done
fi

if [ "$quick" == "0" ]; then
    bibtex $FILENAME_BASE-main;
    pdflatex $FILENAME_BASE-main;
    pdflatex $FILENAME_BASE-main;
    ## again for good measure
    pdflatex $FILENAME_BASE-main;
fi

## open pdf in default viewer
open $FILENAME_BASE-main.pdf;

if [ "$quick" == "0" ]; then
    ## make a single latex file
    echo "making a single latex file..."
    ./make-single-latex-file.pl $FILENAME_BASE-main.tex

    ## check the consolidated tex file and check it for issues
    echo "checking for lexical illusions: $FILENAME_BASE-main-combined.tex" > $FILENAME_BASE-autoedits.txt
    echo " " >> $FILENAME_BASE-autoedits.txt
    perl bin/lexical-illusion-spotter.pl $FILENAME_BASE-main-combined.tex >> $FILENAME_BASE-autoedits.txt

    echo "checking for weasel words: $FILENAME_BASE-main-combined.tex" > $FILENAME_BASE-autoedits.txt
    echo " " >> $FILENAME_BASE-autoedits.txt
    bin/weasel-word-spotter.sh $FILENAME_BASE-main-combined.tex >> $FILENAME_BASE-autoedits.txt

    echo "checking for passive voice: $FILENAME_BASE-main-combined.tex" > $FILENAME_BASE-autoedits.txt
    echo " " >> $FILENAME_BASE-autoedits.txt
    bin/passive-word-spotter.sh $FILENAME_BASE-main-combined.tex >> $FILENAME_BASE-autoedits.txt

    echo "checking for todos: $FILENAME_BASE-main-combined.tex" >> $FILENAME_BASE-autoedits.txt
    echo " " >> $FILENAME_BASE-autoedits.txt
    echo "There are $(($(grep todo $FILENAME_BASE-main-combined.tex | wc -l | awk '{print $1;}')-2)) to-dos!!" >> $FILENAME_BASE-autoedits.txt
    
    ## leaving the .bbl for making arxiv version    
    ## \rm *.{toc,aux,log,lot,lof,blg}
fi
