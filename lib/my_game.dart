import 'package:color_switch/components/ball.dart';
import 'package:color_switch/components/circle_rotator.dart';
import 'package:color_switch/components/ground.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  MyGame()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: 400,
            height: 850,
          ),
        );

  @override
  Color backgroundColor() => Colors.lightBlue.withOpacity(.2);

  final gameColors = [
    Colors.redAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.greenAccent,
  ];

  final ground = Ground();
  final ball = Ball();
  final circle = CircleRotator();

  @override
  Future<void> onLoad() async {
    world.add(ground);
    world.add(ball);
    world.add(circle);
    // debugMode = true;
  }

  @override
  void update(double dt) {
    Vector2 cameraPosition = camera.viewfinder.position;
    Vector2 ballPosition = ball.position;

    if (ballPosition.y < cameraPosition.y) {
      camera.viewfinder.position = ballPosition;
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    ball.jump();
    super.onTapDown(event);
  }
}
