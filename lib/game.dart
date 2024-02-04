import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/level/map.dart';


class PacmanGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {


  PacmanGame({
    required this.viewportResolution,
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: viewportResolution.x,
      height: viewportResolution.y,
    ),
  );

  final Vector2 viewportResolution;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = false;

    // FlameAudio.play('pacman_beginning.wav');

    await images.loadAll([
      'ember.png',
      'water_enemy.png',
      'stars.png',
    ]);

    add(FpsTextComponent());

    add(
        Level()
          ..anchor = Anchor.center
    );



  }


}
