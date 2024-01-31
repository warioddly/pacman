import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pacman/player.dart';


class PacmanGame extends FlameGame with HasKeyboardHandlerComponents {


  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.loadAll([
      'ember.png',
      'water_enemy.png',
    ]);

    add(
      Player()
        ..position = size / 2
        ..width = 50
        ..height = 100
        ..anchor = Anchor.center,
    );

  }

}
