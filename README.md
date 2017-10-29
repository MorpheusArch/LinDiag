# morpheusarchtools
A collection of tools to be used with MorpheusArch Linux. If you're getting a permission denied error. You may need to make the shell scripts executable with the command:
chmod +x <name_of_file_>

# Archlog.sh

Archlog.sh is a system maintenence tool designed to give users a way to diagnose problems with a system. Through a graphical user interface.

![alt text](https://i.imgur.com/DxYhWDP.png)

Its made possible with whiptail BASH scripts and allows the user to:

1) Check for failed systemd services.
2) Check network connection.
3) Display the results of the network connection diagnostic.
4) Display status of WPA_Supplicant.
5) Generates a list of all installed packages.
6) Back up the entire pacman database in the active directory.
7) Create a dmesg.txt file.

Logging:

The results of Archlog.sh can be found in /var/log/archlog for closer inspection later on.

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
