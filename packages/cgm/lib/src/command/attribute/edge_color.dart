import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/color_command.dart';

class EdgeColor extends ColorCommand {
  EdgeColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    if (color != null) {
      display.setEdge(color: color!);
    } else {
      display.setEdge(index: colorIndex);
    }

    display.setCurrentEdgeColor(this);
  }

  @override
  String toString() => 'EdgeColor -> ${super.toString()}';
}
