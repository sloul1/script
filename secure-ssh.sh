#!/bin/bash

# Shell script for automatic hardening of SSH access using commonly used techniques.
# Meant to be used with newly installed Ubuntu 22.04 workstation and Raspberry Pi OS (Debian Bookworm based).

# Make backup copy of original sshd_config file

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Change the default port SSH listens to your preference."-i" is for in place editing meaning changes will
# be written in same file defined "/etc/ssh/sshd_config". First occurrence of text "/#Port 22" is going to be changed to "Port 2424".
# It is also possible to change all occurrences of defined text by using global option adding letter "g" after changed text and slash.
# Then command would be: sed -i 's/#Port 22/Port 2424/g' /etc/ssh/sshd_config 

sed -i 's/#Port 22/Port 2424/' /etc/ssh/sshd_config

# Restart SSH service to apply changes
systemctl restart sshd


