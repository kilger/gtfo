#!/bin/bash

# Read binary names from a file and store them in an array
binaries=($(cat ./binaries.txt))

# Download the gtfobins.github.io website, extract binary names and store them in an array
gtfobins=($(curl -k -s https://gtfobins.github.io | grep "<li>" | awk '{print $2}' | sed 's@href="/gtfobins/@@g' | sed s'@</a></li>@@g' | sed s'/>/ /g' | sed 's/"//g' | sed 's@/#@:@g' | awk '{print $1}'))

# Loop over binary names and compare with binary names from the website
for binary in "${binaries[@]}"
do
	for gtfobin in "${gtfobins[@]}"
	do
		# If binary name from the file matches with a binary name from the website, print the matching name
		if [[ "$gtfobin" == "$binary:"* ]]; then
			echo "$gtfobin"
		fi
	done
done
