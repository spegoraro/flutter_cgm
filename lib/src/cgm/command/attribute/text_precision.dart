import 'package:flutter_cgm/src/cgm/cgm.dart';

enum TextPrecisionType { string, character, stroke }

class TextPrecision extends Command {
  late final TextPrecisionType precision;

  TextPrecision(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final precisionType = makeEnum();
    precision = switch (precisionType) {
      0 => TextPrecisionType.string,
      1 => TextPrecisionType.character,
      2 => TextPrecisionType.stroke,
      _ => TextPrecisionType.string,
    };
  }

  @override
  String toString() => 'TextPrecision -> ${precision.name}';
}
