
import 'package:flame/components.dart';
import 'package:pacman/components/wall.dart';
import 'package:pacman/config/constants.dart';
import 'package:pacman/game.dart';


class Level extends PositionComponent with HasGameRef<PacmanGame> {

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

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    for (var y = 0; y < map.length; y++) {
      for (var x = 0; x < map[y].length; x++) {

        final char = map[y][x];

        if (char == '#') {

          add(Wall()
            ..position = Vector2((x + position.x) * tileSize, y * tileSize)
          );

          continue;
        }
        // if (char == '.') {
        //   add(Dot()
        //     ..position = Vector2(x * tileSize, y * tileSize)
        //     ..center = Vector2(x * tileSize + 15, y * tileSize + 15)
        //   );
        // continue;
        // }
        if (char == 'p') {
          (gameRef.world as MyWorld).player.position = Vector2(x * tileSize, y * tileSize);
        }

      }
    }

  }


}


