#!/bin/bash

#Andy Brunner
#April 2015
#This program takes students javascript project submissions from Canvas and runs each one.

#variables 
baseDir="/cygdrive/c/Users/andyb_000/Desktop/javascripts"
p5Loc="/cygdrive/c/Users/andyb_000/Desktop/p5"

cd "$baseDir"
#writes path of each .html file (hopefully their projects).  
find `pwd` -name "index.html" -exec echo '{}' \; > htmlLocs.txt

#get rid of the the duplicate osx files (mac adds these sometimes when it zips stuff)
sed -i'' "/__MACOSX/d" "htmlLocs.txt"

while read p; do
echo "$p"
	#get the path of the directory of the source files (everything before the last slash)
	fileLoc="${p%/*}"
	echo "$fileLoc"
	
	parentDirectory="${fileLoc##*/}"
	echo "Parent directory is $parentDirectory"
	
	#move the the directory the file is in to the p5 folder
	mv "$fileLoc" "$p5Loc"
	cd "$p5Loc"
	cd "$parentDirectory"
	#open each source file in notepad++ and firefox
	notepad++ "*.js" &
	firefox "index.html" &

	read -p "Enter e to exit.  Enter anything to continue." yn < /dev/tty
	
	#go back up to the p5 folder
	cd ..
	#move directory with the file back to original location
	echo "moving $parentDirectory to ${fileLoc%/*}"
	mv "$parentDirectory" "${fileLoc%/*}"
	cd "$baseDir"

done <htmlLocs.txt
