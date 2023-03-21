#!/bin/bash

function adb_pull {
  files=$(adb shell du -a /mnt/SDCARD/Saves | sed 's/[0-9]*\t\/mnt\/SDCARD\/Saves//g')
  #echo "$files" | sed 's/[0-9]*\t\/mnt\/SDCARD\/Saves//g'

echo "" > foo
  while IFS= read -r file; do
    l=$(echo ${file} | sed 's/[^[:print:]]//')
    if ! grep -q "$l" local.files; then
      echo "$l" >> foo
    fi
  done < "$files"


  # $1 = from
  # $2 = to
  #adb shell ls "$1"
}
adb_pull "/a" "/b"