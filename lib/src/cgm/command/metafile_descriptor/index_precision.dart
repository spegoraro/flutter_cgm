import 'package:flutter_cgm/src/cgm/cgm.dart';

class IndexPrecision extends Command {
  IndexPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final precision = makeInt();

    cgm.indexPrecision = precision;
  }

  @override
  toString() => 'IndexPrecision -> { ${cgm.indexPrecision} } ';
}
