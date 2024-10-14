import 'dart:math';
import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/command/graphical_primitive/text_command.dart';
import 'package:vector_math/vector_math.dart';

class Text extends TextCommand {
  Text(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    position = makePoint();
    finalFlag = makeEnum() >= 1;
    // setStringComplete(this.finalFlag);
    text = makeString();
  }

  @override
  Point<double> getTextOffset(CGMDisplay display) {
    return const Point(0, 0);
  }

  @override
  Vector2 scaleText(CGMDisplay display, LineMetrics lineMetrics) {
    final characterHeight = display.characterHeight;
    return Vector2.all(characterHeight / lineMetrics.ascent);
  }
}
