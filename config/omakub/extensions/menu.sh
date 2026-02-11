#! /bin/bash

# Overwrite parts of the omadeb-menu with user-specific submenus.
# See $OMADEB_PATH/bin/omadeb-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Omadeb changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) omadeb-lock-screen ;;
#   *Shutdown*) omadeb-cmd-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }