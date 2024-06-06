#!/bin/bash

# Check if the script is running as root
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root. Re-running with sudo..."
  sudo "$0" "$@"
  exit
fi

# Edit the config.txt file
CONFIG_FILE="/boot/firmware/config.txt"
RTC_OVERLAY="dtoverlay=i2c-rtc-gpio,ds1307,bus=2,i2c_gpio_sda=13,i2c_gpio_scl=6"

echo "Editing $CONFIG_FILE to add RTC overlay..."
if ! grep -q "$RTC_OVERLAY" "$CONFIG_FILE"; then
    echo "$RTC_OVERLAY" | tee -a "$CONFIG_FILE"
    echo "RTC overlay added."
else
    echo "RTC overlay already present."
fi

# Remove fake-hwclock and update systemd configuration
echo "Removing fake-hwclock and updating systemd configuration..."
apt -y remove fake-hwclock
update-rc.d -f fake-hwclock remove

# Comment out lines in hwclock-set script
HW_CLOCK_SET_FILE="/lib/udev/hwclock-set"
echo "Modifying $HW_CLOCK_SET_FILE..."
sed -i 's/^if \[ -e \/run\/systemd\/system \] ; then$/#&/' "$HW_CLOCK_SET_FILE"
sed -i 's/^    exit 0$/#&/' "$HW_CLOCK_SET_FILE"
echo "Modification complete."

echo "RTC setup script completed."
