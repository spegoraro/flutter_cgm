import 'package:flutter_cgm/src/cgm/cgm.dart';

class ColorModel extends Command {
  ColorModel(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeIndex();

    cgm.colorModel = switch (index) {
      1 => ColorModelType.rgb,
      2 => ColorModelType.cielab,
      3 => ColorModelType.cieluv,
      4 => ColorModelType.cmyk,
      5 => ColorModelType.rgbRelated,
      _ => ColorModelType.rgb,
    };
  }

  @override
  String toString() => 'ColorModel -> { ${cgm.colorModel} } ';
}
