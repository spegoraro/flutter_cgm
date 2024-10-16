import 'package:cgm/cgm.dart';
import 'package:cgm/src/command/attribute/dash_command.dart';

class LineType extends DashCommand {
  LineType(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() {
    return 'LineType -> $type';
  }
}
