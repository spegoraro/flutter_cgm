import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

class CircularArcCenter extends Command {
  @protected
  late Vector2 center;

  @protected
  late Vector2 startDelta, endDelta, radius;

  @protected
  CGMPath? shape;

  CircularArcCenter(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    center = makePoint();
    startDelta = Vector2(makeVdc(), makeVdc());
    endDelta = Vector2(makeVdc(), makeVdc());
    radius = Vector2.all(makeVdc());
  }

  @protected
  void initializeShape(CGMDisplay display) {
    if (shape != null) return;

    final CGMCanvas canvas = display.canvas;

    shape = canvas.createPath()
      ..moveTo(center.x + startDelta.x, center.y + startDelta.y)
      ..arcToPoint(
        center + endDelta,
        radius: radius,
        largeArc: false,
        clockwise: true,
      );
  }

  @override
  void paint(CGMDisplay display) {
    initializeShape(display);

    display.canvas.drawPath(shape!, display.linePaint!);
  }

  @override
  String toString() => 'CircularArcCenter -> { '
      'center: $center, '
      'startDelta: $startDelta, '
      'endDelta: $endDelta, '
      'radius: $radius'
      ' }';
}
