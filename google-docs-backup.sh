#!/bin/bash

# This is a bash script for retrieving backup copy of a shared Google Docs spreadsheet.
# Script was inspired by the the final stages of the purchase of soccer uniforms, when
# worksheet edit permissions were considered for all team members.

# Create a .env file with four variables below before running this script by: touch .env
# Open .env file with editor: nano .env
# Add four lines below without "#" in beginning of line.

# SPREADSHEET_LINK="https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID_HERE/export?format=xlsx"
# BACKUP_FILENAME="type string of your choice here for identifying your backup files"
# BACKUP_DIR="/path/to/your/backup/directory"
# LOG_FILE="${BACKUP_DIR}/backup_log.txt"

# .env file should exist in same location with this script. 

echo "This is a script for retrieving copy of a shared Google Docs spreadsheet."  
sleep 3

# Load 4 environment variables from .env file
echo "Loading environment variables."

set -a
. .env

# Set the Google Cloud Storage bucket (if you have one)
## GCS_BUCKET="your-bucket-name"

# Function to get the current timestamp
get_timestamp() {
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
}

# Function to log a backup entry
log_backup() {
  echo "Backup completed: ${TIMESTAMP}_${BACKUP_FILENAME}.xlsx" >> "${LOG_FILE}"
}

# Get the current timestamp
get_timestamp

# Download the spreadsheet as an XLSX file using curl
echo "Downloading file..."
sleep 2
curl -s -X GET --location \
  ${SPREADSHEET_LINK} > "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"
echo "File download successful."

sleep 1
# Log the backup entry in the log file
log_backup
echo "Log created."
# Create a compressed archive (tar.gz) of the xlsx file
## tar -czf "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}_backup.tar.gz" "${BACKUP_DIR}/${TIMESTAMP}_${BACKUP_FILENAME}.xlsx"


###!!!Features under this are not tested yet!!!###

# If you have a Google Cloud Storage bucket, upload the backup to it
## if [ ! -z "${GCS_BUCKET}" ]; then
##  gsutil cp "${BACKUP_DIR}/${TIMESTAMP}.xlsx" "gs://${GCS_BUCKET}/"
## fi

# Remove the local backup file (optional)
## rm -f "${BACKUP_DIR}/${TIMESTAMP}.xlsx"

echo "Backup ready. Script exited."