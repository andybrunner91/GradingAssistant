#!/bin/bash
#gets rid of all the .class files students might have submitted
#find . -name 'bin' -exec rm -r '{}' \;

#compiles every .java file
#find . -name '*.java' -exec javac '{}' \;

#finds each compiled .class file and puts the file location into classLocs.txt
find . -name '*.class' -exec echo '{}' \; > classLocs.txt

#gets rid of all the .class suffixes in classLocs.txt so we can run the java command directly on them
sed -e s/.class//g -i classLocs.txt

dos2unix classLocs.txt
while read p; do
	echo "$p"
	#get the path of the directory of the source files
	fileLoc="${p%/*}"
	echo "$fileLoc"
	cd "$fileLoc"
	#get the class name
	theClass="${p##*/}"
	java "$theClass" < /cygdrive/c/Users/andyb_000/Desktop/Lab1/lab1Input.txt
	notepad++ "*.java"
	read -p "Keep going?" yn < /dev/tty
	cd /cygdrive/c/Users/andyb_000/Desktop/Lab1/
done <classLocs.txt

