import 'package:flutter_cgm/src/cgm/cgm.dart';

class CharacterHeight extends Command {
  late final double characterHeight;

  CharacterHeight(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    characterHeight = makeVdc();
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'Character Height: $characterHeight';
}
