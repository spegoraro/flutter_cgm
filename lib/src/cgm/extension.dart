import 'dart:math';
import 'dart:ui';

import 'package:vector_math/vector_math.dart';

extension PointExtension on Point<double> {
  Vector2 toVector2() => Vector2(x, y);
  Offset toOffset() => Offset(x, y);
}

extension VectorExtension on Vector2 {
  Point<double> toPoint() => Point(x, y);
  Offset toOffset() => Offset(x, y);
}

extension OffsetExtension on Offset {
  Point<double> toPoint() => Point(dx, dy);
  Vector2 toVector2() => Vector2(dx, dy);
}

extension SizeExtension on Size {
  Vector2 toVector2() => Vector2(width, height);
  Radius toEllipseRadius() => Radius.elliptical(width / 2, height / 2);
}
