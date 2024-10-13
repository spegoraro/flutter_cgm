import 'package:flutter_cgm/src/cgm/cgm.dart';

enum HatchType {
  horizontalLines,
  verticalLines,
  positiveSlopeLines,
  negativeSlopeLines,
  horizontalVerticalCrosshatch,
  positiveNegativeCrosshatch,
}

class HatchIndex extends Command {
  late final HatchType type;

  HatchIndex(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeIndex();
    type = switch (index) {
      1 => HatchType.horizontalLines,
      2 => HatchType.verticalLines,
      3 => HatchType.positiveSlopeLines,
      4 => HatchType.negativeSlopeLines,
      5 => HatchType.horizontalVerticalCrosshatch,
      6 => HatchType.positiveNegativeCrosshatch,
      _ => HatchType.horizontalLines,
    };
  }

  @override
  void paint(CGMDisplay display) {
    display.setHatchStyle(type);
  }

  @override
  String toString() {
    return 'HatchIndex -> { type: $type }';
  }
}
