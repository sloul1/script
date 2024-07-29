#!/bin/bash

# This is a bash script for retrieving backup copy of a shared Google Docs spreadsheet.
# Script was inspired by the the final stages of the purchase of soccer uniforms for our team, when
# giving worksheet edit permissions were considered for all team members.
# Hmm...what could go wrong with this? =)

# Script uses .env file with variables mentioned below.
# .env file should exist in same location with this script.
# Script assumes that downloaded files are kept in same directory
# with this script and no subdirectories are used.

# Edit .env file variables according to your needs

# SPREADSHEET_LINK="https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID_HERE/export?format=xlsx"
# BACKUP_FILENAME="type string of your choice here for identifying your backup files"
# BACKUP_DIR="/path/to/your/backup/directory"
# LOG_FILE="${BACKUP_DIR}/backup_log.txt"

# Name of downloaded backup is $TIMESTAMP(yyyymmdd-hhmmss) + _$BACKUP_FILENAME + export?format(xlsx or csv)
# resulting file '20240730-013418_Gotham-City-FC-team-uniforms.xlsx'
# Script logs downloads to "backup_log.txt" file.

# You can save space with csv formatting. In our case csv file size is 2.0K vs. 91K with xlsx format.
# If you want to save space using csv files, accordingly replace all string "xlsx" occurrences to
#  "csv" everywhere in the code including .env file. Be aware that using "sed" tool for this task in
# following manner "sed -i 's/xlsx/csv/g' google-docs-backup.sh" can also mess up instructions on commented lines.
# Using csv file format using comes with restrictions. You cannot use advanced features like
# formulas, formatting, charts, and graphics with csv files. Csv is a plain-text file format used to store tabular data.
# https://en.wikipedia.org/wiki/Comma-separated_values

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

# Function: current timestamp
get_timestamp() {
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
}

# Function: log a backup entry
log_backup() {
  echo "Backup completed: ${TIMESTAMP}_${BACKUP_FILENAME}.xlsx" >> "${LOG_FILE}"
}


# Check if any csv files with content exist and download one if not
echo "Checking if any spreadsheets exist."
if [ $(find . -type f -name "*.xlsx" | wc -l) -eq 0 ]; then
  get_timestamp
  curl -s -X GET --location \
  ${SPREADSHEET_LINK} > "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"
echo "1st file '${TIMESTAMP}_${BACKUP_FILENAME}.xlsx' download successful."
log_backup
fi

# Function: visual timer
timer(){
INTERVAL=10  # Change this to the desired interval in seconds
echo "Waiting $INTERVAL seconds until next check of file contents."

for ((i=$INTERVAL; i>=0; i--)); do
    echo -ne "\r$i seconds remaining..."
    sleep 1
done
echo -e "\n"
}

timer

LAST_RUN=$(date +%s)

# Function: get last file
get_last_file() {
LAST_FILE=$(find . -type f -name "*.xlsx" | sort -r | head -1)
}

while true; do
  CURRENT_TIME=$(date +%s)
  if [ $(($CURRENT_TIME - $LAST_RUN)) -ge "$INTERVAL" ]; then

# Get the current timestamp
get_timestamp

# Check and print latest downloaded file
get_last_file
    echo "Latest downloaded file: '$LAST_FILE'"

# Download the spreadsheet file using curl
    echo "Downloading file."
    curl -s -X GET --location \
      ${SPREADSHEET_LINK} > "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"
    echo "File '${TIMESTAMP}_${BACKUP_FILENAME}.xlsx' download successful."

### FILE COMPARING AND SPACE SAVING SECTION WORKS ONLY WITH CSV TYPE FILE DOWNLOADS ###

    # If content of two last downloaded files are the same, delete the newly downloaded file
    if diff "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx" "$LAST_FILE" > /dev/null; then
      echo "Files are same. No new files saved."
      rm -f "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"
 timer
    # If different, keep new downloaded file.
    else
      echo "Files are different. New file saved."
      log_backup
      echo "Entry created in '${LOG_FILE}'."
timer
    fi
### FILE COMPARING AND SPACE SAVING SECTION WORKS ONLY WITH CSV TYPE FILE DOWNLOADS ###

LAST_RUN=$CURRENT_TIME
  else
    sleep 1
  fi
done

#) # this is closing brace for logging stdout and stderr to file
