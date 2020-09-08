#!/bin/bash

# Example locker script -- demonstrates how to use the --transfer-sleep-lock
# option with i3lock's forking mode to delay sleep until the screen is locked.

## CONFIGURATION ##############################################################

# Options to pass to i3lock
i3lock_options="-u"

# Run before starting the locker
pre_lock() {
    BGPATH=$(cut -d\' -f 2 -s ~/.fehbg)
    TMPBG=/tmp/lockscreen.png

    LOCK=$HOME/.config/i3/lock.png
    RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')

    # use ffmpeg to blur image for wallpaper
    ffmpeg -y -i $BGPATH -i $LOCK -filter_complex "boxblur=5:5,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet

    # pause music on lid close but not timeout lock
    if cat /proc/acpi/button/lid/LID/state | grep -v -c "state:      open"
    then
        mpc pause
    fi

    return
}

# Run after the locker exits
post_lock() {
    return
}

###############################################################################

pre_lock

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock -n -i $TMPBG $i3lock_options {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    i3lock -n -i $TMPBG $i3lock_options &
    wait
fi

post_lock
