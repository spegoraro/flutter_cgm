import 'dart:math';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class Polyline extends Command {
  late final Path path;
  late final List<Point<double>> points;

  Polyline(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final n = arguments.length ~/ sizeOfPoint();

    path = Path();
    points = List<Point<double>>.generate(n, (index) {
      final point = makePoint();
      if (index == 0) {
        path.moveTo(point.x, point.y);
      } else {
        path.lineTo(point.x, point.y);
      }

      return point;
    });
  }

  @override
  void paint(CGMDisplay display) {
    final canvas = display.canvas;
    final paint = display.linePaint!;

    canvas.drawPath(path, paint);
  }

  @override
  String toString() => 'Polyline -> { '
      'points: $points, '
      'path: ${path.toString()} } ';
}
