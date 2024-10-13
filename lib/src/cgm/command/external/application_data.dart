import 'package:flutter_cgm/src/cgm/cgm.dart';

class ApplicationData extends Command {
  late final int identifier;
  late final String data;

  ApplicationData(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    identifier = makeInt();
    data = makeString();
  }

  @override
  String toString() => 'ApplicationData -> { '
      'identifier: $identifier, '
      'data: $data'
      ' }';
}
