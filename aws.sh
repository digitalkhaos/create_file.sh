#!/bin/bash

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
			echo
		  echo "Working on it"	
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
			if #user entered -r
				`aws configure set region $opt`
				echo "using $opt region..."
				echo
			else
				`aws configure set region us-west-2`
				echo "using us-west-2 region..."
				echo
			fi
	esac
while [ 1 ]; do
	show_menu
	read_input
done


