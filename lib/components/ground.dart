import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ground extends PositionComponent {
  static const String keyName = 'ground_key';
  Ground()
      : super(
          position: Vector2(0, 340),
          size: Vector2(150, 20),
          anchor: Anchor.center,
          key: ComponentKey.named(keyName),
        );

  late Sprite fingerSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    fingerSprite = await Sprite.load('finger_tap.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(
    //     Rect.fromLTWH(0, 0, size.x, size.y),
    //     const Radius.circular(12), // Set the border radius here
    //   ),
    //   Paint()..color = Colors.pink.withOpacity(0.9),
    // );

    fingerSprite.render(
      canvas,
      size: Vector2.all(80),
      position: Vector2(41, 0),
    );
  }
}
