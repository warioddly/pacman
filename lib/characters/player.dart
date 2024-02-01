import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'character.dart';


class Player extends Character with KeyboardHandler {


  LogicalKeyboardKey? lastPressedKey;


  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
    size = Vector2.all(30);

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

      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (velocity.x <= 0){
          flipHorizontallyAroundCenter();
        }
      }
      else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (velocity.x <= -1) {
          flipHorizontallyAroundCenter();
        }
      }
      else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        velocity
          ..y = -moveSpeed
          ..x = 0;
      }
      else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        velocity
          ..y = moveSpeed
          ..x = 0;
      }

      lastPressedKey = event.logicalKey;

    }
    else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        lastPressedKey = null;
      }
    }
    return false;
  }


  void continueMoving() {
    if (lastPressedKey == LogicalKeyboardKey.arrowLeft) {
      velocity
        ..x = -moveSpeed
        ..y = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowRight) {
      velocity
        ..x = moveSpeed
        ..y = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowUp) {
      velocity
        ..y = -moveSpeed
        ..x = 0;
    } else if (lastPressedKey == LogicalKeyboardKey.arrowDown) {
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


}
