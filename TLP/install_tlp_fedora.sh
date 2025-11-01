#!/bin/bash

# TLP installer (Optimize Linux Laptop Battery Life)
# 
# Created 2025/11/1
# Tested on:

# Fedora Linux 42 (Workstation Edition) stable

# This TLP installer script is created according to 
# https://linrunner.de/tlp/installation/fedora.html
# © Copyright 2025, linrunner. Licensed under the CC BY-NC-SA
# https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en

# Install
# tlp (Updates) – Power saving
#
# tlp-rdw (Updates) – optional – Radio Device Wizard
# https://linrunner.de/tlp/settings/rdw.html

sudo dnf install tlp tlp-rdw

# Remove conflicting power management tools

# Fedora 40 and below
# sudo dnf remove power-profiles-daemon

# Fedora version 41 and newer
sudo dnf remove tuned tuned-ppd

# "To complete the installation you must enable TLP’s service:
sudo systemctl enable tlp.service

# "You should also mask the following services to avoid conflicts and assure
# proper operation of TLP’s Radio Device Switching options:"
# https://linrunner.de/tlp/settings/radio.html
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket

# Configure after installing:
# sudo nano /etc/tlp.conf
# https://linrunner.de/tlp/settings/introduction.html

# Activate changes
# sudo tlp start