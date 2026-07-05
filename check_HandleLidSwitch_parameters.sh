#!/bin/bash

# This script checks recursively if configuration files (*.conf) in
# /etc/systemd contain lines including the string "HandleLidSwitch"
# After modifying for example /etc/systemd/logind.conf run 
# systemctl restart systemd-logind to apply the changes. 

# Created: 2026/03/19
# Modified: 2026/07/05

# Tested on:
#   Fedora Linux 43 (Workstation Edition)
#   24.04.4 LTS (Noble Numbat)
#   Proxmox 9.2.4 - Debian Trixie (13.5)

# Set the keyword to search for
keyword=${1:-"HandleLidSwitch"}

# Function to search for keyword in files recursively
search_keyword() {
    local directory="$1"
    local file_pattern="$2"

    # Use grep to search files recursively for the specified pattern
    grep -Hrn --include="*$file_pattern" "$keyword" "$directory" 2>/dev/null
}

# Start the search from /etc/systemd or any other directory you want
search_directory="/etc/systemd"
echo -e "Checking for string '$keyword' in '$search_directory'...\n"
search_keyword "$search_directory" "*.conf"
