# OdinOnDemand - SOFT Dependency Edition

A Valheim mod that adds media players to watch videos, play music, and listen to audio with full multiplayer sync. **This is a SOFT dependency version** — clients without the mod can still join servers with it installed.

## Features

- **Universal Media Support**: Direct video files and local files (MP4, WebM compatible codecs)
- **Multiple Player Types**: Theater screens, flat-screen TVs, boomboxes, gramophones, radios, and mobile players
- **Remote Control**: Craft with 1 Bronze to control media players from a distance
- **Linkable Speakers**: Direct audio output to any location on the map
- **Playlist Support**: Queue up multiple media files with shuffle and loop options
- **Time Sync**: All players see synchronized playback across the server
- **Admin Controls**: Lock players, configure recipes, set listening distances
- **SOFT Dependency**: Clients without the mod can join — they just won't see the custom items

## Installation

### For Dedicated Servers

Use **OdinOnDemand-Server-Bundle.zip**:

1. Extract to your server root directory
2. Restart the server
3. Check logs for: `[Info   :Jotunn.Managers.PieceManager] Adding 13 custom pieces to the PieceTables`

### For Clients (Full Installation)

Use **OdinOnDemand-Client-Bundle.zip** if you don't have BepInEx installed:

1. Extract the `plugins/` folder contents into your `BepInEx/plugins/` directory
2. For r2modman: `~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/plugins/`
3. For standalone: `<Valheim install>/BepInEx/plugins/`
4. Launch Valheim
5. Look for **Hammer → Furniture → OOD** for the media pieces

### For Clients (Mod Only)

Use **OdinOnDemand-Mod-Only.zip** if you already have BepInEx, JotunnLib, and JsonDotNET:

1. Extract `plugins/Valmedia-OdinOnDemand/` into your `BepInEx/plugins/` directory
2. Launch Valheim

## In-Game Usage

### Placing Media Players

- Open Hammer menu → Furniture → OOD category
- Place any media player (TVs, boomboxes, gramophones, radios, etc.)
- Interact with the player to open the media UI

### Playing Media

**Direct Video/Audio Files:**
- Paste direct links to MP4, WebM, or audio files with compatible codecs
- Example: `https://example.com/video.mp4`

**Local Files:**
- Place files in: `BepInEx/plugins/Valmedia-OdinOnDemand/media/`
- In the media player URL tab, type just the filename
- Example: type `bee.mp4` or `music.mp3`
- Supported formats: MP4, WebM, OGG, WAV, MP3, FLAC

**Playlists:**
- Create multiple entries in the media player to queue videos
- Use shuffle and loop options from the settings menu

### Remote Control

Craft a **Remote Control** with 1 Bronze:
- **Primary action (LMB)**: Open media player UI from a distance
- **Secondary action (RMB)**: Link/unlink speakers to players

### Speakers

- Link speakers to any media player using the remote control
- Audio plays at the speaker location instead of the player location
- Useful for creating surround sound setups

## Configuration

Config files are stored in `BepInEx/config/OdinOnDemand/`:

- **config.cfg**: Main settings (listening distance, remote control range, admin options)
- **recipes.json**: Customize piece crafting costs
- **recipes_item.json**: Customize item recipes

To reset to defaults, delete the config files and restart the game.

## SOFT Dependency

This mod uses SOFT dependency mode:
- **Server has mod, client has mod**: Full OOD experience
- **Server has mod, client doesn't have mod**: Client can join but won't see OOD items
- **Crossplay works**: No requirement for all players to have the mod

## Troubleshooting

**Pieces don't appear in Hammer menu:**
- Verify all DLLs are in `BepInEx/plugins/Valmedia-OdinOnDemand/`
- Check that `videoplayers` asset bundle file is present
- Restart the game

**Media won't play:**
- Verify all dependency DLLs are present in `Valmedia-OdinOnDemand/` folder
- For local files: Check that `media/` folder exists and files are placed there
- For local files: Type just the filename (e.g., `song.mp3`, not paths or URLs)
- Check that the media file format is compatible (MP4, WebM, OGG, WAV, MP3, FLAC)
- Verify the URL or file path is correct
- Check `BepInEx/LogOutput.log` for errors

**No sound from speakers:**
- Verify speakers are linked to the media player
- Check the volume slider in the UI
- Confirm game audio isn't muted

## Platform Notes

- **Audio** (MP3, OGG, WAV, FLAC): Works on all platforms
- **Video** (MP4, WebM): Works on Windows only — Linux clients will not display video

## Known Issues

- Boomboxes can be difficult to place on certain terrain — try placing on flat ground
- If you have V-Sync forced in your GPU driver, disable it or set to "match application setting"

## Credits

- **Original OdinOnDemand**: Created by Moddy (modestimpala)
- **SOFT Dependency Conversion**: Updated to support crossplay
- **Dependencies**: 
  - [YouTubeExplode](https://github.com/Tyrrrz/YoutubeExplode)
  - [SoundCloudExplode](https://github.com/jerry08/SoundCloudExplode)
  - [yt-dlp](https://github.com/yt-dlp/yt-dlp)
  - [JotunnLib](https://github.com/Valheim-Modding/Jotunn)

## Bug Reports

Found an issue? Report it on:
- [GitHub Issues](https://github.com/modestimpala/OdinOnDemand/issues)
- [Nexus Mods](https://www.nexusmods.com/valheim/mods/2229?tab=bugs)

## License

This mod is based on the original OdinOnDemand project. Modifications made for SOFT dependency support.
