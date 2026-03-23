echo "Update alacritty configs"
omadeb-refresh-config alacritty/alacritty.toml

if omadeb-cmd-present zellij; then
  echo "Setting up omadeb-zellij configuration"
  if omadeb-pkg-present omakasui-zellij; then
    omadeb-pkg-drop omakasui-zellij
  fi
  omadeb-pkg-add zellij omadeb-zellij
  # Set up the configuration for zellij
  omadeb-zellij-setup
fi