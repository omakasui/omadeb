#!/bin/bash

# Setup user theme folder
if [ -d ~/.config/omadeb/themes ]; then
  rm -rf ~/.config/omadeb/themes
fi
mkdir -p ~/.config/omadeb/themes

# Set initial theme
omadeb-theme-set "Tokyo Night"

# Set gnome theme colors
OMADEB_THEME_COLOR=$(<~/.config/omadeb/current/theme/gnome.theme)

gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface cursor-theme "Yaru"
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-$OMADEB_THEME_COLOR-dark"
gsettings set org.gnome.desktop.interface icon-theme "$(<~/.config/omadeb/current/theme/icons.theme)"
gsettings set org.gnome.desktop.interface accent-color "$OMADEB_THEME_COLOR" 2>/dev/null || true

# Change gnome extensions theme
gsettings set org.gnome.shell.extensions.tophat meter-fg-color "$(<~/.config/omadeb/current/theme/tophat.theme)"

# Update GNOME background settings
gsettings set org.gnome.desktop.background picture-uri "$HOME/.config/omadeb/current/background"
gsettings set org.gnome.desktop.background picture-uri-dark "$HOME/.config/omadeb/current/background"
gsettings set org.gnome.desktop.background picture-options 'zoom'

# Set specific app links for current theme
ln -snf ~/.config/omadeb/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omadeb/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/zellij/themes
ln -snf ~/.config/omadeb/current/theme/zellij.kdl ~/.config/zellij/themes/current.kdl