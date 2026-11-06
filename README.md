# PADChat

**PADChat** is a World of Warcraft addon that brings quick-chat to gamepad and controller players. Inspired by the Voice Game System (VGS) from Tribes 2, it lets you send tactical callouts, group readiness checks, and social emotes in seconds, without touching a keyboard.

---

## Why?

I've played World of Warcraft with a controller for many years, and communicating with other players has always been the biggest drawback. Now that World of Warcraft: Forever supports controllers, more people are playing this way, and this addon is my attempt to ease that frustration. I hope it helps you!

## Features

- **Button combos:** Navigate chat menus up to 4 presses deep using the face buttons (**A / X / Y** or **Cross / Square / Triangle**).
- **Context tabs:** Tap **LB / RB** (bumpers) to switch between **Whisper**, **Say**, **RP**, **Group**, **Guild**, and **Battleground** tabs. **Guild** sends your Say options to guild chat, with guild calls (*Grats!*, *Anyone up for a dungeon run?*) in place of Callout. The header shows where the current tab sends (for example *to Party* or *to Bob*), or why it can't.
- **Roleplay tab:** For RP servers. The **RP** tab, one bumper press from where the menu opens, speaks in character on `/say` with fitting emotes: greetings, farewells, tavern banter, guard lines and battle cries. Alliance characters hear "Light be with you" and "For the Alliance!", Horde characters "Throm-Ka" and "Lok'tar ogar!". `{TARGET}` fills in your target's name ("Well met, Bob!") and `{NAME}` your own. Edit the phrases in the editor's **RP** tab, or turn the tab off under **Settings → Quick chat → Roleplay tab**.
- **Whispers:** The Whisper tab sends your Say messages privately. A list of the people you've recently whispered or been whispered by (most recent first), followed by your online group members, appears beside the overlay; pick one with **D-pad Up / Down**.
- **Looking For Group integration:** Select a group or player in the Looking For Group window and press **Y** to whisper them with quick chat. It opens on a special **LFG** tab with role replies (`{LEVEL} {CLASS} DPS`, `HEALS` or `TANK`, for example "60 Mage HEALS"); LB / RB still reach the other tabs. A **Y** prompt appears beside **Send Message**. In the window's **Who** tab, move the cursor onto a player and press **Y**; the row shows the **Y** prompt. Turn both off under **Settings → Integrations → Enhance LFG Window**.
- **Controller glyphs:** The menu shows your controller's own button icons (Xbox letters or PlayStation shapes) when the game provides them.
- **Send confirmation:** A short note shows what was sent and where, or why it couldn't be.
- **Built-in editor:** Customize messages, categories, emotes, and `{location}`, `{LEVEL}`, `{CLASS}`, `{TARGET}` and `{NAME}` placeholders from the minimap button.
- **Normal and compact modes:** Pick the overlay size that suits your UI.

## Screenshots

**Normal mode**

![Normal mode](https://media.forgecdn.net/attachments/description/null/description_5517e305-2c61-48c4-aaf9-3c2cec566149.png)

**Compact mode**

![Compact mode](https://media.forgecdn.net/attachments/description/null/description_43fcd6cc-57be-48e1-bf3c-515f01e9f937.png)

**Settings and customization**

![Settings](https://media.forgecdn.net/attachments/description/null/description_86a4cfd7-1ea3-4a2d-9725-4ff35cdfa012.png)

## Installation

1. Download the latest release (or clone this repository).
2. Place the `PADChat` folder in your WoW AddOns directory, for example:
   `World of Warcraft/_classic_/Interface/AddOns/PADChat`
3. Restart the game or run `/reload`, then make sure **PAD Chat** is enabled in the AddOns list.

## Getting started

1. Place the generated **`PADChat`** macro on any action bar slot bound to your controller.
2. Press the macro in-game to open the quick-chat overlay.
3. Click the minimap button at any time to open the editor and tailor your callouts to your playstyle.

## Default controls

| Button | Action |
| --- | --- |
| **Action bar macro (`PADChat`)** | Open quick chat |
| **A / X / Y** *(Cross / Square / Triangle)* | Select a category or message |
| **B** *(Circle)* | Cancel / close the menu |
| **LB / RB** *(left / right bumper)* | Switch tabs (Whisper / Say / RP / Group / Guild / BG) |
| **D-pad Up / Down** *(Whisper and LFG tabs only)* | Choose who to whisper |
| **Y** *(Looking For Group window, listing selected)* | Whisper that listing's leader from the LFG tab |
| **Y** *(Looking For Group Who tab, on a player)* | Whisper that player |

## Project layout

| File | Purpose |
| --- | --- |
| `PADChat.toc` | Addon manifest |
| `PADChat.lua` | Core overlay, input handling, and chat sending |
| `Messages.lua` | Default message tree |
| `Integrations.lua` | Looking For Group window enhancements |
| `Editor.lua` | In-game message and settings editor |
| `MinimapButton.lua` | Minimap button |
| `Media/` | Icon and logo assets |
| `tests/` | Tests |

## Changelog

### 0.4.0

- New **RP** (Roleplay) tab between Say and Group: in-character greetings, farewells, courtesies, banter, guard lines, battle cries and warnings, spoken on `/say` with emotes. Alliance and Horde characters each get their own phrases, kept separately so an account with both keeps both.
- New **Guild** tab after Group: your Say options sent to guild chat, with guild calls (Grats, dungeon runs, quest help) in the Callout slot. It greys out with *Join a guild first* when you aren't in one.
- New `{TARGET}` (your target's name, or "friend") and `{NAME}` (your name) placeholders.
- **Settings → Quick chat → Roleplay tab** turns the tab on or off.
- Refreshed look: gold-trimmed frame, a bumper-flanked tab strip with the active tab underlined, and a breadcrumb showing where you are in the menu.
- Controller glyphs for A / B / X / Y, the bumpers and the D-pad when the game provides them.
- The header shows where the current tab sends (*to Say*, *to Party*, *to Bob*), or why it can't (*Join a group first*).
- In the full menu, messages are grouped under their category's heading.
- A short confirmation shows each sent message, or why it wasn't sent.
- More emotes in the editor's picker: Hail, Greet, Nod, No, Shrug, Kneel, Curtsey, Drink, Ponder, Flex and Charge.

### 0.3.0

- New **Whisper** tab: sends your Say messages privately to a player picked with **D-pad Up / Down**.
- The whisper list is built by PAD Chat: people you've recently whispered or been whispered by (kept across `/reload`), then your online group members.
- New **LFG** tab: press **Y** on a selected listing in the Looking For Group window to whisper its leader a role reply (`{LEVEL} {CLASS} DPS`, `HEALS` or `TANK`).
- Press **Y** on a player in the Looking For Group window's **Who** tab to whisper them.
- New `{LEVEL}` and `{CLASS}` message placeholders.
- Removed the Recent Allies window integration.

## Coming soon

Location-based callouts in Battlegrounds (for example, "Incoming Mine!" or "Incoming BS!"). I'll release this once Battlegrounds are in-game and I can test it.

## Contributing

Issues, suggestions, and pull requests are welcome. Fork it, change it, and make it your own.

## License

PADChat is released under the [MIT License](LICENSE). You're free to use, copy, modify, merge, publish, distribute, sublicense, and sell copies of it, as long as the copyright notice and license text are kept with it.

World of Warcraft is a trademark of Blizzard Entertainment, Inc. This project is not affiliated with or endorsed by Blizzard Entertainment.
