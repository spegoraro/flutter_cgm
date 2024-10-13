import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class BackgroundColor extends Command {
  late final Color backgroundColor;

  BackgroundColor(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    backgroundColor = makeDirectColor();
  }

  @override
  void paint(CGMDisplay display) {
    // TODO: implement paint
  }

  @override
  String toString() {
    return 'Background Color -> $backgroundColor';
  }
}
