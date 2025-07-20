#!/usr/bin/env sh
rofi=~/.config/rofi/launchers/type-4/style-4.rasi

rofi -modi clipboard:~/.config/hypr/scripts/cliphist-rofi-img -theme ${rofi} -show clipboard
