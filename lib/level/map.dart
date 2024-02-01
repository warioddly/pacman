import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:pacman/components/dot.dart';


class Level extends PositionComponent {







  @override
  Future<void> onLoad() async {
    await super.onLoad();


    final random = Random();


    addAll([
      ...List.generate(10, (index) => Dot()
        ..center = Vector2(
          random.nextDouble() * 1000,
          random.nextDouble() * 1000,
        ))
    ]);








  }


  @override
  void render(Canvas canvas) {
    // Define the Pacman map here
    final List<String> pacmanMap = [
      "###############################",
      "#...........#...#...........#.#",
      "#.###.#####.#.#.#.#####.###.#.#",
      "#.#  #.#   #.#.#.#   #.#  #.#.#",
      "#.#  #.# ###.#.#.### #.#  #.#.#",
      "#.#  #.# #     #     #.#  #.#.#",
      "#.#  #.# # ####### #######.#.#.#",
      "#.#     # #   #   #   #   #...#",
      "#.####### ### # ### ### # ###.#",
      "#.......#       #       #     .#",
      "#####.#.######### ####### #####",
      "# #...#   #..............#...#.#",
      "# ###.##################.#####.#",
      "# #..............#............#",
      "# #############################"
    ];

    const tileSize = 50.0;
    final paint = Paint()..color = Colors.blue;

    for (var y = 0; y < pacmanMap.length; y++) {
      for (var x = 0; x < pacmanMap[y].length; x++) {
        final char = pacmanMap[y][x];
        if (char == '#') {

          canvas.drawRect(
            Rect.fromLTWH(
              x * tileSize,
              y * tileSize,
              40,
              40,
            ),
            paint,
          );

        }
      }
    }
  }




}


