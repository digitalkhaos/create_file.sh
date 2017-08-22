#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Using us-west-2 region..."
	`aws configure set region us-west-2`
fi

#elif [ $# -lt 2 ]; then
#	echo "Usage: $0 -r [arg]"
#	exit 1
#fi

function show_menu {
	echo "Choose from the following: "
	echo "1 - List all running instances"
	echo "2 - Create a new instance"
	echo "3 - Delete an instance"
	echo "x - Exit this menu"
}

function read_input {
	local _INPUT
	KEY=Name

	read -p ">>" _INPUT

	case $_INPUT in
		1)
			INSTANCE_ID=`aws ec2 describe-instances | jq .Reservations[0].Instances[0].InstanceId`
			IP_ADDRESS=`aws ec2 describe-instances | jq .Reservations[0].Instances[0].PrivateIpAddress`
			INSTANCE_NAME=`aws ec2 describe-tags --filters "Name=key,Values=$KEY" --output=text | cut -f5`
			echo
			echo "INSTANCE ID              PRIVATE IP         NAME"
			echo "---------------------------------------------------"
		  echo "$INSTANCE_ID | $IP_ADDRESS | $INSTANCE_NAME"	
			echo
			;;
		2)
			echo
			echo "Not yet implemented"
			echo
			;;
		3)
			echo
			echo "Not yet implemented"
			echo
			;;
		x)
			echo
			echo "Exiting..."
			echo
			exit 0
			;;
		*)
			echo
			echo "Invalid entry, Try again."
			echo
			;;
	esac
}

while getopts "r:" opt; do
	case $opt in
		r)
			if [ $2 ]; then #user entered -r
				`aws configure set region $2`
				echo "using $2 region..."
				echo
			else  #user didn't use the -r switch, using default
				`aws configure set region us-west-2`
				echo "using us-west-2 region..."
				echo
			fi
	esac
done

while [ 1 ]; do
	show_menu
	read_input
done
