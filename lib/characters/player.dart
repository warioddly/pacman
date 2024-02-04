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


  }

  Ray2? ray;
  Ray2? reflection;
  static const numberOfRays = 4;
  final List<Ray2> rays = [];
  final List<RaycastResult<ShapeHitbox>> results = [];

  get getOrigin => absolutePosition;

  bool canMoveTop = true;
  bool canMoveBottom = true;
  bool canMoveLeft = true;
  bool canMoveRight = true;

  late Ray2 rightRay;
  late Ray2 leftRay;

  @override
  void update(double dt) {

    gameRef.collisionDetection.raycastAll(
      getOrigin,
      numberOfRays: numberOfRays,
      rays: rays,
      out: results,
      maxDistance: 300
    );

    for (final result in results) {

      getRayDirection(result);

    }

    continueMoving(dt);
    super.update(dt);

  }



  void getRayDirection(RaycastResult<ShapeHitbox> ray) {

    if (!ray.isActive) {
      return;
    }

    final distance = ray.intersectionPoint!.distanceTo(absolutePosition) / tileSize;

    const safetyDistance = 0.65;

    canMoveRight = true;
    canMoveLeft = true;



    if(ray.normal!.x == -1 && distance <= safetyDistance) {
      canMoveRight = false;
    }

    if(ray.normal!.x == 1 && distance >= safetyDistance) {
      canMoveLeft = false;
    }


  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      lastPressedKey = event.logicalKey;
    }
    return false;
  }


  void continueMoving(dt)  {
    if (canMoveLeft && (lastPressedKey == LogicalKeyboardKey.arrowLeft || lastPressedKey == LogicalKeyboardKey.keyA)) {
      velocity = Vector2(-moveSpeed, 0);
      position += velocity * dt;
      return;
    }
    else if (canMoveRight && (lastPressedKey == LogicalKeyboardKey.arrowRight || lastPressedKey == LogicalKeyboardKey.keyD)) {
      velocity = Vector2(moveSpeed, 0);
      position += velocity * dt;
      return;
    }
    else if (canMoveTop && (lastPressedKey == LogicalKeyboardKey.arrowUp || lastPressedKey == LogicalKeyboardKey.keyW)) {
      velocity = Vector2(0, -moveSpeed);
      position += velocity * dt;
      return;
    }
    else if (canMoveBottom && (lastPressedKey == LogicalKeyboardKey.arrowDown || lastPressedKey == LogicalKeyboardKey.keyS)) {
      velocity = Vector2(0, moveSpeed);
      position += velocity * dt;
      return;
    }
    else if (lastPressedKey == LogicalKeyboardKey.escape) {
      velocity = Vector2.zero();
    }
    else {
      velocity = Vector2.zero();
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
