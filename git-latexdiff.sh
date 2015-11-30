#!/bin/bash
#set -x

# m = filename
# dir = full path to dissertation directory
# ver = branch
#
#m=$1
#dir=$2
#ver=$3

m="fgimenez_dissertation.tex"
dir="/Users/fgimenez/Documents/Stanford/projects/dissertation"
ver="master"
dir_old=`mktemp -dt git-latexdiff`

#copy the git repo
echo "Copying current directory to $dir_old"
cp -R "$dir/" "$dir_old"

#go into the old version and checkout desired version
echo "Checking out old branch"
cd "$dir_old"
git checkout -f "$ver" .
latexpand "$m" > "old.tex"
cd -

#diff the two repos
echo "Diffing files"
latexpand "$dir/$m" > "$dir/curr.tex"
latexdiff --config="PICTUREENV=(?:picture|DIFnomarkup|description|table|sidewaystable)[\w\d*@]*" "$dir_old/old.tex"  "$dir/curr.tex" > "$dir/diff.tex"

# compile the diff
echo "Compiling diff"
mkdir -p "$dir/diff"
latexmk -pdf -outdir="$dir/diff" diff.tex

# move diff file to the diff directory
echo "Cleaning up"
mv "$dir/diff.tex" "$dir/diff/"
rm -f "$dir/curr.tex"
rm -rf "$dir_old"
