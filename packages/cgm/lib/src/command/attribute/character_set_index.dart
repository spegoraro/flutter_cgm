import 'package:cgm/cgm.dart';

class CharacterSetIndex extends Command {
  late final int _index;

  CharacterSetIndex(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _index = makeIndex();
  }

  @override
  String toString() => 'CharacterSetIndex -> { index:$_index } ';
}
