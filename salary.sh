#write a script that prompts the user for their salary if their salary is less than 5k pay no taxes if salary is betqeen 5k and 30k tax rate is 10% and if their salary is over 30k pay 20% tell them tax rate and how much taxes

#!/bin/bash

echo -n "Enter your salary: "
read SALARY

if [ ($SALARY + 0) -le 0 ]; then 
	echo "You must enter a salary" 
	exit 1;
fi
done

