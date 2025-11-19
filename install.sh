#!/bin/bash
# Installation script for MSM8916 USB Gadget
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

echo "Installing MSM8916 USB Gadget Configuration..."

# Create directories
mkdir -p /var/lib/msm8916-gadget

# Copy files manually since install may not be available
cp ${SCRIPT_DIR}/msm8916-usb-gadget.conf /etc/
chmod 644 /etc/msm8916-usb-gadget.conf

cp ${SCRIPT_DIR}/msm8916-usb-gadget.sh /usr/sbin/
chmod 755 /usr/sbin/msm8916-usb-gadget.sh

cp ${SCRIPT_DIR}/msm8916-usb-gadget.service /etc/systemd/system/
chmod 644 /etc/systemd/system/msm8916-usb-gadget.service

cp ${SCRIPT_DIR}/getty@ttyGS0.service /etc/systemd/system/
chmod 644 /etc/systemd/system/getty@ttyGS0.service

# Reload systemd if available
if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload
    systemctl enable msm8916-usb-gadget
    systemctl enable getty@ttyGS0
else
    echo ""
    echo "Systemd not found. Please enable the service manually if needed."
    echo ""
fi

echo ""
echo "Installation complete!"
echo ""
echo "Configuration file: /etc/msm8916-usb-gadget.conf"
echo ""