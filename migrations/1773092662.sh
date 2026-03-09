echo "Nautilus now handles all terminals..."
omadeb-pkg-remove nautilus-extension-gnome-terminal
omadeb-pkg-add omakasui-nautilus-open-any-terminal

# Set the default terminal for the nautilus-open-any-terminal extension
DEFAULT_TERMINAL=$(omadeb-terminal-current)
DEFAULT_TERMINAL=${DEFAULT_TERMINAL,,}

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "${DEFAULT_TERMINAL}"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab true
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system
