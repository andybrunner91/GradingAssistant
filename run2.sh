#!/bin/bash

#variables 
labNum="2"
inputFile="/cygdrive/c/Users/andyb_000/Desktop/lab${labNum}/lab${labNum}input.txt"
baseDir="/cygdrive/c/Users/andyb_000/Desktop/lab2/"

#writes path of each .java file to javaLocs.txt
find . -name '*.java' -exec echo '{}' \; > javaLocs.txt

#this loop is supposed to remove the files without a main function from javaLocs.txt, but it doesn't work yet
while read p; do
	if grep -Eq "public[ ]+static[ ]+void[ ]+main" "$p"
		then
		echo "Found main at $p !"
		echo "$p" > javasWithMain.txt
	fi
done <javaLocs.txt

while read p; do
echo "$p"
	#get the path of the directory of the source files (everything before the last slash)
	fileLoc="${p%/*}"
	echo "$fileLoc"
	cd "$fileLoc"
	#get the file name (everything after the last slash)
	fileName="${p##*/}"
	
	#open each source file in notepad++
	notepad++ "*.java"
	
	#Recompile and rerun the file if the user says n, otherwise, go to the next program
	yn="n"
	while [ "$yn" == "n" ]; do
		#javac "$fileName"
		javac "*.java"
		java "${fileName%.java}" < "$inputFile"
		printf "\n"
		read -p "Type n to recompile and rerun the current program.  Type anything else to go to the next one." yn < /dev/tty
	done
	cd "$baseDir"

done <javasWithMain.txt