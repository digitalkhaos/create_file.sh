#!/bin/bash

showsyntax() {
	echo "Syntax: $0 -d <directory> -t <age of file>"
}

while getopts "d:t:" opt; do
	case $opt in
		d)
			DIRECTORY=$OPTARG	
			;;
		t)
			FILE_AGE=$OPTARG
			;;
	esac
done

if [ ! -d $DIRECTORY ]; then
	echo "Directory does not exist. "
	showsyntax
	exit 1
fi

if ([ -z "$DIRECTORY" ] || [ -z $FILE_AGE ]); then
	echo "Missing arguments."
	showsyntax
	exit 1
fi

echo "Cleaning up files older than $FILE_AGE days..."
find $DIRECTORY -mtime +$FILE_AGE -exec rm "{}" \;
echo "Done!"

