#!/bin/bash

tooltip="$(playerctl -a metadata album)"
text="$(playerctl -a metadata title) - $(playerctl -a metadata artist)"

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
