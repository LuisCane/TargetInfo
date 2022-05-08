#!/bin/bash

#initialize some variables
targetIP=127.0.0.1
targetPORT=80
targetSOCK=127.0.0.1:80
targetDOMAIN=academy.htb

#Warn user of the dangers of scripts
ScriptWarning () {
    printf '\nIt is not recommended that you run scripts that you find on the internet without knowing exactly what they do.\n\n
This script contains functions that require root privilages and is intended to run as root or with sudo. Running this script without root or sudo privilage may result in errors.\n'
    sleep 3s
    while true; do
        read -p $'Do you wish to proceed? [y/N]' yn
        yn=${yn:-N}
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo 'Please answer yes or no.';;
        esac
    done
}

#get target info from the user
GetTargetInfo () {
read -p "Enter Target IP and Port in format x.x.x.x:yyyy [127.0.0.1:80]: " targetSOCK;
targetSOCK=${targetSOCK=127.0.0.1:80}
targetIP=$(echo $targetSOCK | cut -d : -f 1)
targetPORT=$(echo $targetSOCK | cut -d : -f 2)
read -p "Enter desired Domain for /etc/hosts/ [academy.htb]:" targetDOMAIN;
targetDOMAIN=${targetDOMAIN=academy.htb}
}

#Print Target info back to user    
PrintTargetInfo () {
    printf "Target IP: $targetIP"
    printf "Target Port: $targetPORT"
    printf "Target Socket: $targetSOCK"
    printf "Target Domain: $targetDOMAIN"
}

#Generate Target Info Text
CreateTargetTxt () {
    printf "Generating ~/HTB/Target.txt"
    mkdir ~/HTB/;
    echo "Target Socket: $targetSOCK
    Target IP: $targetIP
    Target PORT: $targetPORT
    Target Domain: $targetDOMAIN:$targetPORT" > Target.txt;
}
#Backup Hosts File
BackupHosts () {
    FILE=/etc/hosts.bak
    if test -f "$FILE"; then
    printf "/etc/hosts.bak already exists\n"
    else sudo cp /etc/hosts /etc/hosts.bak;
    printf "Backing up /etc/hosts\n"
    fi
}

#Modify Hosts File
ModifyHosts () {
    BackupHosts
    sudo cp /etc/hosts.bak /etc/hosts;
    sudo sed -i "$ a $targetIP $targetDOMAIN" /etc/hosts;
    printf "New /etc/hosts, manualy edit this file to add subdomains"
    cat /etc/hosts;
}

ScriptWarning
GetTargetInfo
PrintTargetInfo
CreateTargetTxt
BackupHosts
ModifyHosts
