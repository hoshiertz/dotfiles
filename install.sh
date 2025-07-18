#!/bin/bash

echo "Arch Linux Quick Install Assistant v0.1"

read -p "Use iwctl or dhcpcd? " network
if [ "$network" = "iwctl" ]; then
    iwctl station wlan0 scan
    iwctl station wlan0 get-networks
    read -p "Input SSID (WiFi Name): " ssid
    iwctl station wlan0 connect $ssid
    sleep 1
elif [ "$network" = "dhcpcd" ]; then
    echo "dhcpcd start..."
    dhcpcd
    sleep 1
else
    echo "Error command."
    exit 0
fi