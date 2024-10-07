#!/bin/bash

if [[ ! -f ./colors.cfg ]]; then
	echo "Error: file not found"
	exit 1
fi

colors=("white" "red" "green" "blue" "purple" "black")
bg_col_fr=('47' '41' '42' '44' '45' '40')
ft_col_fr=('97' '91' '92' '94' '95' '90')
bg_col_sec=('47' '41' '42' '44' '45' '40')
ft_col_sec=('97' '91' '92' '94' '95' '90')
default_color_colomn1=("1" "2")
default_color_colomn2=("1" "2")

bg_fr=$(grep "^column1_background=" colors.cfg | cut -d "=" -f 2)
ft_fr=$(grep "^column1_font_color=" colors.cfg | cut -d "=" -f 2)
bg_sec=$(grep "^column2_background=" colors.cfg | cut -d "=" -f 2)
ft_sec=$(grep "^column2_font_color=" colors.cfg | cut -d "=" -f 2)

if [[ -z "$bg_fr" ]]; then
	bg_fr=${default_color_colomn1[0]}
	def_bg1=1
fi

if [[ -z "$ft_fr" ]]; then
	ft_fr=${default_color_colomn1[1]}
	def_ft1=1
fi

if [[ -z "$bg_sec" ]]; then
	bg_sec=${default_color_colomn2[0]}
	def_bg2=1
fi

if [[ -z "$ft_sec" ]]; then
	ft_sec=${default_color_colomn2[1]}
	def_ft2=1
fi

if [ "$bg_fr" = "$ft_fr" ] || [ "$bg_sec" = "$ft_sec" ]; then
    echo "Error: wrong colors"
    exit 1
fi

if ! [[ $bg_fr =~ ^[1-6]$ ]] || ! [[ $ft_fr =~ ^[1-6]$ ]] ||
   ! [[ $bg_sec =~ ^[1-6]$ ]] || ! [[ $ft_sec =~ ^[1-6]$ ]]; then
   echo "Error: wrong parametrs"
   exit 1
fi

bg_fr1=$bg_fr
ft_fr1=$ft_fr
bg_sec1=$bg_sec
ft_sec1=$ft_sec

bg_fr=${bg_col_fr[$bg_fr - 1]}
ft_fr=${ft_col_fr[$ft_fr - 1]}
bg_sec=${bg_col_sec[$bg_sec - 1]}
ft_sec=${ft_col_sec[$ft_sec - 1]}

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
printf "\e[${bg_fr};${ft_fr}mHOSTNAME = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n" "$HOSTNAME"
printf "\e[${bg_fr};${ft_fr}mTIMEZON = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$TIMEZONE"
printf "\e[${bg_fr};${ft_fr}mUSER = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$USER"
printf "\e[${bg_fr};${ft_fr}mOS = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$OS"
printf "\e[${bg_fr};${ft_fr}mDATE = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$DATE"
printf "\e[${bg_fr};${ft_fr}mUPTIME = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$UPTIME"
printf "\e[${bg_fr};${ft_fr}mUPTIME_SEC = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$UPTIME_SEC"
printf "\e[${bg_fr};${ft_fr}mIP = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n" "$IP"
printf "\e[${bg_fr};${ft_fr}mMASK = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$MASK"
printf "\e[${bg_fr};${ft_fr}mGATEWAY = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$GATEWAY"
printf "\e[${bg_fr};${ft_fr}mRAM_TOTAL = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$RAM_TOTAL GB"
printf "\e[${bg_fr};${ft_fr}mRAM_USED = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$RAM_USED GB"
printf "\e[${bg_fr};${ft_fr}mRAM_FREE = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$RAM_FREE GB"
printf "\e[${bg_fr};${ft_fr}mSPACE_ROOT = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$SPACE_ROOT MB"
printf "\e[${bg_fr};${ft_fr}mSPACE_ROOT_USED = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$SPACE_ROOT_USED MB"
printf "\e[${bg_fr};${ft_fr}mSPACE_ROOT_FREE = \e[0m\e[${bg_sec};${ft_sec}m%s\e[0m\n"  "$SPACE_ROOT_FREE MB"
printf "\n"
if [[ -z "$def_bg1" ]]; then
    printf "Column 1 background = $bg_fr1 (${colors[${bg_fr1}-1]})\n"
else
    printf "Column 1 background = default (${colors[${bg_fr1}-1]})\n"
fi
if [[ -z "$def_ft1" ]]; then
    printf "Column 1 font color = $ft_fr1 (${colors[${ft_fr1}-1]})\n"
else
    printf "Column 1 font color = default (${colors[${ft_fr1}-1]})\n"
fi
if [[ -z "$def_bg2" ]]; then
    printf "Column 2 background = $bg_sec1 (${colors[${bg_sec1}-1]})\n"
else
    printf "Column 2 background = default (${colors[${bg_sec1}-1]})\n"
fi
if [[ -z "$def_ft2" ]]; then
    printf "Column 2 font color = $ft_sec1 (${colors[${ft_sec1}-1]})\n"
else
    printf "Column 2 font color = default (${colors[${ft_sec1}-1]})\n"
fi

exit 0