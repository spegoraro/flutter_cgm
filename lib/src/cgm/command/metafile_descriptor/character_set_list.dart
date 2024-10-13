// ignore_for_file:  constant_identifier_names

import 'package:flutter_cgm/src/cgm/cgm.dart';

enum CharacterSetListType {
  _94charGSet,
  _96charGSet,
  _94charMbyteGSet,
  _96charMbyteGSet,
  completeCode;
}

class CharacterSetList extends Command {
  late final Map<CharacterSetListType, String> _characterSets;

  CharacterSetList(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _characterSets = {};

    while (currentArgument < arguments.length) {
      final intType = makeEnum();

      CharacterSetListType type = switch (intType) {
        0 => CharacterSetListType._94charGSet,
        1 => CharacterSetListType._96charGSet,
        2 => CharacterSetListType._94charMbyteGSet,
        3 => CharacterSetListType._96charMbyteGSet,
        4 => CharacterSetListType.completeCode,
        _ => CharacterSetListType.completeCode
      };

      String characterSetDesignation = makeFixedString();
      _characterSets.putIfAbsent(type, () => characterSetDesignation);
    }
  }

  @override
  String toString() => 'CharacterSetList -> { ${_characterSets.toString()} } ';
}
