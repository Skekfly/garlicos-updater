#!/bin/bash

echo "# Start"

source ./garlicos-updater.cfg
#source ./utils.sh

workingDir=/tmp/garlicOS/
sdCardContent=$(adb shell ls /mnt/SDCARD | wc -l)

mkdir -p "$workingDir" || exit
cd "$workingDir" || exit

echo "# Downloading update package"
wget -O garlicOS.7z "$garlicOsDownloadPath" || exit
7z x garlicOS.7z || exit

echo "# Updating misc"
adb shell mount -o rw,remount /misc
adb -s "$adbDeviceId" push --sync misc/* /misc/ || exit

echo "# Updating cfw"
adb -s "$adbDeviceId" shell cp -v /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/current_retroarch.cfg || exit
adb -s "$adbDeviceId" push --sync roms/CFW /mnt/mmc/ || exit
adb -s "$adbDeviceId" shell cp -v /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg.new || exit
adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/retroarch/.retroarch/current_retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg || exit

echo "# Updating roms"
adb -s "$adbDeviceId" push --sync roms/Roms/* /mnt/mmc/ || exit
if [ "$sdCardContent" -gt 1 ]; then
  adb -s "$adbDeviceId" push --sync roms/Roms/* /mnt/SDCARD/ || exit
fi

echo "# Updating bios"
adb -s "$adbDeviceId" push --sync roms/BIOS /mnt/mmc/ || exit
if [ "$sdCardContent" -gt 1 ]; then
  adb -s "$adbDeviceId" push --sync roms/BIOS /mnt/SDCARD/ || exit
fi

if [[ -v saveDir ]]; then
  echo "# Saving saves"
  if [ "$sdCardContent" -gt 1 ]; then
    adb -s "$adbDeviceId" pull --sync /mnt/SDCARD/Saves "$saveDir" || exit
  else
    adb -s "$adbDeviceId" pull --sync -a /mnt/mmc/Saves "$saveDir" || exit
  fi
fi

echo "# End"


adb reboot