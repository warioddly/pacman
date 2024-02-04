import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pacman/components/wall.dart';
import 'package:pacman/config/constants.dart';
import 'character.dart';


class Player extends Character with KeyboardHandler {


  Player() {
    setMoveSpeed = playerSpeed;
  }

  LogicalKeyboardKey? lastPressedKey;


  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    debugMode = true;

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    size = Vector2.all(tileSize - 5);

    add(RectangleHitbox());

  }


  @override
  void update(double dt) {
    position += velocity * dt;
    continueMoving();
    super.update(dt);
  }


  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {

      // if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      //   if (velocity.x <= 0){
      //     flipHorizontallyAroundCenter();
      //   }
      // }
      // else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      //   if (velocity.x <= -1) {
      //     flipHorizontallyAroundCenter();
      //   }
      // }
      // else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      //   velocity
      //     ..y = -moveSpeed
      //     ..x = 0;
      // }
      // else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      //   velocity
      //     ..y = moveSpeed
      //     ..x = 0;
      // }

      lastPressedKey = event.logicalKey;

    }
    return false;
  }


  void continueMoving()  {
    if (lastPressedKey == LogicalKeyboardKey.arrowLeft || lastPressedKey == LogicalKeyboardKey.keyA) {
      velocity
        ..x = -moveSpeed
        ..y = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowRight || lastPressedKey == LogicalKeyboardKey.keyD) {
      velocity
        ..x = moveSpeed
        ..y = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowUp || lastPressedKey == LogicalKeyboardKey.keyW) {
      velocity
        ..y = -moveSpeed
        ..x = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowDown || lastPressedKey == LogicalKeyboardKey.keyS) {
      velocity
        ..y = moveSpeed
        ..x = 0;
    }
    else {
      velocity
        ..x = 0
        ..y = 0;
    }
  }


  bool canMoveLeft = true;
  bool canMoveRight = true;
  bool canMoveTop = true;
  bool canMoveBottom = true;
  final hitbox = RectangleHitbox();


  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
  ) {
    final myCenter =
    Vector2(position.x + tileSize / 2, position.y + tileSize / 2);
    if (other is Wall) {

      lastPressedKey = null;
      final diffX = myCenter.x - other.x;
      final diffY = myCenter.y - other.y;
      position = Vector2(position.x + diffX / 20, position.y + diffY / 20);

    }

    super.onCollisionStart(intersectionPoints, other);
  }



}
