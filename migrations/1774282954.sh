echo "Update alacritty configs"
omadeb-refresh-config alacritty/alacritty.toml

echo "Setting up omadeb-zellij configuration"
omadeb-pkg-add omadeb-zellij
omadeb-setup-zellij