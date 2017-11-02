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

init(){
OPTION=$(whiptail --title "data_rec" --backtitle "data_rec" --menu "Choose your option" 15 60 4 \
"1" "Display all mounted drives" \
"2" "Attempt ddrescue of drive" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	
	clear
	whiptail --msgbox "$(lsblk -o name,label,size,fstype,model)" 20 40
	init

fi

if [ "$OPTION" == '2' ]; then

	if (whiptail --title "WARNING!" --yesno "Is the drive currently failing?"  8 78) then
		yFail
	else
		nFail
	fi

fi
}

yFail(){
DRIVE=$(whiptail --inputbox "What is the drive you're attempting to recover data on?" 8 78 Blue --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    ddrescue -d $DRIVE test.img test.logfile
    if (whiptail --title "ATTENTION!" --yesno "Would you like to restore newly created image to a new disk?"  8 78) then
		yRestore
	else
		init
	fi
    
else
    init
fi

}

nFail(){
DRIVE=$(whiptail --inputbox "What is the drive you're attempting to recover data on?" 8 78 Blue --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    ddrescue -d -r3 $DRIVE test.img test.logfile
    if (whiptail --title "ATTENTION!" --yesno "Would you like to restore newly created image to a new disk?"  8 78) then
		yRestore
	else
		init
	fi
    
else
    init
fi
}

yRestore(){
DRIVE_R=$(whiptail --inputbox "What is the drive you want the new .img to go to?" 8 78 Blue --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    dd if=test.img of=$DRIVE_R
else
    init
fi
}

authCheck
