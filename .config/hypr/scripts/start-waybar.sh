#!/bin/bash

# Give services some time to start up
sleep 2

# Check if Waybar is already running (optional, but good practice)
if ! pgrep -x "waybar" > /dev/null; then
    waybar &
fi
