import 'package:flutter_cgm/src/cgm/cgm.dart';

class ColorValueExtent extends Command {
  late final double _firstComponentScale;
  late final double _secondComponentScale;
  late final double _thirdComponentScale;

  ColorValueExtent(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final colorModel = cgm.colorModel;
    if (colorModel == ColorModelType.rgb || colorModel == ColorModelType.cmyk) {
      final precision = cgm.colorPrecision;

      if (colorModel == ColorModelType.rgb) {
        cgm.minimumColorValueRGB = [makeUInt(precision), makeUInt(precision), makeUInt(precision)];
        cgm.maximumColorValueRGB = [makeUInt(precision), makeUInt(precision), makeUInt(precision)];
      } else {
        // Unsupported
      }
    } else {
      _firstComponentScale = makeReal();
      _secondComponentScale = makeReal();
      _thirdComponentScale = makeReal();
    }
  }

  @override
  String toString() {
    if (cgm.colorModel == ColorModelType.rgb) {
      return 'ColorValueExtent -> { '
          'min RGB: ${cgm.minimumColorValueRGB}, '
          'max RGB: ${cgm.maximumColorValueRGB}'
          ' } ';
    }

    return 'ColorValueExtent -> { '
        'firstComponentScale: $_firstComponentScale, '
        'secondComponentScale: $_secondComponentScale, '
        'thirdComponentScale: $_thirdComponentScale'
        ' } ';
  }
}
