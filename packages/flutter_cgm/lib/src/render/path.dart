import 'dart:typed_data';
import 'dart:ui';

import 'package:cgm/cgm.dart';
import 'package:vector_math/vector_math.dart';

class FlutterCGMPath extends CGMPath {
  final Path path;

  FlutterCGMPath([Path? copyFrom]) : path = copyFrom ?? Path();

  Path getPath() => path;

  @override
  void addOval({required Vector2 center, required Vector2 radii}) =>
      path.addOval(Rect.fromLTWH(center.x, center.y, radii.x, radii.y));

  @override
  void addPath(CGMPath path, {required bool connect}) =>
      this.path.addPath((path as FlutterCGMPath).path, Offset.zero, matrix4: Float64List(16));

  @override
  void addRect(Vector2 topLeft, double width, double height) =>
      path.addRect(Rect.fromLTWH(topLeft.x, topLeft.y, width, height));

  @override
  void arcToPoint(Vector2 point,
          {Vector2? radius, double rotation = 0.0, bool largeArc = false, bool clockwise = true}) =>
      path.arcToPoint(
        Offset(point.x, point.y),
        radius: radius != null ? Radius.elliptical(radius.x, radius.y) : const Radius.circular(1),
        rotation: rotation,
        largeArc: largeArc,
        clockwise: clockwise,
      );

  @override
  void close() => path.close();

  @override
  void cubicTo(double x1, double y1, double x2, double y2, double x3, double y3) =>
      path.cubicTo(x1, y1, x2, y2, x3, y3);

  @override
  void extendWithPath(CGMPath path, [Vector2? offset]) =>
      this.path.addPath((path as FlutterCGMPath).path, Offset(offset?.x ?? 0, offset?.y ?? 0));

  @override
  Vector2 getBounds() {
    final bounds = path.getBounds();
    return Vector2(bounds.width, bounds.height);
  }

  @override
  void lineTo(double x, double y) => path.lineTo(x, y);

  @override
  void moveTo(double x, double y) => path.moveTo(x, y);

  @override
  CGMPath transform(Float64List matrix4) => FlutterCGMPath(path.transform(matrix4));
}
