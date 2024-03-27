#!/bin/bash

# Set the download directory
old_directory="/home/pi/sBITX-toolbox64"

# Set the working directory
working_directory="/home/pi/sBITX-toolbox"

# Start install
if [ -d "$old_directory" ]; then
    mv "$old_directory" "$working_directory"
fi

# Check for python3-tk and install if not present
if ! dpkg -l | grep -qw python3-tk; then
    echo "Installing python3-tk..."
    sudo apt-get update
    sudo apt-get install -y python3-tk
fi

# Check for sox and install if not present
if ! dpkg -l | grep -qw sox; then
    echo "Installing sox..."
    sudo apt-get update
    sudo apt-get install -y sox
fi

# Change directory
cd "$working_directory"

# Give execute permissions
chmod +x ./*.sh ./sb_launcher ./apps/* 

# Create a desktop menu shortcut
echo -e "[Desktop Entry]\nName=sBITX Apps\nExec=sh -c 'cd $working_directory && ./sb_launcher'\nType=Application\nIcon=/home/pi/sBITX-toolbox/icons/toolbox_icon.png\n" | sudo tee /usr/share/applications/sb_launcher.desktop > /dev/null
echo -e "[Desktop Entry]\nName=sBITX Apps\nExec=sh -c 'cd $working_directory && ./sb_launcher'\nType=Application\nIcon=/home/pi/sBITX-toolbox/icons/toolbox_icon.png\n" | sudo tee /home/pi/Desktop/sb_launcher.desktop > /dev/null

# Update the menu
sudo update-desktop-database

echo "sBITX-Launcher setup completed successfully! The applications have been added to the Pi Menu"
