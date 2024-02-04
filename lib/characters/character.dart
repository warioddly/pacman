import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pacman/game.dart';


class Character extends SpriteAnimationComponent with HasGameRef<PacmanGame>, CollisionCallbacks {


  Character({
    Vector2? position,
    Vector2? size,
    SpriteAnimation? animation,
  }) : super(
    position: position,
    size: size,
    animation: animation,
  );

  Vector2 velocity = Vector2.zero();
  double _moveSpeed = 100.0;


  set setMoveSpeed(double speed) {
    _moveSpeed = speed;
  }


  get moveSpeed => _moveSpeed;

}
