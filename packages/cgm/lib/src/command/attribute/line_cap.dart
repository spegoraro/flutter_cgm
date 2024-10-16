import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/cap_command.dart';

class LineCap extends CapCommand {
  LineCap(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.edgePaint?.strokeCap = lineCapIndicator.strokeCap;
  }

  @override
  String toString() {
    return 'LineCap -> ${super.toString()}';
  }
}
