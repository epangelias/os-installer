#!/bin/bash

# Function to add a custom keybinding
add_custom_keybinding() {
    local name=$1
    local command=$2
    local binding=$3
    local index=$4

    local keybinding_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${index}/"

    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${keybinding_path} name "${name}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${keybinding_path} command "${command}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${keybinding_path} binding "${binding}"
}

# Get the current list of custom keybindings
current_keybindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Remove the leading and trailing brackets and quotes
current_keybindings=${current_keybindings:1:-1}
current_keybindings=${current_keybindings//\'/}

# Add new keybindings to the list
new_keybindings="${current_keybindings}, '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/'"

# Remove leading comma if current_keybindings was empty
new_keybindings=${new_keybindings#, }

# Set the new list of custom keybindings
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[${new_keybindings}]"

# Add the custom keybindings
add_custom_keybinding "Open Terminal" "gnome-terminal" "<Control><Alt>T" 0
add_custom_keybinding "Open Firefox" "firefox --new-window" "<Control><Alt>F" 1
add_custom_keybinding "Open Nautilus" "nautilus --new-window" "<Control><Alt>H" 2

echo "Custom keyboard shortcuts have been set."
