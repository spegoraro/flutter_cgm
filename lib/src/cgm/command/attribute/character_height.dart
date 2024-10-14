import 'package:flutter_cgm/src/cgm/cgm.dart';

class CharacterHeight extends Command {
  late final double characterHeight;

  CharacterHeight(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    characterHeight = makeVdc();
  }

  @override
  void paint(CGMDisplay display) {
    display.characterHeight = characterHeight;
  }

  @override
  String toString() => 'Character Height: $characterHeight';
}
