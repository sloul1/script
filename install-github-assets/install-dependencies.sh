#!/bin/bash

# Function to check if jq is installed
is_jq_installed() {
    command -v jq > /dev/null 2>&1
}

# Check if jq is installed
if is_jq_installed; then
    echo "jq is already installed."
else
    # Ask the user if they want to install jq
    read -p "jq is not installed. Do you want to install it? (y/n): " answer

    # User input validation
    while [[ "$answer" != [YyNn] ]]; do
        echo "Invalid input. Please enter y or n."
        read -p "Do you want to install jq? (y/n): " answer
    done

    if [[ $answer == [Yy] ]]; then
        # Check the platform and run appropriate package manager
        case "$(uname -s)" in
            Linux*)     apt-get install jq ;;
            # Darwin*)    brew install jq ;; # Darwin version installation disabled as not yet tested
            *)         echo "Unsupported platform. Please install jq manually." ;;
        esac
    else
        echo "jq is required for this script to work properly. Exiting..."
        exit 1
    fi
fi