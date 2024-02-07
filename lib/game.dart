import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pacman/characters/player.dart';
import 'package:pacman/level/map.dart';



class PacmanGame extends FlameGame with HasKeyboardHandlerComponents, HasQuadTreeCollisionDetection {


  PacmanGame({
    required this.viewportResolution,
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: viewportResolution.x,
      height: viewportResolution.y,
    ),
    world: MyWorld(),
  );

  final Vector2 viewportResolution;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugMode = false;

    // FlameAudio.play('pacman_beginning.wav');

    initializeCollisionDetection(
      mapDimensions: Rect.fromLTWH(0, 0, viewportResolution.x, viewportResolution.y),
      minimumDistance: 10,
    );


    await images.loadAll([
      'ember.png',
      'water_enemy.png',
      'stars.png',
    ]);

    add(FpsTextComponent());
    add(ScreenHitbox());


  }


}


class MyWorld extends World with HasGameRef<PacmanGame>, HasCollisionDetection {

  late final Player player;

  @override
  FutureOr<void> onLoad() {

    super.onLoad();

    add(player = Player());

    gameRef.camera.follow(player, maxSpeed: 200);

    addAll([

      Level()

    ]);

  }

}