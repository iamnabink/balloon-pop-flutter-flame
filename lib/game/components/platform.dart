import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '../../game/balloon_game.dart';

class MovingPlatform extends BodyComponent<BalloonGame> {
  final double width;
  final double speed;
  bool movingRight = true;

  MovingPlatform({
    required Vector2 position,
    required this.width,
    required this.speed,
  }) : super(
          bodyDef: BodyDef(
            position: position,
            type: BodyType.kinematic,
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    const height = 20.0;
    final shape = PolygonShape()
      ..setAsBox(width / 2, height / 2, Vector2.zero(), 0.0);

    final fixtureDef = FixtureDef(
      shape,
      friction: 0.3,
      restitution: 0.8,
      density: 1.0,
    );

    body.createFixture(fixtureDef);

    // Add visual component
    add(RectangleComponent(
      size: Vector2(width, height),
      paint: Paint()..color = const Color(0xFF8B4513), // Brown platform
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move platform back and forth
    final currentX = body.position.x;
    final game = parent as BalloonGame;
    final screenWidth = game.camera.viewport.size.x;

    if (movingRight) {
      body.linearVelocity = Vector2(speed, 0);
      if (currentX > screenWidth - width / 2) {
        movingRight = false;
      }
    } else {
      body.linearVelocity = Vector2(-speed, 0);
      if (currentX < width / 2) {
        movingRight = true;
      }
    }
  }
}
