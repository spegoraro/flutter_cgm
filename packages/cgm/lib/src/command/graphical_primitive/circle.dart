import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class Circle extends Command {
  late final Vector2 center;
  late final double radius;

  Circle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    center = makePoint();
    radius = makeVdc();
  }

  @override
  void paint(CGMDisplay display) {
    display.canvas.drawCircle(center, radius, display.edgePaint!);
  }

  @override
  String toString() => 'Circle(center: $center, radius: $radius)';
}
