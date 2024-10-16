import 'package:cgm/src/command/graphical_primitive/text_command.dart';
import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class Text extends TextCommand {
  Text(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    position = makePoint();
    finalFlag = makeEnum() >= 1;
    // setStringComplete(this.finalFlag);
    text = makeString();
  }

  @override
  Vector2 getTextOffset(CGMDisplay display) {
    return Vector2(
      0,
      -display.characterHeight,
    );
  }

  @override
  Vector2 scaleText(CGMDisplay display, LineMetrics lineMetrics) {
    final characterHeight = display.characterHeight;
    return Vector2.all(characterHeight / lineMetrics.ascent * 1.1);
  }

  @override
  String toString() => 'Text -> { position: $position, finalFlag: $finalFlag, text: $text }';
}
