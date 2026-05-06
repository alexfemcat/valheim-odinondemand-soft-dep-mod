#!/usr/bin/env bash
set -euo pipefail

# Builds OdinOnDemand client mod-only package
# For players who already have BepInEx, Jotunn, and JsonDotNet installed
# Just the OOD mod files + dependencies

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$REPO_ROOT/plugin"
RELEASE_DIR="$PLUGIN_DIR/bin/Release"

STAGE_DIR="$REPO_ROOT/dist/staging-client-minimal"
OUT_DIR="$REPO_ROOT/dist"
ZIP_NAME="OdinOnDemand-Mod-Only.zip"

echo "=== Building OdinOnDemand (Release) ==="
cd "$PLUGIN_DIR"
dotnet build -c Release > /dev/null
echo "Build complete."

echo "=== Staging mod-only package ==="
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/plugins/Valmedia-OdinOnDemand"

# OdinOnDemand mod files (DLLs, asset bundle, configs, yt-dlp)
cp "$RELEASE_DIR"/*.dll "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR"/*.json "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR/videoplayers" "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"

# yt-dlp for YouTube support
if [ -f "$PLUGIN_DIR/Assets/yt-dlp.exe" ]; then
  cp "$PLUGIN_DIR/Assets/yt-dlp.exe" "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
else
  echo "WARNING: yt-dlp.exe not found, YouTube won't work"
fi

# Drop install README inside the zip
cat > "$STAGE_DIR/plugins/README-MOD-ONLY-INSTALL.txt" <<'EOF'
OdinOnDemand Mod-Only Bundle - Installation
============================================

This bundle contains ONLY the OdinOnDemand mod and its dependencies.
Use this if you already have BepInEx, JotunnLib, and JsonDotNET installed.

PREREQUISITE
Before installing this mod, ensure you have:
  ✓ BepInEx 5.4+ installed
  ✓ JotunnLib 2.27+ installed
  ✓ JsonDotNET installed

STEP 1: Extract Mod Folder
Extract the "plugins/Valmedia-OdinOnDemand" folder into your BepInEx/plugins/ folder.

For r2modman users:
  ~/.config/r2modmanPlus-local/Valheim/profiles/<YourProfile>/BepInEx/plugins/

For vanilla BepInEx:
  <Valheim install>/BepInEx/plugins/

STEP 2: Verify Files
Make sure you have these files in BepInEx/plugins/Valmedia-OdinOnDemand/:
  ✓ OdinOnDemand.dll
  ✓ YoutubeDLSharp.dll
  ✓ YoutubeExplode.dll
  ✓ SoundCloudExplode.dll
  ✓ System.ValueTuple.dll
  ✓ yt-dlp.exe (for YouTube support)
  ✓ videoplayers (asset bundle, no extension)
  ✓ default.json
  ✓ default_items.json

STEP 3: Launch Valheim
Launch Valheim. OOD pieces appear under Hammer → Furniture → OOD.

IN-GAME
  - Craft Remote Control with 1 Bronze
  - Use Remote Control to interact with media players
  - Boomboxes, TVs, and other media devices play YouTube, SoundCloud, and local files

TROUBLESHOOTING
  - If pieces don't appear: restart the game
  - If YouTube won't play: verify yt-dlp.exe is in the same folder as OdinOnDemand.dll
  - Check BepInEx logs for errors: BepInEx/LogOutput.log
EOF

echo "=== Creating zip ==="
mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR/$ZIP_NAME"
cd "$STAGE_DIR"
zip -r -q "$OUT_DIR/$ZIP_NAME" plugins 2>/dev/null || zip -r -q "$OUT_DIR/$ZIP_NAME" plugins

echo "=== Cleaning up ==="
rm -rf "$STAGE_DIR"

echo ""
echo "Done! Mod-Only Bundle: $OUT_DIR/$ZIP_NAME"
ls -lh "$OUT_DIR/$ZIP_NAME"
