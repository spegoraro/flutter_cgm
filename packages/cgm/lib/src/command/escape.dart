import 'package:cgm/cgm.dart';

class Escape extends Command {
  late final int _identifier;
  late final String _dataRecord;

  Escape(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _identifier = makeInt();
    _dataRecord = makeString();
  }

  @override
  String toString() => 'Escape -> { Identifier: $_identifier, Data Record: $_dataRecord }';
}
