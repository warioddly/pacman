import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:pacman/core/constants.dart';
import 'package:pacman/game.dart';



class Wall extends PositionComponent with HasGameRef<PacmanGame>, CollisionCallbacks {


  final paint = Paint()
    ..color = const Color(0xFF0000FF)
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleHitbox(
        size: Vector2.all(tileSize),
      )
        ..paint = paint
        ..debugColor = BasicPalette.red.color.withOpacity(0.4)
        ..debugMode = false
        ..priority = 1
        ..renderShape = true
    );

  }

}

