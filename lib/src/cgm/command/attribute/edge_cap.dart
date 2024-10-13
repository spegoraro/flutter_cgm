import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/command/attribute/cap_command.dart';

class EdgeCap extends CapCommand {
  EdgeCap(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.edgePaint?.strokeCap = lineCapIndicator.strokeCap;
  }

  @override
  String toString() => 'EdgeCap -> { lineCap: $lineCapIndicator, dashCap: $dashCapIndicator } ';
}
