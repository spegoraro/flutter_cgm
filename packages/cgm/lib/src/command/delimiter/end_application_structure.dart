import 'package:cgm/cgm.dart';

class EndApplicationStructure extends Command {
  EndApplicationStructure(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {
    display.endApplicationStructure();
  }

  @override
  toString() => 'EndApplicationStructure ';
}
