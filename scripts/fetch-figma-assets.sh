#!/usr/bin/env bash
# ============================================================
# Haalt de hero-assets op van de Figma desktop asset-server.
#
# Vereisten:
#   • Figma desktop app is geopend met het Kelderman-bestand
#   • De Figma MCP / dev-server draait (localhost:3845)
#
# Gebruik:  bash scripts/fetch-figma-assets.sh
#
# LET OP: de asset-hashes hieronder rouleren wanneer Figma
# opnieuw start. Krijg je 404's, vraag dan in Claude Code om
# verse URL's op te halen via de Figma MCP (node-IDs staan in
# CLAUDE.md) en werk de hashes hieronder bij.
# ============================================================
set -euo pipefail

BASE="http://localhost:3845/assets"
OUT="$(cd "$(dirname "$0")/.." && pwd)/assets"
mkdir -p "$OUT"

declare -A ASSETS=(
  [logo.png]="4c0d9674144f071d5f6d40a227a340ac8cd0ef0d.png"
  [kwalitatiever.png]="85b824b96ec485235ed6dae5c708470951d443b5.png"
  [beter.png]="282a39fe9e6e4bd0e03cf6a5a9d30b6bdb221f7f.png"
  [duurzamer.png]="fed753a8308943351fc9e6b0802eae833ec05a0d.png"
  [sportiever.png]="8aabfa37ade7ff395da394d7f067656c882d681c.png"
  [mooier.png]="b14aeefab7a36cb5f40d11d294c4745e55966010.png"
)

fail=0
for name in "${!ASSETS[@]}"; do
  url="$BASE/${ASSETS[$name]}"
  echo "→ $name"
  if curl -sf --max-time 15 -o "$OUT/$name" "$url"; then
    size=$(wc -c < "$OUT/$name")
    if [ "$size" -lt 1000 ]; then
      echo "  ⚠ $name is verdacht klein ($size bytes) — mogelijk verlopen hash"
      fail=1
    else
      echo "  ✓ opgeslagen ($((size/1024)) kB)"
    fi
  else
    echo "  ✗ download mislukt: $url"
    fail=1
  fi
done

echo
if [ "$fail" -eq 0 ]; then
  echo "Alle assets staan in $OUT"
else
  cat <<'EOF'
Eén of meer assets konden niet worden opgehaald.
Controleer:
  1. Staat Figma desktop open met het Kelderman-bestand?
  2. Draait de MCP/dev-server? (localhost:3845 bereikbaar)
  3. Hashes verlopen? → vraag Claude Code om verse asset-URL's
     via de Figma MCP (zie CLAUDE.md voor de node-IDs) en werk
     dit script bij.
EOF
  exit 1
fi
