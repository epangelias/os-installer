#!/bin/bash

gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.desktop.background picture-uri "file://$(realpath ./black_pixel.png)"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$(realpath ./black_pixel.png)"
gsettings set org.gnome.mutter workspaces-only-on-primary false
