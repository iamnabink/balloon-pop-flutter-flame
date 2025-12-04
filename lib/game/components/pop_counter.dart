import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import '../bloc/pop_counter_bloc.dart';

class PopCounter extends Component
    with FlameBlocReader<PopCounterBloc, PopCounterState> {
  late TextComponent _countText;
  late RectangleComponent _background;
  late RectangleComponent _border;

  PopCounter();

  void increment() {
    bloc.add(PopCounterIncremented());
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Create small background
    _background = RectangleComponent(
      position: Vector2(20, 85),
      size: Vector2(80, 50),
      paint: Paint()
        ..color = Colors.black.withValues(alpha: 0.5)
        ..style = PaintingStyle.fill,
    );
    add(_background);

    // Add border
    _border = RectangleComponent(
      position: Vector2(20, 85),
      size: Vector2(80, 50),
      paint: Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    add(_border);

    // Create count text component centered in the box
    // Background center: (20 + 40, 85 + 25) = (60, 110)
    _countText = TextComponent(
      text: '0',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.orange.withValues(alpha: 0.8),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
      ),
      position: Vector2(60, 110),
      anchor: Anchor.center,
    );
    add(_countText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    final state = bloc.state;

    // Update text directly from state count
    _countText.text = '${state.count}';
  }
}
