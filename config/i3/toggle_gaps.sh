#!/bin/sh

if [ `i3-msg -t get_tree | grep -Po '.*\\"gaps\\":{\\"inner\\":\K(-|)[0-9]+(?=.*\\"focused\\":true)'` -eq 0 ]; then
        i3-msg gaps inner current set 0;
        i3-msg gaps outer current set 0;
    else
        i3-msg gaps inner current set 24;
        i3-msg gaps outer current set 16;
    fi
