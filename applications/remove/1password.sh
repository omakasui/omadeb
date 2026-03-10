#!/bin/bash

sudo rm /etc/apt/sources.list.d/1password.list
sudo rm /usr/share/keyrings/1password-archive-keyring.gpg
omadeb-pkg-drop 1password 1password-cli
