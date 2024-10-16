import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/cap_command.dart';

class EdgeCap extends CapCommand {
  EdgeCap(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.edgePaint?.strokeCap = lineCapIndicator.strokeCap;
  }

  @override
  String toString() => 'EdgeCap -> { lineCap: $lineCapIndicator, dashCap: $dashCapIndicator } ';
}
