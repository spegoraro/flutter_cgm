import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:flutter_cgm/src/cgm/command/attribute/join_command.dart';

class EdgeJoin extends JoinCommand {
  EdgeJoin(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.edgePaint?.strokeJoin = type.strokeJoin;
  }

  @override
  String toString() {
    return 'EdgeJoin -> { type: $type } ';
  }
}
