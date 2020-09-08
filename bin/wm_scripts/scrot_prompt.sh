#!/bin/bash

### config ###
screenshot_dir="/home/eric/Photos/screenshots"
image_viewer="sxiv"

mkdir -p $screenshot_dir
file_path="${screenshot_dir}/$(rofi -config '~/.config/rofi/slprompt.rasi' -dmenu -p 'Screenshot name').png"

sleep 1
if [ "$1" = "-w" ]; then
    name=$(scrot -z -u $file_path -e 'echo $f')
else
    name=$(scrot -z $file_path -e 'echo $f')
fi

$image_viewer "$name"
