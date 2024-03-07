#!/bin/bash

# Remove the toolbox directory
sudo rm -rf /home/pi/sBITX-toolbox

# Remove shortcut
sudo rm /usr/share/applications/sb_launcher.*

# Update the menu cache
sudo update-desktop-database

echo "sBITX-toolbox applications and menu shortcuts have been successfully uninstalled."
