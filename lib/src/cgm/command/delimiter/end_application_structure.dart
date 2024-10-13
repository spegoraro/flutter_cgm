import 'package:flutter_cgm/src/cgm/command/command.dart';
import 'package:flutter_cgm/src/cgm/model/cgm_display.dart';

class EndApplicationStructure extends Command {
  EndApplicationStructure(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.endApplicationStructure();
  }

  @override
  toString() => 'EndApplicationStructure ';
}
