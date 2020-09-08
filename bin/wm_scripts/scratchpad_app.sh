#/bin/bash

windowname="$1"
desk=`wmctrl -d | grep '*' | cut -d ' ' -f '1'`
scratch_desk=`wmctrl -l | grep $windowname | cut -d ' ' -f '3'`

xprop -name "$windowname"

if [ $? -eq 0 ]; then
    if [ $desk -eq $scratch_desk ]; then
        wmctrl -r $windowname -t $desk
        wmctrl -r $windowname -b toggle,hidden
    else
        wmctrl -R $windowname
        wmctrl -r $windowname -b remove,hidden
    fi
else
    kitty --title $windowname "$2"
    wmctrl -r $windowname -e 0,0,0,"$3","$4"
fi
