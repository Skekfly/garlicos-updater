#!/bin/bash

echo "Start int update"

source ./variables.sh

if ! [[ `mount | grep $intMiscDir` ]]; then
	mount $intMiscDir
	echo "$intMiscDir mounted"
fi
if ! [[ `mount | grep $intRomsDir` ]]; then
	mount $intRomsDir
	echo "$intRomsDir mounted"
fi

mkdir -p $workingDir
cd $workingDir
wget -O garlicOS.7z $garlicOsDownloadPath
7z x garlicOS.7z
cp -Rv misc/* $intMiscDir
cp -Rv roms/Roms/* $intRomsDir
cp -Rv roms/BIOS $intRomsDir
cp -Rv roms/CFW $intRomsDir

echo "\nEnd int update. You must now unmount $intMiscDir and $intRomsDir before ejecting them."