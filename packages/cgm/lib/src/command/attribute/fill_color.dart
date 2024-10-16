import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/color_command.dart';

class FillColor extends ColorCommand {
  FillColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    if (color != null) {
      display.setFillColor(color: color!);
    } else {
      display.setFillColor(index: colorIndex);
    }

    display.setCurrentFillColor(this);
  }

  @override
  String toString() {
    return 'Fill Color -> ${super.toString()}';
  }
}
