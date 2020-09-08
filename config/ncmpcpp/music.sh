#! /usr/bin/env bash

function launch_player() {
    kitty @ set-tab-title music
    kitty @ set-window-title cover
    kitty @ new-window --title ncmpcpp ncmpcpp
    kitty @ resize-window --increment 93
    change_cover
    export PS1=""
    exec sh
}

function change_cover() {
    kitty @ send-text \
        --match title:cover \
        "clear && kitty icat /tmp/cover.png \r"
    }

function extract_cover() {
    path="$1"
    border_color=#1fb1a4

    ffmpeg \
        -hide_banner \
        -loglevel 0 \
        -y \
        -i "$path" \
        -vf scale=400:-1 \
        -vf "scale=400:-1,pad=410:ow:(ow-iw)/2:(oh-ih)/2:${border_color}" \
        "/tmp/cover.png" > /dev/null 2>&1
    }

function replace_cover() {
    music_dir="$HOME/Music"
    temp_song="/tmp/current-song"

    cp "$music_dir/$(mpc --format %file% current)" "$temp_song"

    extract_cover "$temp_song"

    rm "$temp_song"
}

if [[ $1 == "extract" ]]; then
    replace_cover
    change_cover
else
    launch_player
fi
