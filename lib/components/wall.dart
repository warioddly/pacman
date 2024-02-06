import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/game.dart';



class Wall extends PositionComponent with HasGameRef<PacmanGame>, CollisionCallbacks {


  Wall({
    Vector2? position
  }) : super(
    position: position
  );

  final paint = Paint()
    ..color = const Color(0xFF0000FF)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;

  Vector2 coordinates = Vector2.zero();
  String id = "";


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleComponent(
        size: Vector2.all(tileSize),
        paint: paint,
      ),
    );


    add(RectangleHitbox(
        collisionType: CollisionType.active,
        position: coordinates / tileSize / 10,
        size: Vector2.all(tileSize),
      )
          ..debugColor = BasicPalette.red.color
          ..debugMode = true
          ..priority = 1
    );

  }



}

