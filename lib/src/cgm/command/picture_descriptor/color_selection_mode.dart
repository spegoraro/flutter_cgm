import 'package:flutter_cgm/src/cgm/cgm.dart';

class ColorSelectionMode extends Command {
  late final ColorSelectionType colorSelectionMode;

  ColorSelectionMode(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    final index = makeEnum();
    colorSelectionMode = switch (index) {
      0 => ColorSelectionType.indexed,
      1 => ColorSelectionType.direct,
      _ => ColorSelectionType.indexed,
    };

    cgm.colorSelectionMode = colorSelectionMode;
  }

  @override
  String toString() => 'Color Selection Mode -> $colorSelectionMode';
}
