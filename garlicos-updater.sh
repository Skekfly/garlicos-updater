#!/bin/bash

echo "# Start"

source ./garlicos-updater.cfg
workingDir=/tmp/garlicOS/
sdCardContent=$(adb shell ls /mnt/SDCARD | wc -l)

mkdir -p "$workingDir" || exit
cd "$workingDir" || exit

echo "# Downloading update package"
wget -O garlicOS.7z.001 "$garlicOsDownloadPath_001" || exit
wget -O garlicOS.7z.002 "$garlicOsDownloadPath_002" || exit
7z x garlicOS.7z.001 || exit

echo "# Updating misc"
adb shell mount -o rw,remount /misc
if [ ! "$resetCfg" = true ]; then
  adb -s "$adbDeviceId" shell cp -v /misc/boot_logo.bmp.gz /misc/current_boot_logo.bmp.gz || exit
fi
adb -s "$adbDeviceId" push --sync misc/* /misc/ || exit
if [ ! "$resetCfg" = true ]; then
  adb -s "$adbDeviceId" shell rm -r /misc/boot_logo.bmp.gz.new || exit
  adb -s "$adbDeviceId" shell mv /misc/boot_logo.bmp.gz /misc/boot_logo.bmp.gz.new || exit
  adb -s "$adbDeviceId" shell mv /misc/current_boot_logo.bmp.gz /misc/boot_logo.bmp.gz || exit
fi

echo "# Updating cfw"
if [ ! "$resetCfg" = true ]; then
  adb -s "$adbDeviceId" shell cp -v /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/current_retroarch.cfg || exit
  adb -s "$adbDeviceId" shell cp -rv /mnt/mmc/CFW/retroarch/.retroarch/assets /mnt/mmc/CFW/retroarch/.retroarch/current_assets || exit
  adb -s "$adbDeviceId" shell cp -rv /mnt/mmc/CFW/skin /mnt/mmc/CFW/current_skin || exit
fi
adb -s "$adbDeviceId" push --sync roms/CFW /mnt/mmc/ || exit
if [ ! "$resetCfg" = true ]; then
  adb -s "$adbDeviceId" shell rm -r /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/retroarch/.retroarch/current_retroarch.cfg /mnt/mmc/CFW/retroarch/.retroarch/retroarch.cfg || exit
  adb -s "$adbDeviceId" shell rm -r /mnt/mmc/CFW/retroarch/.retroarch/assets.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/retroarch/.retroarch/assets /mnt/mmc/CFW/retroarch/.retroarch/assets.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/retroarch/.retroarch/current_assets /mnt/mmc/CFW/retroarch/.retroarch/assets || exit
  adb -s "$adbDeviceId" shell rm -r /mnt/mmc/CFW/skin.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/skin /mnt/mmc/CFW/skin.new || exit
  adb -s "$adbDeviceId" shell mv /mnt/mmc/CFW/current_skin /mnt/mmc/CFW/skin || exit
fi

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

adb -s "$adbDeviceId" reboot