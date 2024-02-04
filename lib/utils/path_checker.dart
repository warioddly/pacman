


import 'package:flame/components.dart';
import 'package:pacman/config/constants.dart';

class PathChecker {


  (bool, bool, bool, bool) check(Vector2 position, List<String> map) {

    final x = position.x ~/ (tileSize);
    final y = position.y ~/ (tileSize);

    final currentBlock = map[y][x];
    final topBlock     = (map.length > y - 1)    ? map[y - 1][x] : '#';
    final bottomBlock  = (map.length > y + 1)    ? map[y + 1][x] : '#';
    final leftBlock    = (map[y].length > x - 1) ? map[y][x - 1] : '#';
    final rightBlock   = (map[y].length > x + 1) ? map[y][x + 1] : '#';

    final canMoveTop = topBlock != '#';
    final canMoveBottom = bottomBlock != '#';
    final canMoveLeft = leftBlock != '#';
    final canMoveRight = rightBlock != '#';

    print('currentBlock: $currentBlock');
    print('topBlock: $topBlock');
    print('bottomBlock: $bottomBlock');
    print('leftBlock: $leftBlock');
    print('rightBlock: $rightBlock');

    return (canMoveRight, canMoveLeft, canMoveTop, canMoveBottom);
  }



}