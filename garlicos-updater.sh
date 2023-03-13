#!/bin/bash

echo "Start"

source garlicos-updater.cfg

mkdir -p "$workingDir" || exit
cd "$workingDir" || exit

echo "Downloading update package"
wget -O garlicOS.7z "$garlicOsDownloadPath" || exit
7z x garlicOS.7z || exit

echo "Updating misc"
adb -s "$adbDeviceId" push misc/* /misc/ || exit

echo "Updating roms (int)"
adb -s "$adbDeviceId" push roms/Roms/* /mnt/mmc/ || exit

if [ -d "/mnt/SDCARD/" ]; then
  echo "Updating roms (ext)"
  adb -s "$adbDeviceId" push roms/Roms/* /mnt/SDCARD/ || exit
fi

echo "Updating bios (int)"
adb -s "$adbDeviceId" push roms/BIOS /mnt/mmc/ || exit

if [ -d "/mnt/SDCARD/" ]; then
  echo "Updating bios (ext)"
  adb -s "$adbDeviceId" push roms/BIOS /mnt/SDCARD/ || exit
fi

echo "Updating cfw (int)"
adb -s "$adbDeviceId" push roms/CFW /mnt/mmc/* || exit

if [ -d "/mnt/SDCARD/" ]; then
  echo "Updating cfw (ext)"
  adb -s "$adbDeviceId" push roms/CFW /mnt/SDCARD/ || exit
fi

if [ -d "/mnt/SDCARD/" ]; then
  echo "Saving saves (int)"
  adb -s "$adbDeviceId" pull /mnt/SDCARD/Saves "$extSaveDir" || exit
fi

echo "End"
