import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pacman/game.dart';
import 'package:pacman/characters/player.dart';



class Dot extends SpriteAnimationComponent with HasGameRef<PacmanGame>, CollisionCallbacks {


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = SpriteSheet.fromColumnsAndRows(
      image: await game.images.load('stars.png'),
      rows: 4,
      columns: 4,
    ).createAnimation(
        row: 0,
        to: 4,
        stepTime: Random().nextDouble() * 0.1 + 0.1
    );

    add(CircleHitbox());

  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      FlameAudio.play('pacman_chomp.wav');
      removeFromParent();
    }
  }


}

