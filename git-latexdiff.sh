#!/bin/bash

# checkout master version of dissertaiton into "old.tex"
git show master:fgimenez_dissertation.tex > tmp_old.tex

# expand comparison files so we don't generate annoying aux files
latexpand fgimenez_dissertation.tex > tmp_new_expanded.tex
latexpand tmp_old.tex > tmp_old_expanded.tex

# diff the versions
latexdiff tmp_old_expanded.tex tmp_new_expanded.tex > diff.tex

# compile the diff
latexmk -pdf -outdir=diff diff.tex

# move diff file to the diff directory
mv diff.tex diff/

# delete all tmp files
rm tmp*
