#!/bin/bash

# Get metadata from playerctl
METADATA=$(playerctl -a metadata --format '{"playerName": "{{playerName}}", "artist": "{{artist}}", "title": "{{title}}", "album": "{{album}}", "text": "{{title}} - {{artist}}"}')

# Check if metadata is empty (no player running)
if [ -z "$METADATA" ]; then
    echo '{"text": "", "tooltip": "No player running"}'
else
    echo "$METADATA"
fi
