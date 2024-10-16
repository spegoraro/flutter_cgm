import 'package:cgm/cgm.dart';

class MetafileDescription extends Command {
  late String _s;

  MetafileDescription(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _s = makeString();
  }

  @override
  toString() => ' MetafileDescription -> { description: $_s } ';
}
