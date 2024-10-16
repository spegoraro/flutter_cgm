// ignore_for_file: unused_field

import 'package:cgm/cgm.dart';
import 'package:cgm/src/render/color.dart';

// TODO: implement BitonalTile

class BitonalTile extends TileElement {
  late Color _backgroundColor;
  late int _backgroundColorIndex;
  late Color _foregroundColor;
  late int _foregroundColorIndex;

  BitonalTile(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    compressionType = CompressionType.from(makeIndex());
    rowPaddingIndicator = makeInt();

    final ColorSelectionType colorSelectionMode = cgm.colorSelectionMode;
    if (colorSelectionMode == ColorSelectionType.direct) {
      _backgroundColor = makeDirectColor();
    } else {
      _backgroundColorIndex = makeColorIndex();
    }

    if (colorSelectionMode == ColorSelectionType.direct) {
      _foregroundColor = makeDirectColor();
    } else {
      _foregroundColorIndex = makeColorIndex();
    }

    readSdrAndBitStream();
  }

  @override
  String toString() => 'BitonalTile -> { unimplemented } ';
}
