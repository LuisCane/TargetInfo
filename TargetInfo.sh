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
printf "\nEnter Target IP and Port in format x.x.x.x:yyyy.\n"
read -p "[Eg. 127.0.0.1:80]: " targetSOCK;
targetSOCK=${targetSOCK=127.0.0.1:80}
targetIP=$(echo $targetSOCK | cut -d : -f 1)
targetPORT=$(echo $targetSOCK | cut -d : -f 2)
printf "\nEnter desired Domain and Subdomains separated by spaces for /etc/hosts/.\n" 
read -p "[Eg. academy.htb test.academy.htb]:" targetDOMAIN;
targetDOMAIN=${targetDOMAIN=academy.htb}
}

#Print Target info back to user    
PrintTargetInfo () {
<<<<<<< HEAD
    printf "\nTarget IP: $targetIP"
    printf "\nTarget Port: $targetPORT"
    printf "\nTarget Socket: $targetSOCK"
    printf "\nTarget Domain: $targetDOMAIN\n\n"
    sleep 1s
=======
    printf "Target IP: $targetIP\n"
    printf "Target Port: $targetPORT\n"
    printf "Target Socket: $targetSOCK\n"
    printf "Target Domain: $targetDOMAIN\n"
>>>>>>> origin/main
}

#Generate Target Info Text
CreateTargetTxt () {
    printf "Generating ~/HTB/Target.txt"
    mkdir -p ~/HTB/;
    echo "Target Socket: $targetSOCK
    Target IP: $targetIP
    Target PORT: $targetPORT
    Target Domain: $targetDOMAIN:$targetPORT" > ~/HTB/Target.txt;
    sleep 1s
}
#Backup Hosts File
BackupHosts () {
    printf "\nBacking up /etc/hosts\n"
    sleep 1s
    FILE=/etc/hosts.bak
    if test -f "$FILE"; then
    printf "\netc/hosts.bak already exists\n"
    sleep 1s
    else sudo cp /etc/hosts /etc/hosts.bak;
    printf "/etc/hosts is backed up.\n"
    sleep 1s
    fi
}

#Modify Hosts File
ModifyHosts () {
    sudo cp /etc/hosts.bak /etc/hosts;
    sudo sed -i "$ a $targetIP $targetDOMAIN" /etc/hosts;
    printf "\nNew /etc/hosts, manualy edit this file to add subdomains\n"
    sleep 1s
    cat /etc/hosts;
}

ScriptWarning
GetTargetInfo
PrintTargetInfo
CreateTargetTxt
BackupHosts
ModifyHosts
