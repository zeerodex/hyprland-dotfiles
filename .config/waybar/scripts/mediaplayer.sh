#!/usr/bin/env bash

# A simple script to get media player information for Waybar
# using playerctl.

player_status=$(playerctl status 2>/dev/null)

if [ "$player_status" = "Playing" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Playing"}'
elif [ "$player_status" = "Paused" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    echo '{"text": "'"$artist - $title"'", "class": "custom-media", "alt": "Paused"}'
else
    # Output nothing if no player is active
    echo ""
fi
