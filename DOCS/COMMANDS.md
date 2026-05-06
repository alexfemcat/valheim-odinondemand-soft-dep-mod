# OdinOnDemand Commands & Controls

## In-Game Controls

### Remote Control Item
Equip the **Remote Control** (crafted with 1 Bronze) to interact with media players.

**Primary Action** (Mouse0 / LMB):
- Point at a media player screen
- Click to open the media player UI
- Play/pause/control videos and music

**Secondary Action** (Mouse1 / RMB):
- Point at a speaker → click to select it
- Point at a media player → click to link/unlink the speaker
- Creates audio output at speaker location instead of player location

### Key Bindings

Default keys (customizable in config):
- **Mouse0** - Use/interact with screen
- **Mouse1** - Link/unlink speakers

To customize:
1. Edit: `~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/config/com.ood.valmedia.keyconfig.cfg`
2. Change `Use Screen` and `Link` key values
3. Restart game

## Media Player Controls

### URL Input
Paste into the URL field:
- **YouTube**: `https://youtube.com/watch?v=...` or `https://youtu.be/...`
- **YouTube Playlist**: `https://youtube.com/playlist?list=...`
- **Direct Video**: Direct MP4/WebM links (compatible codecs)
- **SoundCloud**: `https://soundcloud.com/...`
- **Local Files**: `local://path/to/file.mp4` (relative to OOD plugin folder)

### Video/Audio Controls
- **Play/Pause**: Click play button
- **Volume**: Slider control
- **Time Seek**: "Set Time" button in settings (input seconds)
- **Loop**: Toggle looping in settings
- **Shuffle** (playlists): Toggle shuffle option

### Admin Controls
Admins can:
- Lock media players (prevent other players from using them)
- Configure max recipe costs
- Set time sync intervals in config

## Configuration Files

### Main Config
`~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/config/OdinOnDemand/config.cfg`

Key settings:
- `RemoteControlMaxDistance` - How far away you can control players
- `PrivateRemoteControl` - Only owner can use their remote
- `AdminOnlyLocking` - Only admins can lock/unlock media players
- `TimeSyncInterval` - Frequency of playback sync checks (seconds)

### Key Configuration
`~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/config/com.ood.valmedia.keyconfig.cfg`

Bind keys for:
- `Use Screen` - Primary remote action
- `Link` - Secondary remote action (speaker linking)

### Recipe Configuration
`~/.config/r2modmanPlus-local/Valheim/profiles/Default/BepInEx/config/OdinOnDemand/recipes.json`

Customize crafting costs for pieces and items.

## No Console Commands

This mod does **not** register any server/client console commands. All interaction is through:
1. Placing pieces (via hammer menu → OOD category)
2. Using the Remote Control item
3. Modifying config files (requires restart)

## Pieces (Buildable Items)

Access via **Hammer > Furniture > OOD** section:

- **Theater Screen** - Large cinema display
- **Flatscreen TV** - Modern TV
- **Table TV** - Desktop-sized screen
- **Monitor** - Computer monitor
- **Old TV** - Retro CRT style
- **Laptop** - Portable screen
- **Gramophone** - Retro music player
- **Boombox** - Portable speaker
- **Radio** - Radio receiver
- **Receiver** - Audio receiver
- **Bard's Wagon** (Cart Player) - Mobile media on wheels
- **Skald's Girdle** (Belt Player) - Worn media player (buy from Haldor)
- **Speaker** - Linkable audio output

## Items

### Remote Control
**Craft**: 1 Bronze  
**Use**: Hold and click on media players to control them

### Skald's Girdle (Belt Player)
**Buy From**: Haldor (NPC merchant)  
**Wear**: Equip like armor  
**Use**: Click with remote control at empty space (not on another player) to access

## Troubleshooting

### Remote not working
- Make sure you're within `RemoteControlMaxDistance` range
- If `PrivateRemoteControl` is enabled, only the owner can use it
- Check if the media player is locked

### Media won't load
- Verify URL is correct and accessible
- Check compatible codecs for direct video files
- Local files must be in relative path from OOD plugin folder

### No sound
- Check volume slider in UI
- Verify speakers are linked to the media player
- Check game audio settings aren't muted

### Videos lag/stutter
- Reduce video quality/resolution
- Check network bandwidth (for streaming)
- Lower game graphics settings
