import 'package:flutter_cgm/src/cgm/cgm.dart';

class MarkerSize extends Command {
  late final double width;

  MarkerSize(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final mode = cgm.markerSizeSpecificationMode;
    width = makeSizeSpecification(mode);
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() => 'MarkerSize -> $width';
}
