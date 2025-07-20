#!/usr/bin/env sh

pid=$(pidof waybar)
if [[ $pid ]]; then
  kill $pid
else
  waybar &
fi
