import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:pacman/level/map.dart';


class PacmanGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {


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

    addAll([
      FpsTextComponent(),

      Level()
        ..center = size / 5,

      // Enemy()
      //   ..center = size / 1.8,
      // Enemy()
      //   ..center = size / 3,
      // Enemy()
      //   ..center = size / 1.5,
    ]);

  }


}
