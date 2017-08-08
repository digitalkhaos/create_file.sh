#create file and write data to it

#!/bin/bash

if [ -e $1 ]; then
	echo "File already exists"
	exit 1
else
	echo "Creating File: $1"
	`touch $1`
fi

echo $2 > $1
