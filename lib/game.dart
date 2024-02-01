import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pacman/characters/enemy.dart';
import 'package:pacman/level/map.dart';
import 'package:pacman/characters/player.dart';


class PacmanGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    debugMode = true;

    await images.loadAll([
      'ember.png',
      'water_enemy.png',
      'stars.png',
    ]);

    addAll([
      FpsTextComponent(),

      Level(),

      Enemy()
        ..center = size / 1.8,
      Enemy()
        ..center = size / 3,
      Enemy()
        ..center = size / 1.5,

      Player()
        ..center = size / 2
    ]);

  }


}
