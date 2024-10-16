import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class Polyline extends Command {
  CGMPath? path;
  late List<Vector2> points;

  Polyline(super.ec, super.eid, super.l, super.buffer, super.cgm);

  void _initializeShape(CGMDisplay display) {
    if (path != null) return;

    final n = arguments.length ~/ sizeOfPoint();

    path = display.canvas.createPath();
    points = List<Vector2>.generate(n, (index) {
      final point = makePoint();
      if (index == 0) {
        path!.moveTo(point.x, point.y);
      } else {
        path!.lineTo(point.x, point.y);
      }

      return point;
    });
  }

  @override
  void paint(CGMDisplay display) {
    _initializeShape(display);

    final canvas = display.canvas;
    final paint = display.linePaint!;

    canvas.drawPath(path!, paint);
  }

  @override
  String toString() => 'Polyline -> { '
      'points: $points, '
      'path: ${path.toString()} } ';
}
