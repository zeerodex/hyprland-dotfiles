#!/usr/bin/env sh
rofi=~/.config/rofi/launchers/type-7/style-2.rasi

rofi -modi clipboard:~/.config/hypr/scripts/cliphist-rofi-img -theme ${rofi} -show clipboard
