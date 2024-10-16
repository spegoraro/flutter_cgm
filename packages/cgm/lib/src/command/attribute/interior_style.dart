import 'package:cgm/cgm.dart';

enum InteriorStyleStyle {
  hollow,
  solid,
  pattern,
  hatch,
  empty,
  geometricPattern,
  interpolated,
}

class InteriorStyle extends Command {
  late final InteriorStyleStyle style;

  InteriorStyle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    style = switch (makeEnum()) {
      0 => InteriorStyleStyle.hollow,
      1 => InteriorStyleStyle.solid,
      2 => InteriorStyleStyle.pattern,
      3 => InteriorStyleStyle.hatch,
      4 => InteriorStyleStyle.empty,
      5 => InteriorStyleStyle.geometricPattern,
      6 => InteriorStyleStyle.interpolated,
      _ => InteriorStyleStyle.hollow,
    };
  }

  @override
  void paint(CGMDisplay display) {
    display.setInteriorStyle(style);
  }

  @override
  String toString() => 'InteriorStyle -> ${style.name}';
}
