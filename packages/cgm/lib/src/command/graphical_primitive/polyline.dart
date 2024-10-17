import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class Polyline extends Command {
  CGMPath? path;
  late List<Vector2> points;

  Polyline(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final n = arguments.length ~/ sizeOfPoint();

    points = List<Vector2>.generate(n, (index) => makePoint());
  }

  void _initializeShape(CGMDisplay display) {
    if (path != null) return;

    path = display.canvas.createPath();
    final first = points.first;
    path!.moveTo(first.x, first.y);

    for (var i = 1; i < points.length; i++) {
      final point = points[i];
      path!.lineTo(point.x, point.y);
    }
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
