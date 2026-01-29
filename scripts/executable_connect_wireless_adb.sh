#!/bin/bash
set -euo pipefail

adb disconnect

adb shell cmd -w wifi connect-network FPA-IOT wpa2 SHQConn3ct22!
DEVICE_IP="$(adb shell ip -f inet addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)"
echo "Device address is $DEVICE_IP"

adb tcpip 5555
adb connect $DEVICE_IP:5555

adb devices
echo "Please disconnect USB"
