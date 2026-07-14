#!/bin/sh
# offsend-managed-ai-hook v1
set -eu
ADAPTER="${1:?adapter required}"
POLICY="${2:-advise}"
PREFERRED_BIN=/opt/homebrew/bin/offsend
OFFSEND_BIN=""
if [ -x "${PREFERRED_BIN}" ]; then
  OFFSEND_BIN="${PREFERRED_BIN}"
fi
if [ -z "${OFFSEND_BIN}" ]; then
  OFFSEND_BIN="$(command -v offsend 2>/dev/null || true)"
fi
if [ -z "${OFFSEND_BIN}" ] || [ ! -x "${OFFSEND_BIN}" ]; then
  echo "offsend: executable not found; install CLI or re-run hook install" >&2
  case "$ADAPTER" in
    cursor) echo '{"continue":true}' ;;
    claude|codex) echo '{}' ;;
    windsurf) : ;;
  esac
  exit 0
fi
exec "${OFFSEND_BIN}" check --adapter "${ADAPTER}" --hook-policy "${POLICY}" --secrets-only --no-notify