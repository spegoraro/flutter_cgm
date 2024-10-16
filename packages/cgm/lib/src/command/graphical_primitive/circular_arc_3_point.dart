import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class CircularArc3Point extends Command {
  late final Vector2 center;
  late final double radius;
  late final double startDeltaX;
  late final double startDeltaY;
  late final double intermediateDeltaX;
  late final double intermediateDeltaY;
  late final double endDeltaX;
  late final double endDeltaY;
  late final Vector2 point1;
  late final Vector2 point2;
  late final Vector2 point3;

  CircularArc3Point(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    point1 = makePoint();
    point2 = makePoint();
    point3 = makePoint();

    center = _findCenter(point1.x, point1.y, point2.x, point2.y, point3.x, point3.y);
    radius = point1.distanceTo(center);

    startDeltaX = point1.x - center.x;
    startDeltaY = point1.y - center.y;

    intermediateDeltaX = point2.x - center.x;
    intermediateDeltaY = point2.y - center.y;

    endDeltaX = point3.x - center.x;
    endDeltaY = point3.y - center.y;
  }

  // TODO: This method looks AWFUL, but it's a direct translation from the original Java code.
  Vector2 _findCenter(double x1, double y1, double x2, double y2, double x3, double y3) {
    return Vector2(
        ((((x1 * x1) * (y3 - y2)) +
                (y2 * ((x3 * x3) + (y1 * (y2 - y1)) + (y3 * (y3 - y2)))) +
                (y1 * ((y3 * (y1 - y3)) + (x2 * x2) - (x3 * x3))) -
                (y3 * (x2 * x2))) /
            (2.0 * (((x1 - x3) * (y3 - y2)) + ((x2 - x3) * (y1 - y3))))),
        (((x3 * ((y1 * y1) - (x2 * x2) - (y2 * y2))) +
                (x2 * ((x3 * x3) + (y3 * y3) - (y1 * y1))) +
                ((x1 * x1) * (x3 - x2)) +
                (x1 * ((x2 * x2) - (x3 * x3) + (y2 * y2) - (y3 * y3)))) /
            (2.0 * ((x2 * (y3 - y1)) + (x1 * (y2 - y3)) + (x3 * (y1 - y2))))));
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'CircularArc3Point -> { '
      'center: $center, '
      'radius: $radius, '
      'startDeltaX: $startDeltaX, '
      'startDeltaY: $startDeltaY, '
      'intermediateDeltaX: $intermediateDeltaX, '
      'intermediateDeltaY: $intermediateDeltaY, '
      'endDeltaX: $endDeltaX, '
      'endDeltaY: $endDeltaY, '
      'point1: $point1, '
      'point2: $point2, '
      'point3: $point3'
      ' }';
}
