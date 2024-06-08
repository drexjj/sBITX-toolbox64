#!/bin/bash

# Set the working directory
working_directory="/home/pi/sBITX-toolbox"

# Change directory
cd "$working_directory"

# Update from Git
git reset --hard && git pull origin main 

# Set execute permissions
chmod +x ./*.sh ./sb_launcher ./apps/* ./scripts/*

# Remove fake hw clock and setup RTC
cd "$working_directory/scripts"
./rtc_enable.sh

# Update the menu
sudo update-desktop-database

# Open Toolbox
cd "$working_directory"
./sb_launcher

echo "sBITX-Launcher upgrade completed successfully! The applications have been added to the Pi Menu"
