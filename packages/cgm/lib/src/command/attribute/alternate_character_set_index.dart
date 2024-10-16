import 'package:cgm/cgm.dart';

class AlternateCharacterSetIndex extends Command {
  late final int _index;

  AlternateCharacterSetIndex(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _index = makeIndex();
  }

  @override
  String toString() => 'AlternateCharacterSetIndex: $_index';
}
