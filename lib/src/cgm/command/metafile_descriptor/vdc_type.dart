import 'package:flutter_cgm/src/cgm/cgm.dart';

class VDCType extends Command {
  VDCType(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final p1 = makeInt();

    var type = VDCTypeType.integer;
    if (p1 == 0) {
      type = VDCTypeType.integer;
    } else if (p1 == 1) {
      type = VDCTypeType.real;
    }

    cgm.vdcType = type;
  }

  @override
  toString() => 'VDCType -> { ${cgm.vdcType} } ';
}
