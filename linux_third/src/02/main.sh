#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
TIMEZONE="$TIMEZONE UTC $(date +"%:z" | awk '{split($0,a,""); print a[1]""a[3]}')"
USER=$(whoami)
OS="Unknown"
if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS=$PRETTY_NAME
elif [ -f /etc/lsb-release ]; then
    source /etc/lsb-release
    OS=$PRETTY_NAME
fi
DATE=$(date +"%d %b %Y %T")
UPTIME=$(uptime -p)
UPTIME_SEC=$(awk '{print int($1)}' /proc/uptime)
IP=$(ip a | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | head -n 1 )
MASK=$(ifconfig | grep "netmask " | grep -v "127.0.0.1" | awk '{print $4}' | head -n 1 )
GATEWAY=$(ip r | awk '/default/{print$3}')
RAM_TOTAL=$(grep -i 'memtotal' /proc/meminfo | awk '{printf ("%.3f", $2/1024/1024);}')
RAM_USED=$(free | grep "Mem:" | awk '{printf ("%.3f", $3/1024/1024);}')
RAM_FREE=$(free | grep "Mem:" | awk '{printf ("%.3f", $4/1024/1024);}')
SPACE_ROOT=$(df / | awk 'NR==2 {printf ("%.2f", $2/1024);}')
SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf ("%.2f", $3/1024);}')
SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf ("%.2f", $4/1024);}')
echo "HOSTNAME = "$HOSTNAME
echo "TIMEZONE = "$TIMEZONE
echo "USER = "$USER
echo "OS = "$OS
echo "DATE = "$DATE
echo "UPTIME = "$UPTIME
echo "UPTIME_SEC = "$UPTIME_SEC
echo "IP = "$IP
echo "MASK = "$MASK
echo "GATEWAY = "$GATEWAY
echo "RAM_TOTAL = "$RAM_TOTAL" GB"
echo "RAM_USED = "$RAM_USED" GB"
echo "RAM_FREE = "$RAM_FREE" GB"
echo "SPACE_ROOT = "$SPACE_ROOT" MB"
echo "SPACE_ROOT_USED = "$SPACE_ROOT_USED" MB"
echo "SPACE_ROOT_FREE = "$SPACE_ROOT_FREE" MB"

read -p "Save current info into file? (Y/N) " choice
if [[ ${choice} =~ ^[Yy]$ ]]; then
    FILENAME="$(date +'%d_%m_%y_%H_%M_%S').status"
    {
        echo "HOSTNAME = "$HOSTNAME
        echo "TIMEZONE = "$TIMEZONE
        echo "USER = "$USER
        echo "OS = "$OS
        echo "DATE = "$DATE
        echo "UPTIME = "$UPTIME
        echo "UPTIME_SEC = "$UPTIME_SEC
        echo "IP = "$IP
        echo "MASK = "$MASK
        echo "GATEWAY = "$GATEWAY
        echo "RAM_TOTAL = "$RAM_TOTAL" GB"
        echo "RAM_USED = "$RAM_USED" GB"
        echo "RAM_FREE = "$RAM_FREE" GB"
        echo "SPACE_ROOT = "$SPACE_ROOT" MB"
        echo "SPACE_ROOT_USED = "$SPACE_ROOT_USED" MB"
        echo "SPACE_ROOT_FREE = "$SPACE_ROOT_FREE" MB"
    }>"${FILENAME}"
    echo "Info saved into "$FILENAME
else 
    echo "Info didnt save"
fi