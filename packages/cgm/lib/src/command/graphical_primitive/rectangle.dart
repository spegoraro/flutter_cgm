import 'package:cgm/cgm.dart';
import 'package:vector_math/vector_math.dart';

class Rectangle extends Command {
  late final Vector2 topLeft;
  late final Vector2 size;

  Rectangle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    topLeft = makePoint();
    final Vector2 bottomRight = makePoint();

    size = bottomRight - topLeft;
  }

  @override
  void paint(CGMDisplay display) {
    display.canvas.drawRect(topLeft, size, display.fillPaint!);

    if (display.drawEdge) {
      display.canvas.drawRect(topLeft, size, display.edgePaint!);
    }
  }

  @override
  String toString() => 'Rectangle -> { position: $topLeft, size: $size }';
}
