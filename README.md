# morpheusarchtools
A collection of tools to be used with MorpheusArch Linux. If you're getting a permission denied error. You may need to make the shell scripts executable with the command:
chmod +x <name_of_file_>

# Archlog.sh

Archlog.sh is a system maintenence tool designed to give users a way to diagnose problems with a system. Through a graphical user interface.

![alt text](https://i.imgur.com/dY3PgTu.png)

Its made possible with whiptail BASH scripts and allows the user to:

1) Check for failed systemd services.
2) Check network connection.
3) Display the results of the network connection diagnostic.
4) Display status of WPA_Supplicant.
5) Generates a list of all installed packages.
6) Back up the entire pacman database in the active directory.
7) Create a dmesg.txt file.

# Logging

The results of Archlog.sh can be found in /var/log/archlog for closer inspection later on.

# Pacman+.sh

Pacman+ is a GUI friendly way to update MorpheusArch Linux and Arch Linux. 

![alt text](https://i.imgur.com/e9BuoZ4.png)
