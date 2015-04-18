#!/bin/bash

#Andy Brunner
#Extracts js projects from submissions.zip folder that is downloaded from canvas.  
pathToSubmissions="/cygdrive/c/Users/andyb_000/Desktop"
unzipDestination="javascripts"

cd "$pathToSubmissions"
unzip -d "$unzipDestination" submissions.zip 
rm submissions.zip
#Get rid of everything after the first underscore in each filename
cd "$unzipDestination"
mmv "*_*.zip" "#1.zip"
for zipfile in *.zip; do 
	#get the name of the file without the .zip extension
	exdir="${zipfile%.zip}"
	#unzip the file and remove the .zip archive
    unzip -d "$exdir" "$zipfile" && rm "$zipfile"
done
