#!/bin/bash

# Setup user theme folder
if [[ -d ~/.config/omadeb/themes ]]; then
  rm -rf ~/.config/omadeb/themes
fi
mkdir -p ~/.config/omadeb/themes

# Set initial theme
omadeb-theme-set "Tokyo Night"

# Set specific app links for current theme
ln -snf ~/.config/omadeb/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omadeb/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/zellij/themes
ln -snf ~/.config/omadeb/current/theme/zellij.kdl ~/.config/zellij/themes/current.kdl