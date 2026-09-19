#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

bash -n "$ROOT/bin/iptime-wol-api"
bash -n "$ROOT/install.sh"

# No real deployment identifiers or secrets may be tracked.
if grep -RInE 'ontwsn5|iptime\.org|100\.|192\.168\.|[0-9A-Fa-f]{2}([:-][0-9A-Fa-f]{2}){5}|home_server_agent|IPTIME_WOL_PASS=.*[^-]|Tailscale|tailscale|SSH' "$ROOT" --exclude='*.example' --exclude='test_static.sh' >/dev/null; then
  echo 'privacy or removed-feature scan failed' >&2
  exit 1
fi
OLD_NAME=$(printf 'home%s' '-server-power')
if grep -RInF "$OLD_NAME" "$ROOT" --exclude='*.example' --exclude='test_static.sh' >/dev/null; then
  echo 'old project name remains' >&2
  exit 1
fi

[[ -f "$ROOT/bin/iptime-wol-api" ]]
[[ ! -e "$ROOT/bin/iptime-wol" ]]
grep -q 'session/login' "$ROOT/bin/iptime-wol-api"
grep -q 'wol/show' "$ROOT/bin/iptime-wol-api"
grep -q 'wol/signal' "$ROOT/bin/iptime-wol-api"
grep -q 'chmod 600' "$ROOT/README.md"
grep -q 'iptime-wol-api' "$ROOT/README.md"

echo 'static tests passed'
