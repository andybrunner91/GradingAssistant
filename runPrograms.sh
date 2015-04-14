#!/bin/bash

#Andy Brunner
#March 2015
#This program takes students java project submissions from Canvas and runs each one.

#variables 
labNum="3"

baseDir="/cygdrive/c/Users/andyb_000/Desktop/Lab${labNum}/"
#inputFile="${baseDir}/Lab${labNum}input.txt"

#writes path of each .java file to javaLocs.txt
find . -name "*.java" -exec echo '{}' \; > javaLocs.txt

rm javasWithMain.txt
#this loop is supposed to remove the files without a main function from javaLocs.txt, but it doesn't work yet
while read p; do
	#Get rid of lines that start with package.
	sed -i'' "/^[ ]*package/d" "$p"
	if grep -Eq "public[ ]+static[ ]+void[ ]+main" "$p"
		then
		echo "Found main at $p !"
		echo "$p" >> javasWithMain.txt
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
		#If the input file is unset (or is the empty string), then just run the file.
		#Otherwise, run the program with the input file
		if [ -z "$inputFile" ]; then 
		java "${fileName%.java}"
	else
		java "${fileName%.java}" < "$inputFile"
	fi	
		printf "\n"
		read -p "Type n to recompile and rerun the current program.  Type anything else to go to the next one." yn < /dev/tty
	done
	cd "$baseDir"

done <javasWithMain.txt
