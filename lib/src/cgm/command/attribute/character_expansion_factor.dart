import 'package:flutter_cgm/src/cgm/cgm.dart';

class CharacterExpansionFactor extends Command {
  late final double _factor;

  CharacterExpansionFactor(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _factor = makeReal();
  }

  @override
  String toString() => 'Character Expansion Factor: $_factor';
}
