import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:pacman/game.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Game());

}


class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PacmanGame(
        viewportResolution: Vector2(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}


