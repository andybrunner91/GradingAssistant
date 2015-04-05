#!/bin/bash

#Get rid of everything after the first underscore in each filename
mmv "*_*.zip" "#1.zip"
for zipfile in *.zip; do 
	#get the name of the file without the .zip extension
	exdir="${zipfile%.zip}"
	#unzip the file and remove the .zip archive
    unzip -d "$exdir" "$zipfile" && rm "$zipfile"
done