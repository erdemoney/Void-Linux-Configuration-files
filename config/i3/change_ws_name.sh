#!/bin/bash

name=$(rofi -config "~/.config/rofi/slprompt.rasi" -dmenu -p "New name")
#if new name isnt whitespace or empty then change name
if [[ $name = *[!\ ]* ]]; then
    WS=`python3 -c "import json; print(next(filter(lambda w: w['focused'], json.loads('$(i3-msg -t get_workspaces)')))['num'])"`; i3-msg "rename workspace to \"$WS: $name\""
fi
