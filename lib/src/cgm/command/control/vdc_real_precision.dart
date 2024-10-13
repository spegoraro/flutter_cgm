import 'package:flutter_cgm/src/cgm/cgm.dart';

class VDCRealPrecision extends Command {
  VDCRealPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final p1 = makeEnum();
    final p2 = makeInt();
    final p3 = makeInt();

    var precision = VDCRealPrecisionType.fixedPoint32bit;
    if (p1 == 0) {
      if (p2 == 9 && p3 == 23) {
        precision = VDCRealPrecisionType.floatingPoint32bit;
      } else if (p2 == 12 && p3 == 52) {
        precision = VDCRealPrecisionType.floatingPoint64bit;
      } else {
        assert(false);
      }
    } else if (p1 == 1) {
      if (p2 == 16 && p3 == 16) {
        precision = VDCRealPrecisionType.fixedPoint32bit;
      } else if (p2 == 32 && p3 == 32) {
        precision = VDCRealPrecisionType.fixedPoint64bit;
      } else {
        assert(false);
      }
    } else {
      precision = VDCRealPrecisionType.fixedPoint32bit;
    }

    cgm.vdcRealPrecision = precision;
  }

  @override
  toString() => 'VDCRealPrecision -> { ${cgm.vdcRealPrecision} } ';
}
