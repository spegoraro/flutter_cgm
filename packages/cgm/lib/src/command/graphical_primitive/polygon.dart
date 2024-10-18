import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart';

class Polygon extends Command {
  late final List<Vector2> points;

  @protected
  CGMPath? path;

  Polygon(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final int n = (arguments.length - currentArgument) ~/ sizeOfPoint();

    points = List.generate(n, (_) => makePoint());
  }

  @protected
  void initializeShape(CGMDisplay display) {
    if (path != null) return;
    path = display.canvas.createPath();

    final Vector2 first = points.first;
    path!.moveTo(first.x, first.y);

    for (final Vector2 point in points.skip(1)) {
      path!.lineTo(point.x, point.y);
    }

    path!.close();
  }

  @override
  void paint(CGMDisplay display) {
    initializeShape(display);

    display.canvas.drawPath(path!, display.fillPaint!);
    if (display.drawEdge) {
      display.canvas.drawPath(path!, display.edgePaint!);
    }
  }
}
