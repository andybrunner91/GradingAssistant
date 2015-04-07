#!/bin/bash

#Andy Brunner
#March 2015
#Extracts java projects from submissions.zip folder that is downloaded from canvas.  
#Put this file in the same directory that the submissions.zip folder is in and run it.
read -p "What would you like the folder that contains the files to be called?" folderName < /dev/tty
unzip -d "$folderName" submissions.zip 
rm submissions.zip
#Get rid of everything after the first underscore in each filename
cd "$folderName"
mmv "*_*.zip" "#1.zip"
for zipfile in *.zip; do 
	#get the name of the file without the .zip extension
	exdir="${zipfile%.zip}"
	unzip the file and remove the .zip archive
    unzip -d "$exdir" "$zipfile" && rm "$zipfile"
done
