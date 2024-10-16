import 'package:cgm/cgm.dart';

class VDCIntegerPrecision extends Command {
  VDCIntegerPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    int precision = makeInt();
    cgm.vdcIntegerPrecision = precision;
  }

  @override
  toString() => 'VDCIntegerPrecision -> { ${cgm.vdcIntegerPrecision} } ';
}
