#!/bin/bash

mkdir ~/Pictures/Wallpapers
cp -R ./black_pixel.png ~/Pictures/Wallpapers/
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.background picture-uri "file://$(realpath ~/Pictures/Wallpapers/black_pixel.png)"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$(realpath ~/Pictures/Wallpapers/black_pixel.png)"
gsettings set org.gnome.mutter workspaces-only-on-primary false

git config --global user.email "epangelias@gmail.com"
git config --global user.name "Epangelias"
git config --global credential.helper store

./custom_shortcuts.sh
./set_firefox_pref.sh