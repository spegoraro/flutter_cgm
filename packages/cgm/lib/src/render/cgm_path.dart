import 'dart:typed_data';

import 'package:vector_math/vector_math.dart';

/// Wrapper around Flutter's [Path] class.
abstract class CGMPath {
  /// Returns the bounds of the path.
  Vector2 getBounds();

  /// Returns a copy of the path, transformed by the given [matrix4].
  CGMPath transform(Float64List matrix4);

  /// Moves the current point to the given [x] and [y] coordinates.
  void moveTo(double x, double y);

  /// Extends the path with the given [path], optionally offsetting it by [offset].
  void extendWithPath(CGMPath path, [Vector2? offset]);

  /// Closes the path.
  void close();

  /// Draws a cubic bezier curve to the given coordinates.
  void cubicTo(double x1, double y1, double x2, double y2, double x3, double y3);

  /// Adds a quadratic bezier curve to the path.
  void addOval({required Vector2 center, required Vector2 radii});

  /// Adds a path to the current path.
  void addPath(CGMPath path, {required bool connect});

  /// Draws a line to the given coordinates.
  void lineTo(double x, double y);

  /// Draws an arc to the given coordinates.
  void arcToPoint(
    Vector2 point, {
    Vector2? radius,
    double rotation = 0.0,
    bool largeArc = false,
    bool clockwise = false,
  });

  /// Adds a rectangle to the path.
  void addRect(Vector2 topLeft, double width, double height);
}
