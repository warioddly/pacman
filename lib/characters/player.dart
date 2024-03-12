import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/services.dart';
import 'package:pacman/core/constants.dart';
import 'character.dart';


class Player extends Character with KeyboardHandler, CollisionCallbacks {


  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    moveSpeed = playerSpeed;

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    size = Vector2.all(tileSize);

    add(
      RectangleHitbox(
        size: Vector2.all(tileSize),
      )
        ..debugColor = BasicPalette.red.color.withOpacity(0.4)
        ..debugMode = true
        ..priority = 1
    );


  }


  @override
  void update(double dt) {
    keepMoving(dt);
    position += velocity * dt;
    super.update(dt);
  }


  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      switch(event.logicalKey) {
        case LogicalKeyboardKey.arrowUp || LogicalKeyboardKey.keyW:
          direction = Direction.up;
          break;
        case LogicalKeyboardKey.arrowDown || LogicalKeyboardKey.keyS:
          direction = Direction.down;
          break;
        case LogicalKeyboardKey.arrowLeft || LogicalKeyboardKey.keyA:
          direction = Direction.left;
          break;
        case LogicalKeyboardKey.arrowRight || LogicalKeyboardKey.keyD:
          direction = Direction.right;
          break;
        default:
          direction = Direction.idle;
          break;
      }
    }
    return false;
  }


  void keepMoving(double dt) {

    switch (direction) {
      case Direction.left:
        velocity = Vector2(-moveSpeed, 0);
        break;
      case Direction.right:
        velocity = Vector2(moveSpeed, 0);
        break;
      case Direction.up:
        velocity = Vector2(0, -moveSpeed);
        break;
      case Direction.down:
        velocity = Vector2(0, moveSpeed);
        break;
      case Direction.idle:
        velocity = Vector2.zero();
        break;
    }

  }


}

