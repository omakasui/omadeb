#!/bin/bash

run_logged $OMADEB_INSTALL/config/config.sh
run_logged $OMADEB_INSTALL/config/git.sh
run_logged $OMADEB_INSTALL/config/branding.sh
run_logged $OMADEB_INSTALL/config/xcompose.sh
run_logged $OMADEB_INSTALL/config/mise-work.sh
run_logged $OMADEB_INSTALL/config/mimetypes.sh
run_logged $OMADEB_INSTALL/config/terminal.sh
run_logged $OMADEB_INSTALL/config/localdb.sh
run_logged $OMADEB_INSTALL/config/omadeb-ai-skill.sh
run_logged $OMADEB_INSTALL/config/hardware/fix-fkeys.sh
run_logged $OMADEB_INSTALL/config/hardware/fix-framework-text-scaling.sh
run_logged $OMADEB_INSTALL/config/gnome/app-grid.sh
run_logged $OMADEB_INSTALL/config/gnome/dock.sh
source $OMADEB_INSTALL/config/gnome/request-confirm.sh
run_logged $OMADEB_INSTALL/config/gnome/extensions.sh
run_logged $OMADEB_INSTALL/config/gnome/hotkeys.sh
run_logged $OMADEB_INSTALL/config/gnome/settings.sh
run_logged $OMADEB_INSTALL/config/theme.sh