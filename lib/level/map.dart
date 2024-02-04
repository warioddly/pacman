
import 'package:flame/components.dart';
import 'package:pacman/characters/player.dart';
import 'package:pacman/components/dot.dart';
import 'package:pacman/components/wall.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/game.dart';


class Level extends PositionComponent with HasGameRef<PacmanGame> {

  static const List<String> map = [
    "#######################",
    "#.....p....#..........#",
    "#.##.###.#.#.#.###.##.#",
    "#..........#..........#",
    "#.####.#########.# #..#",
    "#.# #.....#     #    ##",
    "#.#  #.# # ####### ####",
    "#.#     # #   #   #   #",
    "#.####### ### # ## ## #",
    "#.......#       #.....#",
    "#####.#.########.######",
    "# #...#   #...........#",
    "# ###.#################",
    "# #...................#",
    "#######################"
  ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    for (var y = 0; y < map.length; y++) {
      for (var x = 0; x < map[y].length; x++) {

        final char = map[y][x];

        if (char == '#') {

          add(Wall(
            coordinates: Vector2(x.toDouble(), y.toDouble()),
            position: Vector2(x * tileSize, y * tileSize))
          );

        }
        if (char == '.') {
          add(Dot()
            ..position = Vector2(x * tileSize, y * tileSize)
            ..center = Vector2(x * tileSize + 15, y * tileSize + 15)
          );
        }


        if (char == 'p') {
          add(Player()
            ..position = Vector2(x * tileSize, y * tileSize)
            ..center = Vector2(x * tileSize + 4, y * tileSize + 4)
          );
        }

      }
    }

  }


}


