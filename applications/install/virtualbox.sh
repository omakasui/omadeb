#!/bin/bash

# Virtualbox allows you to run VMs for other flavors of Linux or even Windows

sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers ${USER}
