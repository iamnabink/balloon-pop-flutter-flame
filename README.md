# Balloon Bounce Letters - Flutter Game

A fun educational game built with Flutter and Flame where players catch Nepali letters in a basket to spell words.

![Game Screenshot](screenshot.png)

## Features

- **Physics-based gameplay**: Balloons float up with gravity and bounce off moving platforms
- **Nepali letter learning**: Catch the correct letters to spell words
- **Player controls**: Move the basket left/right using arrow keys or A/D keys
- **Sound effects**: Balloon burst sound when catching wrong letters
- **Burst animations**: Animated sprite sheet burst effect when catching wrong letters
- **Visual feedback**: Colorful balloons with Nepali character images

## Gameplay

1. Balloons with Nepali letters float up from the bottom
2. Use arrow keys (← →) or A/D keys to move the basket left/right
3. Catch the correct letters in order to spell the target word
4. If you catch a wrong letter, the balloon bursts with a sound and animated burst effect
5. Complete words to progress through the game

## Setup

1. Make sure you have Flutter installed
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the game:
   ```bash
   flutter run
   ```

## Assets

The game follows Flame's recommended asset structure:

```
assets/
├── audio/
│   └── balloon-burst.mp3  # Sound effect for wrong letter catches
└── images/
    ├── red.png, blue.png, etc.  # Balloon sprite images in various colors
    └── *SpriteSheetAnimation.png  # Burst animation sprite sheets
```

All assets are automatically loaded when the game starts using `images.loadAllImages()`.

## Game Structure

- `lib/main.dart`: Entry point and UI overlay
- `lib/game/balloon_game.dart`: Main game class with physics and game logic
- `lib/game/components/`: Game components
  - `balloon.dart`: Balloon with Nepali letters
  - `platform.dart`: Moving platforms for balloons to bounce off
  - `world_boundaries.dart`: Physics boundaries
  - `burst_animation.dart`: Sprite sheet animation for balloon bursts

## Technologies

- **Flutter**: UI framework
- **Flame**: Game engine
- **Flame Forge2D**: Physics engine
- **Flame Audio**: Sound effects

Enjoy the game!

