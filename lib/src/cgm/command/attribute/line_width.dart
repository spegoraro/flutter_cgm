import 'package:flutter_cgm/src/cgm/cgm.dart';

class LineWidth extends Command {
  late final double width;

  LineWidth(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final mode = cgm.lineWidthSpecificationMode;
    width = makeSizeSpecification(mode);
  }

  @override
  void paint(CGMDisplay display) {
    display.setLine(width: width);

    display.setCurrentLineWidth(this);
  }

  @override
  String toString() => 'LineWidth -> $width';
}
