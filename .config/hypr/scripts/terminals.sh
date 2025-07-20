#!/bin/bash

NUM_TERMINALS="${1:-1}" # Default to 3 terminals if not specified
TERM_DIR="$HOME/go/src/github.com/zeerodex/goot/"

# Open the specified number of terminals
for ((i = 1; i <= NUM_TERMINALS; i++)); do
  kitty --directory="$TERM_DIR" &
done
