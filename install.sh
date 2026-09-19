#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BIN_DIR="${IPTIME_WOL_API_BIN_DIR:-$HOME/.local/bin}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/iptime-wol-api"

install -d -m 700 "$BIN_DIR" "$CONFIG_DIR"
install -m 700 "$ROOT/bin/iptime-wol-api" "$BIN_DIR/iptime-wol-api"

if [[ ! -e "$CONFIG_DIR/iptime.env" ]]; then
  install -m 600 "$ROOT/config/iptime.env.example" "$CONFIG_DIR/iptime.env"
  printf 'Created template: %s\n' "$CONFIG_DIR/iptime.env"
  printf 'Edit it with real values, then run: chmod 600 %s\n' "$CONFIG_DIR/iptime.env"
else
  printf 'Keeping existing config: %s\n' "$CONFIG_DIR/iptime.env"
fi

printf 'Installed command: %s\n' "$BIN_DIR/iptime-wol-api"
