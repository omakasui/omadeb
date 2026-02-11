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
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

# Install Zellij
source ~/.local/share/omadeb/applications/install/zellij.sh

# Install Docker
source ~/.local/share/omadeb/applications/install/docker.sh

# Install LazyDocker
source ~/.local/share/omadeb/applications/install/lazydocker.sh

# Install GitHub CLI
source ~/.local/share/omadeb/applications/install/github-cli.sh

# Install LazyGit
source ~/.local/share/omadeb/applications/install/lazygit.sh

# Install Starship
source ~/.local/share/omadeb/applications/install/starship.sh