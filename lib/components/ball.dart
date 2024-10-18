import 'dart:async';

import 'package:color_switch/components/ground.dart';
import 'package:color_switch/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends PositionComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Vector2 velocity = Vector2(0, 30);
  // bool gameOver = false;
  final jumpSpeed = 350.0;
  final gravity = 980.0;
  bool isCollided = false;

  Ball()
      : super(
          size: Vector2.all(30),
          position: Vector2(0, 100),
          anchor: Anchor.topCenter,
        );

  @override
  FutureOr<void> onLoad() async {
    add(CircleHitbox());
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
        Offset(
          size.x / 2,
          size.y / 2,
        ),
        size.x / 2,
        Paint()..color = Colors.yellowAccent);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (!isCollided) {
      position += velocity * dt;
      velocity.y += gravity * dt;
    }
  }

  void jump() {
    isCollided = false;
    velocity.y = -jumpSpeed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      isCollided = true;
      velocity.setValues(0, 0);
      Ground ground = gameRef.findByKeyName(Ground.keyName)!;
      position =
          Vector2(0, ground.positionOfAnchor(Anchor.topCenter).y - height);
      super.onCollision(intersectionPoints, other);
    }
  }
}
