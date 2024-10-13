import 'package:flutter_cgm/src/cgm/cgm.dart';

class EndTileArray extends Command {
  EndTileArray(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @override
  void paint(CGMDisplay display) {} // TODO: Implement paint

  @override
  String toString() => 'EndTileArray ';
}
