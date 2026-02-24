#!/bin/bash

# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMADEB_INSTALL/omadeb-base.packages" | grep -v '^$')
omadeb-pkg-add "${packages[@]}"
