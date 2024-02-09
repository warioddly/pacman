import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pacman/core/constants.dart';

import 'character.dart';


class Enemy extends Character {


  Enemy() {
    setMoveSpeed = enemySpeed;
  }



  @override
  FutureOr<void> onLoad() async {
     super.onLoad();

     animation = SpriteAnimation.fromFrameData(
       game.images.fromCache('water_enemy.png'),
       SpriteAnimationData.sequenced(
         amount: 2,
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
    randomMovement();
    super.update(dt);
  }


  randomMovement() {

    int random = Random().nextInt(150);

    if (random == 0) {
      velocity
        ..y = -moveSpeed
        ..x = 0;
    }
    else if (random == 1) {
      velocity
        ..y = moveSpeed
        ..x = 0;
    }
    else if (random == 2) {
      velocity
        ..y = 0
        ..x = -moveSpeed;
    }
    else if (random == 3) {
      velocity
        ..y = 0
        ..x = moveSpeed;
    }

  }


  // @override
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   super.onCollisionStart(intersectionPoints, other);
  //
  //   if (other is Player) {
  //     FlameAudio.play('pacman_death.wav');
  //   }
  //
  //   if (other is Enemy) {
  //     randomMovement();
  //   }
  //
  // }



}
