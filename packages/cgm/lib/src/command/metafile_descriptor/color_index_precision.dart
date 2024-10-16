import 'package:buffer/buffer.dart';
import 'package:cgm/cgm.dart';

class ColorIndexPrecision extends Command {
  ColorIndexPrecision(int ec, int eid, int l, ByteDataReader buffer, CGM cgm) : super(ec, eid, l, buffer, cgm) {
    cgm.colorIndexPrecision = makeInt();
  }

  @override
  String toString() => 'ColorIndexPrecision -> { ${cgm.colorIndexPrecision} } ';
}
