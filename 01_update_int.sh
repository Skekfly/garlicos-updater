#!/bin/bash

echo "Start int update"

source ./variables.sh

mkdir -p $workingDir
cd $workingDir
wget -O garlicOS.7z $garlicOsDownloadPath
7z x garlicOS.7z
cp -Rv misc/* $intMiscDir
cp -Rv roms/Roms/* $intRomsDir
cp -Rv roms/BIOS $intRomsDir
cp -Rv roms/CFW $intRomsDir

echo "\nEnd int update. You must now unmount $intMiscDir and $intRomsDir before ejecting them."
