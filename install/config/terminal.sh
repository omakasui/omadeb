#!/bin/bash

# Force migrate alacritty config format in first run
alacritty migrate 2>/dev/null || true

# Remove existing xdg-terminals config files to avoid conflicts with new format
rm -f ~/.config/gnome-xdg-terminals.list