
import 'package:flame/components.dart';
import 'package:pacman/game.dart';


enum Direction {
  left,
  right,
  up,
  down,
  idle,
}

class Character extends SpriteAnimationComponent with HasGameRef<PacmanGame> {


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
  double moveSpeed = 100.0;
  Direction direction = Direction.idle;





}
