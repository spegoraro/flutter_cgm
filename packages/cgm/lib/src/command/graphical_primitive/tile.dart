// ignore_for_file: unused_local_variable

import 'package:cgm/cgm.dart';

class Tile extends TileElement {
  Tile(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    compressionType = CompressionType.from(makeIndex());
    rowPaddingIndicator = makeInt();

    int cellColorPrecision = makeInt();

    readSdrAndBitStream();
  }

  @override
  String toString() => 'Tile -> Compression Type: $compressionType, Row Padding Indicator:'
      '$rowPaddingIndicator';
}
