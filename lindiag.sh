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

#Author
#Mark Chisholm
#http://morpheusarchlinux.com

########################################################################
#-- authCheck asks for adminstrator aka root priveleges

authCheck(){

	if [ $(id -u) != "0" ]; then
		clear
        echo "You must be root to run this script"
        echo "Please enter the following command and press enter: sudo !!"
		exit 1
			else
		mklindiag
	fi

}

########################################################################
#-- mklindiag creates the directory for logs to be stored.

mklindiag(){
if [ -d /var/log/lindiag ]; then
	init
else #if the /var/log/lindiag directory does not exist this creates it
	mkdir /var/log/lindiag >> /dev/null 2>&1
	init
fi

}

########################################################################
#-- init is the main menu

init(){
OPTION=$(whiptail --title "lindiag.sh" --backtitle "2018.4" --menu "Choose your option" 15 60 4 \
"1" "Systemd Diagnostics" \
"2" "Network Diagnostics" \
"3" "Server Configuration" \
"4" "Network Mapper" \
"5" "Package Manager" \
"6" "Data Recovery" \
"7" "Extra Options" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	systemdDiagnostics

fi

if [ "$OPTION" == '2' ]; then

	networkDiagnostics

fi

if [ "$OPTION" == '3' ]; then

	serverConfig

fi


if [ "$OPTION" == '4' ]; then

	chkNmap

fi

if [ "$OPTION" == '5' ]; then

	chkDistro

fi

if [ "$OPTION" == '6' ]; then

	chkDdrescue

fi

if [ "$OPTION" == '7' ]; then

	extraOpts

fi
}

########################################################################

systemdDiagnostics(){
OPTION=$(whiptail --title "Systemd_Diagnostics" --menu "Choose your option" 15 60 4 \
"1" "Check for failed services" \
"2" "Start a unit" \
"3" "Stop a unit" \
"4" "Restart a unit" \
"5" "Check if a unit is enabled or not" \
"6" "Enable a unit at boot" \
"7" "Show man page of unit" \
"8" "Show Systemd status" \
"9" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	whiptail --msgbox "$(systemctl --failed)" 15 60 4
	systemdDiagnostics

fi

if [ "$OPTION" == '2' ]; then

UNIT=$(whiptail --inputbox "What is the unit you want to start?" 8 78 --title "Please enter name of unit" 3>&1 1>&2 2>&3)

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
	whiptail --msgbox "$(systemctl stop $UNIT)" 15 60 4
	else
		systemdDiagnostics
	fi

fi

if [ "$OPTION" == '4' ]; then

UNIT=$(whiptail --inputbox "What is the unit you want to restart?" 8 78  --title "Please enter name of unit" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    systemctl restart $UNIT
	whiptail --msgbox "$(systemctl restart $UNIT)" 15 60 4
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
	whiptail --msgbox "$(systemctl help $UNIT)" 30 120 8
	systemdDiagnostics
	else
		systemdDiagnostics
	fi

fi

if [ "$OPTION" == '8' ]; then

	whiptail --msgbox "Press Q to Quit and return to LinDiag" 15 60 4
	systemctl status
	systemdDiagnostics

fi

if [ "$OPTION" == '9' ]; then

	init

fi
}

########################################################################

networkDiagnostics(){
OPTION=$(whiptail --title "Network Diagnostics" --menu "Choose your option" 15 60 4 \
"1" "Display available network devices" \
"2" "Restart wpa_supplicant" \
"3" "Check status of wpa_supplicant" \
"4" "Connect to WiFi network" \
"5" "Run Network Speed Test" \
"6" "Firewall Configuration" \
"7" "Return" \
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

	curl -s  https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - >> /var/log/lindiag/netspeed.log &
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

	chkOutput

fi

if [ "$OPTION" == '6' ]; then

	FirewallConfig

fi

if [ "$OPTION" == '7' ]; then

	init

fi

}

########################################################################
serverConfig(){
OPTION=$(whiptail --title "Server Configuration" --menu "Choose your option" 15 60 4 \
"1" "Install LAMP" \
"2" "Install Wordpress" \
"3" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	    if [ -f /var/log/pacman.log ]; then
				pacman -Syu
				pacman -S apache php mariadb
				mysql_secure_installation
				serverConfig
	    fi

	    if [ -f /var/log/dpkg.log ]; then
				apt-get update
				apt-get upgrade
	    	apt-get install apache2 apache2-doc mysql-server mysql-client php php-mysql
				mysql_secure_installation
				serverConfig
	    fi

	    if [ -d /var/log/dnf ]; then
	    dnf update
			dnf install httpd mariadb-server
			mysql_secure_installation
			dnf install php php-common
			dnf install php-mysql php-pdo php-gd php-mbstring
			serverConfig
	    fi


  fi
	if [ "$OPTION" == '2' ]; then
		    if [ -f /var/log/pacman.log ]; then
					pacman -Syu
					pacman -S wordpress
					mysql_secure_installation
					serverConfig
		    fi

		    if [ -f /var/log/dpkg.log ]; then
					apt-get update
					apt-get upgrade
		    	apt-get install wordpress curl apache2 mariadb-server
					mysql_secure_installation
					serverConfig
		    fi

		    if [ -d /var/log/dnf ]; then
		    dnf update
				dnf install wordpress php-mysqlnd mariadb-server
				serverConfig
		    fi
  fi

if [ "$OPTION" == '3' ]; then
	init
fi
}

########################################################################

FirewallConfig(){
OPTION=$(whiptail --title "Firewall Configuration" --menu "Choose your option" 15 60 4 \
"1" "List IPv4 Rules" \
"2" "List IPv6 Rules" \
"3" "List All Rules" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	clear
  whiptail --msgbox "$(iptables -S)" 15 60 4
	FirewallConfig

fi

if [ "$OPTION" == '2' ]; then

	clear
	whiptail --msgbox "$(ip6tables -S)" 15 60 4
	FirewallConfig

fi

if [ "$OPTION" == '3' ]; then

	clear
	whiptail --msgbox "$(iptables -L -v -n | more)" 15 60 4
	FirewallConfig

fi

}
ArchPackage(){
OPTION=$(whiptail --title "Package Management" --menu "Choose your option" 15 60 4 \
"1" "Update System" \
"2" "Clear Pacman Cache" \
"3" "Rank Mirrors" \
"4" "Install A Package" \
"5" "LinDiag Mirrorlist Retriever" \
"6" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	clear
	pacman -Syu
	ArchPackage

fi

if [ "$OPTION" == '2' ]; then

if (whiptail --title "WARNING!" --yesno "Only do this when certain that previous package versions are not required, for example for a later downgrade. Would you like to continue?" 8 78) then
    clear
    pacman -Sc
    ArchPackage
else
    ArchPackage
fi

fi

if [ "$OPTION" == '3' ]; then

	if [ rankmirrors ]; then
		clear
		echo ""
		echo "Generating backup of /etc/pacman.d/mirrorlist"
		echo ""
		sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
		sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
		sudo rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
		echo ""
		echo "Refreshing Mirrors"
		echo ""
		sudo pacman -Syyu
		ArchPackage
	else
		clear
		pacman -S pacman-contrib
		echo ""
		echo "Generating backup of /etc/pacman.d/mirrorlist"
		echo ""
		sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
		sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
		sudo rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
		echo ""
		echo "Refreshing Mirrors"
		echo ""
	fi
fi

if [ "$OPTION" == '4' ]; then
PACKAGE=$(whiptail --inputbox "Enter name of package" 8 78 --title "Package Installer" 3>&1 1>&2 2>&3)
exitstatus=$?
	if [ $exitstatus = 0 ]; then
		clear
		pacman -S $PACKAGE
		ArchPackage
	else
		ArchPackage
	fi

fi

if [ "$OPTION" == '5' ]; then

	clear
	wget -O mirrorlist_all_https https://www.archlinux.org/mirrorlist/all/https/
	wget -O mirrorlist_all_http http://www.archlinux.org/mirrorlist/all/http/
	wget -O mirrorlist_all_https_IPv4_IPv6_MirrorStatus_On https://www.archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on
	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.LinDiagbackup
	clear
	sleep 1 #small sanity check
	ArchPackage

fi

if [ "$OPTION" == '6' ]; then

	init

fi

}

########################################################################

FedoraPackage(){
OPTION=$(whiptail --title "Package Management" --menu "Choose your option" 15 60 4 \
"1" "Update System" \
"2" "Auto Remove Packages" \
"3" "Clean All dnf Temp Files" \
"4" "Install a package" \
"5" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	clear
	dnf upgrade
	FedoraPackage

fi

if [ "$OPTION" == '2' ]; then

	clear
	dnf autoremove
	FedoraPackage

fi

if [ "$OPTION" == '3' ]; then

	clear
	dnf clean all
	FedoraPackage

fi

if [ "$OPTION" == '4' ]; then
PACKAGE=$(whiptail --inputbox "Enter name of package" 8 78 --title "Package Installer" 3>&1 1>&2 2>&3)
exitstatus=$?
	if [ $exitstatus = 0 ]; then
		clear
		dnf install $PACKAGE
		FedoraPackage
	else
		FedoraPackage
	fi

fi

if [ "$OPTION" == '5' ]; then

	init

fi
}

########################################################################

DebianPackage(){
OPTION=$(whiptail --title "Package Management" --menu "Choose your option" 15 60 4 \
"1" "Update System" \
"2" "Auto Remove Packages" \
"3" "Install A Package" \
"4" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	clear
	apt-get update && apt-get upgrade
	DebianPackage

fi

if [ "$OPTION" == '2' ]; then

	clear
	apt-get autoremove
	DebianPackage

fi

if [ "$OPTION" == '3' ]; then
PACKAGE=$(whiptail --inputbox "Enter name of package" 8 78 --title "Package Installer" 3>&1 1>&2 2>&3)
exitstatus=$?
	if [ $exitstatus = 0 ]; then
		clear
		apt-get install $PACKAGE
		DebianPackage
	else
		DebianPackage
	fi

fi

if [ "$OPTION" == '4' ]; then

	init

fi


}

########################################################################

DataRec(){
OPTION=$(whiptail --title "Data Recovery" --menu "Choose your option" 15 60 4 \
"1" "Display all mounted drives" \
"2" "Attempt ddrescue of drive" \
"3" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	clear
	whiptail --msgbox "$(lsblk -o name,label,size,fstype,model)" 20 40
	DataRec

fi

if [ "$OPTION" == '2' ]; then

	if (whiptail --title "WARNING!" --yesno "Is the drive currently failing?"  8 78) then
		yFail
	else
		nFail
	fi

fi

if [ "$OPTION" == '3' ]; then

	init

fi
}

yFail(){
DRIVE=$(whiptail --inputbox "What is the drive you're attempting to recover data on?" 8 78 --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    ddrescue -d $DRIVE test.img test.logfile
    if (whiptail --title "ATTENTION!" --yesno "Would you like to restore newly created image to a new disk?"  8 78) then
		yRestore
	else
		DataRec
	fi

else
    DataRec
fi

}

nFail(){
DRIVE=$(whiptail --inputbox "What is the drive you're attempting to recover data on?" 8 78 --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    ddrescue -d -r3 $DRIVE test.img test.logfile
    if (whiptail --title "ATTENTION!" --yesno "Would you like to restore newly created image to a new disk?"  8 78) then
		yRestore
	else
		DataRec
	fi

else
    DataRec
fi
}

yRestore(){
DRIVE_R=$(whiptail --inputbox "What is the drive you want the new .img to go to?" 8 78 --title "Input Format /dev/sdX" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    dd if=test.img of=$DRIVE_R
else
    DataRec
fi
}

########################################################################

nmapTools(){
	OPTION=$(whiptail --title "Nmap Tools" --menu "Choose your option" 15 60 4 \
	"1" "Full TCP port scan" \
	"2" "Verbose Stealth Scan" \
	"3" "Stealth Syn With OS Detect" \
	"4" "Stealth Syn Full TCP Port" \
	"5" "Scan From File" \
	"6" "Return" \
	3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then

	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -p 1-65535 -sV -sS -T4 $TARGET | tee full_TCPscan.log
		nmapTools
	else
		nmapTools
	fi

fi

if [ "$OPTION" == '2' ]; then

	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -sS -A -T4 $TARGET | tee verbose_Stealth.log
		nmapTools
	else
		nmapTools
	fi

fi

if [ "$OPTION" == '3' ]; then

	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -sV -O -sS -T5 $TARGET | tee stealthOS.log
		nmapTools
	else
		nmapTools
	fi

fi

if [ "$OPTION" == '4' ]; then

	TARGET=$(whiptail --inputbox "Enter IP address or hostname" 8 78 --title "Enter target" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -v -p 1-65535 -sV -O -sS -T5 $TARGET | tee stealthFullTCP.log
		nmapTools
	else
		nmapTools
	fi

fi

if [ "$OPTION" == '5' ]; then

	TARGET=$(whiptail --inputbox "Enter file with full path" 8 78 --title "Enter file with IP's you wish to scan" 3>&1 1>&2 2>&3)
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		nmap -iL $TARGET | tee scan_FromFile.log
		nmapTools
	else
		nmapTools
	fi

fi

if [ "$OPTION" == '6' ]; then

	networkDiagnostics

fi

}

extraOpts(){
OPTION=$(whiptail --title "Extra Options" --menu "Choose your option" 15 60 4 \
"1" "32 bit or x86_64" \
"2" "Use Google" \
"3" "Check for LinDiag updates" \
"4" "Generate backup of /var/log" \
"5" "Return" \
3>&1 1>&2 2>&3)

if [ "$OPTION" == '1' ]; then
	whiptail --msgbox "$(uname -m)" 15 60 4
	extraOpts
fi

if [ "$OPTION" == '2' ]; then
	INPUT=$(whiptail --inputbox "Enter search query" 8 78 --title "Use Google" 3>&1 1>&2 2>&3)
	lynx https://www.google.co.uk/search?q=$INPUT
	extraOpts
fi

if [ "$OPTION" == '3' ]; then
	clear
	git clone https://github.com/MorpheusArch/morpheusarchtools.git
    cd morpheusarchtools
    mv lindiag.sh /usr/local/bin/
    chmod +x /usr/local/bin/lindiag.sh
    cd ..
    rm -rf morpheusarchtools
    #./usr/local/bin/lindiag.sh#
    extraOpts
fi

if [ "$OPTION" == '4' ]; then
	cd /var/log
	zip -r "archive-$(date +"%Y-%m-%d%H-%M-%S").zip" * >> /dev/null
	mkdir /var/log/LinDiag_Backups
	mv *.zip /var/log/LinDiag_Backups
	extraOpts
fi

if [ "$OPTION" == '5' ]; then

	init
fi
}
########################################################################
#Auxillary functions. The functions here are required by others in order
#to work.
########################################################################
#chkOutput is required for network diagnostic speedtest

chkOutput(){
	whiptail --msgbox "$(cat /var/log/lindiag/netspeed.log)" 30 120 8
	whiptail --msgbox "Detailed logs can be found in: /var/log/lindiag/" 15 60 4
	networkDiagnostics
}

########################################################################
#Required for package management functions chkdistro determines which
#package manager is installed and directs user to appropriate function

chkDistro(){
    if [ -f /var/log/pacman.log ]; then
	ArchPackage
    fi

    if [ -f /var/log/dpkg.log ]; then
    DebianPackage
    fi

    if [ -d /var/log/dnf ]; then
    FedoraPackage
    fi

}

########################################################################
#Required for DataRec function it determines if ddrescue is already
#installed and allows the user to install it.

chkDdrescue(){
if [ ddrescue ]; then
	DataRec
else
	InstallDdrescue
fi
}

########################################################################
#Function for installing ddrescue dependant on package manager.

InstallDdrescue(){
	if [ -f /var/log/pacman.log ]; then
	pacman -S ddrescue
	DataRec
	else
		if [ if -d /var/log/dnf ]; then
		dnf install ddrescue
		DataRec
		fi
			if [ if -d /var/log/dpkg.log ]; then
			apt-get install ddrescue
			DataRec
			else
				whiptail --msgbox "ERROR! UNSUPPORTED PACKAGE MANAGER!" 30 120 8
				init
            fi

	fi
}

########################################################################
#chkNmap is required for network diagnosis. [Network Mapper]

chkNmap(){
if [ nmap ]; then
	nmapTools
else
	InstallNmap
fi
}

########################################################################
#Installs nmap

InstallNmap(){
	if [ -f /var/log/pacman.log ]; then
	pacman -S nmap
	nmapTools
	else
		if [ if -d /var/log/dnf ]; then
		dnf install nmap
		nmapTools
		fi
			if [ if -d /var/log/dpkg.log ]; then
			apt-get install nmap
			nmapTools
			else
				whiptail --msgbox "ERROR! UNSUPPORTED PACKAGE MANAGER!" 30 120 8
				init
            fi
	fi
}
########################################################################
#End auxillary functions

authCheck
