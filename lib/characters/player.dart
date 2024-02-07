import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/level/map.dart';
import 'package:pacman/utils/path_checker.dart';
import 'character.dart';


class Player extends Character with KeyboardHandler {


  Player() {
    setMoveSpeed = playerSpeed;
  }



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

    size = Vector2.all(tileSize);

    lastPosition = position;


  }

  final pathChecker = PathChecker();
  LogicalKeyboardKey? lastPressedKey;
  bool canMoveTop = true;
  bool canMoveBottom = true;
  bool canMoveLeft = true;
  bool canMoveRight = true;

  Vector2 lastPosition = Vector2.zero();
  Direction lastDirection = Direction.stop;

  @override
  void update(double dt) {
    super.update(dt);

    final pos = position;

    dynamic x = pos.x.round();
    dynamic y = pos.y.round();


    if ((y % tileSize).toInt() == 0) {

      if (lastDirection == Direction.up) {
        canMoveTop = pathChecker.canMove(Vector2(x, y), Level.map, Direction.up);
        lastPosition.y = y;
      }

      if (lastDirection == Direction.down) {
        canMoveBottom = pathChecker.canMove(Vector2(x, y), Level.map, Direction.down);
        lastPosition.y = y;
      }

    }


    if ((x % tileSize).toInt() == 0) {

      if (lastDirection == Direction.left) {
        canMoveLeft = pathChecker.canMove(Vector2(x, y), Level.map, Direction.left);
        lastPosition.x = x;
      }

      if (lastDirection == Direction.right) {
        canMoveRight = pathChecker.canMove(Vector2(x, y), Level.map, Direction.right);
        lastPosition.x = x;
      }

    }


    // if ((x % 10).toInt() == 0) {
    //   canMoveLeft = pathChecker.canMove(pos, Level.map, Direction.left);
    //   canMoveRight = pathChecker.canMove(pos, Level.map, Direction.right);
    // }

    continueMoving(dt);

  }



  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      lastPressedKey = event.logicalKey;
    }
    return false;
  }


  void continueMoving(double dt) {
    switch (lastPressedKey) {
      case LogicalKeyboardKey.arrowLeft:
      case LogicalKeyboardKey.keyA:
        if (canMoveLeft) {
          velocity = Vector2(-moveSpeed, 0);
          position += velocity * dt;
          lastDirection = Direction.left;
        }
        break;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.keyD:
        if (canMoveRight) {
          velocity = Vector2(moveSpeed, 0);
          position += velocity * dt;
          lastDirection = Direction.right;
        }
        break;
      case LogicalKeyboardKey.arrowUp:
      case LogicalKeyboardKey.keyW:
        if (canMoveTop) {
          velocity = Vector2(0, -moveSpeed);
          position += velocity * dt;
          lastDirection = Direction.up;
        }
        break;
      case LogicalKeyboardKey.arrowDown:
      case LogicalKeyboardKey.keyS:
        if (canMoveBottom) {
          velocity = Vector2(0, moveSpeed);
          position += velocity * dt;
          lastDirection = Direction.down;
        }
        break;
      case LogicalKeyboardKey.escape:
        velocity = Vector2.zero();
        lastDirection = Direction.stop;
        break;
      default:
        velocity = Vector2.zero();
        lastDirection = Direction.stop;
        break;
    }

  }



}
