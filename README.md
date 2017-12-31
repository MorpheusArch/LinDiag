# morpheusarchtools
Previously a collection of tools that has recently been merged to one file. Intended to be used with MorpheusArch Linux however a standard Arch Linux system is supported along with Debian / Fedora based linux distributions.

If you're getting a permission denied error. You may need to make the shell scripts executable with the command:
chmod +x <name_of_file_>

# lindiag.sh
![alt text](https://i.imgur.com/CVdNfjL.png)

Previously MorpheusArch tools was split up into seperate .sh files each with their own use. Now everything has been merged into one file called lindiag.sh.

This has the benefit of being able to use MorpheusArch tools without having to jump from file to file, or terminal to terminal.

lindiag is short for Linux Diagnostics and contains most of what you'll need to diagnose and fix a GNU/Linux based system.

LinDiag allows you to:

1) Check for failed systemd units.
2) Stop, Start and Restart systemd units.
3) Verify if a systemd unit is enabled at boot and enable if required.
4) Show the man page of a systemd unit.

![alt text](https://i.imgur.com/xpfuCPW.png)

Next in lindiags arsenal is the network diagnostics that lets you:

1) Display all available network devices.
2) Check the status of and restart wpa_supplicant (can also be done on systemd diagnostics).
3) Connect to a Wi-Fi network.
4) Run a network speed test.
5) Launch / install nmap. With verbose stealth SYN/ACK scanning & OS detection all pre-configured and ready to use

![alt text](https://i.imgur.com/AMe3wSc.png)

After all thats done you need to manage some packages? No problem lindiags got you covered, and this is where the cross distro support comes into play here. Currently only Arch, Fedora and Debian based distros are supported. LinDiag checks for which package manager is in use and knows what to do from there.

![alt text](https://i.imgur.com/39EojOo.png)

Next up is the Data Recovery portion of LinDiag.

![alt text](https://i.imgur.com/TbhpzYo.png)

It lets you display all mounted drives and attempt to use ddrescue to recover data from them with more to come.

LinDiag will also install Lynis and perform a full system audit when installed.

![alt text](https://i.imgur.com/cFAmy4D.png)

LinDiag has extra options as well literally titled extra options this is where all the other stuff goes that might be useful along with being able to search google direct through the terminal with this. This is also where you can git clone the latest releases of LinDiag

![alt text](https://i.imgur.com/ru3WLtm.png)

