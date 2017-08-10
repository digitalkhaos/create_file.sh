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












#!/bin/bash

#Check if we're root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

#Check if script is already running
for pid in $(pidof -x divisible-by-3.sh); do
    if [ $pid != $$ ]; then
        echo "[$(date)] : divisible-by-3.sh : Process is already running with PID $pid"
        exit 1
    fi
done


