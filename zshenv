# Append ~/.bin and all subdirectories to path
if [ -d ~/.bin ]; then
    export PATH=$PATH:/home/eric/.bin/:/home/eric/.local/bin
    for i in $( find ~/.bin -type d ); do
        export PATH=$PATH:$i
    done
fi

# Set window manager variable
export WM="spectrwm"

# Set wallpaper path variable
export WALLPAPER_PATH="/home/eric/Photos/wallpapers/wallpaper.png"

# Set locker
export LOCKER="betterlockscreen -l"

# Set snclirc path
export SNCLIRC=/home/eric/.config/sncli/snclirc

# Turn off ..
export ENHANCD_DISABLE_DOT=1

# Set var for bluez-alsa
export LIBASOUND_THREAD_SAFE=0
