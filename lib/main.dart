import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:pacman/game.dart';

void main() {

  // FlameAudio.play('pacman_beginning.wav');

  runApp(GameWidget(game: PacmanGame()));

}

