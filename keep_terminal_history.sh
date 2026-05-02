#!/bin/bash

# Created 2026/05
# Tested on: Fedora Linux 43 (Workstation Edition)

echo "This script enables history between terminal sessions by"
echo "adding few lines at the end of bash configuration file"
echo "<~/.bashrc> and reloading the configuration file."

cat << EOF >> ~/.bashrc
## Append commands between sessions to history starts
# Enable appending to history file instead of overwriting
shopt -s histappend

# Append history to file after each command, then reload to see other sessions' commands
PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

# Optional: Increase history size limits
HISTSIZE=10000
HISTFILESIZE=20000
## Append commands between sessions to history ends
EOF

# Enable changes made to file ~/.bashrc
source ~/.bashrc