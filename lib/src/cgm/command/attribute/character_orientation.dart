import 'package:flutter_cgm/src/cgm/cgm.dart';

class CharacterOrientation extends Command {
  late final double _xUp;
  late final double _yUp;
  late final double _xBase;
  late final double _yBase;

  CharacterOrientation(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _xUp = makeVdc();
    _yUp = makeVdc();
    _xBase = makeVdc();
    _yBase = makeVdc();
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'CharacterOrientation -> { xUp: $_xUp, yUp: $_yUp, xBase: $_xBase, yBase: $_yBase } ';
}
