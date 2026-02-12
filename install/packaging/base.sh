#!/bin/bash

# This script installs many packages and can take a long time
export OMADEB_SCRIPT_TIMEOUT=1200  # 20 minutes

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMADEB_INSTALL/omadeb-base.packages" | grep -v '^$')
sudo apt install -y "${packages[@]}"
