#!/bin/bash

read -p "Enter the directory to search under `echo ~`/repo: " input
read -p "Enter the file name to search: " file_name
DIR=`echo ~`/repo/$input

for file in $(find $DIR -type f -name "${file_name}" 2>/dev/null); do
	grep -Hn "k8s_secret_name\s*=" $file | grep -E " k8s_secret_name\s*=\s*\".*_.*\"" 2>/dev/null | 
		while read -r line; do
			echo $line
		done
done

