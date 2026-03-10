#!/bin/bash

# Install Alacritty
source ~/.local/share/omadeb/applications/install/alacritty.sh

# Install Fastfetch
cd /tmp
wget -O fastfetch.deb "https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb"
sudo dpkg -i fastfetch.deb
sudo apt install -f -y
rm fastfetch.deb
cd -

# Install mise
source ~/.local/share/omadeb/applications/install/mise.sh

# Install Zellij
source ~/.local/share/omadeb/applications/install/zellij.sh

# Install Docker
source ~/.local/share/omadeb/applications/install/docker.sh

# Install GitHub CLI
source ~/.local/share/omadeb/applications/install/github-cli.sh

# Install Starship
source ~/.local/share/omadeb/applications/install/starship.sh