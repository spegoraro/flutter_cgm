import 'package:flutter_cgm/src/cgm/cgm.dart';

enum CharacterCodingAnnouncerType {
  basic7Bit,
  basic8Bit,
  extended7Bit,
  extended8Bit,
}

class CharacterCodingAnnouncer extends Command {
  late final CharacterCodingAnnouncerType _type;

  CharacterCodingAnnouncer(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final int type = makeEnum();

    _type = switch (type) {
      0 => CharacterCodingAnnouncerType.basic7Bit,
      1 => CharacterCodingAnnouncerType.basic8Bit,
      2 => CharacterCodingAnnouncerType.extended7Bit,
      3 => CharacterCodingAnnouncerType.extended8Bit,
      _ => CharacterCodingAnnouncerType.basic7Bit,
    };
  }

  @override
  String toString() => 'CharacterCodingAnnouncer -> { type: $_type } ';
}
