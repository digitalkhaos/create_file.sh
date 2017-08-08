#Create a script that you can point a directory at, and it will go ahead delete files that are more than X days old.
#So the arguments to the script would be...
#./cleanup.sh -d "/tmp/backups" -t 30
#-d is the directory
#-t is the number of days

#!/bin/bash

DIRECTORY

#does directory exist
if [ ! -z `ls ($DIRECTORY)` ]; then
	echo "Directory does not exist.  Bailing"
	exit 1
fi 

while getopts "d:t:" opt; do
	case $opt in
		d)
			echo "-d was called"
			$DIRECTORY=$OPTARG
			;;
		t)
			echo "-t was called"
			;;
	esac
done

for file in $DIRECTORY
	do
		NOW=`date +%s`
		FILE_AGE=`stat $OPTARG`

