import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/components/wall.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/level/map.dart';
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

    size = Vector2.all(tileSize);

    // add(RectangleHitbox());

  }


  final List<Ray2> rays = [];
  final List<RaycastResult<ShapeHitbox>> results = [];

  get getOrigin => absolutePosition;

  bool canMoveTop = true;
  bool canMoveBottom = true;
  bool canMoveLeft = true;
  bool canMoveRight = true;


  @override
  void update(double dt) {

    // gameRef.collisionDetection.raycastAll(
    //     getOrigin,
    //     numberOfRays: 4,
    //     maxDistance: tileSize * 2,
    //     out: results,
    // );
    //
    // for (final result in results) {
    //   getRayDirection(result);
    // }

    continueMoving(dt);

    return super.update(dt);

  }


  void getRayDirection(RaycastResult<ShapeHitbox> ray) {

    if (!ray.isActive) {
      return;
    }

    final distance = (ray.intersectionPoint?.distanceTo(absolutePosition) ?? 0) / tileSize;
    const safetyDistance = 0.80;

    canMoveRight = !(ray.normal!.x == -1 && distance <= safetyDistance);
    canMoveLeft = !(ray.normal!.x == 1 && distance <= safetyDistance);
    canMoveBottom = !(ray.normal!.y == -1 && distance <= safetyDistance);
    canMoveTop = !(ray.normal!.y == 1 && distance <= safetyDistance);

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
        }
        break;
      case LogicalKeyboardKey.arrowRight:
      case LogicalKeyboardKey.keyD:
        if (canMoveRight) {
          velocity = Vector2(moveSpeed, 0);
          position += velocity * dt;
        }
        break;
      case LogicalKeyboardKey.arrowUp:
      case LogicalKeyboardKey.keyW:
        if (canMoveTop) {
          velocity = Vector2(0, -moveSpeed);
          position += velocity * dt;
        }
        break;
      case LogicalKeyboardKey.arrowDown:
      case LogicalKeyboardKey.keyS:
        if (canMoveBottom) {
          velocity = Vector2(0, moveSpeed);
          position += velocity * dt;
        }
        break;
      case LogicalKeyboardKey.escape:
        velocity = Vector2.zero();
        break;
      default:
        velocity = Vector2.zero();
        break;
    }
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderResult(canvas, getOrigin, results, paint);
  }


  void renderResult(
      Canvas canvas,
      Vector2 origin,
      List<RaycastResult<ShapeHitbox>> results,
      Paint paint,
  ) {

    final originOffset = origin.toOffset();

    for (final result in results) {
      if (!result.isActive) {
        continue;
      }
      final intersectionPoint = result.intersectionPoint!.toOffset();
      canvas.drawLine(
        originOffset,
        intersectionPoint,
        paint,
      );
    }

    canvas.drawCircle(originOffset, 5, paint);
  }



}
