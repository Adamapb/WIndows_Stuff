echo Type all user account names, with a space in between
read -a users

usersLength=${#users[@]}	

for (( i=0;i<$usersLength;i++))
do
	clear
	echo ${users[${i}]}
	echo Delete ${users[${i}]}? yes or no
	read yn1
	if [ $yn1 == yes ]
	then
		userdel -r ${users[${i}]}
		printTime "${users[${i}]} has been deleted."
	else	
		echo Make ${users[${i}]} administrator? yes or no
		read yn2								
		if [ $yn2 == yes ]
		then
			gpasswd -a ${users[${i}]} sudo
			gpasswd -a ${users[${i}]} adm
			gpasswd -a ${users[${i}]} lpadmin
			gpasswd -a ${users[${i}]} sambashare
			printTime "${users[${i}]} has been made an administrator."
		else
			gpasswd -d ${users[${i}]} sudo
			gpasswd -d ${users[${i}]} adm
			gpasswd -d ${users[${i}]} lpadmin
			gpasswd -d ${users[${i}]} sambashare
			gpasswd -d ${users[${i}]} root
			printTime "${users[${i}]} has been made a standard user."
		fi
		
		echo Make custom password for ${users[${i}]}? yes or no
		read yn3								
		if [ $yn3 == yes ]
		then
			echo Password:
			read pw
			echo -e "$pw\n$pw" | passwd ${users[${i}]}
			printTime "${users[${i}]} has been given the password '$pw'."
		else
			echo -e "Moodle!22\nMoodle!22" | passwd ${users[${i}]}
			printTime "${users[${i}]} has been given the password 'Moodle!22'."
		fi
		passwd -x30 -n3 -w7 ${users[${i}]}
		usermod -L ${users[${i}]}
		printTime "${users[${i}]}'s password has been given a maximum age of 30 days, minimum of 3 days, and warning of 7 days. ${users[${i}]}'s account has been locked."
	fi
done
clear