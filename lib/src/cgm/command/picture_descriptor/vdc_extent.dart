import 'dart:math';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class VDCExtent extends Command {
  late final Point<double> lowerLeft;
  late final Point<double> upperRight;

  VDCExtent(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    lowerLeft = makePoint();
    upperRight = makePoint();
  }

  List<Point<double>> get extent => [lowerLeft, upperRight];

  @override
  String toString() => 'VDC Extent -> { lowerLeft: $lowerLeft, upperRight: $upperRight }';
}
