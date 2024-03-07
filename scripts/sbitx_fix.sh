#!/bin/bash

echo ""
echo ""
echo "sBitx Improvements by W9JES: Select an option to make changes sbitx application."
echo ""
echo ""
echo "These imrovements apply to sBitx transceivers v3.0 to v3.2"
echo ""
echo ""
echo "Each option will present a Yes or No option for you to choose from.."
echo ""
echo ""

echo "Do you want to remove the static AZ timezone setting from .profile? (y/n)"
read -r remove_tz_confirmation

if [[ "$remove_tz_confirmation" =~ ^[Yy]$ ]]; then
    PROFILE_FILE="/home/pi/.profile"

    if [ -f "$PROFILE_FILE" ]; then
        sed -i '/TZ=America\/Phoenix; export TZ/d' "$PROFILE_FILE"
        echo "AZ Timezone setting removed from $PROFILE_FILE."
        echo "Please restart your sBitx transceiver to complete the changes."
    else
        echo "The file $PROFILE_FILE does not exist."
    fi
else
    echo "Timezone setting removal skipped."
fi


echo "Do you want to remove RTTY and PSK31 modes in sbitx_gtk.c and rebuild the sbitx application? (y/n)"
read -r modify_rebuild_confirmation

if [[ "$modify_rebuild_confirmation" =~ ^[Yy]$ ]]; then
    SBITX_FILE="/home/pi/sbitx/sbitx_gtk.c"

    cp "$SBITX_FILE" "${SBITX_FILE}.bak"

    sed -i 's/USB\/LSB\/CW\/CWR\/FT8\/PSK31\/RTTY\/DIGITAL\/2TONE/USB\/LSB\/CW\/CWR\/FT8\/DIGITAL\/2TONE/g' "$SBITX_FILE"

    echo "Replacement complete in sbitx_gtk.c. Original file backed up as ${SBITX_FILE}.bak"

    cd /home/pi/sbitx || exit
    ./build sbitx
    echo "Rebuild of sbitx completed."
else
    echo "Modification and rebuild of sbitx skipped."
fi
