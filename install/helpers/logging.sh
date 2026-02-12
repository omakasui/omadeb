start_install_log() {
  sudo touch "$OMADEB_INSTALL_LOG_FILE"
  sudo chmod 666 "$OMADEB_INSTALL_LOG_FILE"

  export OMADEB_START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
  echo "=== $OMADEB_BRAND Installation Started: $OMADEB_START_TIME ===" >>"$OMADEB_INSTALL_LOG_FILE"
}

stop_install_log() {
  if [[ -n ${OMADEB_INSTALL_LOG_FILE:-} && -n ${OMADEB_START_TIME:-} ]]; then
    local end_time mins secs
    end_time=$(date '+%Y-%m-%d %H:%M:%S')

    local start_epoch end_epoch duration
    start_epoch=$(date -d "$OMADEB_START_TIME" +%s)
    end_epoch=$(date -d "$end_time" +%s)
    duration=$((end_epoch - start_epoch))
    mins=$((duration / 60))
    secs=$((duration % 60))

    {
      echo "=== $OMADEB_BRAND Installation Completed: $end_time ==="
      echo ""
      echo "=== Installation Time Summary ==="
      echo "$OMADEB_BRAND: ${mins}m ${secs}s"
      echo "================================="
    } >>"$OMADEB_INSTALL_LOG_FILE"
  fi
}

# Run a script with output visible on terminal and appended to the log file.
run_logged() {
  local script="$1"
  local script_name
  script_name=$(basename "$script" .sh)
  export CURRENT_SCRIPT="$script"

  # Pick up any PATH updates
  if [[ -f "$HOME/.local/state/omadeb/.env_update" ]]; then
    source "$HOME/.local/state/omadeb/.env_update"
  fi

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting: $script_name" | tee -a "$OMADEB_INSTALL_LOG_FILE"

  headline "Running: $script_name"

  # Run the script — output goes to both terminal and log via tee.
  # pipefail ensures the exit code from bash propagates through the pipe.
  bash "$script" 2>&1 | tee -a "$OMADEB_INSTALL_LOG_FILE"

  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed: $script_name" | tee -a "$OMADEB_INSTALL_LOG_FILE"

  unset CURRENT_SCRIPT
}