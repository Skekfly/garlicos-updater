#!/bin/bash

echo "# Start"

source ./garlicos-updater.cfg
workingDir=/tmp/garlicOS/
sdCardContent=$(adb shell ls /mnt/SDCARD | wc -l)

mkdir -p "$workingDir" || exit
cd "$workingDir" || exit

echo "# Downloading update package"
wget -O garlicOS.7z "$garlicOsDownloadPath" || exit
7z x garlicOS.7z || exit

echo "# Updating misc"
adb -s "$adbDeviceId" shell cp -Rv misc/* /misc/ || exit

echo "# Updating cfw"
adb -s "$adbDeviceId" push roms/CFW /mnt/mmc/ || exit

echo "# Updating roms"
adb -s "$adbDeviceId" push roms/Roms/* /mnt/mmc/ || exit
if [ "$sdCardContent" -gt 1 ]; then
  adb -s "$adbDeviceId" push roms/Roms/* /mnt/SDCARD/ || exit
fi

echo "# Updating bios"
adb -s "$adbDeviceId" push roms/BIOS /mnt/mmc/ || exit
if [ "$sdCardContent" -gt 1 ]; then
  adb -s "$adbDeviceId" push roms/BIOS /mnt/SDCARD/ || exit
fi

if [[ -v saveDir ]]; then
  echo "# Saving saves"
  if [ "$sdCardContent" -gt 1 ]; then
    adb -s "$adbDeviceId" pull /mnt/SDCARD/Saves "$saveDir" || exit
  else
    adb -s "$adbDeviceId" pull /mnt/mmc/Saves "$saveDir" || exit
  fi
fi

echo "# End"
