import 'package:cgm/cgm.dart';

class ColorPrecision extends Command {
  ColorPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    cgm.colorPrecision = makeInt();
  }

  @override
  String toString() => 'ColorPrecision -> ${cgm.colorPrecision}';
}
