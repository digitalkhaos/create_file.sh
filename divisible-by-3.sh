#!/bin/bash

# divisible-by-3

#1) If the script is running, nobody else can run the script.
#2) The script can only be run as the root user.
#3) The script will generate 50 files using the touch command.
#With the following restrictions...
#If the file number is divisible by 3 or if the file number ends with a 3, it should have the tar.gz extension.
#Otherwise it has the tgz extension.
#The filename should look like...
#delta01.tgz
#delta02.tgz
#delta03.tar.gz

#Check if we're root
if [ $EUID -ne 0 ]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

#Check if script is already running
for pid in $(pidof -x divisible-by-3.sh); do
    if [ $pid != $$ ]; then
        echo "script is already running."
        exit 1
    fi
done


#Create 50 files
for i in {1..50}; do
  x=`printf %02d $i`
	if [ $(($i % 3)) == 0 ] || [[ $i == *3 ]]; then
		touch "/home/john/code/scripts/script_practice/tmp/delta$x.tar.gz"
	else
		touch "/home/john/code/scripts/script_practice/tmp/delta$x.tgz"
	fi
done

echo "All files created successfully!"
