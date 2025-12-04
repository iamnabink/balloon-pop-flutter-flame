import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import '../../constants/app_assets.dart';
import '../../game/balloon_game.dart';

/// Burst animation component that plays a sprite sheet animation
class BurstAnimation extends SpriteAnimationComponent {
  final String color;
  final BalloonGame game;
  double _elapsedTime = 0.0;
  double _totalDuration = 0.0;

  BurstAnimation({
    required Vector2 position,
    required this.color,
    required this.game,
  }) : super(
          position: position,
          size: Vector2(100, 100),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Capitalize first letter to match file names (Red, Blue, etc.)
    final colorName = color.isEmpty
        ? 'Red'
        : color.substring(0, 1).toUpperCase() + color.substring(1);
    final spriteSheetName = AppAssets.getSpriteSheetName(colorName);

    try {
      // Use cached sprite sheet (images are preloaded in BalloonGame.onLoad)
      final spriteSheet = game.images.fromCache(spriteSheetName);

      // Get the actual texture size to calculate frame dimensions
      final textureSize =
          Vector2(spriteSheet.width.toDouble(), spriteSheet.height.toDouble());

      // Assuming sprite sheet has frames in a horizontal row
      // Adjust these values based on your actual sprite sheet layout
      // Common patterns: 8 frames in a row, or 4x2 grid, etc.
      // If your sprite sheet has a different layout, adjust frameCount accordingly
      const frameCount =
          8; // TO-DO: Adjust based on your actual sprite sheet frame count
      final frameWidth = textureSize.x / frameCount;
      final frameHeight = textureSize.y;

      final spriteSize = Vector2(frameWidth, frameHeight);
      const stepTime = 0.08; // Time per frame (adjust for speed)
      _totalDuration = stepTime * frameCount;

      final animationData = SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: stepTime,
        textureSize: spriteSize,
        loop: false, // Don't loop, play once
      );

      animation = SpriteAnimation.fromFrameData(
        spriteSheet,
        animationData,
      );

      // Update size to match frame size
      size = spriteSize;
    } catch (e) {
      // If sprite sheet not found, remove immediately
      if (kDebugMode) {
        print('Could not load burst animation for $color: $e');
      }
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Safety check: don't update if already removed
    if (!isMounted) return;

    // Remove component when animation completes
    _elapsedTime += dt;
    if (_elapsedTime >= _totalDuration || animation == null) {
      removeFromParent();
    }
  }

  @override
  void onRemove() {
    // Explicit cleanup - animation resources are automatically disposed
    super.onRemove();
  }
}
