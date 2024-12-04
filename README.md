# GunGameZW

GunGameZW is a Fortnite Creative game mode where players compete to eliminate each other and progress through different weapon loadouts. The game includes various managers and devices to handle player respawns, weapon loadouts, XP awards, and end-game conditions.

## Project Structure

- `end_game_manager.verse`: Manages the end-game conditions, including displaying ranks and ending the game.
- `game_manager.verse`: Handles player loadouts, weapon switches, and player teleportation.
- `respawn_manager.verse`: Manages player respawns and grants items upon respawn.
- `static_weapon_refill.verse`: Refills weapons and grants items to players.
- `XP_device.verse`: Awards XP to players when they collect coins.
- `zone_manager.verse`: Manages teleporters and storm controllers within the game zone.

## Key Features

- **Weapon Loadouts**: Players can switch between different weapon loadouts using switches.
- **XP Awards**: Players earn XP by collecting coins.
- **Respawn Management**: Players respawn with specific items and are teleported to designated zones.
- **End Game**: The game ends when certain conditions are met, and players are ranked based on their performance.

## How to Play

1. Players start with a basic weapon loadout.
2. Eliminate other players to progress through different weapon tiers.
3. Collect coins to earn XP and improve your rank.
4. The game ends when a player reaches the final weapon tier or the timer runs out.

## Devices and Classes

- **Creative Devices**: Various devices like `teleporter_device`, `timer_device`, `item_granter_device`, and more are used to manage game mechanics.
- **Managers**: Classes like `game_manager`, `end_game_manager`, and `respawn_manager` handle different aspects of the game.

## Setup

1. Place the necessary devices in your Fortnite Creative map.
2. Configure the devices using the provided Verse scripts.
3. Start the game and enjoy!

