#!/bin/bash

# Clone Lynis from GitHub
git clone https://github.com/CISOfy/lynis

# Go to Lynis directory and execute Lynis
cd lynis && ./lynis audit system
