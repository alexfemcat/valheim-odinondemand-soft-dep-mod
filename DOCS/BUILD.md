# OdinOnDemand Build & Development Guide

## Quick Build

```bash
cd plugin
dotnet build -c Release
```

DLL output: `plugin/bin/Release/OdinOnDemand.dll`

## Setup (One-time)

### 1. Install Dependencies

```bash
# Install mono-complete for xbuild (if building with old .csproj)
sudo apt-get install -y mono-complete

# Or just use dotnet (modern, recommended)
dotnet --version  # should be 8.0+
```

### 2. Create Environment.props

```bash
cp plugin/Environment.props.example plugin/Environment.props
```

Update paths in `plugin/Environment.props` if needed (usually auto-detected on Linux Mint).

### 3. Copy Assembly References (Linux only)

The build needs local copies of Valheim DLLs because dotnet can't reliably read `~/.steam/` paths.

```bash
# Copy Valheim managed assemblies
mkdir -p plugin/Lib/Managed
cp ~/.steam/debian-installation/steamapps/common/Valheim/valheim_Data/Managed/*.dll plugin/Lib/Managed/

# Copy BepInEx core
mkdir -p plugin/Lib/BepInEx
cp ~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/core/*.dll plugin/Lib/BepInEx/

# Publicized assemblies are auto-generated during build via Krafs.Publicizer
```

## Build Variants

### Debug Build
```bash
cd plugin
dotnet build -c Debug
```
Output: `plugin/bin/Debug/OdinOnDemand.dll`

### Release Build (optimized)
```bash
cd plugin
dotnet build -c Release
```
Output: `plugin/bin/Release/OdinOnDemand.dll`

### Clean Build
```bash
cd plugin
rm -rf bin obj
dotnet build -c Release
```

## Deployment

### Deploy to r2modman Client Profile
```bash
mkdir -p ~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/Valmedia-OdinOnDemand
cp plugin/bin/Release/OdinOnDemand.dll ~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/Valmedia-OdinOnDemand/
```

### Deploy to Dedicated Server
```bash
mkdir -p <server-root>/BepInEx/plugins/Valmedia-OdinOnDemand
cp plugin/bin/Release/OdinOnDemand.dll <server-root>/BepInEx/plugins/Valmedia-OdinOnDemand/
```

## Troubleshooting

### Build fails: "Cannot find assembly X"
Make sure you ran the copy commands in Setup step 3. The build needs local DLL copies.

### Build fails: "Krafs.Publicizer not found"
Run:
```bash
cd plugin
dotnet restore
```

### DLL won't load in game
- Check BepInEx logs: `~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/LogOutput.log`
- Ensure DLL is in correct path: `BepInEx/plugins/Valmedia-OdinOnDemand/OdinOnDemand.dll`
- Check that all dependencies are installed (JotunnLib, etc.)

## Dependencies

See `plugin/OdinOnDemand.csproj` for package versions. Main deps:
- **JotunnLib** 2.27.0 - Valheim modding framework
- **Newtonsoft.Json** 13.0.3 - JSON serialization
- **YoutubeDLSharp** 1.1.2 - YouTube support
- **Krafs.Publicizer** 2.2.1 - Auto-publicize private Valheim types at build time

## Notes

- **SOFT dependency enabled**: `CompatibilityLevel.VersionCheckOnly` in [OdinOnDemandPlugin.cs:29](../plugin/OdinOnDemandPlugin.cs#L29)
  - Clients without the mod can join servers with it
  - Custom items won't render for those clients
  
- **Linux-specific**: dotnet SDK 8.0+ required. Older Mono 6.8 can't compile modern C# syntax (switch expressions, default literals).

- **Asset bundles**: Embedded in the DLL. No external asset folder needed.
