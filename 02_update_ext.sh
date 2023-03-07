#!/bin/bash

echo "Start ext update"

source ./variables.sh

if ! [[ `mount | grep $extRomsDir` ]]; then
	mount $extRomsDir
	echo "$extRomsDir mounted"
fi

cd $workingDir
cp -Rv roms/Roms/* $extRomsDir
cp -Rv roms/BIOS $extRomsDir
cp -Rv roms/CFW $extRomsDir
cp -Rv "$extRomsDir/Saves" $extSaveDir

echo "\nEnd int update. You must now unmount $extRomsDir before ejecting it."