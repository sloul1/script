#!/bin/bash

# Script for looped battery status check.
# Prints battery status and date in one second intervals.
# Sleep time is defined in seconds.
# Tested with Ubuntu 22.04.5 LTS

while true; do
    clear
    upower -i /org/freedesktop/UPower/devices/battery_BAT0
    echo ""
    date
    sleep 1
done
