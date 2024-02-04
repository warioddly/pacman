import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/game.dart';



class Wall extends PositionComponent with HasGameRef<PacmanGame>, CollisionCallbacks {


  Wall({
    required this.coordinates,
    Vector2? position
  }) : super(
    position: position
  );

  final paint = Paint()
    ..color = const Color(0xFF0000FF)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
  final Vector2 coordinates;


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleComponent(
        size: Vector2.all(tileSize),
        paint: paint,
        children: [
          RectangleHitbox(
            position: Vector2.zero(),
            anchor: Anchor.center,
            size: Vector2.all(6),
          )
        ]
      ),
    );

  }



}

