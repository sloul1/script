#!/bin/bash

# This bash script is for waking up server with wakeonlan utility.
# Script needs .env file in same location it is run with server's
# IP address and MAC address variables to work as shown below.
#
# SERVER="xxx.xxx.xxx.xxx"
# WAKEONLAN_MAC="xx:xx:xx:xx:xx:xx"
#
# Script checks if wakeonlan utility is installed and installs it if not.
# After this wakeonlan command is issued and script pings server until it
# has waken up. Script exits when server starts responding and reports time
# it took server to wake up. Script includes current system time printed when
# server is still waking up.
#
# Tested with Ubuntu 22.04.5 LTS workstation.

# Load environment variables from .env file
if [ -f ".env" ]; then
    source .env
else
    clear
    echo -e "\033[91mError: .env file not found.\033[0m"
    echo -e "\033[91mCreate .env file with two following variable lines:\033[0m"
    echo "SERVER=\"your host's IP address here\""
    echo "WAKEONLAN_MAC=\"your host's network interface's MAC address here\""
    exit 1
fi

# Store the start time when the script begins.
START_TIME=$(date +"%s")

seconds_elapsed() {
    NOW=$(date +"%s")
    ELAPSED=$((NOW - START_TIME))
    echo $ELAPSED
}

is_host_up() {
    local HOST=$SERVER
    echo "Pinging $HOST...pinged: $(seconds_elapsed) seconds"
    echo "(Press Ctrl + c to exit)"
    if ! ping -c 1 -W 1 $HOST &> /dev/null; then
        echo -e "\033[91mHost $HOST is down.\033[0m"
        return 1
    else
        clear
        echo -e "\033[92mHost $HOST is up!\033[0m"
        echo -e "\033[92mHost $HOST started in $(seconds_elapsed) seconds. Exiting script.\033[0m"
        exit 0
    fi
}

if ! which wakeonlan > /dev/null 2>&1; then
echo "Dependency is not installed. Installing dependency..."
sudo apt update && sudo apt upgrade -y
sudo apt install wakeonlan
fi

wakeonlan $WAKEONLAN_MAC

while true; do
  clear
  echo "$(date +"%A, %d.%m.%G %H:%M:%S")"
  echo "Wakeonlan command issued."
  is_host_up
  sleep 1
done
