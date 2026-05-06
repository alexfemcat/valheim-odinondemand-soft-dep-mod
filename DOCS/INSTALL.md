# OdinOnDemand Installation Guide

## Required Files

You need **all files** from the build output:
- `OdinOnDemand.dll` (main mod)
- `YoutubeDLSharp.dll` (dependency)
- `YoutubeExplode.dll` (dependency)
- `SoundCloudExplode.dll` (dependency)
- `videoplayers` (asset bundle - no extension)
- `default.json` (config)
- `default_items.json` (config)

All files are in: `/home/catosaur/Documents/bots_n_coding/Valheim-Mods/OdinOnDemand-SOFT/plugin/bin/Release/`

---

## Server Installation

### Step 1: Create Plugin Folder
```bash
mkdir -p <server-root>/BepInEx/plugins/Valmedia-OdinOnDemand
```

Replace `<server-root>` with your dedicated server root path.

### Step 2: Copy All Files
```bash
cp -r /home/catosaur/Documents/bots_n_coding/Valheim-Mods/OdinOnDemand-SOFT/plugin/bin/Release/* <server-root>/BepInEx/plugins/Valmedia-OdinOnDemand/
```

This copies all required files: DLLs, asset bundles, and configs.

### Step 3: Restart Server
Restart your dedicated server. The mod will load on startup.

**Verify installation:**
- Check server logs for: `[Info   :   BepInEx] Loading [OdinOnDemand 1.0.9]`
- No errors about missing YoutubeDLSharp

---

## Client Installation (r2modman)

### Step 1: Create Plugin Folder
```bash
mkdir -p ~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/Valmedia-OdinOnDemand
```

### Step 2: Copy All Files
```bash
cp -r /home/catosaur/Documents/bots_n_coding/Valheim-Mods/OdinOnDemand-SOFT/plugin/bin/Release/* ~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/Valmedia-OdinOnDemand/
```

This copies all required files: DLLs, asset bundles, and configs.

### Step 3: Launch Game
Launch Valheim through r2modman. The mod will load with the game.

**Verify installation:**
- Look for Hammer menu → Furniture → OOD category (with TVs, boomboxes, etc.)
- In your inventory, craft a Remote Control (1 Bronze)

---

## Folder Structure After Installation

### Server
```
<server-root>/
└── BepInEx/
    └── plugins/
        └── Valmedia-OdinOnDemand/
            ├── OdinOnDemand.dll
            ├── YoutubeDLSharp.dll
            ├── YoutubeExplode.dll
            ├── SoundCloudExplode.dll
            ├── videoplayers (asset bundle)
            ├── default.json
            └── default_items.json
```

### Client (r2modman)
```
~/.config/r2modmanPlus-local/Valheim/profiles/Default/
└── BepInEx/
    └── plugins/
        └── Valmedia-OdinOnDemand/
            ├── OdinOnDemand.dll
            ├── YoutubeDLSharp.dll
            ├── YoutubeExplode.dll
            ├── SoundCloudExplode.dll
            ├── videoplayers (asset bundle)
            ├── default.json
            └── default_items.json
```

---

## Troubleshooting

### Pieces don't appear in Hammer menu
- Verify **all 7 files** were copied (not just DLLs)
- Check the `videoplayers` asset bundle file is present in the folder
- Verify folder paths are correct
- Restart the game/server

### "videoplayers not found" error in logs
- The `videoplayers` file (asset bundle) must be in the same folder as `OdinOnDemand.dll`
- It has no file extension
- Make sure it was copied: `ls -la Valmedia-OdinOnDemand/videoplayers`

### DLLs won't load
- Check file permissions: `chmod +x *.dll`
- Verify all dependency DLLs are present (YoutubeDLSharp, YoutubeExplode, SoundCloudExplode)
- Verify BepInEx is installed and working
- Check logs: `BepInEx/LogOutput.log`

---

## SOFT Dependency Note

This mod is configured as a **SOFT dependency**. This means:
- **Server has mod**: Clients WITH the mod see all OOD features
- **Server has mod**: Clients WITHOUT the mod can still join but won't see custom items
- **Crossplay enabled**: You don't need ALL players to have the mod installed
