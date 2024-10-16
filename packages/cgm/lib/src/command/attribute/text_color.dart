import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/color_command.dart';

class TextColor extends ColorCommand {
  TextColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    if (color != null) {
      display.textColor = color!;
    } else {
      display.textColor = display.getIndexedColor(colorIndex);
    }
  }

  @override
  String toString() {
    return 'TextColor -> ${super.toString()}';
  }
}
