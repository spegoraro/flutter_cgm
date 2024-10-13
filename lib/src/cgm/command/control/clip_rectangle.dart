import 'dart:math';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class ClipRectangle extends Command {
  late final Path _shape;
  late final Point<double> _p1;
  late final Point<double> _p2;

  ClipRectangle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _p1 = makePoint();
    _p2 = makePoint();
    _shape = Path()
      ..moveTo(_p1.x, _p1.y)
      ..lineTo(_p2.x, _p1.y)
      ..lineTo(_p2.x, _p2.y)
      ..lineTo(_p1.x, _p2.y)
      ..close();
  }

  @override
  void paint(CGMDisplay display) {
    display.canvas.clipPath(_shape);
  }

  @override
  toString() => 'ClipRectangle -> { $_p1, $_p2 } ';
}
