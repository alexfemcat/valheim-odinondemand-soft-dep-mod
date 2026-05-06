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

# OdinOnDemand mod files (DLLs, asset bundle, configs)
cp "$RELEASE_DIR"/*.dll "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR"/*.json "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR/videoplayers" "$STAGE_DIR/plugins/Valmedia-OdinOnDemand/"

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

Copy the contents of THIS folder (everything inside "plugins/")
into your BepInEx/plugins/ folder.

For r2modman users:
  ~/.config/r2modmanPlus-local/Valheim/profiles/<YourProfile>/BepInEx/plugins/

For vanilla BepInEx:
  <Valheim install>/BepInEx/plugins/

After copying, you should have these folders inside BepInEx/plugins/:
  - Valmedia-OdinOnDemand/
  - ValheimModding-Jotunn/
  - ValheimModding-JsonDotNET/

Launch Valheim. The OOD pieces appear under Hammer -> Furniture -> OOD.
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
