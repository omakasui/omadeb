# Track if we're already handling an error to prevent double-trapping
ERROR_HANDLING=false

# Drain pending terminal responses (OSC 11, CPR, etc.) left by gum
drain_terminal() {
  if [[ -t 0 ]]; then
    stty -echo 2>/dev/null || true
    while read -r -t 0.3 -n 1024 2>/dev/null; do :; done
    stty echo 2>/dev/null || true
  fi
  stty sane 2>/dev/null || true
}

# Error handler - shows error info and options to retry or view log
catch_errors() {
  local exit_code=$?

  if [[ $ERROR_HANDLING == true ]]; then
    return
  fi
  ERROR_HANDLING=true

  set +eE

  drain_terminal

  echo
  clear_logo
  gum style --foreground 1 "$OMADEB_BRAND installation stopped!"

  if [[ -n ${CURRENT_SCRIPT:-} ]]; then
    gum style "Failed script: $CURRENT_SCRIPT (exit code $exit_code)"
  else
    gum style "Failed command: $BASH_COMMAND (exit code $exit_code)"
  fi

  echo

  # Show last lines from the log for quick context
  if [[ -f ${OMADEB_INSTALL_LOG_FILE:-} ]]; then
    echo "Recent log output:"
    tail -10 "$OMADEB_INSTALL_LOG_FILE" | sed 's/\x1b\[[0-9;]*m//g' | while IFS= read -r line; do
      echo "  $line"
    done
    echo
  fi

  # Options menu — loops until user retries or exits
  while true; do
    local choice
    choice=$(gum choose \
      "Retry installation" \
      "View full log" \
      "Exit" \
      --header "What would you like to do?" --height 6) || choice=""

    case "$choice" in
    "Retry installation")
      printf "\033[H\033[2J"
      exec bash ${OMADEB_RETRY_CMD:-~/.local/share/omadeb/install.sh}
      ;;
    "View full log")
      less "$OMADEB_INSTALL_LOG_FILE" 2>/dev/null || tail -50 "$OMADEB_INSTALL_LOG_FILE"
      ;;
    *)
      exit 1
      ;;
    esac
  done
}

# Exit handler — cleanup on any exit
exit_handler() {
  local exit_code=$?

  if [[ $exit_code -ne 0 && $ERROR_HANDLING != true ]]; then
    catch_errors
  fi
}

# Set up traps
trap catch_errors ERR
trap 'exit 130' INT TERM # Handle Ctrl+C and termination gracefully
trap exit_handler EXIT
