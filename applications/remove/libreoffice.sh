#!/bin/bash

omadeb-pkg-drop "libreoffice*"
sudo apt -y clean
sudo apt -y autoremove