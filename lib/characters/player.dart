import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/services.dart';
import 'package:pacman/core/constants.dart';
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

    add(
      RectangleHitbox(
        size: Vector2.all(tileSize),
      )
        ..debugColor = BasicPalette.red.color.withOpacity(0.4)
        ..debugMode = true
        ..priority = 1
    );


  }

  LogicalKeyboardKey? lastPressedKey;


  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      lastPressedKey = event.logicalKey;
    }
    return false;
  }



}

