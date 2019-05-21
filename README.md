From Andy's version, I've updated in two rounds:

1. In 2015, I completed my UVM Ph.D. Dissertation, whereupon I reorganized and 
entered a lot of new hyperlinks to and from the TOC
and ensured compatibility with the `tikz` package
that I often used at the time.
Overall, these updates were oriented towards
making the repo in line with the Journal Format Thesis guidelines,
unlike Andy's, which was set up better for standard format.
However, I believe I was also to reasonably-well consolidate
Standard vs. Journal format chapter styles so that
the template will function for both, 
without having to specify any special filenames
or extensions indicating what _type_ of chapter you're writing.
This said, there is still a bit of juggling required
to manage the differnet bibliography styles,
as is documented inline in the updated template comments.
Note: some Journal Format actions are taken at the command level,
particularly in `makedoc.sh`, whereupon the `STYLE="JA"`
simply needs to be modified away (to anything else)
to move back into the standard thesis style.

Additonally, from this point of update there is still one remaining
issue with errors having to do with the Journal Format bibliographies.
Apparently `chicago.bst` isn't compatible with `natbib` such that
the following error is thrown:

- `! Paragraph ended before \citeauthoryear was complete.`

once for each cite in the main bibliography. 
While this is _very_ annoying,
it can be ignored by hitting `<return>` 
until compilation continues. 
While this is a serious obstruction to speed,
it _does not_ appear to have a tangible effect on the output document.

2. In 2019, I submitted my Mid-Point Review Dossier 
documenting my progress towards tenure at Drexel. 
Naturally, a range of different variables and
functionalities were required for this update, 
including the Executive Summary enviornment.
While likely not of interest for UVM folks,
these elements are left in the template,
perhaps for no other purpose than to exhibit
how this template might be twisted towards other purposes;
it's a good workhorse! 
Note, that since this tempalte's recent use
was not towards the current UVM dissertation guidelines,
it will likely need to be 
checked against the current guidelines for compliance.

Additionally, since multiple document types are
being handled through this template, 
I've replaced `make-dissertation.sh`
with a trimmed-back version---the standard usage is now:

- `./makedoc.sh` or `./makedoc.sh q`

(the latter being for quick, non-TOC-updating, etc., compilations.)

Note as well that in order to use the `./fig/` directory
as a repository of document figures 
(to be drawn upon from the chapters)
one must update their their `TEXINPUTS` path vairable
in a `.bash_profile` of `.bashrc`, etc., file, like:

- `export TEXINPUTS=./:./fig//:$TEXINPUTS

Otherwise, all figures will just have to be in the repo-main directory.

Overall, continued maintemance will be sparse from my end,
relating mostly to needs for other big-document production.
I'm happy to field questions, but can't promise efficient support.

Cheers,
Jake

-------------------------------------------

From Josh's version I've added some functionality through scripts, reorganized, and made the default more thesis-oriented.

TLDR: run "./setup.sh my-dissertation", edit away, compile w "./make-dissertation.sh"

Mainly, it's just more set up for making a standard style thesis (as opposed to a journal article thesis).
Both functionalities are included in the dissertation.tex file, and both sets of tex files for the chapters are included.
Running ./make-dissertation.sh makes either format, specified by the variable STYLE.

I've also included a few files for catching common writing errors, as detailed in http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/ and brought to our attention by Chris Danforth.
These run by default in make-dissertation.sh and their usage is otherwise documented in bin.

On making an arxiv version: there are three scripts of Peter's that I've hacked upto make work on this repo.
This has only been tested with Master's thesis options in place.
As I've left it, it moves all the TeX to one file, and renames and grabs all of the figures, converts them all to pdf (from .ps,.pdf,.png,.jpg).
Things I changed from Peter were in the make-links, and make-arxiv-submission scripts.
In make-links.pl, you can play around to convert more figure types to pdf, or I commented out a chunk that converts them all to .eps.
But those files are bigger (although it will run without pdflatex then).
For the arXiv the images need to be small, (and they don't say), but I've figured out that less than 400K is okay.
It might be best to leave photos (with colors) as jpg, but the size penalty for converting the to pdf isn't that bad, and it looks nice having everything be pdf.
(This would be a quick change in make-links.pl).
For pdf's that are huge (millions of points plotted), you can bitmap them by converting to a png and back.
The -density is really important, for how it looks and the file size (those work in opposite directions).
Here is an example: (you need imagemagick and/or miktex)
% convert -density 150 image.{pdf,png}
% cp image{.pdf,-backup.pdf}
% convert image.{png,pdf}

If you have an ToC formatting questions, ask soon because I'll forget how that works.

Cheers,
Andy

-------------------------------------------

This is a LaTeX style file for typesetting a UVM thesis or dissertation in compliance with the guideline of the Graduate College.  The package is free software, available under the terms of the Academic Free License version 2.0.

I, Joshua Auerbach, adapted this from materials provided by David Van Horn (see http://www.cs.brandeis.edu/~dvanhorn/uvmlatexthesis/ and text below)

I have updated David's file to comply with the current guidelines (As of Spring semester 2013, see http://www.uvm.edu/~gradcoll/pdf/Guidelines%20for%20Writing%20and%20Defending%20Thesis%20and%20Disseration.pdf)
and to allow for journal format dissertations, but you will still need to bring a copy of your thesis to the Graduate College for a format review, and they may require you to make small changes. 

See dissertation.tex for an example and more details.

Use make-dissertation.sh to compile (this has some special logic for creating the per chapter reference sections)

Hope this is somewhat helpful.  Following David's initial remarks I welcome comments, questions, and improvements on this package. If your thesis uses this style, I'd really appreciate a notice. 
---Josh

------------------------------------------

David's original notice:

This is a LaTeX style file for typesetting a graduate thesis in compliance with the guidelines of the Graduate College of the University of Vermont. The package is free software, available under the terms of the Academic Free License version 2.0.

caveat emptor: You will still need to bring a copy of your thesis to the Graduate College for a format review, and they may require you to make small changes. Several people have taken a thesis using this style for review. Each time, different minor changes are requested by the reviewer. So, the process is not totally consistent, but this package should save you significant work. Send me any changes requested by the Graduate College and I will incorporate them into the style to save others the hassle.

I welcome comments, questions, and improvements on this package. If your thesis uses this style, I'd really appreciate a notice. ---David
