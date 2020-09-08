#!/bin/bash
if [ "$1" = "-w" ]; then
    tmp_name=$(scrot -z -u /tmp/tmp.png -e 'echo $f')
else
    tmp_name=$(scrot -z /tmp/tmp.png -e 'echo $f')
fi
file_name=$(rofi -config '~/.config/rofi/slprompt.rasi' -dmenu -p 'Screenshot name')
mv $tmp_name ~/Photos/screenshots/${file_name}
sxiv ~/Photos/screenshots/${file_name}
