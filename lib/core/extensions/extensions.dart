

import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

extension OffsetExtension on Offset {
  /// Creates an [Vector2] from the [Offset]
  Vector2 toVector2() => Vector2(dx, dy);

  /// Creates a [Size] from the [Offset]
  Size toSize() => Size(dx, dy);

  /// Creates a [Point] from the [Offset]
  Point toPoint() => Point(dx, dy);

  /// Creates a [Rect] starting in origin and going the [Offset]
  Rect toRect() => Rect.fromLTWH(0, 0, dx, dy);
}

extension RectExtension on Rect {
  Vector2 get positionVector2 => Vector2(left, top);
  Vector2 get sizeVector2 => Vector2(width, height);

  Rectangle getRectangleByTileSize(double tileSize) {
    final left = (this.left / tileSize).floorToDouble();
    final top = (this.top / tileSize).floorToDouble();
    final width = (this.width / tileSize).ceilToDouble();
    final height = (this.height / tileSize).ceilToDouble();

    return Rectangle(
      left,
      top,
      width,
      height,
    );
  }

  bool overlapComponent(PositionComponent c) {
    double left = c.position.x;
    double top = c.position.y;
    double right = c.position.x + c.size.x;
    double bottom = c.position.y + c.size.y;
    if (this.right <= left || right <= this.left) {
      return false;
    }
    if (this.bottom <= top || bottom <= this.top) {
      return false;
    }
    return true;
  }

  /// Returns a new rectangle with edges moved outwards by the given delta.
  Rect inflatexy(double deltaX, double deltaY) {
    return Rect.fromLTRB(
        left - deltaX, top - deltaY, right + deltaX, bottom + deltaY);
  }

  /// Returns a new rectangle with edges moved inwards by the given delta.
  Rect deflatexy(double deltaX, double deltaY) => inflatexy(-deltaX, -deltaY);

  Vector2 get centerVector2 => Vector2(left + width / 2.0, top + height / 2.0);
}