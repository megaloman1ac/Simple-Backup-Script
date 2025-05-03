#!/bin/bash

while IFS= read -r line;
do
	for path in $(find $HOME -type d -name $(echo $line | awk '{print $1}')); do
		if [[ $(echo $line | awk '{print $2}') == *"."* ]]; then
			find $path -type f -name "$(echo $line | grep $line | awk '{print $2}')" | xargs -I {} echo "-> {}"
			echo "This is $line"
		else
			find $path -type d -name "$(echo $line | awk '{print $2}')" | xargs -I {} echo "-> {}"
		fi
	done
done < "txt.txt"
