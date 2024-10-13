import 'dart:math';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class Circle extends Command {
  late final Point<double> center;
  late final double radius;

  Circle(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    center = makePoint();
    radius = makeVdc();
  }

  @override
  String toString() => 'Circle(center: $center, radius: $radius)';

  @override
  void paint(CGMDisplay display) {} //TODO: Circle.paint
}
