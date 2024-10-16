import 'dart:typed_data';

import 'package:cgm/cgm.dart';
import 'package:meta/meta.dart';

abstract class TileElement extends Command {
  @protected
  late CompressionType compressionType;
  @protected
  late int rowPaddingIndicator;
  @protected
  late StructuredDataRecord sdr;
  // @protected BufferedImage? bufferedImage;
  late ByteData bytes;

  TileElement(super.ec, super.eid, super.l, super.buffer, super.cgm);

  @protected
  void readSdrAndBitStream() {
    while (currentArgument < arguments.length) {
      makeByte();
    }
  }
}
