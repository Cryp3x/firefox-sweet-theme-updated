#!/bin/bash
set -euo pipefail

THEMEDIR="$(cd "$(dirname "$0")" && cd .. && pwd)"
FIREFOXFOLDER="${HOME}/.mozilla/firefox"
PROFILENAME=""
GNOMISHEXTRAS=false

while getopts 'f:p:gh' flag; do
  case "${flag}" in
    f) FIREFOXFOLDER="${OPTARG}" ;;
    p) PROFILENAME="${OPTARG}" ;;
    g) GNOMISHEXTRAS=true ;;
    h|*) echo "Usage: $0 [-f firefox_folder] [-p profile_name] [-g]" >&2; exit 1 ;;
  esac
done

# Resolve profile directory properly
if [ -z "$PROFILENAME" ]; then
  # Auto-detect the one and only profile if unambiguous, otherwise fail loudly
  PROFILECANDIDATES=("$FIREFOXFOLDER"/*.default*)
  if [ ${#PROFILECANDIDATES[@]} -eq 1 ] && [ -d "${PROFILECANDIDATES[0]}" ]; then
    PROFILEDIR="${PROFILECANDIDATES[0]}"
  else
    echo "Error: Multiple or zero profiles found. Use -p to specify exact profile folder name." >&2
    ls -1 "$FIREFOXFOLDER" | grep -E '\.default' >&2
    exit 1
  fi
else
  PROFILEDIR="$FIREFOXFOLDER/$PROFILENAME"
fi

if [ ! -d "$PROFILEDIR" ]; then
  echo "Error: Profile directory not found: $PROFILEDIR" >&2
  exit 1
fi

echo "Target profile: $PROFILEDIR"
cd "$PROFILEDIR"

# Create chrome folder
mkdir -p chrome
cd chrome

# Copy theme (overwrite old one cleanly)
rm -rf firefox-sweet-theme 2>/dev/null || true
cp -R "$THEMEDIR" firefox-sweet-theme
echo "Theme copied to $PWD/firefox-sweet-theme"

# userChrome.css – ensure single @import at the top
cat > userChrome.css <<<'@import "firefox-sweet-theme/userChrome.css";'

# customChrome.css for GNOMISH extras (optional)
if [ "$GNOMISHEXTRAS" = true ]; then
  echo "Enabling GNOMISH extras"
  cat > customChrome.css <<<'@import "firefox-sweet-theme/customChrome.css";'
fi

# user.js symlink – absolute path so it never breaks
ln -sf "$PROFILEDIR/chrome/firefox-sweet-theme/configuration/user.js" "$PROFILEDIR/user.js"

echo "Done."
echo "Restart Firefox completely (no tabs restored) for changes to take effect."