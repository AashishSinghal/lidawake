#!/bin/bash
# One-time setup: lets your user run `pmset -a disablesleep 0|1` without a password.
# Run with: sudo ./setup.sh
set -euo pipefail

[ "$(id -u)" -eq 0 ] || { echo "Run with sudo: sudo $0" >&2; exit 1; }

USER_NAME="${SUDO_USER:?run via sudo from your own account}"
FILE=/etc/sudoers.d/lid-awake
TMP=$(mktemp)

cat > "$TMP" <<EOF
$USER_NAME ALL=(root) NOPASSWD: /usr/bin/pmset -a disablesleep 0, /usr/bin/pmset -a disablesleep 1
EOF

visudo -cf "$TMP" >/dev/null   # refuse to install a broken sudoers file
install -m 0440 -o root -g wheel "$TMP" "$FILE"
rm -f "$TMP"
echo "Installed $FILE"
