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

# Sec_Audit.sh

sec_audit.sh aids in performing a basic security audit against a server through penetration testing techniques. You'll likely need to install the tools first and have some user / pass lists for hydra's attacks.

![alt text](https://i.imgur.com/QxCDQNu.png)

# Nmap Tools 
1) Full TCP port scan against a host.
2) Verbose stealth scan.
3) Stealth Syn with OS Detection.
4) Stealth Syn with Full TCP range.
5) Scan from list of hosts within a file.

# Hydra Tools
1) Get username and password lists through wget. Renaming the file as users.txt and pass.txt.
2) Enter custom Hydra command
3) Attack FTP service
4) Attack SSH service.

# Lynis Tools
This option just has lynis auditing software audit the system and put the output in lynis.log within the active directory.

# Cleaner.sh
This exists so you can safely delete all log entries contained within /var/log upon successful penetration testing of a server. It makes use of the shred utility to overwrite data before deleting them making any attempts at recovering the data, quite impossible.


![alt text](https://i.imgur.com/7awaSGo.png)
