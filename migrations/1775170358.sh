echo 'Prevent conflicts with Super+Escape, which we use for the system menu'
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts "['<Shift><Super>Escape']"