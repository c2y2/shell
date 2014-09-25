#!/bin/bash

#Custom Terminal HUD To Display Current System Information | Kali Linux Only
#Author | Haccmann
#No fancy shit | Just Code

#Instructions#
#~Save this file to root dir
#~Open /etc/bash.bash.rc with your favorite text editor - example: gedit /etc/bash.bash.rc 
#@h@#~and copy+paste the following command to the bottom of the bash.bash.rc file:
#~"bash kalihud"
#~save it, exit then open your terminal and it should prompt your system information 

#~For the terminal to greet you, you must install espeak with the following code:
#~"apt-get espeak"
#and you're done!
#~Find the espeak command below and delete the hash#

##############
#  Settings  #
##############

#Edit what you want

#Current User
whoami=$(whoami)

#System Hostname
hostname=$(hostname)

#Distribution ID
distroID=$(lsb_release -i | awk '{print $3, $4}')

#Distribution
distro=$(lsb_release -r | awk '{print $2, $3, $4, $5}')

#Architecture
architecture=$(arch) 
architecture1=$(getconf LONG_BIT)bit

#Kernel release
kernel=$(uname -v | awk '{print $4, $5}')

#login Session
session=$(echo $DESKTOP_SESSION)
#Desktop Environment
desktop=$(echo $XDG_DATA_DIRS | grep -Eo 'xfce|kde|gnome')

#Shell
shell=$( bash --version | grep -m 1 "GNU" | cut -d"(" -f1 | awk '{print $4}')

#Processor
cpu=$(grep -m 1 "model name" /proc/cpuinfo | cut -d: -f2 | awk '{print $1, $2, $3, $4}')
cpu1=$(grep -m 1 "model name" /proc/cpuinfo | cut -dU -f2 | awk '{print $1, $2, $3, $4}')
cpu2=$(grep -c "processor" /proc/cpuinfo)

#Memory
memory=$(cat /proc/meminfo | head -1 | awk '{print $2}')
memory1=$(echo "scale=3;${memory%/*}/1024/1024" | bc)

#Disk Space
disk=$(df -h | grep "rootfs" | awk '{print $3}')
disk1=$(df -h | grep "rootfs" | awk '{print $4}')


#RAM
ram=$(free -m | grep -i "mem:" | awk '{print $3}')MB
ram1=$(free -m | grep -i "mem:" | awk '{print $2}')MB

#Espeak
#espeak "Welcome, $whoami, at, $hostname" 2>/dev/null

###############
# HUD Display #
###############

echo -e "\e[1;34m8N    8  N888           
888   88   D88           
8888N D88    88D       \e[1;91mSystem Information\e[1;34m
8888888888D   88ON    
888888888888   NNN         \e[1;91m$distroID\e[1;34m
8888888888888N             Distro:\e[0m $distro \e[1;34m
D8888888888888888888          Arch:\e[0m $architecture $architecture1\e[1;34m
    N88888888888888888       Kernel:\e[0m $kernel\e[1;34m 
        N88888888888888        Shell:\e[0m Bash $shell \e[1;34m
         888888888888888      Desktop:\e[0m $session \e[1;34m|\e[0m $desktop\e[1;34m       
         88888888888DD88       
         88888888888N 88D       \e[1;91mHardware\e[1;34m       
         8888888888888ND88        Memory:\e[0m $memory1 GiB\e[1;34m     
         N88888888888888888           CPU:\e[0m $cpu $cpu1 x $cpu2\e[1;34m   
             D888888888888            
                 N888888888OD   \e[1;91mSystem Status\e[1;34m        
                    N888888888N          Disk:\e[0m $disk \e[1;34m|\e[0m $disk1\e[1;34m 
                      N88888888O8N         RAM:\e[0m $ram  \e[1;34m|\e[0m $ram1 \e[1;34m
                        8888888888888DD
                         D8888888888888
                           8888888888D 
                            D888888    
                             8888D     
                             N88D
\e[0m"

# End of the beginning
