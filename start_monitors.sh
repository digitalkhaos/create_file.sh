#!/bin/bash

# Check if we're root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

if [ -z "`pgrep -x \"glances\"`" ]; then
	echo "GLANCES"
	echo "Not Running, starting..."
	glances -w  > /dev/null &
else
	echo "GLANCES"
	echo "Already running..."
fi

if [ -z "`pgrep -x \"grafana\"`" ]; then
	echo "GRAFANA"
	echo "Not running, starting..."
	/etc/init.d/grafana-server start > /dev/null
else
	echo "GRAFANA"
	echo "Already running..."
fi
