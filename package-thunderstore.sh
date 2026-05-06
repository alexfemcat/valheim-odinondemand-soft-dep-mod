#!/usr/bin/env bash
set -euo pipefail

# Builds Thunderstore package for CatosJukeboxes

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$REPO_ROOT/plugin"
RELEASE_DIR="$PLUGIN_DIR/bin/Release"

STAGE_DIR="$REPO_ROOT/dist/staging-thunderstore"
OUT_DIR="$REPO_ROOT/dist"
ZIP_NAME="CatosOnDemand-1.0.10.zip"

echo "=== Building OdinOnDemand (Release) ==="
cd "$PLUGIN_DIR"
dotnet build -c Release > /dev/null
echo "Build complete."

echo "=== Staging Thunderstore package ==="
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand"
mkdir -p "$STAGE_DIR/BepInEx/config/OdinOnDemand"

# Manifest and metadata
cp "$REPO_ROOT/manifest.json" "$STAGE_DIR/"
cp "$REPO_ROOT/icon.png" "$STAGE_DIR/"
cp "$REPO_ROOT/THUNDERSTORE_README.md" "$STAGE_DIR/README.md"

# OdinOnDemand mod files (DLLs, asset bundle)
cp "$RELEASE_DIR"/*.dll "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR/videoplayers" "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand/"

# Default recipes
cp "$RELEASE_DIR/default.json" "$STAGE_DIR/BepInEx/config/OdinOnDemand/recipes.json"
cp "$RELEASE_DIR/default_items.json" "$STAGE_DIR/BepInEx/config/OdinOnDemand/recipes_item.json"

echo "=== Creating zip ==="
mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR/$ZIP_NAME"
cd "$STAGE_DIR"
zip -r -q "$OUT_DIR/$ZIP_NAME" . 2>/dev/null || zip -r -q "$OUT_DIR/$ZIP_NAME" .

echo "=== Cleaning up ==="
rm -rf "$STAGE_DIR"

echo ""
echo "Done! Thunderstore Package: $OUT_DIR/$ZIP_NAME"
ls -lh "$OUT_DIR/$ZIP_NAME"
echo ""
echo "Upload instructions:"
echo "1. Go to https://thunderstore.io/c/valheim/"
echo "2. Click 'Upload Package'"
echo "3. Select this zip file"
echo "4. Follow the prompts"
