#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lid Awake Status
# @raycast.mode inline
# @raycast.refreshTime 10s
# @raycast.packageName Lid Awake
# @raycast.icon ☕️

# Read-only: shows the current state in the Raycast root search. Never changes anything.

if [ "$(/usr/bin/pmset -g | awk '/SleepDisabled/ {print $2}')" = "1" ]; then
  echo "ON · stays awake with lid closed"
else
  echo "OFF · normal sleep"
fi
