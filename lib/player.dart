import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'character.dart';


class Player extends Character with KeyboardHandler {


  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  double direction = 0.0;
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

  }



  @override
  void update(double dt) {
    velocity.x = direction * moveSpeed;
    position += velocity * dt;
    super.update(dt);
  }


  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        direction = -1;
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        direction = 1;
        return true;
      }
      else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        direction = -1;
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        direction = 1;
        return true;
      }
    } else if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.arrowRight) {
        direction = 0;
        return true;
      }

    }

    lastPressedKey = event.logicalKey;

    return false;

  }


}
