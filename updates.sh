#!/bin/bash

# Simple (and crude) script for updating Ubuntu workstation 22.04 software 

# update repositories and upgrade installed software
apt update && apt upgrade -y

# kill snap-store for refreshing
killall snap-store

# update software installed through snap
snap refresh
