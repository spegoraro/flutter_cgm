import 'dart:math';

import 'package:vector_math/vector_math.dart';

extension PointExtension on Point<double> {
  Vector2 toVector2() => Vector2(x, y);
}
