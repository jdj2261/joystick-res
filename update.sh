#!/bin/bash

#### Colors ####
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
Light_BLUE='\033[1;34m'
Light_Cyan='\033[1;35m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color
##################

# --- add screensaver
func_screensaver() {
    echo -e "${GREEN}-- Add consoleblank=0 in /boot/cmdline.txt --${NC}"
    echo consoleblank=0 | sudo tee -a /boot/cmdline.txt
}
func_screensaver

func_install_vscode(){
    echo -e "${GREEN}-- Install VScode -- ${NC}"
    wget https://packagecloud.io/headmelted/codebuilds/gpgkey -O - | sudo apt-key add -
    . <( wget -O - https://code.headmelted.com/installers/apt.sh )
    apt-get install code-oss=1.29.0-1539702286
    echo -e "${Light_BLUE}-- Finished VScode install-- ${NC}"
}
func_install_vscode

sleep 1
echo -e "${BLUE}-- Finished Update-- ${NC}"