import 'package:flutter_cgm/src/cgm/cgm.dart';

class IntegerPrecision extends Command {
  IntegerPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final precision = makeInt();

    cgm.integerPrecision = precision;
  }

  @override
  toString() => 'IntegerPrecision -> { ${cgm.integerPrecision} } ';
}
