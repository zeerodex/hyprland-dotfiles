#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check for stow conflicts
check_stow_conflicts() {
    STOW_DIRS=("$@")
    CONFLICTS=()
    for dir in "${STOW_DIRS[@]}"; do
        # Check for common config locations
        if [ -d "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
            CONFLICTS+=("$HOME/.config/$dir")
        fi
        if [ -d "$HOME/.$dir" ] && [ ! -L "$HOME/.$dir" ]; then
            CONFLICTS+=("$HOME/.$dir")
        fi
    done

    if [ ${#CONFLICTS[@]} -ne 0 ]; then
        echo "WARNING: The following directories may conflict with GNU Stow:"
        for conflict in "${CONFLICTS[@]}"; do
            echo "  - $conflict"
        done
        echo "Please back them up and remove them if you want to use the managed dotfiles."
        read -p "Do you want to continue with stowing? (y/N): " choice
        if [[ ! "$choice" =~ ^[yY]$ ]]; then
            echo "Skipping stow operation."
            return 1
        fi
    fi
    return 0
}

# --- Check for dependencies ---
echo "--- Checking for dependencies ---"
missing_deps=false
if ! command_exists stow; then
    echo "ERROR: stow is not installed. Please install it first."
    missing_deps=true
fi

if ! command_exists yay; then
    echo "ERROR: yay is not installed. Please install it first."
    missing_deps=true
fi

if [ "$missing_deps" = true ]; then
    exit 1
fi
echo "--- All dependencies are installed ---"
echo

# --- Stow ---
echo "--- Syncing dotfiles with stow ---"
PUBLIC_STOW_DIRS=(gtk hypr kitty Kvantum mako qt rofi swappy waybar zathura)
if check_stow_conflicts "${PUBLIC_STOW_DIRS[@]}"; then
    stow "${PUBLIC_STOW_DIRS[@]}"
    echo "--- Dotfiles synced ---"
else
    echo "--- Dotfiles sync skipped ---"
fi
echo

# --- Packages ---
read -p "Do you want to install essential packages from pkgs-essential.txt? (y/N): " choice
if [[ "$choice" =~ ^[yY]$ ]]; then
    echo "--- Installing essential packages ---"
    yay -S --needed --noconfirm - < pkgs-essential.txt
    echo "--- Essential packages installed ---"
else
    echo "--- Skipping essential package installation ---"
fi
echo

echo "--- Installation complete! ---"
