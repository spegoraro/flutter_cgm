import 'package:cgm/cgm.dart';

class EdgeWidth extends Command {
  late final double width;

  EdgeWidth(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final mode = cgm.edgeWidthSpecificationMode;
    width = makeSizeSpecification(mode);
  }

  @override
  void paint(CGMDisplay display) {
    display.setEdge(width: width);
    display.setCurrentEdgeWidth(this);
  }

  @override
  String toString() {
    return 'EdgeWidth -> $width';
  }
}
