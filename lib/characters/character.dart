import 'package:flame/components.dart';
import 'package:pacman/game.dart';


class Character extends SpriteAnimationComponent with HasGameReference<PacmanGame> {


  Character({
    Vector2? position,
    Vector2? size,
    SpriteAnimation? animation,
  }) : super(
    position: position,
    size: size,
    animation: animation,
  );

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 100;

}
