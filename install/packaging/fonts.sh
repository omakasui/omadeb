#!/bin/bash

mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

wget https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip -O fonts-ubuntu.zip
unzip fonts-ubuntu.zip -d fonts-ubuntu
cp fonts-ubuntu*.ttf ~/.local/share/fonts
rm -rf fonts-ubuntu.zip fonts-ubuntu

fc-cache
cd -