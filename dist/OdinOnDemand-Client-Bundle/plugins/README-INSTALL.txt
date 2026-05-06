OdinOnDemand Client Bundle - Installation
==========================================

STEP 1: Extract and Copy Folders
Extract this zip. Copy BOTH folders into your Valheim installation:
  - Copy "plugins/" contents → BepInEx/plugins/
  - Copy "BepInEx/" → Your Valheim BepInEx/ directory (merges with existing config)

For r2modman users:
  ~/.config/r2modmanPlus-local/Valheim/profiles/<YourProfile>/BepInEx/

For vanilla BepInEx:
  <Valheim install>/BepInEx/

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
