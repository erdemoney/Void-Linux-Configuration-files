# Auto start x server
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    # Start rootless X redirecting output to log file
    startx -- -keeptty &> ~/.xorg.log
fi
