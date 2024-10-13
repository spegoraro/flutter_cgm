import 'package:flutter_cgm/src/cgm/cgm.dart';

class EdgeVisibility extends Command {
  late final bool isVisible;

  EdgeVisibility(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    isVisible = makeEnum() != 0;
  }

  @override
  void paint(CGMDisplay display) {
    display.setFlag(drawEdge: isVisible);
  }

  @override
  String toString() => 'EdgeVisibility -> { isVisible: $isVisible }';
}
