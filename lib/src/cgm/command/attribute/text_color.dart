import 'package:flutter_cgm/src/cgm/command/attribute/color_command.dart';
import 'package:flutter_cgm/src/cgm/model/model.dart';

class TextColor extends ColorCommand {
  TextColor(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() {
    return 'TextColor -> ${super.toString()}';
  }
}
