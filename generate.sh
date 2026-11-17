#!/usr/bin/env bash
set -euo pipefail
: "${PENPOT_MCP_URL:?}"
: "${PENPOT_USER_TOKEN:?}"

file=.rulesync/mcp.jsonc
backup=$(mktemp)
cp "$file" "$backup"
restore() {
  cp "$backup" "$file"
  rm -f "$backup"
}
trap restore EXIT

sed -i \
  -e "s|\${PENPOT_MCP_URL}|${PENPOT_MCP_URL}|g" \
  -e "s|\${PENPOT_USER_TOKEN}|${PENPOT_USER_TOKEN}|g" \
  "$file"

rulesync install

rulesync generate
