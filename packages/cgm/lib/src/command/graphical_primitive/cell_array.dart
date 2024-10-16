import 'dart:math';

import 'package:cgm/src/render/color.dart';
import 'package:vector_math/vector_math.dart';

import 'package:cgm/cgm.dart';

class CellArray extends Command {
  late final int representationFlag;
  late final int nX;
  late final int nY;
  late final Vector2 p;
  late final Vector2 q;
  late final Vector2 r;

  late final List<Color> colors;
  late final List<int> colorIndices;
  // late final BufferedImage bufferedImage; // TODO: how?

  //-- Constructor --//
  CellArray(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    p = makePoint();
    q = makePoint();
    r = makePoint();
    nX = makeInt();
    nY = makeInt();

    var localColorPrecision = makeInt();
    final colorSelectionMode = cgm.colorSelectionMode;
    if (localColorPrecision == 0) {
      if (colorSelectionMode == ColorSelectionType.indexed) {
        localColorPrecision = cgm.colorIndexPrecision;
      } else {
        localColorPrecision = cgm.colorPrecision;
      }
    }

    representationFlag = makeEnum();
    final nColors = nX * nY;
    colors = List.generate(nColors, (index) => const Color.fromARGB(0, 0, 0, 0));
    if (colorSelectionMode == ColorSelectionType.direct) {
      if (representationFlag == 0) {
        int c = 0;
        while (c < nColors) {
          final numColors = makeInt();
          final color = makeDirectColor();
          final maxIndex = min(numColors, nColors - c);

          for (var i = 0; i < maxIndex; i++) {
            colors[c++] = color;
          }

          if (c > 0 && c % nX == 0) alignOnWord();
        }
      } else if (representationFlag == 1) {
        int i = 0;
        for (int row = 0; row < nY; row++) {
          for (int col = 0; col < nX; col++) {
            colors[i++] = makeDirectColor();
          }
          alignOnWord();
        }
      }
    } else if (colorSelectionMode == ColorSelectionType.indexed) {
      colorIndices = List.generate(nColors, (index) => 0);

      if (representationFlag == 0) {
        int c = 0;
        while (c < nColors) {
          final numColors = makeInt();
          final colorIndex = makeColorIndex(localColorPrecision);

          final maxIndex = min(numColors, nColors - c);
          for (var i = 0; i < maxIndex; i++) {
            colorIndices[c++] = colorIndex;
          }

          if (c > 0 && c % nX == 0) alignOnWord();
        }
      } else if (representationFlag == 1) {
        int i = 0;
        for (int row = 0; row < nY; row++) {
          for (int col = 0; col < nX; col++) {
            colorIndices[i++] = makeColorIndex(localColorPrecision);
          }
          alignOnWord();
        }
      }
    }
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'CellArray -> { '
      'nX: $nX, '
      'nY: $nY, '
      'representationFlag: $representationFlag, '
      'p: $p, '
      'q: $q, '
      'r: $r'
      ' }';
}
