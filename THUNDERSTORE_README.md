# Cato's Jukeboxes

A Valheim mod that adds media players to watch videos and listen to audio with full multiplayer sync. **SOFT dependency** — clients without the mod can still join servers that have it installed.

## Features

- **Multiple Player Types**: Theater screens, flat-screen TVs, boomboxes, gramophones, radios, and mobile players
- **Direct Media Support**: Play MP4, WebM, OGG, WAV, MP3, and FLAC files
- **Local Files**: Load media from your plugin folder with relative paths
- **Remote Control**: Craft with Bronze to control players from a distance
- **Linkable Speakers**: Direct audio output to any location on the map
- **Playlist Support**: Queue multiple files with shuffle and loop options
- **Time Sync**: All players see synchronized playback across the server
- **Admin Controls**: Lock players, configure recipes, set listening distances
- **Crossplay**: Clients without the mod can join — they just won't see the custom items

## How to Use

### Placing Media Players

1. Open Hammer menu → Furniture → OOD category
2. Place any media player (TVs, boomboxes, gramophones, radios, etc.)
3. Interact with the player to open the media UI

### Playing Media

**Direct Video/Audio Files:**
- Paste direct links to MP4, WebM, or audio files
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

Craft a **Remote Control** with 1 Bronze + 1 Greydwarf Eye:
- **Primary action (LMB)**: Open media player UI from a distance
- **Secondary action (RMB)**: Link/unlink speakers to players

### Speakers

Link speakers to any media player using the remote control. Audio plays at the speaker location instead of the player location — useful for surround sound setups.

## Configuration

Config files are stored in `BepInEx/config/OdinOnDemand/`:

- **config.cfg**: Main settings (listening distance, remote control range, admin options)
- **recipes.json**: Customize piece crafting costs
- **recipes_item.json**: Customize item recipes

To reset to defaults, delete the config files and restart the game.

## Troubleshooting

**Pieces don't appear in Hammer menu:**
- Verify all DLLs are installed correctly
- Restart the game

**Media won't play:**
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
- **SOFT Dependency Conversion & Updates**: Current version by Cato
- **Dependencies**: 
  - [YouTubeExplode](https://github.com/Tyrrrz/YoutubeExplode)
  - [SoundCloudExplode](https://github.com/jerry08/SoundCloudExplode)
  - [JotunnLib](https://github.com/Valheim-Modding/Jotunn)
