#! /bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# enable tap to click on touchpad
xinput set-prop 'Synaptics TM3289-021' 'libinput Tapping Enabled' 1

# enable natural scrolling on touchpad
xinput set-prop 'Synaptics TM3289-021' "libinput Natural Scrolling Enabled" 1

# disable middle mouse button on trackpad
xinput set-prop 'Synaptics TM3289-021' 'libinput Middle Emulation Enabled' 1

# enable simultanious mouse and keyboard input
xinput set-prop 'Synaptics TM3289-021' 294 0

# map caps to escape
# setxkbmap -option caps:swapescape &

# load Xresources
# xrdb -load ~/.Xresources &

# set volume to 30% so you dont blast your ears out
amixer -q sset Master 30%

# start notification daemon
dunst &

# start low battery notification script
#          low battery threshold
bat_not.sh 25 &

# Start wifi notification script
# wifi_not.sh &

# Run update notification script
updates.sh &

# start music player daemon
mpd &

# hide mouse on inactivity
unclutter &

# start blue light filter
redshift &

# set wallpaper
xwallpaper --center $WALLPAPER_PATH

# start compositor
picom --experimental-backends -b

# configure monitors
autorandr --change

# configure locker
#          dim(s)  lock(s)
xset s     240     20

# Start auto locker
xss-lock -n ~/.bin/wm_scripts/dim-screen.sh -l lock.sh &

# exec window manager securely to prevent TTY access && start locker
exec dbus-launch --exit-with-session $WM
