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

