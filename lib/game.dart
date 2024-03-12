import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pacman/characters/player.dart';
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
  final Player player = Player();
  late final CameraComponent cam;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugMode = false;

    FlameAudio.play('pacman_beginning.wav');

    await images.loadAll([
      'ember.png',
      'water_enemy.png',
      'stars.png',
    ]);

    add(FpsTextComponent());
    add(ScreenHitbox());

    final world = Level();

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: viewportResolution.x,
      height: viewportResolution.y,
    )..follow(player);
    // cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
    world.add(player);

  }


}


