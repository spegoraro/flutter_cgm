import 'package:flutter_cgm/src/cgm/cgm.dart';

class RealPrecision extends Command {
  RealPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final representation = makeEnum();
    final p2 = makeInt();
    final p3 = makeInt();
    var precision = RealPrecisionType.fixed32;
    if (representation == 0) {
      if (p2 == 9 && p3 == 23) {
        precision = RealPrecisionType.floating32;
      } else if (p2 == 12 && p3 == 52) {
        precision = RealPrecisionType.floating64;
      } else {
        assert(false);
      }
    } else if (representation == 1) {
      if (p2 == 16 && p3 == 16) {
        precision = RealPrecisionType.fixed32;
      } else if (p2 == 32 && p3 == 32) {
        precision = RealPrecisionType.fixed64;
      } else {
        assert(false);
      }
    } else {
      assert(false);
    }

    cgm.realPrecision = precision;
    cgm.realPrecisionProcessed = true;
  }

  @override
  toString() => 'RealPrecision -> { ${cgm.realPrecision} } ';
}
