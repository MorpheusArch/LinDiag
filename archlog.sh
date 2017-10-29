#!/bin/bash
#######################################################################
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

########################################################################
##  -- authCheck asks for adminstrator aka root password --  ###########

authCheck(){
if [ $(id -u) != "0" ]; then
		clear
        echo "You must be root to run this script"
        echo "Please enter the following command and press enter: su"
		echo "And then run the script with root priveleges"
        sleep 1
        exit 1
			else
		init
fi
}

########################################################################
##  -- init function contains the menu  --  ############################

init(){
OPTION=$(whiptail --title "System Maintenence" --backtitle ArchLog_System_Maintenence_Tool_V0.1 --menu "Choose your option" 15 60 4 \
"1" "Check for failed systemd services" \
"2" "Check Network Connection	" \
"3" "Display Network Test Results	" \
"4" "Display wpa_supplicant status" \
"5" "Create a list of packages in /var/log/archlog" \
"6" "Back up the pacman database in active directory" \
"7" "Create dmesg.txt in /var/log/archlog" \
3>&1 1>&2 2>&3)

########################################################################
##  -- If selected option is equal to 1 execute the commands --  #######

if [ "$OPTION" == '1' ]; then
		if [ -d /var/log/archlog ]; then
			systemctl --failed >> /var/log/archlog/systemdfail.txt
			systemctl list-unit-files &>> /var/log/archlog/systemdfail.txt
			systemctl list-unit-files	##first systemctl list-unit-files is piped output to the systemdfail.txt this command displays in terminal for quick inspection
		else	
			mkdir /var/log/archlog >> /dev/null 2>&1 ##if the /var/log/archlog directory does not exist this creates it
			systemctl --failed >> /var/log/archlog/systemdfail.txt
			systemctl list-unit-files &>> /var/log/archlog/systemdfail.txt
			systemctl list-unit-files	##first systemctl list-unit-files is piped output to the systemdfail.txt this command displays in terminal for quick inspection
		fi
	init  ##this returns to menu
fi

########################################################################
##  -- If selected option is equal to 2 execute the commands --  #######

if [ "$OPTION" == '2' ]; then
	
	curl -s  https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - >> /var/log/archlog/netspeed.txt &
    local pid=$!
    local delay=0.02
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        clear
        echo ""
        echo "Checking connection"
        echo ""
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
	init ##this returns to menu
fi

if [ "$OPTION" == '3' ]; then
	cat /var/log/archlog/netspeed.txt
	sleep 4
	init ##this returns to menu
fi

########################################################################
##  -- If selected option is equal to 3 execute the commands --  #######

if [ "$OPTION" == '4' ]; then
	systemctl status wpa_supplicant.service
	init ##this returns to menu
fi

########################################################################
##  -- If selected option is equal to 4 execute the commands --  #######

if [ "$OPTION" == '5' ]; then
	pacman -Qqe >> /var/log/archlog/packages.txt
	init ##this returns to menu
fi

########################################################################
##  -- If selected option is equal to 5 execute the commands --  #######

if [ "$OPTION" == '6' ]; then
	tar -cjf pacman_database.tar.bz2 /var/lib/pacman/local
	init ##this returns to menu
fi

########################################################################
##  -- If selected option is equal to 6 execute the commands --  #######

if [ "$OPTION" == '7' ]; then
	dmesg >> /var/log/archlog/dmesg.txt
	init ##this returns to menu		
fi
########################################################################
}

authCheck
