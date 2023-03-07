#!/bin/bash

echo "Start ext update"

source ./variables.sh

cd $workingDir
cp -Rv roms/Roms/* $extRomsDir
cp -Rv roms/BIOS $extRomsDir
cp -Rv roms/CFW $extRomsDir
cp -Rv "$extRomsDir/Saves" $extSaveDir

echo "End ext update. You must now unmount $extRomsDir before ejecting it."
