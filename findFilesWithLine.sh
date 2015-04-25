#!/bin/sh

while read p; do
	#Get rid of lines that start with package.
	if grep -Eq '(" ; ")' "$p"
		then
		echo "Found main at $p !"
		notepad++ "$p"
		echo "$p" >> suspicious.txt
	fi
done <javaLocs.txt