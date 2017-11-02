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
OPTION=$(whiptail --title "arch_diagnostic.sh" --menu "Choose your option" 15 60 4 \
"1" "Systemd Diagnostics" \
"2" "Network Diagnostics" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	
	systemdDiagnostics
	
fi

if [ "$OPTION" == '2' ]; then
	
	networkDiagnostics
	
fi
	
}

systemdDiagnostics(){
OPTION=$(whiptail --title "Systemd_Diagnostics" --menu "Choose your option" 15 60 4 \
"1" "Check for failed services" \
"2" "Start a unit" \
"3" "Stop a unit" \
"4" "Restart a unit" \
"5" "Check if a unit is enabled or not" \
"6" "Enable a unit at boot" \
"7" "Show man page of unit" \
"8" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	
	whiptail --msgbox "$(systemctl --failed)" 15 60 4
	systemdDiagnostics
	
fi

if [ "$OPTION" == '2' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to start?" 8 78 Blue --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    systemctl start $UNIT
	whiptail --msgbox "$(systemctl status $UNIT)" 15 60 4
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '3' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to stop?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    systemctl stop $UNIT
	whiptail --msgbox "$(systemctl status $UNIT)" 15 60 4
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '4' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to restart?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    systemctl restart $UNIT
	whiptail --msgbox "$(systemctl status $UNIT)" 15 60 4
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '5' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to check?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	whiptail --msgbox "$(systemctl is-enabled $UNIT)" 15 60 4
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '6' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to enable at boot?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	systemctl enable $UNIT
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '7' ]; then
	
UNIT=$(whiptail --inputbox "What is the unit you want to see man page for?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	whiptail --msgbox "$(systemctl help $UNIT)" 15 60 4
	systemdDiagnostics
	else
		systemdDiagnostics
	fi
    
fi

if [ "$OPTION" == '8' ]; then
	
	init
    
fi
}

networkDiagnostics(){
OPTION=$(whiptail --title "Network Diagnostics" --menu "Choose your option" 15 60 4 \
"1" "Display available network devices" \
"2" "Restart wpa_supplicant" \
"3" "Check status of wpa_supplicant" \
"4" "Connect to WiFi network" \
"5" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	
	whiptail --msgbox "$(ip link show)" 15 60 4
	networkDiagnostics
	    
fi

if [ "$OPTION" == '2' ]; then
	
	systemctl restart wpa_supplicant
	whiptail --msgbox "$(wpa_supplicant restarted)" 15 60 4
	networkDiagnostics
	    
fi

if [ "$OPTION" == '3' ]; then
	
	whiptail --msgbox "$(systemctl status wpa_supplicant)" 15 60 4
	networkDiagnostics
	    
fi

if [ "$OPTION" == '4' ]; then
	
	wifi-menu
	networkDiagnostics
	    
fi

if [ "$OPTION" == '5' ]; then
	
	init
    
fi
	
}

authCheck
