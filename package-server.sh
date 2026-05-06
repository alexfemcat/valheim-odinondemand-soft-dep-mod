#!/usr/bin/env bash
set -euo pipefail

# Builds OdinOnDemand server package
# Contains only the mod files needed for dedicated servers

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$REPO_ROOT/plugin"
RELEASE_DIR="$PLUGIN_DIR/bin/Release"

STAGE_DIR="$REPO_ROOT/dist/staging-server"
OUT_DIR="$REPO_ROOT/dist"
ZIP_NAME="OdinOnDemand-Server-Bundle.zip"

echo "=== Building OdinOnDemand (Release) ==="
cd "$PLUGIN_DIR"
dotnet build -c Release > /dev/null
echo "Build complete."

echo "=== Staging server package ==="
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand"

# OdinOnDemand mod files (DLLs, asset bundle)
cp "$RELEASE_DIR"/*.dll "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand/"
cp "$RELEASE_DIR/videoplayers" "$STAGE_DIR/BepInEx/plugins/Valmedia-OdinOnDemand/"

# Create config folder and add default recipes
mkdir -p "$STAGE_DIR/BepInEx/config/OdinOnDemand"
cp "$RELEASE_DIR/default.json" "$STAGE_DIR/BepInEx/config/OdinOnDemand/recipes.json"
cp "$RELEASE_DIR/default_items.json" "$STAGE_DIR/BepInEx/config/OdinOnDemand/recipes_item.json"

# Drop install README inside the zip
cat > "$STAGE_DIR/BepInEx/plugins/README-SERVER-INSTALL.txt" <<'EOF'
OdinOnDemand Server Bundle - Installation
==========================================

STEP 1: Extract to Server Root
Extract the contents of this zip directly to your Valheim dedicated server root.

Your server folder structure should look like:
  <server-root>/
  ├── valheim_server.x86_64
  ├── BepInEx/
  │   ├── plugins/
  │   │   └── Valmedia-OdinOnDemand/
  │   │       ├── OdinOnDemand.dll
  │   │       ├── YoutubeDLSharp.dll
  │   │       ├── YoutubeExplode.dll
  │   │       ├── SoundCloudExplode.dll
  │   │       ├── System.ValueTuple.dll
  │   │       ├── videoplayers
  │   │       ├── default.json
  │   │       └── default_items.json
  │   ├── core/  (should already exist)
  │   └── config/

STEP 2: Restart Server
Restart your dedicated server. BepInEx will load OdinOnDemand automatically on startup.

STEP 3: Verify Installation
Check your server logs for:
  [Info   :   BepInEx] Loading [OdinOnDemand 1.0.9]
  [Info   :Jotunn.Managers.PieceManager] Adding 13 custom pieces to the PieceTables

If you see these lines, the mod loaded successfully.

CONFIGURATION
- All pieces appear in Hammer → Furniture → OOD
- Players craft Remote Control with 1 Bronze
- Config files: BepInEx/config/OdinOnDemand/config.cfg

SOFT DEPENDENCY
This mod is a SOFT dependency:
- Clients WITH the mod see all OOD features
- Clients WITHOUT the mod can still join but won't see custom items
- Crossplay works either way
EOF

echo "=== Creating zip ==="
mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR/$ZIP_NAME"
cd "$STAGE_DIR"
zip -r -q "$OUT_DIR/$ZIP_NAME" BepInEx 2>/dev/null || zip -r -q "$OUT_DIR/$ZIP_NAME" BepInEx

echo "=== Cleaning up ==="
rm -rf "$STAGE_DIR"

echo ""
echo "Done! Server Bundle: $OUT_DIR/$ZIP_NAME"
ls -lh "$OUT_DIR/$ZIP_NAME"
