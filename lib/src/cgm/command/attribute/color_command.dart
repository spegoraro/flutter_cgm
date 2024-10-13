import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';
import 'package:meta/meta.dart';

class ColorCommand extends Command {
  @protected
  Color? color;

  @protected
  int colorIndex = -1;

  Color? getColor() => color;
  int getColorIndex() => colorIndex;

  ColorCommand(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final ColorSelectionType colorSelectionType = cgm.colorSelectionMode;
    if (colorSelectionType == ColorSelectionType.direct) {
      color = makeDirectColor();
    } else if (colorSelectionType == ColorSelectionType.indexed) {
      colorIndex = makeColorIndex();
    }
  }

  @override
  String toString() {
    if (color != null) {
      return '{ color: ${color!.value.toRadixString(16)} } ';
    } else {
      return '{ colorIndex: $colorIndex } ';
    }
  }
}
