#!/bin/bash

# This is a bash script for retrieving backup copy of a shared Google Docs spreadsheet.
# Script was inspired by the the final stages of the purchase of soccer uniforms for our team, when
# giving worksheet edit permissions were considered for all team members.
# Hmm...what could go wrong with this? =)

# Script uses .env file with variables as mentioned below.
# Edit .env file variables according to your needs

# SPREADSHEET_LINK="https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID_HERE/export?format=xlsx"
# BACKUP_FILENAME="Gotham-City-FC-team-uniforms"
# BACKUP_DIR="/path/to/your/backup/directory"
# LOG_FILE="${BACKUP_DIR}/backup_log.txt"

# Script assumes that '.env' file exist in same location with this script.

# Name of downloaded file is in form $TIMESTAMP + _$BACKUP_FILENAME + .xlsx
# resulting for example file '20240718-152913_Gotham-City-FC-team-uniforms.xlsx'

# TODO: Space saver
# Check if contents of last saved file and newly downloaded file is same.
# If not, keep the newly downloaded file. Else remove newly downloaded file.
# I got this feature already working using diff with .csv file format downloads.

# Further exploring:
# To redirect both stdout and stderr to a log file between braces () uncomment
# two lines below and closing brace in the end of this file.

#( # this is opening brace for logging stdout and stderr to file
#  exec >> my_log.txt 2>&1

echo "This is a script for retrieving copy of a shared Google Docs spreadsheet."

# Check if .env file exists
echo "Checking if .env file exists."

if [ ! -f ".env" ]; then
  echo "Error: .env file not found."
  exit 1
fi

echo ".env file found."
sleep 1

# Load environment variables from .env file
set -a
. .env
echo "Environment variables loaded."

# Function: visual timer
timer(){
INTERVAL=3600  # Change this to the desired interval in seconds. 1 hour = 3600 seconds.
echo "Waiting $INTERVAL seconds until next download."

for ((i=$INTERVAL; i>=0; i--)); do
    echo -ne "\r$i seconds remaining..."
    sleep 1
done
echo -e "\n"
}

timer

LAST_RUN=$(date +%s)

# Function: current timestamp
get_timestamp() {
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
}

# Function: log a backup entry
log_backup() {
  echo "Downloaded: ${TIMESTAMP}_${BACKUP_FILENAME}.xlsx" >> "${LOG_FILE}"
}

while true; do
  CURRENT_TIME=$(date +%s)
  if [ $(($CURRENT_TIME - $LAST_RUN)) -ge "$INTERVAL" ]; then

# Get the current timestamp
get_timestamp

# Download the spreadsheet as an XLSX file using curl
  echo "Downloading file..."
  curl -s -X GET --location \
    ${SPREADSHEET_LINK} > "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"
  echo "Downloaded '${TIMESTAMP}_${BACKUP_FILENAME}.xlsx'"


    # Log the backup entry in the log file
  log_backup
  echo "Entry created in '${LOG_FILE}'."
timer

LAST_RUN=$CURRENT_TIME
  else
    sleep 1
  fi
done
#) # this is closing brace for logging stdout and stderr to file
