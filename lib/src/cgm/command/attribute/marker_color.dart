import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/command/attribute/color_command.dart';

class MarkerColor extends ColorCommand {
  MarkerColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() {
    return 'MarkerColor -> ${super.toString()}';
  }
}
