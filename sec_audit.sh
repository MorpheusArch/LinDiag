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
OPTION=$(whiptail --title "Sec_Audit.sh" --backtitle "Sec_Audit" --menu "Choose your option" 15 60 4 \
"1" "Install Tools" \
"2" "Nmap Tools" \
"3" "Hydra Tools" \
"4" "Launch Lynis" \
3>&1 1>&2 2>&3)

########################################################################

if [ "$OPTION" == '1' ]; then
	
	clear
	pacman -S nmap hydra lynis
	init
	
fi

########################################################################

if [ "$OPTION" == '2' ]; then
	
	nmapTools
	
fi

########################################################################

if [ "$OPTION" == '3' ]; then
	
	hydraTools
	
fi

########################################################################

if [ "$OPTION" == '4' ]; then
	
	lynis audit system | tee lynis.log
	
fi

}
nmapTools(){
	NOPTION=$(whiptail --title "Nmap Tools" --backtitle "Sec_Audit_Nmap_Tools" --menu "Choose your option" 15 60 4 \
	"1" "Full TCP port scan" \
	"2" "Verbose Stealth Scan" \
	"3" "Stealth Syn With OS Detect" \
	"4" "Stealth Syn Full TCP Port" \
	"5" "Scan From File" \
	"6" "Return" \
	3>&1 1>&2 2>&3)

########################################################################

if [ "$NOPTION" == '1' ]; then
	
	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -p 1-65535 -sV -sS -T4 $TARGET | tee full_TCPscan.log
		nmapTools
	else
		nmapTools
	fi
	
fi

########################################################################

if [ "$NOPTION" == '2' ]; then
	
	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -sS -A -T4 $TARGET | tee verbose_Stealth.log
		nmapTools
	else
		nmapTools
	fi
	
fi

########################################################################

if [ "$NOPTION" == '3' ]; then
	
	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -sV -O -sS -T5 $TARGET | tee stealthOS.log
		nmapTools
	else
		nmapTools
	fi
	
fi

########################################################################

if [ "$NOPTION" == '4' ]; then
	
	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -p 1-65535 -sV -O -sS -T5 $TARGET | tee stealthFullTCP.log
		nmapTools
	else
		nmapTools
	fi
	
fi

########################################################################

if [ "$NOPTION" == '5' ]; then
	
	TARGET=$(whiptail --inputbox "Enter file with full path" 8 78 --title "Enter file with IP's you wish to scan" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -iL $TARGET | tee scan_FromFile.log
		nmapTools
	else
		nmapTools
	fi
	
fi

########################################################################

if [ "$NOPTION" == '6' ]; then

	init

fi

}

########################################################################

hydraTools(){
HOPTION=$(whiptail --title "Hydra Tools" --backtitle "Hydra_Tools" --menu "Choose your option" 15 60 4 \
"1" "Retrieve Username List" \
"2" "Retrieve Password List" \
"3" "Custom Hydra Command" \
"4" "Attack FTP Service" \
"5" "Attack SSH Service" \
"6" "Return" \
3>&1 1>&2 2>&3)

########################################################################

if [ "$HOPTION" == '1' ]; then
	
	TARGET=$(whiptail --inputbox "URL of Username List" 8 78 --title "URL of Username List" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		wget $TARGET -O users.txt
		hydraTools
	else
		hydraTools
	fi
	
fi

########################################################################

if [ "$HOPTION" == '2' ]; then
	
	TARGET=$(whiptail --inputbox "URL of Password List" 8 78 --title "URL of Password List" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		wget $TARGET -O pass.txt
		hydraTools
	else
		hydraTools
	fi
	
fi

########################################################################

if [ "$HOPTION" == '3' ]; then
	
	COMMAND=$(whiptail --inputbox "Enter Custom Hydra Command" 8 78 --title "Enter Custom Hydra Command" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		$COMMAND
		hydraTools
	else
		hydraTools
	fi
	
fi

########################################################################

if [ "$HOPTION" == '4' ]; then
	
	TARGET=$(whiptail --inputbox "Enter Host" 8 78 --title "Enter Host" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		hydra -L users.txt -P pass.txt ftp://$TARGET | tee hydra_FTP.log
		hydraTools
	else
		hydraTools
	fi
	
fi

########################################################################

if [ "$HOPTION" == '5' ]; then
	
	TARGET=$(whiptail --inputbox "Enter Host" 8 78 --title "Enter Host" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		hydra -L users.txt -P pass.txt ssh://$TARGET | tee hydra_SSH.log
		hydraTools
	else
		hydraTools
	fi
	
fi

########################################################################

if [ "$HOPTION" == '6' ]; then
		init	
fi
}

########################################################################

authCheck
