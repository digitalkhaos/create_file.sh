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
	read -p ">>" _INPUT

	case $_INPUT in
		1)
			RESULT=`aws ec2 describe-instances --filter Name=instance-state-name,Values=running --query 'Reservations[].Instances[].[PrivateIpAddress,InstanceId,Tags[?Key==\`Name\`] | [0].Value]' --output text`
			echo
			echo "$RESULT"
			echo
			;;
		2)
			echo -n "Enter a Image ID:"
			read IMAGE_ID
			echo -n "Enter a key name:"
			read KEY_NAME
			echo -n "Enter an instance type:"
			read INSTANCE_TYPE
			echo -n "Enter Security Group:"
			read SECURITY_GROUP
			aws ec2 run-instances --image-id ami-$IMAGE_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-groups $SECURITY_GROUP
			echo
			echo "Creating instance..."
			echo
			;;
		3)
			echo -n "Enter an instance ID: "
			read INSTANCE_ID
			aws ec2 terminate-instances --instance-ids $INSTANCE_ID
			echo
			echo "Deleting instance..."
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
