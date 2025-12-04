import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../constants/app_assets.dart';
import 'components/balloon.dart';
import 'components/world_boundaries.dart';
import 'bloc/pop_counter_bloc.dart';

class BalloonGame extends Forge2DGame {
  final PopCounterBloc popCounterBloc;
  bool _isLoaded = false;
  bool _isStarted = false;
  VoidCallback? onLoaded;

  BalloonGame({required this.popCounterBloc, this.onLoaded});

  @override
  bool get isLoaded => _isLoaded;
  bool get isStarted => _isStarted;

  void startGame() {
    if (!_isStarted && _isLoaded) {
      _isStarted = true;
      resumeEngine();
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load all images from assets/images/
    await images.loadAllImages();

    // Add background (using cached image)
    final backgroundImage = images.fromCache(AppAssets.backgroundImageName);
    final backgroundSprite = Sprite(backgroundImage);
    final background = SpriteComponent(
      sprite: backgroundSprite,
      size: camera.viewport.size,
    );
    add(background);

    // Wait for camera to be ready
    await Future.delayed(const Duration(milliseconds: 100));

    // Set up world boundaries [boundary like wall for rgame]
    add(WorldBoundaries());

    // Mark as loaded
    _isLoaded = true;

    // Wait for background to render at least one frame
    await Future.delayed(const Duration(milliseconds: 100));

    // Pause game initially until user starts it (after background is rendered)
    pauseEngine();

    // Notify that loading is complete
    onLoaded?.call();

    // Spawn balloons periodically (but game is paused, so they won't spawn until started)
    add(TimerComponent(period: 2.0, repeat: true, onTick: spawnBalloon));
  }

  void spawnBalloon() {
    final random = Random();
    final screenWidth = camera.viewport.size.x;
    final x = 50.0 + random.nextDouble() * (screenWidth - 100.0);

    final balloon = Balloon(
      position: Vector2(x, camera.viewport.size.y + 50),
      game: this,
    );
    add(balloon);
  }
}
