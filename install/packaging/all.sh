#!/bin/bash

run_logged $OMADEB_INSTALL/packaging/base.sh
run_logged $OMADEB_INSTALL/packaging/remove-snap.sh
run_logged $OMADEB_INSTALL/packaging/pipx.sh
run_logged $OMADEB_INSTALL/packaging/fonts.sh
run_logged $OMADEB_INSTALL/packaging/nvim.sh
run_logged $OMADEB_INSTALL/packaging/tools.sh
run_logged $OMADEB_INSTALL/packaging/icons.sh
run_logged $OMADEB_INSTALL/packaging/apps.sh
run_logged $OMADEB_INSTALL/packaging/webapps.sh
run_logged $OMADEB_INSTALL/packaging/tuis.sh

