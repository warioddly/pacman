
import 'package:flame/components.dart';
import 'package:pacman/decorations/wall.dart';
import 'package:pacman/core/constants.dart';
import 'package:pacman/game.dart';
import 'package:pacman/decorations/dot.dart';


class Level extends World with HasGameRef<PacmanGame> {

  static const List<String> map = [
    "#######################",
    "#..........#..........#",
    "#.##p###.#.#.#.###.##.#",
    "#..........#..........#",
    "#.####.#########.#.#..#",
    "#.#.#.....#......#....#",
    "#.#.##.#.#..#.##.##.###",
    "#.#....#...#..#...#...#",
    "#.##.####.###.#.##.##.#",
    "#.......#........#....#",
    "#####.#.#####.##.##.###",
    "#.....#...#...........#",
    "#.###.##.##.###.#####.#",
    "#.....................#",
    "#######################"
  ];


  final walls = <Wall>[];

  @override
  Future<void> onLoad() async {

    await super.onLoad();

    for (var y = 0; y < map.length; y++) {
      for (var x = 0; x < map[y].length; x++) {

        final char = map[y][x];

        if (char == '#') {

          final wall = Wall()
            ..position = Vector2(x * tileSize, y * tileSize);

          add(wall);
          walls.add(wall);

          continue;
        }
        if (char == '.') {
          add(Dot()
            ..position = Vector2(x * tileSize, y * tileSize)
            ..center = Vector2(x * tileSize + 15, y * tileSize + 15)
          );
        continue;
        }
        if (char == 'p') {
          gameRef.player.position = Vector2(x * tileSize, y * tileSize);
        }

      }
    }

  }


}


