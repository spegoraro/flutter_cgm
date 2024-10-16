import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class ClipRectangle extends Command {
  CGMPath? _shape;
  late final Vector2 _p1;
  late final Vector2 _p2;

  ClipRectangle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _p1 = makePoint();
    _p2 = makePoint();
  }

  void _initializeShape(CGMDisplay display) {
    if (_shape != null) return;

    _shape = display.canvas.createPath()
      ..moveTo(_p1.x, _p1.y)
      ..lineTo(_p2.x, _p1.y)
      ..lineTo(_p2.x, _p2.y)
      ..lineTo(_p1.x, _p2.y)
      ..close();
  }

  @override
  void paint(CGMDisplay display) {
    _initializeShape(display);

    display.canvas.clipPath(_shape!);
  }

  @override
  toString() => 'ClipRectangle -> { $_p1, $_p2 } ';
}
