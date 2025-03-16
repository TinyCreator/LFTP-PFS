#!/bin/bash

# - PRIMITIVE FTP SYNCHRONIZATION
# This script requires previous installation of LFTP.
# The main purpose of the tool is to automate local-remote file synchronization   
# with the use of the mirror command integrated in LFTP

# File with credentials for future login
FILE=./preferences.conf

echo 'RUNNING: PRIMITIVE FTP SYNCHRONIZATION'

# Function for every process related with the profile creation 
setup () {
    read -p "[CURRENTLY REQUIRED] Create file for automatic login? (y/n)" pref
    if [[ $pref=y || $pref=Y ]]; then
        echo 'Creating file for automatic login'
        touch $FILE
        read -p "FTP host: " host
        echo host=$host >> $FILE
        read -p "FTP username: " username
        echo username=$username >> $FILE
        read -p "FTP password: " password
        echo password=$password >> $FILE
    fi
}

# Function to register local folder and remote folder to mirror
select_directories () {
    echo 'Folder requires user access'
    read -p "Server folder to sync (e.g: /FTP-Documents/): " origin
    echo origin=$origin >> $FILE
    read -p "Local folder to sync (e.g: ~/Documents/): " destiny
    echo destiny=$destiny >> $FILE   
}

while true; do
    # Check if everything is Ok to start synchonization
    if [[ -f $FILE ]]; then
    source $FILE
        # Preferences file exists
        if ! [ -z $username ] && ! [ -z $password ] && ! [ -z $host ]; then            
            if [ -z $origin ] || [ -z $destiny ]; then
                # Select sources to synchronize
                select_directories
            else
                # First synchronization remote-local                 
                (lftp -c "open -u $username,$password $host && mirror $origin $destiny"); wait $!
                echo 'Local data up to date';
                # Until user ends the task manually
                while true; do
                    # Update with changes local-remote
                    (lftp -c "open -u $username,$password $host && mirror -Re $destiny $origin"; sleep 30s); wait $!                   
                done
                break
            fi
        else 
            # Preference file exist but all or some values are empty
            echo "Can't authenticate: Missing parameters"; setup
        fi
    else 
        # If preferences cannot be found creation is required
        setup
    fi 
done