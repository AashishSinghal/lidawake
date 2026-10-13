#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Lid Awake
# @raycast.mode silent
# @raycast.packageName Lid Awake
# @raycast.icon ☕️

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "on | off | status (blank = toggle)", "optional": true }

# Keeps the Mac awake with the lid closed, even on battery, via `pmset disablesleep`.
# Needs the sudoers rule installed by setup.sh.

PMSET=/usr/bin/pmset

is_on() { [ "$($PMSET -g | awk '/SleepDisabled/ {print $2}')" = "1" ]; }

set_state() {
  if ! sudo -n "$PMSET" -a disablesleep "$1" 2>/dev/null; then
    echo "Permission denied: run setup.sh once to install the sudoers rule" >&2
    exit 1
  fi
}

case "${1:-toggle}" in
  on)     set_state 1; echo "Lid awake: ON" ;;
  off)    set_state 0; echo "Lid awake: OFF" ;;
  status) is_on && echo "Lid awake: ON" || echo "Lid awake: OFF" ;;
  toggle) if is_on; then set_state 0; echo "Lid awake: OFF"; else set_state 1; echo "Lid awake: ON"; fi ;;
  *)      echo "Usage: $0 [on|off|toggle|status]" >&2; exit 2 ;;
esac
