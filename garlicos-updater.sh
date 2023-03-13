#!/bin/bash

echo "# Start"

source ./garlicos-updater.cfg
workingDir=/tmp/garlicOS/

mkdir -p "$workingDir" || exit
cd "$workingDir" || exit

echo "# Downloading update package"
wget -O garlicOS.7z "$garlicOsDownloadPath" || exit
7z x garlicOS.7z || exit

echo "# Updating misc"
adb -s "$adbDeviceId" shell cp -Rv misc/* /misc/ || exit

echo "# Updating roms (int)"
adb -s "$adbDeviceId" push roms/Roms/* /mnt/mmc/ || exit
echo "# Updating roms (ext)"
adb -s "$adbDeviceId" push roms/Roms/* /mnt/SDCARD/ || exit

echo "# Updating bios (int)"
adb -s "$adbDeviceId" push roms/BIOS /mnt/mmc/ || exit
echo "# Updating bios (ext)"
adb -s "$adbDeviceId" push roms/BIOS /mnt/SDCARD/ || exit

echo "# Updating cfw (int)"
adb -s "$adbDeviceId" push roms/CFW /mnt/mmc/ || exit
echo "# Updating cfw (ext)"
adb -s "$adbDeviceId" push roms/CFW /mnt/SDCARD/ || exit

echo "# Saving saves (int)"
adb -s "$adbDeviceId" pull /mnt/SDCARD/Saves "$extSaveDir" || exit

echo "# End"
