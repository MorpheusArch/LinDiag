# morpheusarchtools
A collection of tools to be used with MorpheusArch Linux. If you're getting a permission denied error. You may need to make the shell scripts executable with the command:
chmod +x <name_of_file_>

# data_rec.sh

data_rec.sh is a whiptail BASH shell script that provides a GUI to the user for using ddrescue that allows them to recover data on a HDD / SSD either through device failure or accidental deletion.

![alt text](https://i.imgur.com/3UGRlnd.png)

It allows the user to display all mounted drives. Use ddrescue for creating .img and logfile and then copy the recovered data to a new disk.

# arch_diagnostic.sh

This is script that helps in diagnosing issues with systemd and diagnosing network issues.

![alt text](https://i.imgur.com/6Bi483l.png)

# Systemd Diagnostics

1) Check for failed services.
2) Start, stop and restart systemd units.
3) Check if a systemd unit is enabled or not.
4) Enable a unit at boot.
5) Show man page of units.

# Network Diagnostics

1) Display available network devices.
2) Check status of wpa_supplicant.
3) Connect to a Wi-Fi network.


# Pacman+.sh

Pacman+ is a GUI friendly way to update MorpheusArch Linux and Arch Linux. 

![alt text](https://i.imgur.com/e9BuoZ4.png)

