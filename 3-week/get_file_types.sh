#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <path/to/dir>"	
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "$1 is not a directory"
	exit 2
fi

for FILE in $(realpath "$1"/*); do
	if [ -f "$FILE" ]; then
		echo "$FILE is regular file"
	elif [ -d "$FILE" ]; then
		echo "$FILE is directory"
	elif [ -L "$FILE" ]; then
		echo "$FILE is soft link"
	elif [ -c "$FILE" ]; then
		echo "$FILE is character device"
	elif [ -b "$FILE" ]; then
		echo "$FILE is block device"
	elif [ -p "$FILE" ]; then
		echo "$FILE is pipe"
	elif [ -S "$FILE" ]; then
		echo "$FILE is socket"
	fi
done

