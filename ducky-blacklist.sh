#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

NewFile=/etc/udev/rules.d/82-badusb-hid.rules
(
cat << EOF
# Amtel chip based HAK.5 USB Rubber Ducky should be disabled
SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2401", ATTR{authorized}="0"
EOF
) > /etc/udev/rules.d/82-badusb-hid.rules

systemctl restart udev
udevadm control --reload
udevadm trigger
