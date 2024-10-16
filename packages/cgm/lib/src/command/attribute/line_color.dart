import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/color_command.dart';

class LineColor extends ColorCommand {
  LineColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    if (super.color != null) {
      display.setLine(color: color);
    } else {
      display.setLine(index: colorIndex);
    }

    display.setCurrentLineColor(this);
  }

  @override
  String toString() {
    return 'LineColor -> ${super.toString()}';
  }
}
