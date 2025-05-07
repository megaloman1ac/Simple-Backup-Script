#!/bin/bash

title=""

while IFS= read -r line;
do
	if [[ "$line" == !* ]]; then
		continue
	elif [[ -z "$line" ]]; then
		continue
	fi

	for path in $(find $HOME -type d -name $(echo $line | awk '{print $1}')); do

		destFolder=$(echo $line | awk '{print $3}')	

		if [[ "$title" != $(echo "$line" | awk '{print $1}') ]]; then
			title=$(echo $line | awk '{print $1}')
			echo $title
		fi

		destFolder=$(echo $line | awk '{print $3}')

		if [[ $(echo $line | awk '{print $2}') == *"."* ]]; then
			source=$(find $path -type f -name "$(echo $line | awk '{print $2}')")
			if [[ -d "$destFolder$(echo $line | awk '{print $2}')" ]]; then
				continue
			fi
			
			if [[ ! -d "$destFolder" ]]; then
				mkdir -p "$destFolder"
			fi

			echo $source | xargs -I {} echo -e "\e[32m->\e[0m {}"

			cp -r -i -f $source $destFolder$(echo $line | awk '{print $2}')
		else
<<<<<<< HEAD
			source=$(find $path -type d -name "$(echo $line | awk '{print $2}')" )
			echo $source | xargs -I {} echo -e "\e[32m->\e[0m {}"
			
			#echo "SOURCE: $source"
			#echo "DEST: $destFolder"
			cp -r $source/ $destFolder
=======
			source=$(find $path -type d -name "$(echo $line | awk '{print $2}')")

			if [[ -d "$destFolder$(echo $line | awk '{print $2}')" ]]; then
				continue
			fi

			if [[ ! -d "$destFolder" ]]; then
				mkdir -p "$destFolder"
			fi
			
			echo $source | xargs -I {} echo -e "\e[32m->\e[0m {}"				
			cp -r -i -f $source $destFolder

>>>>>>> alpha/0.0.0
		fi
	done
done < "paths.txt"
