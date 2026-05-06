#!/usr/bin/env bash
set -euo pipefail

# Builds OdinOnDemand and packages it + all dependencies into a single zip
# that players extract and drop into BepInEx/plugins/

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$REPO_ROOT/plugin"
RELEASE_DIR="$PLUGIN_DIR/bin/Release"
JOTUNN_SRC="/home/catosaur/Downloads/valheim-test-temp/ValheimModding-Jotunn-2.29.0/plugins"
JSONDOTNET_SRC="$HOME/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/ValheimModding-JsonDotNET"

STAGE_DIR="$REPO_ROOT/dist/staging"
OUT_DIR="$REPO_ROOT/dist"
ZIP_NAME="OdinOnDemand-Client-Bundle.zip"

echo "=== Building OdinOnDemand (Release) ==="
cd "$PLUGIN_DIR"
dotnet build -c Release > /dev/null
echo "Build complete."

echo "=== Staging package ==="
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/plugins/Valmedia-OdinOnDemand"
mkdir -p "$STAGE_DIR/plugins/ValheimModding-Jotunn"
mkdir -p "$STAGE_DIR/plugins/ValheimModding-JsonDotNET"

# OdinOnDemand mod files (DLLs, asset bundle)
cp "$RELEASE_DIR"/*.dll "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR/videoplayers" "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"

# yt-dlp for YouTube support
if [ -f "$PLUGIN_DIR/Assets/yt-dlp.exe" ]; then
  cp "$PLUGIN_DIR/Assets/yt-dlp.exe" "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
else
  echo "WARNING: yt-dlp.exe not found, YouTube won't work"
fi

# Jotunn dependency
if [ -d "$JOTUNN_SRC" ]; then
  cp "$JOTUNN_SRC"/Jotunn.dll "$STAGE_DIR/plugins/ValheimModding-Jotunn/"
else
  echo "ERROR: Jotunn source not found at $JOTUNN_SRC"
  exit 1
fi

# Newtonsoft.Json dependency
if [ -d "$JSONDOTNET_SRC" ]; then
  cp "$JSONDOTNET_SRC"/Newtonsoft.Json.dll "$STAGE_DIR/plugins/ValheimModding-JsonDotNET/"
  cp "$JSONDOTNET_SRC"/NewtonsoftJsonDetector.dll "$STAGE_DIR/plugins/ValheimModding-JsonDotNET/"
else
  echo "ERROR: JsonDotNET source not found at $JSONDOTNET_SRC"
  exit 1
fi

# Drop a quick install README inside the zip
cat > "$STAGE_DIR/plugins/README-INSTALL.txt" <<'EOF'
OdinOnDemand Client Bundle - Installation
==========================================

STEP 1: Copy plugin folders
Copy the contents of THIS folder (everything inside "plugins/")
into your BepInEx/plugins/ folder.

For r2modman users:
  ~/.config/r2modmanPlus-local/Valheim/profiles/<YourProfile>/BepInEx/plugins/

For vanilla BepInEx:
  <Valheim install>/BepInEx/plugins/

STEP 2: Place yt-dlp.exe
The Valmedia-OdinOnDemand folder contains yt-dlp.exe. This file MUST be
in the same folder as OdinOnDemand.dll for YouTube videos to work.

After copying, verify you have:
  BepInEx/plugins/Valmedia-OdinOnDemand/OdinOnDemand.dll
  BepInEx/plugins/Valmedia-OdinOnDemand/yt-dlp.exe
  BepInEx/plugins/Valmedia-OdinOnDemand/YoutubeDLSharp.dll
  BepInEx/plugins/Valmedia-OdinOnDemand/YoutubeExplode.dll
  BepInEx/plugins/Valmedia-OdinOnDemand/SoundCloudExplode.dll
  BepInEx/plugins/ValheimModding-Jotunn/Jotunn.dll
  BepInEx/plugins/ValheimModding-JsonDotNET/Newtonsoft.Json.dll

STEP 3: Launch Valheim
Launch Valheim. The OOD pieces appear under Hammer -> Furniture -> OOD.
Videos and music will play through your placed boomboxes and TVs.
EOF

echo "=== Creating zip ==="
mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR/$ZIP_NAME"
cd "$STAGE_DIR"
zip -r -q "$OUT_DIR/$ZIP_NAME" plugins README-INSTALL.txt 2>/dev/null || zip -r -q "$OUT_DIR/$ZIP_NAME" plugins

echo "=== Cleaning up ==="
rm -rf "$STAGE_DIR"

echo ""
echo "Done! Bundle: $OUT_DIR/$ZIP_NAME"
ls -lh "$OUT_DIR/$ZIP_NAME"
