import 'package:flutter_cgm/src/cgm/cgm.dart';

class NamePrecision extends Command {
  NamePrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    int precision = makeInt();
    cgm.namePrecision = precision;
  }

  @override
  toString() => 'NamePrecision -> { precision: ${cgm.namePrecision} } ';
}
