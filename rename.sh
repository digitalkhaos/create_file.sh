#!/bin/bash

#Look for all delta files in a directory with either that tar.gz or tgz file extension.
#Use the generated files from the last script.
#Rename files based on the following rules:
# 1) The structure of the file name should look like delta-<iteration>x<file number>.<original extension>
#    ie:
#       delta01.tgz -> delta-0x01.tgz
#       delta02.tgz -> delta-0x02.tgz
#       delta03.tgz -> delta-0x03.tar.gz
#       ...
#       delta11.tgz -> delta-1x01.tgz
#       delta12.tar.gz -> delta-1x02.tar.gz
#       delta13.tar.gz -> delta-1x03.tar.gz
#
# 2) Each iterration should rename 10 files
# 3) The original extension name should be preserved
# 4) The file number should be 1 through 10 and should be padded in the file name

DIRECTORY=/home/john/code/scripts/script_practice/tmp

ITERATION=0

for name in `ls -1 $DIRECTORY/delta[0-9][0-9].{tgz,tar.gz}`; do
  COUNT=$((COUNT + 1))
  PADDED=`printf "%02d" $COUNT`

	if [[ $name == *.tgz ]]; then
    EXTENSION="tgz"
  else
    EXTENSION="tar.gz"
  fi

  mv $name $DIRECTORY/delta-${ITERATION}x${PADDED}.${EXTENSION}

  if [ $COUNT -ge 10 ]; then
    ITERATION=$((ITERATION + 1))
    COUNT=0
  fi
	
done
