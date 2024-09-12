#!/bin/bash

# Ensure RFKill keys are set
gsettings set org.gnome.settings-daemon.plugins.media-keys rfkill-static "['XF86UWB', 'XF86RFKill']"

# Install inotify-tools (for monitoring backlight changes)
sudo pacman -S --noconfirm inotify-tools

# Clone the Zenbook Duo 2024 UX8406MA Linux repository
git clone https://github.com/alesya-h/zenbook-duo-2024-ux8406ma-linux.git

# Copy the duo script to /usr/local/bin
cd zenbook-duo-2024-ux8406ma-linux
sudo cp duo /usr/local/bin
cd ..
rm -rf zenbook-duo-2024-ux8406ma-linux

DUO_PATH="/usr/local/bin/duo"

# Create the systemd service for brightness sync
echo "[Service]
Description=Sync Brightness of Duo Screens
After=network.target
StartLimitIntervalSec=0
Type=simple
Restart=always
RestartSec=1
ExecStart=$DUO_PATH watch-backlight

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/duo-brightness-sync.service > /dev/null

# Create the systemd service for battery limit
echo "[Service]
Description=Limit Battery Charge
After=network.target
StartLimitIntervalSec=0
Type=simple
Restart=always
RestartSec=1
ExecStart=$DUO_PATH bat-limit 80

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/duo-battery-limit.service > /dev/null

$DUO_PATH set-tablet-mapping

# Reload systemd to recognize the new services
sudo systemctl daemon-reload

# Enable and start the brightness sync service
sudo systemctl enable duo-brightness-sync.service
sudo systemctl start duo-brightness-sync.service

# Enable and start the battery limit service
sudo systemctl enable duo-battery-limit.service
sudo systemctl start duo-battery-limit.service

echo "Installation completed successfully!"

