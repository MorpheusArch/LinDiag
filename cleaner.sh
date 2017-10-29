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

init(){

	if (whiptail --title "Cleaner.sh" --yesno "This will safely delete all logs on the host. Continue?" 8 78) then
		delConfirm
	else
		exit 1
	fi
}

########################################################################

delConfirm(){

	cd /var/log
	shred -zvu -n  5 *
	echo ""
	echo "All logs have now been deleted"
	echo ""
}

########################################################################

authCheck
