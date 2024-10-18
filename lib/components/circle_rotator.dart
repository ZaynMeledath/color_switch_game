import 'dart:async';
import 'package:color_switch/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleRotator extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  CircleRotator()
      : super(
          // position: Vector2(0, 0),
          size: Vector2.all(220),
          anchor: Anchor.center,
        );

  // Color color = Colors.lightBlue;
  // bool shouldChangeColor = true;

  @override
  FutureOr<void> onLoad() {
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onMount() {
    const circle = 2 * math.pi;
    final sweep = circle / gameRef.gameColors.length;
    final colors = gameRef.gameColors;
    for (int i = 0; i < colors.length; i++) {
      add(CircleArc(
        color: colors[i],
        startAngle: sweep * i,
        sweepAngle: sweep,
      ));
    }
    add(
      RotateEffect.to(
        math.pi * 2,
        EffectController(
          speed: 2,
          infinite: true,
        ),
      ),
    );
    super.onMount();
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   if (shouldChangeColor) {
  //     if (color == Colors.lightBlue) {
  //       color = Colors.pink;
  //     } else {
  //       color = Colors.lightBlue;
  //     }
  //     shouldChangeColor = false;
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //       shouldChangeColor = true;
  //     });
  //   }
  //   super.onCollision(intersectionPoints, other);
  // }
}

class CircleArc extends PositionComponent with ParentIsA<CircleRotator> {
  final Color color;
  final double startAngle;
  final double sweepAngle;

  CircleArc({
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  });

  final thickness = 12.0;
  @override
  FutureOr<void> onLoad() {
    size = parent.size;
    position = size / 2;
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawArc(
      size.toRect().deflate(thickness / 2),
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness,
    );
  }
}
