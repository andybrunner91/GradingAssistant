#!/bin/sh

#Andy Brunner
#April 20
#This program adds a given file (like a required .txt file) to every java project

fileToMove="PirateDictionary-1.txt"
while read p; do
	#get the path of the directory of the source files (everything before the last slash)
	fileLoc="${p%/*}"
	cp "$fileToMove" "$fileLoc" 
done <javasWithMain.txt