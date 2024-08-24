#!/bin/bash

echo "Updating the system..."
sudo pacman -Syu --noconfirm

# Install packages
echo "Installing packages..."
sudo pacman -S --noconfirm vim geary # libreoffice-fresh inkscape

# Install AUR packages
echo "Installing AUR packages..."
sudo pamac build visual-studio-code-bin --no-confirm

# Install Firefox GNOME theme
echo "Installing Firefox GNOME theme..."
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh | bash
./set_firefox_pref.sh

# Install ollama
echo "Installing ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Install deno
echo "Installing deno..."
curl -fsSL https://deno.land/install.sh | sh
DENO_PATH="export DENO_INSTALL=\"$HOME/.deno\""
PATH_LINE='export PATH="$DENO_INSTALL/bin:$PATH"'
grep -qxF "$DENO_PATH" "$FILE" || echo "$DENO_PATH" >> "$FILE"
grep -qxF "$PATH_LINE" "$FILE" || echo "$PATH_LINE" >> "$FILE"

# Install printer service
sudo -u $USER pamac install --no-confirm manjaro-printer
sudo gpasswd -a $USER sys
sudo -u $USER pamac install --no-confirm hplip-plugin avahi system-config-printer

echo "\n\nAll packages installed and unwanted packages removed."
