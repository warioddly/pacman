


import 'package:flame/components.dart';
import 'package:pacman/characters/character.dart';
import 'package:pacman/config/constants.dart';

class PathChecker {


  bool canMove(Vector2 position, List<String> map, Direction direction) {

    final x = position.x.toInt().abs() ~/ tileSize;
    final y = position.y.toInt().abs() ~/ tileSize;

    if (direction == Direction.down || direction == Direction.up) {
      print('x: ${position}, y: $y');
    }

    switch (direction) {
      case Direction.up:
        return y > 0 && map[y - 1][x] != '#';
      case Direction.down:
        return y < map.length - 1 && map[y + 1][x] != '#';
      case Direction.left:
        return x > 0 && map[y][x - 1] != '#';
      case Direction.right:
        return x < map[0].length - 1 && map[y][x + 1] != '#';
      case Direction.stop:
        return false;
      default:
        return false;
    }

  }



}