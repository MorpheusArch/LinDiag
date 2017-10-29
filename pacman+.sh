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
		echo "After doing so please enter the command: update"
		echo "And run the script root priveleges"
        sleep 1
        exit 1
			else
		init
fi
}

init(){
OPTION=$(whiptail --title "Pacman+" --backtitle "Pacman+_Package_Management" --menu "Choose your option" 15 60 4 \
"1" "Update System" \
"2" "Clear Pacman Cache" \
"3" "Rank Mirrors" \
3>&1 1>&2 2>&3)
 
if [ "$OPTION" == '1' ]; then
	
	clear
	pacman -Syu
	init
	
fi

if [ "$OPTION" == '2' ]; then
	
	clear
	pacman -Sc
	init
	
fi

if [ "$OPTION" == '3' ]; then
	
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
	init

fi
}


authCheck
