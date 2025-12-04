import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/app_assets.dart';
import '../../game/balloon_game.dart';
import '../bloc/pop_counter_bloc.dart';
import 'burst_animation.dart';

class Balloon extends BodyComponent<BalloonGame> with TapCallbacks {
  late SpriteComponent balloonSprite;
  String balloonColor = 'red';
  final List<String> balloonColors = [
    'red',
    'blue',
    'green',
    'yellow',
    'orange',
    'pink',
    'purple',
    'black'
  ];

  Balloon({
    required Vector2 position,
    required BalloonGame game,
  }) : super(
          bodyDef: BodyDef(
            position: position,
            type: BodyType.dynamic,
            gravityScale:
                Vector2(0, -0.5), // Negative gravity makes it float up
          ),
        );

  @override
  bool get renderBody => false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Random balloon color
    final random = Random();
    balloonColor = balloonColors[random.nextInt(balloonColors.length)];

    final game = parent as BalloonGame;

    try {
      // Use cached sprite (images are preloaded in BalloonGame.onLoad)
      final imageName = AppAssets.getBalloonImageName(balloonColor);
      final image = game.images.fromCache(imageName);
      final sprite = Sprite(image);
      balloonSprite = SpriteComponent(
        sprite: sprite,
        size: Vector2(96, 128),
        anchor: Anchor.center,
      );
    } catch (e) {
      // Fallback: try red
      try {
        final image = game.images.fromCache(AppAssets.redBalloon);
        final sprite = Sprite(image);
        balloonSprite = SpriteComponent(
          sprite: sprite,
          size: Vector2(96, 128),
          anchor: Anchor.center,
        );
      } catch (e2) {
        if (kDebugMode) {
          print('Could not load balloon sprite: $e2');
        }
        return;
      }
    }

    add(balloonSprite);

    // Create physics body
    final shape = CircleShape()..radius = 48.0;
    final fixtureDef = FixtureDef(
      shape,
      density: 0.1,
      friction: 0.0,
      restitution: 0.8, // Bouncy
    );

    body.createFixture(fixtureDef);

    // Add some upward force
    body.applyLinearImpulse(Vector2(0, -50));

    // Add slight horizontal drift
    final drift = (random.nextDouble() - 0.5) * 20;
    body.applyLinearImpulse(Vector2(drift, 0));
  }

  @override
  bool onTapDown(TapDownEvent event) {
    final game = parent as BalloonGame;
    // Don't allow tapping when game is paused
    if (game.paused) return false;
    _burst();
    return true;
  }

  void _burst() async {
    // Safety check: don't burst if already removed
    if (!isMounted) return;

    final game = parent as BalloonGame;

    // Additional safety check: don't burst if game is paused
    if (game.paused) return;

    // Increment pop counter via bloc
    game.popCounterBloc.add(PopCounterIncremented());

    // Play burst sound
    try {
      await FlameAudio.play(AppAssets.balloonBurstSoundName, volume: 0.5);
    } catch (e) {
      if (kDebugMode) {
        print('Could not play sound: $e');
      }
    }

    // Show burst animation at balloon position
    final burstAnimation = BurstAnimation(
      position: body.position,
      color: balloonColor,
      game: game,
    );
    game.add(burstAnimation);

    // Remove balloon
    removeFromParent();
    game.world.destroyBody(body);
  }

  @override
  void onRemove() {
    // Explicit cleanup - child components are automatically removed
    // Physics body is destroyed in _burst() or update()
    super.onRemove();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Safety check: don't update if already removed
    if (!isMounted) return;

    final game = parent as BalloonGame;

    // Remove if balloon goes off screen
    final screenHeight = game.camera.viewport.size.y;
    if (body.position.y < -100 || body.position.y > screenHeight + 100) {
      removeFromParent();
      game.world.destroyBody(body);
    }
  }
}
