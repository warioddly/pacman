import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/services.dart';
import 'package:pacman/core/constants.dart';
import 'package:pacman/level/map.dart';
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
    position += velocity * dt;
    keepMoving(dt);
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


  bool canMoveInDirection(Direction direction) {
    return true;
    int nextX = position.x ~/ tileSize;
    int nextY = position.y ~/ tileSize;
    final map = Level.map;

    switch (direction) {
      case Direction.left:
        nextX -= 1;
        break;
      case Direction.right:
        nextX += 1;
        break;
      case Direction.up:
        nextY -= 1;
        break;
      case Direction.down:
        nextY += 1;
        break;
      default:
        return false; // Неверное направление
    }

    // Проверка находится ли следующая клетка внутри карты и не является ли стеной
    if (nextX < 0 || nextX >= map[0].length || nextY < 0 || nextY >= map.length || map[nextY][nextX] == '#') {
      return false;
    }

    return true;
  }


  void keepMoving(double dt) {

    switch (direction) {
      case Direction.left:
        if (canMoveInDirection(Direction.left)) {
          velocity = Vector2(-moveSpeed, 0);
        }
        else {
          velocity = Vector2.zero();
        }
        break;
      case Direction.right:
        if (canMoveInDirection(Direction.right)) {
          velocity = Vector2(moveSpeed, 0);
        }
        else {
          velocity = Vector2.zero();
        }
        break;
      case Direction.up:
        if (canMoveInDirection(Direction.up)) {
          velocity = Vector2(0, -moveSpeed);
        }
        else {
          velocity = Vector2.zero();
        }
        break;
      case Direction.down:
        if (canMoveInDirection(Direction.down)) {
          velocity = Vector2(0, moveSpeed);
        }
        else {
          velocity = Vector2.zero();
        }
        break;
      case Direction.idle:
        velocity = Vector2.zero();
        break;
    }

  }

}

