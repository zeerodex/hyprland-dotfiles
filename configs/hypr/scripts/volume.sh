#!/usr/bin/env sh

down() {
pamixer -d 5
volume=$(pamixer --get-volume)
[$volume -gt 0 ] && volume=`expr $volume`  
dunstify -a "VOLUME" "Decreasing to $volume%"  -i audio-volume-medium-symbolic -u normal -r 91190 -t 1000
canberra-gtk-play -i dialog-error -d "error"

}

up() {
pamixer -i 5
volume=$(pamixer --get-volume)
[ $volume -lt 100 ] && volume=`expr $volume`  
dunstify -a "VOLUME" "Increasing to $volume%" -i audio-volume-high-symbolic -u normal -r 91190 -t 1000
canberra-gtk-play -i dialog-error -d "error"
}

mute() {
muted="$(pamixer --get-mute)"
if $muted; then
  pamixer -u
  dunstify -a "VOLUME" "UNMUTED" -i audio-volume-high-symbolic -u normal -r 91190 -t 1000
else 
  pamixer -m
  dunstify -a "VOLUME" "MUTED" -i audio-volume-muted-symbolic -u normal -r 91190 -t 1000
fi
}

case "$1" in
  up) up;;
  down) down;;
  mute) mute;;
esac

