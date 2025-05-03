#!/bin/bash

title=""

while IFS= read -r line;
do
	for path in $(find $HOME -type d -name $(echo $line | awk '{print $1}')); do
		
		destFolder=$(echo $line | awk '{print $3}')

		if [[ "$title" != $(echo "$line" | awk '{print $1}') ]]; then
			title=$(echo $line | awk '{print $1}')
			echo $title
		fi

		if [[ $(echo $line | awk '{print $2}') == *"."* ]]; then
			find $path -type f -name "$(echo $line | grep $line | awk '{print $2}')" | xargs -I {} echo "-> {}"
		else
			source=$(find $path -type d -name "$(echo $line | awk '{print $2}')" )
			echo $source | xargs -I {} echo -e "\e[32m->\e[0m {}"
			#echo "$destFolder"
			#mkdir -p $destFolder
			
			if [[ ! -f $destFolder$(echo $line | awk '{print $2}') ]]; then
				mkdir -p $destFolder$(echo $line | awk '{print $2}')
			fi

			cp -r $source $destFolder
			echo $destFolder
			#echo "$source" "$destFolder/"
			 
		fi
	done
done < "txt.txt"
