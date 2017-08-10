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


