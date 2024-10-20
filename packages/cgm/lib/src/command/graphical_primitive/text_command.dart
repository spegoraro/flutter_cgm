import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

abstract class TextCommand extends Command {
  @protected
  late final String text;
  @protected
  late final Vector2 position;
  @protected
  late final bool finalFlag;
  @protected
  bool stringComplete = true;

  TextCommand(super.ec, super.eid, super.l, super.buffer, super.cgm);

  Vector2 getTextOffset(CGMDisplay display, LineMetrics lineMetrics);

  @protected
  Vector2 scaleText(CGMDisplay display, LineMetrics lineMetrics);

  @override
  void paint(CGMDisplay display) {
    if (text.trim().isEmpty) return;

    final fontMetrics = display.canvas.getLineMetrics(text);
    final Vector2 scale = scaleText(display, fontMetrics);

    display.canvas.save();
    display.canvas.translate(position.x, position.y);
    display.canvas.scale(scale.x, -scale.y);

    display.canvas.drawText(
      text,
      offset: getTextOffset(display, fontMetrics),
    );

    display.canvas.restore();
  }
}
