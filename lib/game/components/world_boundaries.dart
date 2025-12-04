import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../game/balloon_game.dart';

class WorldBoundaries extends Component {
  @override
  Future<void> onLoad() async {
    final game = parent as BalloonGame;
    final gameSize = game.camera.viewport.size;
    final boundaries = [
      // Left wall
      createBoundary(
        Vector2(0, gameSize.y / 2),
        Vector2(1, gameSize.y),
      ),
      // Right wall
      createBoundary(
        Vector2(gameSize.x, gameSize.y / 2),
        Vector2(1, gameSize.y),
      ),
      // Top wall
      createBoundary(
        Vector2(gameSize.x / 2, 0),
        Vector2(gameSize.x, 1),
      ),
      // Bottom wall (invisible, just for physics)
      createBoundary(
        Vector2(gameSize.x / 2, gameSize.y + 50),
        Vector2(gameSize.x, 1),
      ),
    ];

    for (final boundary in boundaries) {
      game.world.add(boundary);
    }
  }

  BodyComponent createBoundary(Vector2 position, Vector2 size) {
    final shape = PolygonShape()
      ..setAsBox(size.x / 2, size.y / 2, Vector2.zero(), 0.0);

    final fixtureDef = FixtureDef(shape, friction: 0.0, restitution: 0.5);
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static,
    );

    return _InvisibleBoundary(
      bodyDef: bodyDef,
      fixtureDefs: [fixtureDef],
    );
  }
}

// Invisible boundary that doesn't render
class _InvisibleBoundary extends BodyComponent {
  _InvisibleBoundary({
    required super.bodyDef,
    required super.fixtureDefs,
  });

  @override
  void render(Canvas canvas) {
    // Don't render - boundaries are invisible
  }
}
